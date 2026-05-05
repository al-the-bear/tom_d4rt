// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: TextEditingController API surface — "Cobalt Inkwell" theme.
// Static snapshot only; no listeners, no live state, no runtime mutation.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextEditingController deep visual demo (Cobalt Inkwell) — start');

  // ---------------------------------------------------------------------------
  // Cobalt Inkwell palette: deep navy fountain-pen tones with copper accents.
  // ---------------------------------------------------------------------------
  const Color inkDeep = Color(0xFF0A1A33);
  const Color inkMid = Color(0xFF12305C);
  const Color inkSoft = Color(0xFF1F4A8A);
  const Color inkRule = Color(0xFF2C5FB0);
  const Color paperCream = Color(0xFFF5EFE2);
  const Color paperWarm = Color(0xFFEFE6D2);
  const Color paperEdge = Color(0xFFD8CDB4);
  const Color copperBright = Color(0xFFC97B3F);
  const Color copperMuted = Color(0xFFA15D2A);
  const Color sageHint = Color(0xFF7A8E6C);
  const Color crimsonInk = Color(0xFF8B2434);
  const Color violetWash = Color(0xFF4B3A75);
  const Color goldLeaf = Color(0xFFB58A2C);
  const Color charcoalText = Color(0xFF1B1B1F);
  const Color slateText = Color(0xFF44464F);
  const Color mistText = Color(0xFF7B7E89);

  // Reusable text styles (constructed once; safe in static snapshot demo).
  const TextStyle styleHeroTitle = TextStyle(
    color: paperCream,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.1,
  );
  const TextStyle styleHeroSub = TextStyle(
    color: paperWarm,
    fontSize: 14,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.4,
  );
  const TextStyle styleSectionTitle = TextStyle(
    color: inkDeep,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
  );
  const TextStyle styleSectionSub = TextStyle(
    color: slateText,
    fontSize: 13,
    fontStyle: FontStyle.italic,
  );
  const TextStyle styleBody = TextStyle(
    color: charcoalText,
    fontSize: 13,
    height: 1.5,
  );
  const TextStyle styleMono = TextStyle(
    color: inkDeep,
    fontSize: 12,
    fontFamily: 'monospace',
    height: 1.4,
  );
  const TextStyle styleMonoLight = TextStyle(
    color: paperCream,
    fontSize: 12,
    fontFamily: 'monospace',
    height: 1.4,
  );
  const TextStyle styleCaption = TextStyle(
    color: mistText,
    fontSize: 11,
    fontStyle: FontStyle.italic,
  );
  const TextStyle styleTableHead = TextStyle(
    color: paperCream,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
  );
  const TextStyle styleTableCell = TextStyle(
    color: charcoalText,
    fontSize: 12,
    height: 1.35,
  );
  const TextStyle styleChipText = TextStyle(
    color: paperCream,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );

  // ---------------------------------------------------------------------------
  // Section 1 — Construct a battery of TextEditingControllers (snapshots only).
  // Each is wrapped in try/catch in case the bridged constructor errors.
  // ---------------------------------------------------------------------------
  TextEditingController? ctrlEmpty;
  try {
    ctrlEmpty = TextEditingController();
    print('ctrlEmpty constructed; text="${ctrlEmpty.text}"');
  } catch (e) {
    print('ctrlEmpty failed: $e');
  }

  TextEditingController? ctrlGreeting;
  try {
    ctrlGreeting = TextEditingController(text: 'Hello, world.');
    print('ctrlGreeting constructed; text="${ctrlGreeting.text}"');
  } catch (e) {
    print('ctrlGreeting failed: $e');
  }

  TextEditingController? ctrlSearch;
  try {
    ctrlSearch = TextEditingController(text: 'cobalt fountain pen');
    print('ctrlSearch constructed; text="${ctrlSearch.text}"');
  } catch (e) {
    print('ctrlSearch failed: $e');
  }

  TextEditingController? ctrlEmail;
  try {
    ctrlEmail = TextEditingController(text: 'scribe@inkwell.example');
    print('ctrlEmail constructed; text="${ctrlEmail.text}"');
  } catch (e) {
    print('ctrlEmail failed: $e');
  }

  TextEditingController? ctrlPassword;
  try {
    ctrlPassword = TextEditingController(text: 'correct horse battery staple');
    print('ctrlPassword constructed (snapshot)');
  } catch (e) {
    print('ctrlPassword failed: $e');
  }

  TextEditingController? ctrlMultiline;
  try {
    ctrlMultiline = TextEditingController(
      text:
          'Dear reader,\nThe nib glides over cream paper.\nCobalt ink dries slowly.\nYours, the scribe.',
    );
    print('ctrlMultiline constructed; length=${ctrlMultiline.text.length}');
  } catch (e) {
    print('ctrlMultiline failed: $e');
  }

  TextEditingController? ctrlPoem;
  try {
    ctrlPoem = TextEditingController(
      text:
          'A blot of cobalt on the page —\nso small, yet read across the age.',
    );
    print('ctrlPoem constructed; length=${ctrlPoem.text.length}');
  } catch (e) {
    print('ctrlPoem failed: $e');
  }

  TextEditingController? ctrlNumeric;
  try {
    ctrlNumeric = TextEditingController(text: '1864');
    print('ctrlNumeric constructed; text=${ctrlNumeric.text}');
  } catch (e) {
    print('ctrlNumeric failed: $e');
  }

  TextEditingController? ctrlUnicode;
  try {
    ctrlUnicode = TextEditingController(text: 'café — naïve façade — résumé');
    print('ctrlUnicode constructed');
  } catch (e) {
    print('ctrlUnicode failed: $e');
  }

  TextEditingController? ctrlEmoji;
  try {
    ctrlEmoji = TextEditingController(text: 'fountain pen ink bottle paper');
    print('ctrlEmoji constructed');
  } catch (e) {
    print('ctrlEmoji failed: $e');
  }

  TextEditingController? ctrlBlank;
  try {
    ctrlBlank = TextEditingController(text: '');
    print('ctrlBlank constructed');
  } catch (e) {
    print('ctrlBlank failed: $e');
  }

  // Try a TextEditingValue constructor with selection + composing.
  TextEditingValue? valueWithSelection;
  try {
    valueWithSelection = const TextEditingValue(
      text: 'manuscript draft',
      selection: TextSelection.collapsed(offset: 10),
      composing: TextRange(start: 0, end: 10),
    );
    print(
        'valueWithSelection constructed; text="${valueWithSelection.text}" composing=${valueWithSelection.composing.start}..${valueWithSelection.composing.end}');
  } catch (e) {
    print('valueWithSelection failed: $e');
  }

  TextSelection? collapsedAtFive;
  try {
    collapsedAtFive = const TextSelection.collapsed(offset: 5);
    print('collapsedAtFive constructed; offset=${collapsedAtFive.baseOffset}');
  } catch (e) {
    print('collapsedAtFive failed: $e');
  }

  // ---------------------------------------------------------------------------
  // Helper builders (closures returning Widgets — fine for static demo).
  // ---------------------------------------------------------------------------
  Widget tagChip(String label, Color bg) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: styleChipText),
    );
  }

  Widget swatch(String name, Color color, String hex) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: paperWarm,
        border: Border.all(color: paperEdge),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 60, color: color),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: inkDeep,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(hex, style: styleMono),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget keyValueRow(String key, String value, {Color? accent}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              key,
              style: TextStyle(
                color: accent ?? inkMid,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(child: Text(value, style: styleMono)),
        ],
      ),
    );
  }

  Widget ruleHorizontal({double thickness = 1, Color color = paperEdge}) {
    return Container(
      height: thickness,
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget sectionHeader(String number, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: paperWarm,
        border: Border(
          left: BorderSide(color: copperBright, width: 5),
          bottom: BorderSide(color: paperEdge, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: inkMid,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: paperCream,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: styleSectionTitle),
                const SizedBox(height: 2),
                Text(subtitle, style: styleSectionSub),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget codeBlock(String title, String code) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: inkDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: inkSoft, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: inkMid,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: copperBright,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: goldLeaf,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: sageHint,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: const TextStyle(
                    color: paperWarm,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(code, style: styleMonoLight),
          ),
        ],
      ),
    );
  }

  Widget calloutBox(String title, String body, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border(left: BorderSide(color: accent, width: 4)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(body, style: styleBody),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 0 — Hero header.
  // ---------------------------------------------------------------------------
  final Widget heroHeader = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28, 30, 28, 28),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [inkDeep, inkMid, inkSoft],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: copperBright,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: paperCream, width: 2),
              ),
              child: const Center(
                child: Text(
                  'Aa',
                  style: TextStyle(
                    color: inkDeep,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TextEditingController', style: styleHeroTitle),
                  const SizedBox(height: 4),
                  Text(
                    'Cobalt Inkwell — a static visual atlas of the bridged API.',
                    style: styleHeroSub,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: paperCream.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: paperCream.withValues(alpha: 0.45)),
              ),
              child: const Text(
                'snapshot · no listeners',
                style: TextStyle(
                  color: paperCream,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          children: [
            tagChip('flutter/widgets', copperBright),
            tagChip('value: TextEditingValue', copperMuted),
            tagChip('selection', violetWash),
            tagChip('composing', sageHint),
            tagChip('dispose-aware', crimsonInk),
            tagChip('no setState', goldLeaf),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paperCream.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: paperCream.withValues(alpha: 0.30)),
          ),
          child: const Text(
            'A TextEditingController bridges a Flutter TextField to a value '
            'object holding plain text, a selection range, and a composing '
            'range used by IMEs. It is a ChangeNotifier — but in this demo '
            'we never subscribe; we read a snapshot and render. This atlas '
            'shows construction shapes, value layouts, scenarios, and '
            'lifecycle traps without animating or mutating any state.',
            style: TextStyle(color: paperWarm, fontSize: 13, height: 1.5),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 1 widget — API surface table.
  // ---------------------------------------------------------------------------
  final List<List<String>> apiRows = <List<String>>[
    <String>[
      'TextEditingController()',
      'constructor',
      'Empty controller; text starts as "".',
    ],
    <String>[
      'TextEditingController(text: ...)',
      'constructor',
      'Seeds initial text; selection is collapsed at offset -1.',
    ],
    <String>[
      'TextEditingController.fromValue(value)',
      'factory',
      'Initialises from an explicit TextEditingValue (text+selection+composing).',
    ],
    <String>[
      'controller.text',
      'getter / setter',
      'Plain text. Setting it resets selection to collapsed at -1.',
    ],
    <String>[
      'controller.value',
      'getter / setter',
      'Full TextEditingValue. Setting fires notifyListeners().',
    ],
    <String>[
      'controller.selection',
      'getter / setter',
      'TextSelection range; collapsed when base==extent.',
    ],
    <String>[
      'controller.clear()',
      'method',
      'Resets text to "" and selection to collapsed at -1.',
    ],
    <String>[
      'controller.clearComposing()',
      'method',
      'Resets composing range to TextRange.empty without touching text.',
    ],
    <String>[
      'controller.addListener(fn)',
      'method',
      'Subscribes to value changes. (NOT used in this static demo.)',
    ],
    <String>[
      'controller.removeListener(fn)',
      'method',
      'Unsubscribes a listener. (NOT used in this static demo.)',
    ],
    <String>[
      'controller.dispose()',
      'method',
      'Releases resources; mandatory for State-owned controllers.',
    ],
    <String>[
      'controller.buildTextSpan(...)',
      'method',
      'Builds the TextSpan a TextField uses to render the current value.',
    ],
  ];

  Widget apiTableHeader = Container(
    decoration: const BoxDecoration(color: inkMid),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Row(
      children: const [
        SizedBox(
          width: 230,
          child: Text('Member', style: styleTableHead),
        ),
        SizedBox(
          width: 110,
          child: Text('Kind', style: styleTableHead),
        ),
        Expanded(child: Text('Description', style: styleTableHead)),
      ],
    ),
  );

  final List<Widget> apiTableRows = <Widget>[];
  for (int i = 0; i < apiRows.length; i++) {
    final List<String> row = apiRows[i];
    final bool stripe = i.isOdd;
    apiTableRows.add(
      Container(
        decoration: BoxDecoration(
          color: stripe ? paperWarm : paperCream,
          border: const Border(
            bottom: BorderSide(color: paperEdge, width: 0.5),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 230,
              child: Text(
                row[0],
                style: const TextStyle(
                  color: inkDeep,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(
                row[1],
                style: const TextStyle(
                  color: copperMuted,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Expanded(child: Text(row[2], style: styleTableCell)),
          ],
        ),
      ),
    );
  }

  Widget apiTable = Container(
    decoration: BoxDecoration(
      border: Border.all(color: inkMid, width: 1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        apiTableHeader,
        ...apiTableRows,
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 2 — Value / selection / composing inspector.
  // Render bridged readings inside try/catch for resilience.
  // ---------------------------------------------------------------------------
  String safeText(TextEditingController? c) {
    if (c == null) return '<null>';
    try {
      return c.text;
    } catch (e) {
      return '<error: $e>';
    }
  }

  String safeSelectionDesc(TextEditingController? c) {
    if (c == null) return '<null>';
    try {
      final TextSelection sel = c.selection;
      final int b = sel.baseOffset;
      final int x = sel.extentOffset;
      final bool collapsed = b == x;
      return 'base=$b extent=$x ${collapsed ? "(collapsed)" : "(range)"}';
    } catch (e) {
      return '<selection error: $e>';
    }
  }

  String safeComposingDesc(TextEditingController? c) {
    if (c == null) return '<null>';
    try {
      final TextRange r = c.value.composing;
      return 'start=${r.start} end=${r.end}';
    } catch (e) {
      return '<composing error: $e>';
    }
  }

  String safeLength(TextEditingController? c) {
    if (c == null) return '<null>';
    try {
      return c.text.length.toString();
    } catch (e) {
      return '<error: $e>';
    }
  }

  Widget inspectorCard(String title, String tagline, TextEditingController? c,
      Color accent) {
    final String t = safeText(c);
    final String preview = t.length > 80 ? '${t.substring(0, 80)}…' : t;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: paperEdge, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: paperCream,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Text(
                  tagline,
                  style: const TextStyle(
                    color: paperWarm,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: paperWarm,
                    border: Border.all(color: paperEdge),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    preview.isEmpty ? '(empty text)' : preview,
                    style: const TextStyle(
                      color: inkDeep,
                      fontSize: 13,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                keyValueRow('text length', safeLength(c)),
                keyValueRow('selection', safeSelectionDesc(c)),
                keyValueRow('composing', safeComposingDesc(c)),
                keyValueRow(
                    'runtimeType', c == null ? '<null>' : 'TextEditingController'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget inspectorPanel = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      inspectorCard(
        'ctrlEmpty',
        'default constructor',
        ctrlEmpty,
        inkMid,
      ),
      inspectorCard(
        'ctrlGreeting',
        'short seeded text',
        ctrlGreeting,
        inkSoft,
      ),
      inspectorCard(
        'ctrlSearch',
        'search-style query',
        ctrlSearch,
        copperMuted,
      ),
      inspectorCard(
        'ctrlEmail',
        'email field',
        ctrlEmail,
        violetWash,
      ),
      inspectorCard(
        'ctrlPassword',
        'masked field source',
        ctrlPassword,
        crimsonInk,
      ),
      inspectorCard(
        'ctrlMultiline',
        'multi-line composition',
        ctrlMultiline,
        sageHint,
      ),
      inspectorCard(
        'ctrlPoem',
        'verse / wrapping',
        ctrlPoem,
        goldLeaf,
      ),
      inspectorCard(
        'ctrlNumeric',
        'pure digits',
        ctrlNumeric,
        copperBright,
      ),
      inspectorCard(
        'ctrlUnicode',
        'diacritics',
        ctrlUnicode,
        inkRule,
      ),
      inspectorCard(
        'ctrlEmoji',
        'noun-shaped tokens',
        ctrlEmoji,
        inkDeep,
      ),
      inspectorCard(
        'ctrlBlank',
        'explicit empty seed',
        ctrlBlank,
        slateText,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 3 — TextEditingValue layout diagram (purely visual / static).
  // ---------------------------------------------------------------------------
  Widget valueDiagram() {
    const String demoText = 'manuscript draft';
    final List<Widget> charBoxes = <Widget>[];
    for (int i = 0; i < demoText.length; i++) {
      final String ch = demoText.substring(i, i + 1);
      final bool isComposing = i < 10;
      final bool isCursorAt = i == 10;
      Color bg = paperCream;
      Color border = paperEdge;
      if (isComposing) {
        bg = sageHint.withValues(alpha: 0.25);
        border = sageHint;
      }
      if (isCursorAt) {
        bg = copperBright.withValues(alpha: 0.30);
        border = copperBright;
      }
      charBoxes.add(
        Container(
          width: 24,
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(ch, style: styleMono),
        ),
      );
    }

    final List<Widget> indexBoxes = <Widget>[];
    for (int i = 0; i < demoText.length; i++) {
      indexBoxes.add(
        Container(
          width: 24,
          height: 16,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          alignment: Alignment.center,
          child: Text(
            i.toString(),
            style: const TextStyle(
              color: mistText,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: paperEdge),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TextEditingValue layout',
            style: TextStyle(
              color: inkDeep,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'text="manuscript draft"  composing=[0,10)  selection=collapsed@10',
            style: styleMono,
          ),
          const SizedBox(height: 12),
          Row(children: indexBoxes),
          Row(children: charBoxes),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(width: 14, height: 14, color: sageHint),
              const SizedBox(width: 6),
              const Text('composing range', style: styleMono),
              const SizedBox(width: 16),
              Container(width: 14, height: 14, color: copperBright),
              const SizedBox(width: 6),
              const Text('cursor (collapsed selection)', style: styleMono),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4 — Multiple controller snapshots showing different selection
  // states (visual diagrams).
  // ---------------------------------------------------------------------------
  Widget selectionSnapshot(
    String title,
    String text,
    int base,
    int extent, {
    Color accent = inkSoft,
    String? note,
  }) {
    final List<Widget> charBoxes = <Widget>[];
    final int lo = base < extent ? base : extent;
    final int hi = base < extent ? extent : base;
    for (int i = 0; i < text.length; i++) {
      final String ch = text.substring(i, i + 1);
      final bool inSel = i >= lo && i < hi;
      Color bg = paperCream;
      Color border = paperEdge;
      if (inSel) {
        bg = accent.withValues(alpha: 0.30);
        border = accent;
      }
      charBoxes.add(
        Container(
          width: 18,
          height: 26,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(ch, style: styleMono),
        ),
      );
      if (i + 1 == base && base == extent) {
        // Insert cursor caret marker (visual only).
        charBoxes.add(
          Container(
            width: 2,
            height: 26,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            color: crimsonInk,
          ),
        );
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paperWarm,
        border: Border.all(color: paperEdge),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: paperCream,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'base=$base  extent=$extent',
                style: styleMono,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(children: charBoxes),
          if (note != null) ...[
            const SizedBox(height: 6),
            Text(note, style: styleCaption),
          ],
        ],
      ),
    );
  }

  Widget selectionGallery = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      selectionSnapshot(
        'A',
        'manuscript',
        0,
        0,
        accent: inkMid,
        note: 'Cursor at start; selection collapsed at offset 0.',
      ),
      selectionSnapshot(
        'B',
        'manuscript',
        4,
        4,
        accent: inkSoft,
        note: 'Cursor mid-word at offset 4 (between "manu" and "script").',
      ),
      selectionSnapshot(
        'C',
        'manuscript',
        10,
        10,
        accent: copperMuted,
        note: 'Cursor at end (offset == text.length).',
      ),
      selectionSnapshot(
        'D',
        'manuscript',
        0,
        4,
        accent: violetWash,
        note: 'Forward selection covering "manu".',
      ),
      selectionSnapshot(
        'E',
        'manuscript',
        4,
        0,
        accent: crimsonInk,
        note: 'Reverse selection — base>extent — same span, different anchor.',
      ),
      selectionSnapshot(
        'F',
        'manuscript',
        4,
        10,
        accent: sageHint,
        note: 'Selection covers "script".',
      ),
      selectionSnapshot(
        'G',
        'manuscript',
        0,
        10,
        accent: goldLeaf,
        note: 'Full selection — common after Ctrl+A.',
      ),
      selectionSnapshot(
        'H',
        'manuscript',
        -1,
        -1,
        accent: slateText,
        note:
            '"Pristine" sentinel — collapsed at -1 means "no selection set yet".',
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 5 — Prose on lifecycle.
  // ---------------------------------------------------------------------------
  final Widget lifecycleProse = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        'A TextEditingController is a long-lived editable model. In a '
        'StatefulWidget you typically create it in initState, hand it to a '
        'TextField via the controller parameter, and dispose it in the State '
        'object\'s dispose method. Forgetting to dispose leaks a '
        'ChangeNotifier — small in isolation, but compounded over a '
        'long-running session it manifests as gradual memory growth and '
        'lingering listeners pinned by closures.',
        style: styleBody,
      ),
      SizedBox(height: 8),
      Text(
        'Because a controller is also a ChangeNotifier, every assignment to '
        'text or value broadcasts to listeners. In production you usually '
        'subscribe via addListener to mirror text into other state. This '
        'demo deliberately avoids listeners: we want a deterministic '
        'static atlas that renders correctly even under a static snapshot '
        'interpreter, so we read .text, .selection, and .value once and '
        'paint the result. Live mutation belongs in dynamic widget tests, '
        'not here.',
        style: styleBody,
      ),
      SizedBox(height: 8),
      Text(
        'When you assign controller.text = "...", Flutter resets the '
        'selection to TextSelection.collapsed(offset: -1). That sentinel '
        'tells the framework "there is no caret yet" — the next focus '
        'event will place one. If you set text and immediately set '
        'selection, do it through controller.value to avoid the sentinel '
        'flicker. Likewise, if you only need to clear IME composition '
        'state, call clearComposing() rather than rebuilding a full value.',
        style: styleBody,
      ),
      SizedBox(height: 8),
      Text(
        'Two controllers are never equal even with identical text — '
        'identity, not value, drives equality. That matters when you '
        'rebuild a widget tree and accidentally pass a fresh controller '
        'each frame: the TextField will detach the old, attach the new, '
        'and your typing position resets. Always own your controller '
        'in State, never inline in build.',
        style: styleBody,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 6 — Pitfalls.
  // ---------------------------------------------------------------------------
  final Widget pitfallList = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      calloutBox(
        'PITFALL 1 — forgetting dispose()',
        'The controller is a ChangeNotifier and holds a list of listeners. '
        'A leaked controller survives until garbage collection, and any '
        'closures it captured live with it. Always pair `final c = '
        'TextEditingController(...)` with `c.dispose()` in your State.',
        crimsonInk,
      ),
      calloutBox(
        'PITFALL 2 — re-creating in build()',
        'If you write `TextEditingController()` inside build(), every '
        'rebuild constructs a new one and the previous instance leaks. '
        'Hoist it to State or to a stable scope.',
        copperBright,
      ),
      calloutBox(
        'PITFALL 3 — assigning text and selection separately',
        'Setting controller.text resets selection to collapsed @ -1. If '
        'you intend "set the text AND keep cursor at end", set '
        'controller.value = TextEditingValue(text: t, selection: '
        'TextSelection.collapsed(offset: t.length)).',
        violetWash,
      ),
      calloutBox(
        'PITFALL 4 — out-of-range selection',
        'Programmatically setting selection.baseOffset to a value outside '
        '[0, text.length] either gets clamped or asserted, depending on '
        'the framework version. Always validate offsets against '
        'text.length.',
        inkSoft,
      ),
      calloutBox(
        'PITFALL 5 — leaking listeners',
        'addListener without removeListener traps the closure for the '
        'controller\'s lifetime. If the closure captures a State that '
        'has been disposed, you can call setState on a dead state. '
        'Pair every addListener with removeListener — or use a single '
        'lambda you can pass to both.',
        sageHint,
      ),
      calloutBox(
        'PITFALL 6 — assuming text.length == characters',
        'text.length counts UTF-16 code units, not user-perceived '
        'characters. Combining marks, ZWJ sequences, and surrogate pairs '
        'each can occupy more than one code unit. For grapheme counting '
        'use the characters package.',
        goldLeaf,
      ),
      calloutBox(
        'PITFALL 7 — composing range surprises',
        'During IME composition, value.composing is non-empty and the '
        'underlying text already contains the in-progress glyphs. Reading '
        '.text mid-composition therefore returns text the user has not '
        'yet "committed". Filter on composing.isCollapsed if you only '
        'want committed text.',
        copperMuted,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 7 — Restorable vs non-restorable comparison.
  // ---------------------------------------------------------------------------
  Widget compareCell(String text, {bool head = false, Color? accent}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: head ? (accent ?? inkMid) : paperCream,
        border: Border.all(color: paperEdge),
      ),
      child: Text(
        text,
        style: head
            ? const TextStyle(
                color: paperCream,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              )
            : styleTableCell,
      ),
    );
  }

  Widget restorableTable = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Expanded(child: compareCell('Aspect', head: true, accent: inkDeep)),
          Expanded(
              child: compareCell('TextEditingController',
                  head: true, accent: inkMid)),
          Expanded(
              child: compareCell('RestorableTextEditingController',
                  head: true, accent: copperMuted)),
        ],
      ),
      Row(
        children: [
          Expanded(child: compareCell('Persists across hot restart')),
          Expanded(child: compareCell('No')),
          Expanded(child: compareCell('Yes — via RestorationMixin')),
        ],
      ),
      Row(
        children: [
          Expanded(child: compareCell('Persists across app kill')),
          Expanded(child: compareCell('No')),
          Expanded(child: compareCell('Yes — bucket round-trip')),
        ],
      ),
      Row(
        children: [
          Expanded(child: compareCell('Construction shape')),
          Expanded(child: compareCell('TextEditingController(text: t)')),
          Expanded(
              child: compareCell('RestorableTextEditingController(text: t)')),
        ],
      ),
      Row(
        children: [
          Expanded(child: compareCell('Reads via')),
          Expanded(child: compareCell('controller.text')),
          Expanded(child: compareCell('restorable.value.text')),
        ],
      ),
      Row(
        children: [
          Expanded(child: compareCell('Disposal')),
          Expanded(child: compareCell('controller.dispose()')),
          Expanded(
              child: compareCell('restorable.dispose() (+ State unregister)')),
        ],
      ),
      Row(
        children: [
          Expanded(child: compareCell('Where to instantiate')),
          Expanded(child: compareCell('State.initState()')),
          Expanded(child: compareCell('State + restoreState callback')),
        ],
      ),
      Row(
        children: [
          Expanded(child: compareCell('Common use')),
          Expanded(child: compareCell('Most TextField cases')),
          Expanded(
              child: compareCell('Forms users expect to survive backgrounding')),
        ],
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 8 — Glossary.
  // ---------------------------------------------------------------------------
  final List<List<String>> glossaryRows = <List<String>>[
    <String>[
      'TextEditingController',
      'Mutable model that backs a TextField. Holds text + selection + composing range and notifies listeners on change.',
    ],
    <String>[
      'TextEditingValue',
      'Immutable triplet (text, selection, composing) returned by controller.value. Replace it wholesale to update atomically.',
    ],
    <String>[
      'TextSelection',
      'Range with baseOffset and extentOffset. Collapsed when both are equal — that is the cursor position.',
    ],
    <String>[
      'TextRange',
      'Generic [start, end) UTF-16 range used for composing. TextRange.empty has start == end == -1.',
    ],
    <String>[
      'composing',
      'IME-managed range of in-progress glyphs (e.g. dead-key composition). Empty when input is committed.',
    ],
    <String>[
      'baseOffset',
      'Anchor end of a selection — where the selection started.',
    ],
    <String>[
      'extentOffset',
      'Free end of a selection — where the cursor currently is. Equal to baseOffset when collapsed.',
    ],
    <String>[
      'collapsed',
      'A selection with zero width. Equivalent to a single caret position.',
    ],
    <String>[
      'ChangeNotifier',
      'Flutter mixin that lets controllers broadcast change events to subscribed listeners.',
    ],
    <String>[
      'dispose',
      'Lifecycle method that releases a controller\'s listener list. Mandatory in State.dispose.',
    ],
    <String>[
      'RestorableTextEditingController',
      'Variant that round-trips its value through Flutter\'s restoration scope.',
    ],
    <String>[
      'TextField',
      'Material text input widget consuming a TextEditingController as its model.',
    ],
  ];

  Widget glossaryHeader = Container(
    decoration: const BoxDecoration(color: violetWash),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Row(
      children: const [
        SizedBox(
          width: 220,
          child: Text('Term', style: styleTableHead),
        ),
        Expanded(child: Text('Definition', style: styleTableHead)),
      ],
    ),
  );

  final List<Widget> glossaryRowWidgets = <Widget>[];
  for (int i = 0; i < glossaryRows.length; i++) {
    final List<String> row = glossaryRows[i];
    final bool stripe = i.isOdd;
    glossaryRowWidgets.add(
      Container(
        decoration: BoxDecoration(
          color: stripe ? paperWarm : paperCream,
          border: const Border(
            bottom: BorderSide(color: paperEdge, width: 0.5),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 220,
              child: Text(
                row[0],
                style: const TextStyle(
                  color: violetWash,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(child: Text(row[1], style: styleTableCell)),
          ],
        ),
      ),
    );
  }

  Widget glossaryTable = Container(
    decoration: BoxDecoration(
      border: Border.all(color: violetWash, width: 1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        glossaryHeader,
        ...glossaryRowWidgets,
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 9 — Palette swatches.
  // ---------------------------------------------------------------------------
  final Widget paletteRow = Wrap(
    children: [
      swatch('Ink Deep', inkDeep, '#0A1A33'),
      swatch('Ink Mid', inkMid, '#12305C'),
      swatch('Ink Soft', inkSoft, '#1F4A8A'),
      swatch('Ink Rule', inkRule, '#2C5FB0'),
      swatch('Paper Cream', paperCream, '#F5EFE2'),
      swatch('Paper Warm', paperWarm, '#EFE6D2'),
      swatch('Paper Edge', paperEdge, '#D8CDB4'),
      swatch('Copper Bright', copperBright, '#C97B3F'),
      swatch('Copper Muted', copperMuted, '#A15D2A'),
      swatch('Sage Hint', sageHint, '#7A8E6C'),
      swatch('Crimson Ink', crimsonInk, '#8B2434'),
      swatch('Violet Wash', violetWash, '#4B3A75'),
      swatch('Gold Leaf', goldLeaf, '#B58A2C'),
      swatch('Charcoal', charcoalText, '#1B1B1F'),
      swatch('Slate', slateText, '#44464F'),
      swatch('Mist', mistText, '#7B7E89'),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 10 — Code snippet blocks.
  // ---------------------------------------------------------------------------
  final Widget codeBlocks = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      codeBlock(
        'idiomatic_state_owned.dart',
        'class _MyFormState extends State<MyForm> {\n'
            '  final TextEditingController _name =\n'
            '      TextEditingController(text: "Aurelia");\n'
            '\n'
            '  @override\n'
            '  void dispose() {\n'
            '    _name.dispose();\n'
            '    super.dispose();\n'
            '  }\n'
            '\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    return TextField(controller: _name);\n'
            '  }\n'
            '}',
      ),
      codeBlock(
        'set_text_keep_cursor_at_end.dart',
        '// Bad — flickers cursor to -1 sentinel:\n'
            'controller.text = newText;\n'
            '\n'
            '// Good — set value as a single transaction:\n'
            'controller.value = TextEditingValue(\n'
            '  text: newText,\n'
            '  selection:\n'
            '      TextSelection.collapsed(offset: newText.length),\n'
            ');',
      ),
      codeBlock(
        'clear_and_clear_composing.dart',
        '// Wipe everything (text + selection):\n'
            'controller.clear();\n'
            '\n'
            '// Wipe IME composition only — text untouched:\n'
            'controller.clearComposing();',
      ),
      codeBlock(
        'snapshot_read_pattern.dart',
        '// Read once; render. No subscription.\n'
            'final value = controller.value;\n'
            'final text = value.text;\n'
            'final base = value.selection.baseOffset;\n'
            'final composing = value.composing;\n'
            'render(text, base, composing);',
      ),
      codeBlock(
        'avoid_rebuild_construct.dart',
        '// Anti-pattern — leaks one controller per build:\n'
            'Widget build(BuildContext c) {\n'
            '  final ctl = TextEditingController(text: prop);\n'
            '  return TextField(controller: ctl);\n'
            '}\n'
            '\n'
            '// Hoist to State and own its lifetime instead.',
      ),
      codeBlock(
        'restorable_form.dart',
        'class _S extends State<F> with RestorationMixin {\n'
            '  final RestorableTextEditingController _email =\n'
            '      RestorableTextEditingController();\n'
            '\n'
            '  @override\n'
            '  String get restorationId => "f";\n'
            '\n'
            '  @override\n'
            '  void restoreState(b, _) {\n'
            '    registerForRestoration(_email, "email");\n'
            '  }\n'
            '\n'
            '  @override\n'
            '  void dispose() {\n'
            '    _email.dispose();\n'
            '    super.dispose();\n'
            '  }\n'
            '}',
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 11 — Decision flowchart (visual rectangles, no logic).
  // ---------------------------------------------------------------------------
  Widget flowNode(String text, Color bg, {double width = 240}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: inkDeep, width: 1),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: paperCream,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget flowArrow() {
    return Container(
      width: 2,
      height: 18,
      color: inkDeep,
      margin: const EdgeInsets.symmetric(vertical: 2),
    );
  }

  Widget flowDecision(String text) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: goldLeaf,
        border: Border.all(color: inkDeep, width: 1),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: inkDeep,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  final Widget flowchart = Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: paperWarm,
      border: Border.all(color: paperEdge),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      children: [
        flowNode('Need editable text in a TextField?', inkMid),
        flowArrow(),
        flowDecision('Should it survive app restoration?'),
        flowArrow(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                flowNode('Yes — use RestorableTextEditingController',
                    copperMuted,
                    width: 260),
                flowArrow(),
                flowNode('Register in restoreState', violetWash, width: 260),
                flowArrow(),
                flowNode('Dispose in State.dispose', crimsonInk, width: 260),
              ],
            ),
            const SizedBox(width: 24),
            Column(
              children: [
                flowNode('No — use TextEditingController', inkSoft,
                    width: 260),
                flowArrow(),
                flowNode('Construct in initState', sageHint, width: 260),
                flowArrow(),
                flowNode('Dispose in State.dispose', crimsonInk, width: 260),
              ],
            ),
          ],
        ),
        flowArrow(),
        flowNode('Read .text / .value when needed', inkDeep),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 12 — Scenario panels (visual only, no live input).
  // ---------------------------------------------------------------------------
  Widget mockTextField({
    required String label,
    required String text,
    required Color accent,
    String? hint,
    bool obscure = false,
    bool multiline = false,
    int? maxLines,
    String? helper,
    String? error,
  }) {
    final String displayed = obscure ? ('•' * text.length) : text;
    final List<Widget> lines = <Widget>[];
    if (multiline) {
      final List<String> parts = displayed.split('\n');
      for (int i = 0; i < parts.length; i++) {
        lines.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(parts[i], style: styleMono),
          ),
        );
      }
    } else {
      lines.add(Text(displayed, style: styleMono));
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: paperEdge),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: paperWarm,
              border: Border(bottom: BorderSide(color: accent, width: 2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (text.isEmpty && hint != null)
                  Text(
                    hint,
                    style: const TextStyle(
                      color: mistText,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'monospace',
                    ),
                  ),
                if (text.isNotEmpty) ...lines,
                if (multiline && maxLines != null)
                  SizedBox(height: 14.0 * (maxLines - lines.length).clamp(0, 4)),
              ],
            ),
          ),
          if (helper != null) ...[
            const SizedBox(height: 4),
            Text(helper, style: styleCaption),
          ],
          if (error != null) ...[
            const SizedBox(height: 4),
            Text(
              error,
              style: const TextStyle(
                color: crimsonInk,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget scenarioPanel(String title, String description, List<Widget> items,
      Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: paperWarm,
        border: Border.all(color: paperEdge),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: paperCream,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    color: paperWarm,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: items,
            ),
          ),
        ],
      ),
    );
  }

  final Widget scenarioSearch = scenarioPanel(
    'Scenario A — Search box',
    'A single-line query field with a magnifier icon and a clear-button hint.',
    [
      mockTextField(
        label: 'SEARCH',
        text: safeText(ctrlSearch),
        accent: copperBright,
        hint: 'Search the workshop catalogue…',
        helper: 'Hit Enter to search, Esc to clear.',
      ),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: copperBright,
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Text(
              'Search',
              style: TextStyle(
                color: paperCream,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: paperEdge),
              borderRadius: BorderRadius.circular(3),
            ),
            child: const Text(
              'Clear',
              style: TextStyle(
                color: charcoalText,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ],
    copperMuted,
  );

  final Widget scenarioLogin = scenarioPanel(
    'Scenario B — Login form',
    'Two controllers — username and password — with an error preview.',
    [
      mockTextField(
        label: 'USERNAME',
        text: safeText(ctrlEmail),
        accent: inkSoft,
        hint: 'name@inkwell.example',
        helper: 'Use your enterprise email address.',
      ),
      mockTextField(
        label: 'PASSWORD',
        text: safeText(ctrlPassword),
        accent: crimsonInk,
        hint: '••••••••',
        obscure: true,
        helper: 'Minimum 8 characters; obscured for display.',
      ),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: crimsonInk.withValues(alpha: 0.15),
          border: Border.all(color: crimsonInk.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'preview only — controllers in this demo are static; submission '
          'logic would attach onSubmitted to a TextField.',
          style: TextStyle(
            color: crimsonInk,
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ],
    inkSoft,
  );

  final Widget scenarioMultiline = scenarioPanel(
    'Scenario C — Multi-line editor',
    'A long-form composition controller, snapshot-only.',
    [
      mockTextField(
        label: 'NOTEBOOK',
        text: safeText(ctrlMultiline),
        accent: sageHint,
        hint: 'Begin writing…',
        multiline: true,
        maxLines: 6,
        helper:
            'Multi-line: each "\\n" creates a paragraph break in the layout.',
      ),
      mockTextField(
        label: 'POEM',
        text: safeText(ctrlPoem),
        accent: goldLeaf,
        hint: 'Verse goes here.',
        multiline: true,
        maxLines: 4,
      ),
    ],
    sageHint,
  );

  final Widget scenarioFormGrid = scenarioPanel(
    'Scenario D — Profile form (grid)',
    'A small grid of single-line controllers as you might find in onboarding.',
    [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: mockTextField(
              label: 'GIVEN NAME',
              text: 'Aurelia',
              accent: inkSoft,
              hint: 'Given name',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: mockTextField(
              label: 'FAMILY NAME',
              text: 'Cobalt-Wren',
              accent: inkSoft,
              hint: 'Family name',
            ),
          ),
        ],
      ),
      mockTextField(
        label: 'PROFESSIONAL TITLE',
        text: 'Master Scribe, Inkwell Atelier',
        accent: violetWash,
        hint: 'How you describe your work',
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: mockTextField(
              label: 'CITY',
              text: 'Florence',
              accent: copperMuted,
              hint: 'City',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: mockTextField(
              label: 'POSTAL CODE',
              text: '50122',
              accent: copperMuted,
              hint: 'Postal',
            ),
          ),
        ],
      ),
    ],
    violetWash,
  );

  final Widget scenarioFiltered = scenarioPanel(
    'Scenario E — Filtered numeric input',
    'A controller seeded with digits only, paired with a TextInputFormatter (not shown live).',
    [
      mockTextField(
        label: 'YEAR',
        text: safeText(ctrlNumeric),
        accent: goldLeaf,
        hint: 'YYYY',
        helper:
            'In production, attach FilteringTextInputFormatter.digitsOnly to '
            'the TextField; controller stores only what passes the filter.',
      ),
      mockTextField(
        label: 'INVALID PREVIEW',
        text: 'eighteen-sixty-four',
        accent: crimsonInk,
        hint: 'YYYY',
        error: 'invalid — formatter would block alphabetic characters',
      ),
    ],
    goldLeaf,
  );

  final Widget scenarioReadonly = scenarioPanel(
    'Scenario F — Read-only display',
    'A controller can also back a read-only TextField for selectable display text.',
    [
      mockTextField(
        label: 'CITATION',
        text:
            'Cobalt Inkwell, vol. iii — "On the propagation of selection ranges in editable models."',
        accent: inkMid,
        helper: 'readOnly: true — text remains selectable, never editable.',
      ),
      mockTextField(
        label: 'SHA',
        text: '7a3f1c0e89b41de2f33aa9c8ae74221406d5b4e0',
        accent: slateText,
        helper: 'Long single-line — controller doesn\'t care about width.',
      ),
    ],
    slateText,
  );

  // ---------------------------------------------------------------------------
  // Section 13 — Best practices list.
  // ---------------------------------------------------------------------------
  final List<String> bestPractices = <String>[
    'Own controllers in State; never construct them inside build().',
    'Always pair construction with dispose() in State.dispose.',
    'Prefer assigning controller.value over .text + .selection separately.',
    'Use clearComposing() if you only need to reset IME state.',
    'When mirroring text into other state, keep one addListener / one removeListener — do not re-add on every build.',
    'For onboarding forms expected to survive backgrounding, use RestorableTextEditingController.',
    'Treat .text.length as code-units, not graphemes.',
    'Validate selection offsets against text.length before assigning programmatically.',
    'Do not snapshot the value at construction time and assume it stays current — read it where you need it.',
    'For static visual demos like this one, read once and render — never subscribe.',
    'Avoid exposing the controller from a widget unless callers genuinely need access; expose .text via a callback instead.',
    'When swapping controllers (e.g. switching the bound model), always pass the new instance — never mutate the old then expect the field to detach.',
    'Wrap risky construction calls in try/catch when running through interpreted bridges that may not expose every constructor shape.',
    'Use getter shortcuts (.text) sparingly when the full .value is needed — repeated .text reads still go through the same notifier.',
    'Inspect controller.value.composing.isCollapsed when you want only "committed" text.',
  ];

  final List<Widget> bestPracticeRows = <Widget>[];
  for (int i = 0; i < bestPractices.length; i++) {
    bestPracticeRows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: inkMid,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                (i + 1).toString(),
                style: const TextStyle(
                  color: paperCream,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(bestPractices[i], style: styleBody)),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 14 — Comparative timeline (lifecycle bands).
  // ---------------------------------------------------------------------------
  Widget timelineBand(String phase, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              phase,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(description, style: styleBody)),
        ],
      ),
    );
  }

  final Widget lifecycleTimeline = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      timelineBand(
        'createState',
        'State is constructed; controller fields default to null.',
        inkMid,
      ),
      timelineBand(
        'initState',
        'Construct controllers (TextEditingController(text: seed)). They are now live ChangeNotifiers.',
        inkSoft,
      ),
      timelineBand(
        'didChangeDeps',
        'Re-bind external sources to controllers if they depend on inherited widgets.',
        sageHint,
      ),
      timelineBand(
        'build',
        'Pass controller into TextField. Read .text or .value here only for display — never mutate.',
        copperBright,
      ),
      timelineBand(
        'didUpdateWidget',
        'If the prop-supplied seed changed, decide whether to update the controller or replace it.',
        violetWash,
      ),
      timelineBand(
        'user input',
        'TextField mutates value; ChangeNotifier fires; subscribed listeners react.',
        goldLeaf,
      ),
      timelineBand(
        'submit',
        'Read controller.text once; send to backend or validator. No need to listen.',
        copperMuted,
      ),
      timelineBand(
        'dispose',
        'Call controller.dispose() before super.dispose(). Forgetting leaks the notifier.',
        crimsonInk,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 15 — Anti-pattern gallery.
  // ---------------------------------------------------------------------------
  Widget antiPatternCard(String title, String wrong, String right) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: paperEdge),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: crimsonInk,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: crimsonInk.withValues(alpha: 0.10),
              border: Border.all(color: crimsonInk.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WRONG',
                  style: TextStyle(
                    color: crimsonInk,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(wrong, style: styleMono),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: sageHint.withValues(alpha: 0.18),
              border: Border.all(color: sageHint.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RIGHT',
                  style: TextStyle(
                    color: sageHint,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(right, style: styleMono),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget antiPatternGallery = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      antiPatternCard(
        'Constructing in build()',
        'Widget build(c) {\n'
            '  final ctl = TextEditingController();\n'
            '  return TextField(controller: ctl);\n'
            '}',
        '// In State<MyForm>:\n'
            'final TextEditingController _ctl = TextEditingController();\n'
            '\n'
            'Widget build(c) => TextField(controller: _ctl);',
      ),
      antiPatternCard(
        'Forgetting dispose',
        'class _S extends State<F> {\n'
            '  final c = TextEditingController();\n'
            '  // (no dispose method!)\n'
            '}',
        'class _S extends State<F> {\n'
            '  final c = TextEditingController();\n'
            '  @override void dispose() {\n'
            '    c.dispose();\n'
            '    super.dispose();\n'
            '  }\n'
            '}',
      ),
      antiPatternCard(
        'Setting text + selection separately',
        'controller.text = "manuscript";\n'
            'controller.selection =\n'
            '    TextSelection.collapsed(offset: 10);\n'
            '// First line resets selection to -1.',
        'controller.value = const TextEditingValue(\n'
            '  text: "manuscript",\n'
            '  selection: TextSelection.collapsed(offset: 10),\n'
            ');',
      ),
      antiPatternCard(
        'Silent listener leaks',
        'controller.addListener(_onChanged);\n'
            '// removeListener never called.',
        'controller.addListener(_onChanged);\n'
            '\n'
            '@override void dispose() {\n'
            '  controller.removeListener(_onChanged);\n'
            '  controller.dispose();\n'
            '  super.dispose();\n'
            '}',
      ),
      antiPatternCard(
        'Counting characters wrong',
        'final n = controller.text.length;\n'
            '// counts UTF-16 units, not graphemes.',
        'import "package:characters/characters.dart";\n'
            'final n = controller.text.characters.length;',
      ),
      antiPatternCard(
        'Reading text mid-composition',
        'final committed = controller.text;\n'
            '// may include in-progress IME glyphs.',
        'final v = controller.value;\n'
            'final committed =\n'
            '    v.composing.isCollapsed ? v.text : null;',
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 16 — Footer.
  // ---------------------------------------------------------------------------
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28, 22, 28, 28),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [inkDeep, inkMid],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'End of atlas — Cobalt Inkwell',
          style: TextStyle(
            color: paperCream,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Static visual reference for TextEditingController. No listeners, '
          'no animations, no live mutation. The controllers above were '
          'constructed once at build time and read once for rendering — '
          'exactly the snapshot model an interpreter-bridged demo needs.',
          style: TextStyle(
            color: paperWarm,
            fontSize: 12,
            fontStyle: FontStyle.italic,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: [
            tagChip('snapshot atlas', copperBright),
            tagChip('no setState', goldLeaf),
            tagChip('no addListener', sageHint),
            tagChip('try/catch wrapped', crimsonInk),
            tagChip('Cobalt Inkwell', inkSoft),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: paperCream.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: paperCream.withValues(alpha: 0.30)),
          ),
          child: const Text(
            '“Hold the nib like a thought you do not want to lose.” — '
            'workshop motto, Inkwell Atelier.',
            style: TextStyle(
              color: paperCream,
              fontSize: 12,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Final composition.
  // ---------------------------------------------------------------------------
  print('TextEditingController deep visual demo (Cobalt Inkwell) — assembled');

  return Scaffold(
    backgroundColor: paperCream,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heroHeader,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                sectionHeader('1', 'API surface', 'The bridged members at a glance.'),
                apiTable,
                ruleHorizontal(),

                sectionHeader('2', 'Value / selection / composing inspector',
                    'Snapshot reads of every constructed controller.'),
                inspectorPanel,
                ruleHorizontal(),

                sectionHeader('3', 'TextEditingValue layout',
                    'How text, composing, and selection share the same coordinate space.'),
                valueDiagram(),
                const SizedBox(height: 12),
                const Text(
                  'TextEditingValue is the immutable triple a controller holds. '
                  'Replacing the value transactionally is preferable to setting '
                  'text and selection independently because it broadcasts a '
                  'single notification and avoids the collapsed-at-(-1) flicker.',
                  style: styleBody,
                ),
                ruleHorizontal(),

                sectionHeader('4', 'Selection snapshots',
                    'Eight visual states of TextSelection over the same text.'),
                selectionGallery,
                ruleHorizontal(),

                sectionHeader('5', 'Lifecycle prose',
                    'Why controllers want to live in State, not in build().'),
                lifecycleProse,
                ruleHorizontal(),

                sectionHeader('6', 'Pitfalls',
                    'Seven landmines that actually happen.'),
                pitfallList,
                ruleHorizontal(),

                sectionHeader('7', 'Restorable vs non-restorable',
                    'Choose by whether the value must survive process death.'),
                restorableTable,
                ruleHorizontal(),

                sectionHeader('8', 'Glossary',
                    'Vocabulary that appears across the controller surface.'),
                glossaryTable,
                ruleHorizontal(),

                sectionHeader('9', 'Palette swatches',
                    'Cobalt Inkwell — the colours of the atlas.'),
                paletteRow,
                ruleHorizontal(),

                sectionHeader('10', 'Code snippet blocks',
                    'Idiomatic patterns and the ones to avoid.'),
                codeBlocks,
                ruleHorizontal(),

                sectionHeader('11', 'Decision flowchart',
                    'A small map for "which controller do I want?"'),
                flowchart,
                ruleHorizontal(),

                sectionHeader('12', 'Scenario panels',
                    'Six visual scenarios — search, login, multi-line, form grid, filtered, readonly.'),
                scenarioSearch,
                scenarioLogin,
                scenarioMultiline,
                scenarioFormGrid,
                scenarioFiltered,
                scenarioReadonly,
                ruleHorizontal(),

                sectionHeader('13', 'Best practices',
                    'Fifteen rules — the short list that prevents most bugs.'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: bestPracticeRows,
                ),
                ruleHorizontal(),

                sectionHeader('14', 'Lifecycle timeline',
                    'Where each phase touches the controller.'),
                lifecycleTimeline,
                ruleHorizontal(),

                sectionHeader('15', 'Anti-pattern gallery',
                    'Wrong vs right — paired side by side.'),
                antiPatternGallery,
                const SizedBox(height: 16),
              ],
            ),
          ),
          footer,
        ],
      ),
    ),
  );
}

// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// Visual deep demo: CupertinoSpellCheckSuggestionsToolbar.
//
// Showcases the iOS-flavoured spell-check toolbar that appears above a
// misspelled word, offering up to a small number of suggestion buttons and a
// no-suggestion "No Replacements Found" placeholder. The widget is built on
// top of `CupertinoTextSelectionToolbar` and is wired into Flutter's text
// editing stack via `EditableText.spellCheckConfiguration` and the
// `DefaultSpellCheckService`.
//
// API recap (Cupertino):
//   const CupertinoSpellCheckSuggestionsToolbar({
//     required TextSelectionToolbarAnchors anchors,
//     required List<ContextMenuButtonItem> buttonItems,
//   });
//
// Helper constructor:
//   CupertinoSpellCheckSuggestionsToolbar.editableText({
//     required EditableTextState editableTextState,
//   });
//
// Data shape (from package:flutter/services.dart):
//   class SuggestionSpan {
//     final TextRange range;
//     final List<String> suggestions;
//   }
//
// Default suggestion limit on iOS toolbar: _kMaxSuggestions == 3 plus a
// "No Replacements Found" placeholder when the suggestion list is empty.

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Palette tuned to match real iOS-light / iOS-dark spell-check chrome.
// ---------------------------------------------------------------------------

class IosPalette {
  static const Color background = Color(0xFFF2F2F7);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color toolbarBackground = Color(0xCCFFFFFF);
  static const Color toolbarBackgroundDark = Color(0xCC1D1D1F);
  static const Color toolbarBorder = Color(0x33000000);
  static const Color separator = Color(0x33C6C6C8);
  static const Color highlight = Color(0xFF007AFF);
  static const Color destructive = Color(0xFFFF3B30);
  static const Color subtleText = Color(0xFF8E8E93);
  static const Color primaryText = Color(0xFF1C1C1E);
  static const Color cautionAmber = Color(0xFFFFCC00);
  static const Color softShadow = Color(0x22000000);
  static const Color underlineRed = Color(0xFFFF3B30);
  static const Color highlightChip = Color(0xFFE5E5EA);
}

// ---------------------------------------------------------------------------
// Sample data: typo to suggestions mapping that mirrors realistic
// `SuggestionSpan` payloads emitted by `DefaultSpellCheckService`.
// ---------------------------------------------------------------------------

class TypoSample {
  final String typo;
  final List<String> suggestions;
  final String contextSentence;
  final TextRange range;
  const TypoSample({
    required this.typo,
    required this.suggestions,
    required this.contextSentence,
    required this.range,
  });
}

const List<TypoSample> typoSamples = <TypoSample>[
  TypoSample(
    typo: 'teh',
    suggestions: <String>['the', 'them', 'then'],
    contextSentence: 'I went to teh store yesterday.',
    range: TextRange(start: 10, end: 13),
  ),
  TypoSample(
    typo: 'recieve',
    suggestions: <String>['receive', 'receiver', 'receives'],
    contextSentence: 'Did you recieve the package?',
    range: TextRange(start: 8, end: 15),
  ),
  TypoSample(
    typo: 'occured',
    suggestions: <String>['occurred', 'occurs', 'occur'],
    contextSentence: 'The bug occured on launch.',
    range: TextRange(start: 8, end: 15),
  ),
  TypoSample(
    typo: 'alot',
    suggestions: <String>['a lot', 'about', 'along'],
    contextSentence: 'I learned alot from this.',
    range: TextRange(start: 10, end: 14),
  ),
];

// ---------------------------------------------------------------------------
// Build helpers for static `ContextMenuButtonItem` lists.
// ---------------------------------------------------------------------------

List<ContextMenuButtonItem> buildSuggestionButtonItems(List<String> suggestions) {
  final List<ContextMenuButtonItem> items = <ContextMenuButtonItem>[];
  for (final String suggestion in suggestions.take(3)) {
    items.add(
      ContextMenuButtonItem(
        label: suggestion,
        onPressed: () {},
      ),
    );
  }
  return items;
}

List<ContextMenuButtonItem> buildEmptyStateItems() {
  return <ContextMenuButtonItem>[
    ContextMenuButtonItem(
      label: 'No Replacements Found',
      onPressed: () {},
    ),
  ];
}

// ---------------------------------------------------------------------------
// Section scaffolding.
// ---------------------------------------------------------------------------

class SectionFrame extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget body;
  final IconData icon;
  final Color accent;

  const SectionFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
      decoration: BoxDecoration(
        color: IosPalette.cardBackground,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: IosPalette.softShadow,
            blurRadius: 14.0,
            offset: const Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14.0)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(icon, color: const Color(0xFFFFFFFF), size: 20.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xCCFFFFFF),
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: body,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Visual mock of the iOS spell-check toolbar (pixel-faithful container art).
// ---------------------------------------------------------------------------

class IosSpellToolbarMock extends StatelessWidget {
  final List<String> suggestions;
  final bool dark;
  final bool showPointer;

  const IosSpellToolbarMock({
    super.key,
    required this.suggestions,
    this.dark = false,
    this.showPointer = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = dark ? IosPalette.toolbarBackgroundDark : IosPalette.toolbarBackground;
    final Color fg = dark ? const Color(0xFFFFFFFF) : IosPalette.primaryText;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: IosPalette.toolbarBorder, width: 0.5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: IosPalette.softShadow,
                blurRadius: 10.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _buildPills(fg),
            ),
          ),
        ),
        if (showPointer)
          CustomPaint(
            size: const Size(14.0, 8.0),
            painter: ToolbarPointerPainter(color: bg),
          ),
      ],
    );
  }

  List<Widget> _buildPills(Color fg) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < suggestions.length; i++) {
      if (i > 0) {
        children.add(Container(
          width: 0.5,
          height: 30.0,
          color: IosPalette.separator,
        ));
      }
      children.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Text(
            suggestions[i],
            style: TextStyle(
              color: fg,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ),
      );
    }
    return children;
  }
}

class ToolbarPointerPainter extends CustomPainter {
  final Color color;
  ToolbarPointerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width / 2.0, size.height)
      ..close();
    final Paint paint = Paint()..color = color;
    canvas.drawPath(path, paint);
    final Paint border = Paint()
      ..color = IosPalette.toolbarBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(covariant ToolbarPointerPainter oldDelegate) =>
      oldDelegate.color != color;
}

// ---------------------------------------------------------------------------
// Code listing widget (renders multi-line snippets in monospace).
// ---------------------------------------------------------------------------

class CodeListing extends StatelessWidget {
  final String code;
  final String caption;
  const CodeListing({super.key, required this.code, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0F1115),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: Color(0xFFEAEAF2),
              fontFamily: 'Menlo',
              fontSize: 11.0,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          caption,
          style: const TextStyle(
            color: IosPalette.subtleText,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Misspelled-word ribbon used inside sentence mockups.
// ---------------------------------------------------------------------------

class MisspelledRibbon extends StatelessWidget {
  final String sentence;
  final String typo;
  const MisspelledRibbon({super.key, required this.sentence, required this.typo});

  @override
  Widget build(BuildContext context) {
    final int idx = sentence.indexOf(typo);
    final String pre = idx <= 0 ? '' : sentence.substring(0, idx);
    final String hit = idx < 0 ? '' : sentence.substring(idx, idx + typo.length);
    final String post = idx < 0 ? sentence : sentence.substring(idx + typo.length);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFE5E5EA), width: 1.0),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: IosPalette.primaryText,
            fontSize: 15.0,
            height: 1.3,
          ),
          children: <InlineSpan>[
            TextSpan(text: pre),
            TextSpan(
              text: hit,
              style: const TextStyle(
                color: IosPalette.underlineRed,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
                decorationColor: IosPalette.underlineRed,
                decorationThickness: 2.0,
              ),
            ),
            TextSpan(text: post),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1: Hero card with iOS-styled mockup of 4 suggestion pills.
// ---------------------------------------------------------------------------

Widget heroSection() {
  return SectionFrame(
    title: 'CupertinoSpellCheckSuggestionsToolbar',
    subtitle: 'Hero — anchored above a misspelled word',
    icon: CupertinoIcons.textformat_abc_dottedunderline,
    accent: IosPalette.highlight,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A cupertino-flavoured ContextMenu pinned above a misspelled word, '
          'showing up to three suggestions plus a placeholder.',
          style: TextStyle(fontSize: 13.0, color: IosPalette.primaryText),
        ),
        const SizedBox(height: 18.0),
        Center(
          child: IosSpellToolbarMock(
            suggestions: <String>['the', 'them', 'then', 'they'],
          ),
        ),
        const SizedBox(height: 14.0),
        const MisspelledRibbon(
          sentence: 'I went to teh store yesterday.',
          typo: 'teh',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _heroChip('iOS-blur background'),
            _heroChip('Rounded 8 px'),
            _heroChip('Half-pixel hairlines'),
            _heroChip('Pointer triangle'),
            _heroChip('Up to 3 suggestions'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: IosPalette.highlightChip,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11.0,
        color: IosPalette.primaryText,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: Anatomy view — labels pointer to anchor offset, list, separator,
// replace button.
// ---------------------------------------------------------------------------

Widget anatomySection() {
  return SectionFrame(
    title: 'Anatomy',
    subtitle: 'Anchor pointer, suggestion list, separators, replace action',
    icon: CupertinoIcons.rectangle_3_offgrid,
    accent: const Color(0xFF34C759),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: <Widget>[
              IosSpellToolbarMock(
                suggestions: <String>['receive', 'receiver', 'receives'],
              ),
              Positioned(
                left: -20.0,
                top: 4.0,
                child: _anatomyLabel('Suggestion pills'),
              ),
              Positioned(
                right: -20.0,
                top: 4.0,
                child: _anatomyLabel('Hairline separators'),
              ),
              Positioned(
                left: -10.0,
                bottom: -32.0,
                child: _anatomyLabel('Anchor offset (TextSelectionToolbarAnchors)'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60.0),
        const _AnatomyRow(
          dotColor: IosPalette.highlight,
          label: 'TextSelectionToolbarAnchors.primaryAnchor',
          desc: 'Pixel position above the misspelled word; the toolbar tip aligns to it.',
        ),
        const _AnatomyRow(
          dotColor: Color(0xFF34C759),
          label: 'List<ContextMenuButtonItem>',
          desc: 'Up to 3 SuggestionSpan-derived items — the rest are dropped.',
        ),
        const _AnatomyRow(
          dotColor: Color(0xFFFF9500),
          label: '0.5 px hairline separators',
          desc: 'iOS uses half-pixel separators between pills; native blur behind.',
        ),
        const _AnatomyRow(
          dotColor: Color(0xFFFF3B30),
          label: 'No Replacements Found placeholder',
          desc: 'Shown when SuggestionSpan.suggestions is empty.',
        ),
      ],
    ),
  );
}

Widget _anatomyLabel(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 9.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class _AnatomyRow extends StatelessWidget {
  final Color dotColor;
  final String label;
  final String desc;

  const _AnatomyRow({
    required this.dotColor,
    required this.label,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: IosPalette.primaryText,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: IosPalette.subtleText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3: Default-toolbar rendering using the real
// CupertinoSpellCheckSuggestionsToolbar with sample anchor + button items.
// ---------------------------------------------------------------------------

Widget defaultToolbarSection() {
  final TextSelectionToolbarAnchors anchors = TextSelectionToolbarAnchors(
    primaryAnchor: const Offset(160.0, 220.0),
    secondaryAnchor: const Offset(160.0, 200.0),
  );
  final List<ContextMenuButtonItem> items = buildSuggestionButtonItems(
    typoSamples[0].suggestions,
  );
  final CupertinoSpellCheckSuggestionsToolbar realToolbar =
      CupertinoSpellCheckSuggestionsToolbar(
    anchors: anchors,
    buttonItems: items,
  );

  return SectionFrame(
    title: 'Real Constructor',
    subtitle: 'CupertinoSpellCheckSuggestionsToolbar(anchors: ..., buttonItems: ...)',
    icon: CupertinoIcons.cube_box,
    accent: const Color(0xFFFF9500),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 260.0,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E5EA),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              // Provide a sized canvas for the toolbar to lay itself out.
              SizedBox.expand(child: realToolbar),
              Positioned(
                left: 12.0,
                bottom: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0x99000000),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'anchor=${anchors.primaryAnchor}',
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 10.0,
                      fontFamily: 'Menlo',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Constructed: ${realToolbar.runtimeType} '
          'with ${items.length} button items '
          '(max 3 enforced by _kMaxSuggestions).',
          style: const TextStyle(fontSize: 12.0, color: IosPalette.subtleText),
        ),
        const SizedBox(height: 8.0),
        const CodeListing(
          code: 'CupertinoSpellCheckSuggestionsToolbar(\n'
              '  anchors: TextSelectionToolbarAnchors(\n'
              '    primaryAnchor: Offset(160.0, 220.0),\n'
              '    secondaryAnchor: Offset(160.0, 200.0),\n'
              '  ),\n'
              '  buttonItems: <ContextMenuButtonItem>[\n'
              '    ContextMenuButtonItem(label: "the", onPressed: () {}),\n'
              '    ContextMenuButtonItem(label: "them", onPressed: () {}),\n'
              '    ContextMenuButtonItem(label: "then", onPressed: () {}),\n'
              '  ],\n'
              ')',
          caption: 'Direct constructor — no EditableText needed for static demos.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Four sample mockups — typo to suggestions.
// ---------------------------------------------------------------------------

Widget mockupSection() {
  return SectionFrame(
    title: 'Sample Mockups',
    subtitle: 'Common English typos and their suggestion sets',
    icon: CupertinoIcons.text_badge_checkmark,
    accent: const Color(0xFF5856D6),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final TypoSample sample in typoSamples) _mockupCard(sample),
      ],
    ),
  );
}

Widget _mockupCard(TypoSample sample) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFC),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFE5E5EA), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: IosPalette.underlineRed,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                sample.typo,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              CupertinoIcons.arrow_right,
              size: 14.0,
              color: IosPalette.subtleText,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Wrap(
                spacing: 6.0,
                runSpacing: 4.0,
                children: <Widget>[
                  for (final String s in sample.suggestions)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: IosPalette.highlightChip,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        s,
                        style: const TextStyle(
                          color: IosPalette.primaryText,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        MisspelledRibbon(sentence: sample.contextSentence, typo: sample.typo),
        const SizedBox(height: 10.0),
        Center(
          child: IosSpellToolbarMock(suggestions: sample.suggestions),
        ),
        const SizedBox(height: 6.0),
        Text(
          'TextRange(start: ${sample.range.start}, end: ${sample.range.end})',
          style: const TextStyle(
            color: IosPalette.subtleText,
            fontSize: 11.0,
            fontFamily: 'Menlo',
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: iOS toolbar visual layered mock with hover/press states.
// ---------------------------------------------------------------------------

Widget visualMockSection() {
  return SectionFrame(
    title: 'iOS Toolbar Visual Mock',
    subtitle: 'Rounded backdrop, separators, hover & press states',
    icon: CupertinoIcons.paintbrush,
    accent: const Color(0xFFFF2D55),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Idle state', style: _stateHeader),
        const SizedBox(height: 8.0),
        Center(child: IosSpellToolbarMock(suggestions: <String>['the', 'them', 'then'])),
        const SizedBox(height: 24.0),
        const Text('Hover state (middle pill highlighted)', style: _stateHeader),
        const SizedBox(height: 8.0),
        Center(
          child: _StateAwarePillsMock(
            suggestions: <String>['the', 'them', 'then'],
            highlightIndex: 1,
            press: false,
          ),
        ),
        const SizedBox(height: 24.0),
        const Text('Press state (first pill pressed)', style: _stateHeader),
        const SizedBox(height: 8.0),
        Center(
          child: _StateAwarePillsMock(
            suggestions: <String>['the', 'them', 'then'],
            highlightIndex: 0,
            press: true,
          ),
        ),
        const SizedBox(height: 24.0),
        const Text('Dark mode (CupertinoBrightness.dark)', style: _stateHeader),
        const SizedBox(height: 8.0),
        Center(
          child: IosSpellToolbarMock(
            suggestions: <String>['the', 'them', 'then'],
            dark: true,
          ),
        ),
        const SizedBox(height: 24.0),
        const Text('Empty state', style: _stateHeader),
        const SizedBox(height: 8.0),
        Center(
          child: IosSpellToolbarMock(
            suggestions: <String>['No Replacements Found'],
          ),
        ),
      ],
    ),
  );
}

const TextStyle _stateHeader = TextStyle(
  fontSize: 13.0,
  fontWeight: FontWeight.w600,
  color: IosPalette.primaryText,
);

class _StateAwarePillsMock extends StatelessWidget {
  final List<String> suggestions;
  final int highlightIndex;
  final bool press;

  const _StateAwarePillsMock({
    required this.suggestions,
    required this.highlightIndex,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: IosPalette.toolbarBackground,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: IosPalette.toolbarBorder, width: 0.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _buildStateAwarePills(),
            ),
          ),
        ),
        CustomPaint(
          size: const Size(14.0, 8.0),
          painter: ToolbarPointerPainter(color: IosPalette.toolbarBackground),
        ),
      ],
    );
  }

  List<Widget> _buildStateAwarePills() {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < suggestions.length; i++) {
      if (i > 0) {
        children.add(Container(
          width: 0.5,
          height: 30.0,
          color: IosPalette.separator,
        ));
      }
      final bool isHighlight = i == highlightIndex;
      Color bg = const Color(0x00000000);
      if (isHighlight) {
        bg = press ? const Color(0x33007AFF) : const Color(0x14007AFF);
      }
      children.add(
        Container(
          color: bg,
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Text(
            suggestions[i],
            style: TextStyle(
              color: isHighlight && press ? IosPalette.highlight : IosPalette.primaryText,
              fontSize: 14.0,
              fontWeight: isHighlight ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      );
    }
    return children;
  }
}

// ---------------------------------------------------------------------------
// Section 6: Comparison panel — Cupertino vs Material toolbar.
// ---------------------------------------------------------------------------

Widget comparisonSection() {
  return SectionFrame(
    title: 'Cupertino vs Material',
    subtitle: 'iOS pill-toolbar vs Android material toolbar',
    icon: CupertinoIcons.rectangle_split_3x1,
    accent: const Color(0xFF00C7BE),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Both adapt to platform conventions and are wired through the same '
          'EditableText API. The Cupertino version is a horizontally arranged '
          'pill-bar; the Material version is a popup with menu items.',
          style: TextStyle(fontSize: 13.0, color: IosPalette.primaryText),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _platformColumn(
                title: 'CupertinoSpellCheckSuggestionsToolbar',
                subtitle: 'iOS — pill row',
                child: IosSpellToolbarMock(
                  suggestions: <String>['the', 'them', 'then'],
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _platformColumn(
                title: 'SpellCheckSuggestionsToolbar',
                subtitle: 'Android — menu popup',
                child: _materialPopupMock(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E5),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: IosPalette.cautionAmber, width: 1.0),
          ),
          child: const Text(
            'Both toolbars share the same data shape (List<SuggestionSpan>) — '
            'only the visual layout differs. AdaptiveTextSelectionToolbar '
            'switches between them based on Theme.of(context).platform.',
            style: TextStyle(fontSize: 12.0, color: IosPalette.primaryText),
          ),
        ),
      ],
    ),
  );
}

Widget _platformColumn({required String title, required String subtitle, required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFC),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFE5E5EA), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: IosPalette.primaryText,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 10.0,
            color: IosPalette.subtleText,
          ),
        ),
        const SizedBox(height: 14.0),
        Center(child: child),
      ],
    ),
  );
}

Widget _materialPopupMock() {
  return Container(
    width: 160.0,
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(4.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x33000000),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final String s in <String>['the', 'them', 'then'])
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text(
              s,
              style: const TextStyle(
                fontSize: 13.0,
                color: IosPalette.primaryText,
              ),
            ),
          ),
        Container(height: 1.0, color: const Color(0xFFE5E5EA)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: const Text(
            'DELETE',
            style: TextStyle(
              fontSize: 13.0,
              color: IosPalette.destructive,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Relationship with EditableText.spellCheckConfiguration and
// DefaultSpellCheckService.
// ---------------------------------------------------------------------------

Widget pipelineSection() {
  return SectionFrame(
    title: 'Spell-check pipeline',
    subtitle: 'EditableText → SpellCheckConfiguration → DefaultSpellCheckService',
    icon: CupertinoIcons.arrow_3_trianglepath,
    accent: const Color(0xFFAF52DE),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PipelineStep(
          n: '1',
          title: 'EditableText.spellCheckConfiguration',
          desc: 'Opt in by passing a SpellCheckConfiguration to EditableText / CupertinoTextField.',
        ),
        const _PipelineStep(
          n: '2',
          title: 'DefaultSpellCheckService',
          desc: 'Calls into the platform spell-checker (iOS UITextChecker / Android suggestions).',
        ),
        const _PipelineStep(
          n: '3',
          title: 'List<SuggestionSpan> from services.dart',
          desc: 'Each span describes a TextRange and up to N suggestions for the misspelled slice.',
        ),
        const _PipelineStep(
          n: '4',
          title: 'spellCheckSuggestionsToolbarBuilder',
          desc: 'Builds the toolbar widget from EditableTextState — defaults adapt to platform.',
        ),
        const _PipelineStep(
          n: '5',
          title: 'CupertinoSpellCheckSuggestionsToolbar.editableText(state)',
          desc: 'Convenience constructor that derives anchors + buttonItems from EditableTextState.',
        ),
        const SizedBox(height: 12.0),
        const CodeListing(
          code: 'class SuggestionSpan {\n'
              '  final TextRange range;\n'
              '  final List<String> suggestions;\n'
              '  const SuggestionSpan(this.range, this.suggestions);\n'
              '}',
          caption: 'Defined in package:flutter/services.dart.',
        ),
      ],
    ),
  );
}

class _PipelineStep extends StatelessWidget {
  final String n;
  final String title;
  final String desc;
  const _PipelineStep({required this.n, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 26.0,
            height: 26.0,
            decoration: BoxDecoration(
              color: const Color(0xFFAF52DE),
              borderRadius: BorderRadius.circular(13.0),
            ),
            alignment: Alignment.center,
            child: Text(
              n,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: IosPalette.primaryText,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: IosPalette.subtleText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8: Recipe — wiring CupertinoTextField to spell-check.
// ---------------------------------------------------------------------------

Widget recipeSection() {
  return SectionFrame(
    title: 'Recipe',
    subtitle: 'Wire CupertinoTextField to the spell-check pipeline',
    icon: CupertinoIcons.book,
    accent: const Color(0xFFFF9500),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CodeListing(
          code: 'CupertinoTextField(\n'
              '  spellCheckConfiguration: SpellCheckConfiguration(\n'
              '    spellCheckService: DefaultSpellCheckService(),\n'
              '    spellCheckSuggestionsToolbarBuilder:\n'
              '      (BuildContext ctx, EditableTextState state) =>\n'
              '          CupertinoSpellCheckSuggestionsToolbar.editableText(\n'
              '            editableTextState: state,\n'
              '          ),\n'
              '  ),\n'
              '  // ... other CupertinoTextField props (placeholder, padding, ...)\n'
              ');',
          caption: 'Default builder is auto-selected when targetPlatform == iOS.',
        ),
        const SizedBox(height: 12.0),
        const CodeListing(
          code: 'CupertinoSpellCheckSuggestionsToolbar.editableText(\n'
              '  editableTextState: state,\n'
              ')',
          caption: 'Equivalent to manually building anchors + buttonItems from state.',
        ),
        const SizedBox(height: 12.0),
        const CodeListing(
          code: 'EditableText(\n'
              '  controller: controller,\n'
              '  focusNode: focusNode,\n'
              '  style: textStyle,\n'
              '  cursorColor: CupertinoColors.activeBlue,\n'
              '  backgroundCursorColor: CupertinoColors.inactiveGray,\n'
              '  spellCheckConfiguration: SpellCheckConfiguration(\n'
              '    spellCheckService: DefaultSpellCheckService(),\n'
              '    misspelledTextStyle:\n'
              '        CupertinoTextField.cupertinoMisspelledTextStyle,\n'
              '  ),\n'
              ');',
          caption: 'Lower-level EditableText also supports the same config.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9: Pitfalls.
// ---------------------------------------------------------------------------

Widget pitfallsSection() {
  return SectionFrame(
    title: 'Pitfalls',
    subtitle: 'Things to watch out for in production',
    icon: CupertinoIcons.exclamationmark_triangle,
    accent: const Color(0xFFFF3B30),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _PitfallTile(
          title: 'DefaultSpellCheckService is not universal',
          desc: 'On real devices it is currently iOS-only and Android-only; '
              'desktop and web fall back to no suggestions.',
        ),
        const _PitfallTile(
          title: 'Empty suggestion lists are valid',
          desc: 'A SuggestionSpan may carry an empty List<String>; the toolbar '
              'shows "No Replacements Found" instead of a pill row.',
        ),
        const _PitfallTile(
          title: 'Maximum of 3 suggestions',
          desc: '_kMaxSuggestions == 3; extra entries beyond index 2 are silently dropped.',
        ),
        const _PitfallTile(
          title: 'Anchors must be in global coordinates',
          desc: 'The toolbar positions itself using TextSelectionToolbarAnchors '
              'against the global Overlay; misaligned anchors clip off-screen.',
        ),
        const _PitfallTile(
          title: 'Disposed EditableTextState',
          desc: 'Capturing the state across frames inside a closure can crash '
              'when the field unmounts; rebuild via the toolbarBuilder callback.',
        ),
        const _PitfallTile(
          title: 'AdaptiveTextSelectionToolbar overrides',
          desc: 'If you also set selectionControls, the toolbarBuilder must '
              'cooperate with the controls menu — otherwise both render concurrently.',
        ),
      ],
    ),
  );
}

class _PitfallTile extends StatelessWidget {
  final String title;
  final String desc;
  const _PitfallTile({required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F0),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFFFC9C7), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            CupertinoIcons.exclamationmark_circle,
            color: IosPalette.destructive,
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: IosPalette.primaryText,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: IosPalette.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer.
// ---------------------------------------------------------------------------

Widget footerSection() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 32.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CupertinoSpellCheckSuggestionsToolbar — visual deep demo',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Anchors • SuggestionSpan • DefaultSpellCheckService • iOS look-and-feel',
          style: TextStyle(
            color: Color(0xCCFFFFFF),
            fontSize: 11.0,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            _footerStat('Sections', '9'),
            _footerStat('Mockups', '4'),
            _footerStat('Max sug.', '3'),
            _footerStat('Default empty', 'No Replacements Found'),
          ],
        ),
      ],
    ),
  );
}

Widget _footerStat(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Color(0x99FFFFFF),
            fontSize: 10.0,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Single static `dynamic build(BuildContext)` entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Touch the SuggestionSpan type from services.dart so the import is exercised
  // and the data shape is documented at runtime as well.
  final SuggestionSpan demoSpan = SuggestionSpan(
    const TextRange(start: 10, end: 13),
    const <String>['the', 'them', 'then'],
  );
  final List<SuggestionSpan> demoSpans = <SuggestionSpan>[
    demoSpan,
    SuggestionSpan(
      const TextRange(start: 8, end: 15),
      const <String>['receive', 'receiver', 'receives'],
    ),
    SuggestionSpan(
      const TextRange(start: 8, end: 15),
      const <String>['occurred', 'occurs', 'occur'],
    ),
    SuggestionSpan(
      const TextRange(start: 10, end: 14),
      const <String>['a lot', 'about', 'along'],
    ),
  ];

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    title: 'CupertinoSpellCheckSuggestionsToolbar Demo',
    home: CupertinoPageScaffold(
      backgroundColor: IosPalette.background,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Spell-Check Toolbar'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              heroSection(),
              anatomySection(),
              defaultToolbarSection(),
              mockupSection(),
              visualMockSection(),
              comparisonSection(),
              pipelineSection(),
              recipeSection(),
              pitfallsSection(),
              footerSection(),
              // Reference the demo data so the SuggestionSpan import
              // continues to be analyzed even if the helpers are pruned.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Loaded ${demoSpans.length} demo SuggestionSpans '
                  '(first range: ${demoSpan.range.start}..${demoSpan.range.end}).',
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: IosPalette.subtleText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

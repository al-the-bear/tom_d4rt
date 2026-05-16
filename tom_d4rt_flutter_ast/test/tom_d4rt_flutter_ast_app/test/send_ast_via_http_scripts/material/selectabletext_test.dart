// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// SelectableText — deep visual demo for the analyzer-free D4rt Flutter AST
// interpreter. The build() entry point is the only ground-truth surface; every
// other top-level symbol is a plain helper FUNCTION. There are no Stateful or
// Stateless subclasses, no controllers, no setState calls, no global state.
//
// SelectableText is the read-only sibling of Text that participates in the
// platform's selection / clipboard system. The cursor is purely visual — there
// is no editing — but the widget exposes selection handles, double-tap-to-word
// behaviour, long-press-to-paragraph behaviour on touch platforms, and a
// platform context menu (Copy / Select All / Look Up / Share). Because it
// participates in selection it has to be a leaf in the gesture tree rather
// than a pure RenderObject like Text, which means it is heavier — only use it
// where a human is plausibly going to want to copy the value.
//
// The contextual demos here cover the real reasons a designer reaches for
// SelectableText: article bodies, code blocks, license text, chat bubbles,
// log lines, transaction ids, public addresses, receipt totals. Each demo is
// labelled with a separate non-selectable Text caption so the label itself
// cannot leak into a copied range.
// ============================================================================

dynamic build(BuildContext context) {
  print('SelectableText deep demo: starting build');

  final List<Widget> sections = <Widget>[];

  sections.add(_buildHeader());
  sections.add(_sectionGap());
  sections.add(_buildSection1Anatomy());
  sections.add(_sectionGap());
  sections.add(_buildSection2Basic());
  sections.add(_sectionGap());
  sections.add(_buildSection3Rich());
  sections.add(_sectionGap());
  sections.add(_buildSection4MaxLines());
  sections.add(_sectionGap());
  sections.add(_buildSection5TextAlign());
  sections.add(_sectionGap());
  sections.add(_buildSection6CustomStyle());
  sections.add(_sectionGap());
  sections.add(_buildSection7SelectionTheme());
  sections.add(_sectionGap());
  sections.add(_buildSection8RealWorldCatalog());
  sections.add(_sectionGap());
  sections.add(_buildSection9LongContent());
  sections.add(_sectionGap());
  sections.add(_buildSection10SyntaxHighlighted());
  sections.add(_sectionGap());
  sections.add(_buildSection11EdgeCases());
  sections.add(_sectionGap());
  sections.add(_buildFooter());

  print('SelectableText deep demo: sections assembled, count=${sections.length}');

  return Container(
    color: const Color(0xFFF6F7FB),
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sections,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 0 — Header
// ---------------------------------------------------------------------------

Widget _buildHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1E3A8A), Color(0xFF2563EB)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
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
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.text_fields_outlined,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'SelectableText — copyable read-only text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'The read-only sibling of Text that lets the user mouse / touch '
          'select the rendered glyph run and copy it to the clipboard. It '
          'paints a (faux) cursor, hosts selection handles, and emits a '
          'platform context menu on long-press / right-click.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1 — Anatomy
// ---------------------------------------------------------------------------

Widget _buildSection1Anatomy() {
  return _sectionShell(
    title: '1. Anatomy of a SelectableText',
    subtitle:
        'Why SelectableText is not just Text with a flag. It opts into the '
        'selection / cursor / handle / context-menu machinery, which makes '
        'it heavier than Text and unsuitable as a default.',
    children: <Widget>[
      _bulletLine(
        label: 'Glyph run',
        body:
            'rendered identically to Text — same TextStyle, same layout, '
            'same line breaking algorithm.',
      ),
      _bulletLine(
        label: 'Cursor',
        body:
            'a vertical bar drawn at the active selection edge. Tunable via '
            'cursorWidth, cursorHeight, cursorRadius, cursorColor.',
      ),
      _bulletLine(
        label: 'Selection handles',
        body:
            'lollipops on touch platforms; on desktop the cursor and a '
            'highlight rect do the job. Color comes from the ambient '
            'TextSelectionTheme.',
      ),
      _bulletLine(
        label: 'Gestures',
        body:
            'double-tap → word, triple-tap → paragraph, long-press → handle '
            'drag, right-click → context menu.',
      ),
      _bulletLine(
        label: 'Highlight',
        body:
            'a translucent rect painted under the selected glyph run. Color '
            'comes from TextSelectionThemeData.selectionColor.',
      ),
      const SizedBox(height: 10.0),
      Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7ED),
          border: Border.all(color: const Color(0xFFFDBA74)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'Rule of thumb: use SelectableText for values a user might paste '
          'somewhere (ids, addresses, code, license keys, error messages). '
          'Use Text for ambient chrome like titles, labels, and decorative '
          'copy.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2 — Basic SelectableText
// ---------------------------------------------------------------------------

Widget _buildSection2Basic() {
  final SelectableText basic =
      const SelectableText('Plain selectable text — drag across me to copy.');

  final SelectableText sized = const SelectableText(
    'A larger basic SelectableText with no extra options.',
    style: TextStyle(fontSize: 18.0),
  );

  final SelectableText coloured = const SelectableText(
    'Colour is just a TextStyle property — same as Text.',
    style: TextStyle(fontSize: 15.0, color: Color(0xFF0F766E)),
  );

  return _sectionShell(
    title: '2. Basic SelectableText',
    subtitle:
        'The simplest possible call: a single positional String. Default '
        'theme styling is applied. Behaves exactly like Text for layout.',
    children: <Widget>[
      _labelledRow('Default style:', basic),
      _labelledRow('Larger font:', sized),
      _labelledRow('With colour:', coloured),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3 — SelectableText.rich
// ---------------------------------------------------------------------------

Widget _buildSection3Rich() {
  final SelectableText rich1 = SelectableText.rich(
    TextSpan(
      style: const TextStyle(fontSize: 15.0, color: Color(0xFF111827)),
      children: <InlineSpan>[
        const TextSpan(text: 'Order '),
        TextSpan(
          text: '#48217',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.blue.shade700,
          ),
        ),
        const TextSpan(text: ' was '),
        const TextSpan(
          text: 'shipped',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF15803D),
          ),
        ),
        const TextSpan(text: ' on '),
        TextSpan(
          text: 'Mon 5 May',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade700,
          ),
        ),
        const TextSpan(text: '. The entire sentence is one selectable run.'),
      ],
    ),
  );

  final SelectableText rich2 = SelectableText.rich(
    TextSpan(
      style: const TextStyle(fontSize: 14.5, height: 1.5),
      children: <InlineSpan>[
        const TextSpan(text: 'Mixing '),
        const TextSpan(
          text: 'bold',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const TextSpan(text: ', '),
        const TextSpan(
          text: 'italic',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const TextSpan(text: ', '),
        const TextSpan(
          text: 'underlined',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
        const TextSpan(text: ', and '),
        TextSpan(
          text: 'coloured',
          style: TextStyle(color: Colors.purple.shade600),
        ),
        const TextSpan(
          text: ' spans inside one SelectableText.rich is fine — selection '
              'spans them as one continuous run.',
        ),
      ],
    ),
  );

  final SelectableText rich3 = SelectableText.rich(
    TextSpan(
      style: const TextStyle(fontSize: 14.0, color: Color(0xFF1F2937)),
      children: <InlineSpan>[
        const TextSpan(text: 'Hello '),
        TextSpan(
          text: '@alex',
          style: TextStyle(
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const TextSpan(text: ', please review the change in '),
        TextSpan(
          text: '#pull-2148',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.deepOrange.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const TextSpan(text: ' before Friday.'),
      ],
    ),
  );

  return _sectionShell(
    title: '3. SelectableText.rich (TextSpan tree)',
    subtitle:
        'SelectableText.rich takes an InlineSpan instead of a String. The '
        'whole tree is selectable as a single run; copy / paste produces '
        'the concatenated plain text, dropping styling — which is exactly '
        'what the user expects.',
    children: <Widget>[
      _labelledRow('Status sentence:', rich1),
      _labelledRow('Inline styles:', rich2),
      _labelledRow('Mentions + refs:', rich3),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4 — maxLines + overflow
// ---------------------------------------------------------------------------

Widget _buildSection4MaxLines() {
  const String longSentence =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do '
      'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut '
      'enim ad minim veniam, quis nostrud exercitation ullamco laboris '
      'nisi ut aliquip ex ea commodo consequat.';

  final Widget clip1 = _clippedBox(
    width: 280.0,
    child: const SelectableText(
      longSentence,
      maxLines: 1,
      style: TextStyle(fontSize: 13.5, overflow: TextOverflow.ellipsis),
    ),
  );

  final Widget clip2 = _clippedBox(
    width: 280.0,
    child: const SelectableText(
      longSentence,
      maxLines: 2,
      style: TextStyle(fontSize: 13.5, overflow: TextOverflow.ellipsis),
    ),
  );

  final Widget clip3 = _clippedBox(
    width: 280.0,
    child: const SelectableText(
      longSentence,
      maxLines: 3,
      style: TextStyle(fontSize: 13.5, overflow: TextOverflow.ellipsis),
    ),
  );

  return _sectionShell(
    title: '4. maxLines + overflow',
    subtitle:
        'SelectableText does not take an overflow parameter — overflow is '
        'controlled through TextStyle.overflow and a width constraint. '
        'Combine with maxLines for ellipsised previews.',
    children: <Widget>[
      _captionedCard(
        caption: 'maxLines: 1 — single line preview, useful for table cells.',
        child: clip1,
      ),
      _captionedCard(
        caption: 'maxLines: 2 — typical card subtitle clip.',
        child: clip2,
      ),
      _captionedCard(
        caption: 'maxLines: 3 — list-row body clip.',
        child: clip3,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5 — textAlign variants
// ---------------------------------------------------------------------------

Widget _buildSection5TextAlign() {
  const String sample =
      'Quick brown fox jumps over the lazy dog. The whole sentence '
      'demonstrates how the chosen alignment redistributes whitespace.';

  return _sectionShell(
    title: '5. textAlign variants',
    subtitle:
        'textAlign only has a visible effect when the SelectableText has '
        'extra horizontal space — wrap each in a fixed-width SizedBox so '
        'the alignment is observable.',
    children: <Widget>[
      _alignCard(
        label: 'start (default for LTR)',
        align: TextAlign.start,
        sample: sample,
      ),
      _alignCard(
        label: 'end (right-edge for LTR)',
        align: TextAlign.end,
        sample: sample,
      ),
      _alignCard(
        label: 'center',
        align: TextAlign.center,
        sample: sample,
      ),
      _alignCard(
        label: 'justify (stretches whitespace)',
        align: TextAlign.justify,
        sample: sample,
      ),
    ],
  );
}

Widget _alignCard({
  required String label,
  required TextAlign align,
  required String sample,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: 340.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: SelectableText(
            sample,
            textAlign: align,
            style: const TextStyle(fontSize: 13.0, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — Custom TextStyle
// ---------------------------------------------------------------------------

Widget _buildSection6CustomStyle() {
  return _sectionShell(
    title: '6. Custom TextStyle — families, weights, decorations',
    subtitle:
        'All Text-style knobs are accepted: fontFamily, fontSize, '
        'fontWeight, fontStyle, letterSpacing, height, decoration, '
        'shadows, foreground, background.',
    children: <Widget>[
      _styleSample(
        label: 'Default family',
        text: 'The default family inherits from Theme.of(context).textTheme.',
        style: const TextStyle(fontSize: 14.0),
      ),
      _styleSample(
        label: 'Serif family',
        text: 'Serifs read well for body text, especially long passages.',
        style: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'serif',
        ),
      ),
      _styleSample(
        label: 'Monospace family',
        text: '0123-AB-cd  iI lL 1!  // tabular figures, fixed advances.',
        style: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'monospace',
        ),
      ),
      _styleSample(
        label: 'Heavy weight, wide tracking',
        text: 'HEADLINE PROOFREADER',
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w900,
          letterSpacing: 3.0,
        ),
      ),
      _styleSample(
        label: 'Italic + underline',
        text: 'caveat lector — the reader should beware',
        style: const TextStyle(
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
      _styleSample(
        label: 'Background highlight',
        text: 'inline-highlight via background paint',
        style: TextStyle(
          fontSize: 14.0,
          background: Paint()..color = const Color(0xFFFEF08A),
        ),
      ),
      _styleSample(
        label: 'Shadowed display',
        text: 'shadowed display copy',
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w800,
          color: Color(0xFF1F2937),
          shadows: <Shadow>[
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 2.0,
              color: Color(0x55000000),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _styleSample({
  required String label,
  required String text,
  required TextStyle style,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 3.0),
        SelectableText(text, style: style),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — Selection theme
// ---------------------------------------------------------------------------

Widget _buildSection7SelectionTheme() {
  final Widget warm = Theme(
    data: ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.deepOrange.shade600,
        selectionColor: Colors.deepOrange.shade100,
        selectionHandleColor: Colors.deepOrange.shade400,
      ),
    ),
    child: const SelectableText(
      'Warm theme — selection paints in soft orange, cursor in deep orange.',
      style: TextStyle(fontSize: 14.0),
    ),
  );

  final Widget cool = Theme(
    data: ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.indigo.shade700,
        selectionColor: Colors.indigo.shade100,
        selectionHandleColor: Colors.indigo.shade400,
      ),
    ),
    child: const SelectableText(
      'Cool theme — indigo highlight reads well on a white surface.',
      style: TextStyle(fontSize: 14.0),
    ),
  );

  final Widget dark = Theme(
    data: ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.amber.shade200,
        selectionColor: Colors.amber.withOpacity(0.35),
        selectionHandleColor: Colors.amber.shade300,
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(10.0),
      color: const Color(0xFF111827),
      child: const SelectableText(
        'Dark surface — amber highlight stays legible against #111827.',
        style: TextStyle(fontSize: 14.0, color: Color(0xFFF9FAFB)),
      ),
    ),
  );

  final Widget perWidgetCursor = const SelectableText(
    'Per-widget cursorColor overrides the theme cursorColor for this '
    'instance only.',
    style: TextStyle(fontSize: 14.0),
    cursorColor: Color(0xFFDC2626),
    cursorWidth: 3.0,
    cursorRadius: Radius.circular(1.5),
    showCursor: true,
  );

  return _sectionShell(
    title: '7. Selection theme (TextSelectionThemeData)',
    subtitle:
        'Wrap a SelectableText in a Theme widget to scope the selection '
        'colours. selectionHandleColor only matters on touch platforms — '
        'on desktop the highlight rectangle does the visual work.',
    children: <Widget>[
      _captionedCard(caption: 'Warm theme', child: warm),
      _captionedCard(caption: 'Cool theme', child: cool),
      _captionedCard(caption: 'Dark surface theme', child: dark),
      _captionedCard(
        caption: 'Per-widget cursor (overrides theme cursor)',
        child: perWidgetCursor,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8 — Real-world catalog
// ---------------------------------------------------------------------------

Widget _buildSection8RealWorldCatalog() {
  return _sectionShell(
    title: '8. Real-world catalog — eight scenarios',
    subtitle:
        'Each card shows a situation where SelectableText is the right '
        'choice. The caption is a normal Text so the label cannot leak '
        'into a copied range.',
    children: <Widget>[
      _scenarioArticleBody(),
      _scenarioCodeBlock(),
      _scenarioLicenseText(),
      _scenarioChatBubble(),
      _scenarioLogLine(),
      _scenarioTransactionId(),
      _scenarioPublicAddress(),
      _scenarioReceiptTotal(),
    ],
  );
}

Widget _scenarioArticleBody() {
  return _scenarioCard(
    accent: Colors.blueGrey.shade400,
    icon: Icons.article_outlined,
    title: 'Article body',
    why:
        'Readers quote paragraphs into notes, mail, Slack. The whole body '
        'must be selectable — but headings can stay non-selectable.',
    child: const SelectableText(
      'The first commercial integrated circuit was sold in 1961, a '
      'flip-flop costing US\$120. Within a decade the price had dropped '
      'by three orders of magnitude — a foretelling of the curve that '
      'would later be named after Gordon Moore.',
      style: TextStyle(fontSize: 14.0, height: 1.55),
    ),
  );
}

Widget _scenarioCodeBlock() {
  return _scenarioCard(
    accent: const Color(0xFF111827),
    icon: Icons.code,
    title: 'Code block',
    why:
        'Developers must be able to copy code verbatim. Use monospace, a '
        'fixed background, and disable wrapping with a horizontal '
        'SingleChildScrollView upstream if needed.',
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: const SelectableText(
        'void main() {\n'
        '  final greeting = \'hello world\';\n'
        '  print(greeting);\n'
        '}',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13.0,
          color: Color(0xFFE2E8F0),
          height: 1.45,
        ),
      ),
    ),
  );
}

Widget _scenarioLicenseText() {
  return _scenarioCard(
    accent: Colors.amber.shade700,
    icon: Icons.gavel_outlined,
    title: 'License text',
    why:
        'License text is reproduced verbatim across products. Users '
        'commonly select-all-copy when auditing or archiving.',
    child: Container(
      constraints: const BoxConstraints(maxHeight: 120.0),
      child: const SingleChildScrollView(
        child: SelectableText(
          'Permission is hereby granted, free of charge, to any person '
          'obtaining a copy of this software and associated documentation '
          'files (the "Software"), to deal in the Software without '
          'restriction, including without limitation the rights to use, '
          'copy, modify, merge, publish, distribute, sublicense, and/or '
          'sell copies of the Software, and to permit persons to whom '
          'the Software is furnished to do so, subject to the following '
          'conditions: The above copyright notice and this permission '
          'notice shall be included in all copies or substantial portions '
          'of the Software.',
          style: TextStyle(fontSize: 12.5, height: 1.45),
        ),
      ),
    ),
  );
}

Widget _scenarioChatBubble() {
  return _scenarioCard(
    accent: Colors.green.shade600,
    icon: Icons.chat_bubble_outline,
    title: 'Chat bubble',
    why:
        'Quote-replies are built on copy. Wrap the bubble body in a '
        'SelectableText so users can lift sentences directly.',
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12.0).copyWith(
          bottomLeft: const Radius.circular(2.0),
        ),
      ),
      child: const SelectableText(
        'Are you free to chat at 14:00? I have the staging numbers ready '
        'and would like a second pair of eyes before the standup.',
        style: TextStyle(fontSize: 14.0, height: 1.4),
      ),
    ),
  );
}

Widget _scenarioLogLine() {
  return _scenarioCard(
    accent: Colors.red.shade600,
    icon: Icons.terminal,
    title: 'Log line',
    why:
        'Engineers copy stack traces and request ids into bug reports. '
        'Use monospace and a dark surface so it visually reads as console '
        'output.',
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: const SelectableText(
        '2026-05-16 14:08:31.214Z ERROR [ingest.worker]  '
        'rid=req_8f3a21c0  unable to parse payload: '
        'FormatException: Unexpected character (at offset 142)',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.5,
          color: Color(0xFFFCA5A5),
          height: 1.4,
        ),
      ),
    ),
  );
}

Widget _scenarioTransactionId() {
  return _scenarioCard(
    accent: Colors.deepPurple.shade400,
    icon: Icons.receipt_long_outlined,
    title: 'Transaction id',
    why:
        'Support staff ask for these verbatim. Use tabular figures and a '
        'subtle background so the value reads as a token, not free text.',
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        border: Border.all(color: const Color(0xFFD1D5DB)),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: const SelectableText(
        'txn_01HF6N3Y5K9M2V4Q8X1T7B0C5A',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13.0,
          letterSpacing: 0.4,
          fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
        ),
      ),
    ),
  );
}

Widget _scenarioPublicAddress() {
  return _scenarioCard(
    accent: Colors.orange.shade700,
    icon: Icons.qr_code_2,
    title: 'Public address',
    why:
        'Addresses are case-sensitive and unforgiving. Always selectable, '
        'always monospace, ideally rendered in groups of four.',
    child: const SelectableText(
      '0x71C7 656E C766 4584 6D9C 6048 4F2D 4F2B 4D7D 2F66',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13.0,
        letterSpacing: 0.8,
        color: Color(0xFFB45309),
      ),
    ),
  );
}

Widget _scenarioReceiptTotal() {
  return _scenarioCard(
    accent: Colors.teal.shade600,
    icon: Icons.payments_outlined,
    title: 'Receipt total',
    why:
        'Bookkeepers paste totals into spreadsheets. Tabular figures keep '
        'columns aligned in the destination cell.',
    child: SelectableText.rich(
      const TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: 'Total ',
            style: TextStyle(fontSize: 14.0, color: Color(0xFF6B7280)),
          ),
          TextSpan(
            text: 'CHF 1,284.30',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F766E),
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9 — Long content
// ---------------------------------------------------------------------------

Widget _buildSection9LongContent() {
  const String body =
      'Section 9 — long content. The following paragraph is intentionally '
      'long so the surrounding ConstrainedBox(maxHeight: 160) clips it and '
      'the inner SingleChildScrollView lets the user scroll while still '
      'selecting across paragraphs. Drag from any line to any other line; '
      'the selection survives the scroll because the scroll view does not '
      'split the SelectableText into multiple selectable regions.\n\n'
      'In the early days of personal computing, selecting text meant '
      'memorising key sequences. ed had no cursor. vi gave us a cursor '
      'but no mouse. The pointer-driven select-and-copy idiom we now take '
      'for granted was invented at Xerox PARC, refined at Apple, and made '
      'universal by Microsoft. Today every flat surface that renders text '
      'is expected to honour the same gesture vocabulary: drag to select, '
      'double-tap for word, triple-tap for paragraph, long-press for the '
      'context menu.\n\n'
      'Flutter\'s SelectableText is the workhorse that delivers that '
      'expectation. It costs more than Text because it has to participate '
      'in the selection / clipboard / context-menu pipeline, but for any '
      'value the user might plausibly want to lift into another app, it '
      'is the correct default.\n\n'
      'The remainder of this paragraph is filler designed to ensure the '
      'maxHeight constraint actually clips. Pellentesque habitant morbi '
      'tristique senectus et netus et malesuada fames ac turpis egestas. '
      'Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit '
      'amet, ante. Donec eu libero sit amet quam egestas semper. Aenean '
      'ultricies mi vitae est. Mauris placerat eleifend leo.';

  return _sectionShell(
    title: '9. Long content with scroll',
    subtitle:
        'A ConstrainedBox + SingleChildScrollView gives the SelectableText '
        'a finite viewport. Selection survives the scroll — drag, scroll, '
        'continue dragging, then copy.',
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          border: Border.all(color: const Color(0xFFFCD34D)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 160.0),
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: SelectableText(
              body,
              style: TextStyle(fontSize: 13.5, height: 1.55),
            ),
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      const Text(
        'Note the scroll thumb appears only while dragging. Selection '
        'continues across the scroll boundary because both widgets live '
        'inside the same Scrollable / Selectable scope.',
        style: TextStyle(fontSize: 12.0, color: Color(0xFF6B7280)),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Syntax-highlighted SelectableText.rich
// ---------------------------------------------------------------------------

Widget _buildSection10SyntaxHighlighted() {
  final TextStyle base = const TextStyle(
    fontFamily: 'monospace',
    fontSize: 13.0,
    height: 1.55,
    color: Color(0xFFE2E8F0),
  );

  final TextStyle kw = base.copyWith(
    color: const Color(0xFF7DD3FC),
    fontWeight: FontWeight.w700,
  );
  final TextStyle type = base.copyWith(color: const Color(0xFF6EE7B7));
  final TextStyle string = base.copyWith(color: const Color(0xFFFCD34D));
  final TextStyle comment = base.copyWith(
    color: const Color(0xFF94A3B8),
    fontStyle: FontStyle.italic,
  );
  final TextStyle method = base.copyWith(color: const Color(0xFFFCA5A5));
  final TextStyle number = base.copyWith(color: const Color(0xFFC4B5FD));

  final SelectableText highlighted = SelectableText.rich(
    TextSpan(
      style: base,
      children: <InlineSpan>[
        TextSpan(text: '// Greets a user by name.\n', style: comment),
        TextSpan(text: 'class ', style: kw),
        TextSpan(text: 'Greeter ', style: type),
        const TextSpan(text: '{\n'),
        const TextSpan(text: '  '),
        TextSpan(text: 'final ', style: kw),
        TextSpan(text: 'String ', style: type),
        const TextSpan(text: 'salutation;\n\n'),
        const TextSpan(text: '  '),
        TextSpan(text: 'Greeter', style: method),
        const TextSpan(text: '({'),
        TextSpan(text: 'this', style: kw),
        const TextSpan(text: '.salutation = '),
        TextSpan(text: "'hello'", style: string),
        const TextSpan(text: '});\n\n'),
        const TextSpan(text: '  '),
        TextSpan(text: 'String ', style: type),
        TextSpan(text: 'greet', style: method),
        const TextSpan(text: '('),
        TextSpan(text: 'String ', style: type),
        const TextSpan(text: 'name) => '),
        TextSpan(text: "'\$salutation, \$name!'", style: string),
        const TextSpan(text: ';\n'),
        const TextSpan(text: '}\n\n'),
        TextSpan(text: 'void ', style: kw),
        TextSpan(text: 'main', style: method),
        const TextSpan(text: '() {\n'),
        const TextSpan(text: '  '),
        TextSpan(text: 'final ', style: kw),
        const TextSpan(text: 'g = '),
        TextSpan(text: 'Greeter', style: type),
        const TextSpan(text: '(salutation: '),
        TextSpan(text: "'hi'", style: string),
        const TextSpan(text: ');\n'),
        const TextSpan(text: '  '),
        TextSpan(text: 'print', style: method),
        const TextSpan(text: '(g.'),
        TextSpan(text: 'greet', style: method),
        const TextSpan(text: '('),
        TextSpan(text: "'world'", style: string),
        const TextSpan(text: ')); '),
        TextSpan(text: '// prints: hi, world!\n', style: comment),
        const TextSpan(text: '  '),
        TextSpan(text: 'return', style: kw),
        const TextSpan(text: ' '),
        TextSpan(text: '0', style: number),
        const TextSpan(text: ';\n'),
        const TextSpan(text: '}\n'),
      ],
    ),
  );

  return _sectionShell(
    title: '10. Syntax-highlighted SelectableText.rich',
    subtitle:
        'A single SelectableText.rich with ~30 spans renders coloured '
        'syntax. The whole snippet is one selectable run; copy strips the '
        'highlight and returns the plain source.',
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1220),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: highlighted,
      ),
      const SizedBox(height: 8.0),
      const Text(
        '~30 spans, 6 colour categories: keyword / type / string / '
        'comment / method-name / number. Selection ignores the colouring.',
        style: TextStyle(fontSize: 12.0, color: Color(0xFF6B7280)),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 11 — Edge cases
// ---------------------------------------------------------------------------

Widget _buildSection11EdgeCases() {
  return _sectionShell(
    title: '11. Edge cases',
    subtitle:
        'Three subtleties that bite once and never again: empty strings, '
        'null safety, and the surprising interaction with InkWell.',
    children: <Widget>[
      _edgeCase(
        title: 'Empty string',
        explanation:
            'SelectableText with an empty data parameter renders an '
            'invisible run of zero height. If you might receive an empty '
            'string from the model, fall back to a non-selectable '
            'placeholder Text so the layout does not collapse.',
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: _selectableOrPlaceholder(''),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '← placeholder rendered for empty input',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
      _edgeCase(
        title: 'Nullable input',
        explanation:
            'SelectableText.data is non-nullable. If your value is '
            'String?, do the null check once at the call site and pick '
            'between SelectableText and a placeholder Text.',
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: _selectableOrPlaceholderNullable(null),
            ),
            const SizedBox(width: 12.0),
            const Text(
              '← null input becomes a dimmed em-dash',
              style: TextStyle(fontSize: 12.0, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
      _edgeCase(
        title: 'Interaction with InkWell / GestureDetector',
        explanation:
            'A SelectableText placed inside an InkWell will steal the '
            'long-press / drag gestures from the InkWell. If you need both '
            'a tap target and selection, use SelectableText with its own '
            'onTap and skip the InkWell wrapper.',
        child: const SelectableText(
          'onTap fires after a single tap; selection still works via drag.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF1D4ED8),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      _edgeCase(
        title: 'textHeightBehavior',
        explanation:
            'TextHeightBehavior controls whether the first and last lines '
            'apply their full line-height. Useful for tight badges and '
            'pill-shaped tags where extra leading would push the glyph off '
            'centre.',
        child: SelectableText(
          'pill text — tight leading',
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
            applyHeightToLastDescent: false,
          ),
          style: const TextStyle(fontSize: 14.0, height: 1.0),
        ),
      ),
      _edgeCase(
        title: 'scrollPhysics',
        explanation:
            'SelectableText takes a scrollPhysics for the case where the '
            'parent imposes a finite cross-axis. NeverScrollableScrollPhysics '
            'is the common choice — let the outer scroll view handle '
            'scrolling, not the text.',
        child: const SelectableText(
          'scrollPhysics: NeverScrollableScrollPhysics()',
          scrollPhysics: NeverScrollableScrollPhysics(),
          style: TextStyle(fontSize: 14.0, fontFamily: 'monospace'),
        ),
      ),
    ],
  );
}

Widget _selectableOrPlaceholder(String value) {
  if (value.isEmpty) {
    return const Text(
      '(empty)',
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: Color(0xFF9CA3AF),
        fontSize: 13.0,
      ),
    );
  }
  return SelectableText(value, style: const TextStyle(fontSize: 13.0));
}

Widget _selectableOrPlaceholderNullable(String? value) {
  if (value == null) {
    return const Text(
      '—',
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF9CA3AF),
      ),
    );
  }
  if (value.isEmpty) {
    return _selectableOrPlaceholder(value);
  }
  return SelectableText(value, style: const TextStyle(fontSize: 13.0));
}

Widget _edgeCase({
  required String title,
  required String explanation,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            explanation,
            style: const TextStyle(
              fontSize: 12.0,
              height: 1.45,
              color: Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 8.0),
          child,
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

Widget _buildFooter() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFF111827),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Key takeaways',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6.0),
        _footerLine('Use SelectableText for any value a user might want to '
            'paste — ids, addresses, code, license keys, error messages.'),
        _footerLine('SelectableText.rich accepts an InlineSpan tree but '
            'still produces a single contiguous selection range.'),
        _footerLine('Overflow is controlled through TextStyle.overflow plus '
            'a width constraint; maxLines clips the rendered line count.'),
        _footerLine('Wrap in Theme(textSelectionTheme: ...) to scope cursor '
            'and highlight colours per region.'),
        _footerLine('Empty / null inputs need a fallback Text placeholder; '
            'do the null check at the call site.'),
      ],
    ),
  );
}

Widget _footerLine(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '• ',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12.5),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFE5E7EB),
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared layout helpers
// ---------------------------------------------------------------------------

Widget _sectionShell({
  required String title,
  required String subtitle,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE5E7EB)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 12.0),
        ...children,
      ],
    ),
  );
}

Widget _sectionGap() {
  return const SizedBox(height: 16.0);
}

Widget _bulletLine({required String label, required String body}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '• ',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xFF6B7280),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: Color(0xFF1F2937),
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: '$label — ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _labelledRow(String label, Widget child) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 3.0),
        child,
      ],
    ),
  );
}

Widget _captionedCard({required String caption, required Widget child}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          caption,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: child,
        ),
      ],
    ),
  );
}

Widget _clippedBox({required double width, required Widget child}) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxWidth: width),
    child: child,
  );
}

Widget _scenarioCard({
  required Color accent,
  required IconData icon,
  required String title,
  required String why,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 3.0,
            offset: Offset(0.0, 1.0),
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
                height: 22.0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Icon(icon, size: 18.0, color: accent),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            why,
            style: const TextStyle(
              fontSize: 12.0,
              height: 1.45,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 10.0),
          child,
        ],
      ),
    ),
  );
}

// ignore_for_file: avoid_print
// D4rt deep demo: Semantics Label Building
// Demonstrates how Flutter composes, merges, and configures accessibility
// labels — from simple labels to attributed strings, text spans, tooltips,
// sort keys, and merge strategies — the complete label-building pipeline.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  // ─── Slate / Graphite palette ───
  const Color slate = Color(0xFF708090);
  const Color graphite = Color(0xFF383838);
  const Color charcoal = Color(0xFF36454F);
  const Color silverMist = Color(0xFFC0C8D0);
  const Color ashGray = Color(0xFFB2BEB5);
  const Color darkSlate = Color(0xFF2F4F4F);
  const Color ironGray = Color(0xFF52595D);
  const Color snowDrift = Color(0xFFF5F5F5);
  const Color pencilLead = Color(0xFF4B4B4B);
  const Color fogWhite = Color(0xFFE8ECF0);

  print('[sl] ===== SEMANTICS LABEL BUILDER DEEP DEMO =====');

  // ─── Helpers declared before use ───

  Widget slSectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkSlate, charcoal],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkSlate.withValues(alpha: 0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: slate,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: silverMist, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget slExplanation(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: fogWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ashGray.withValues(alpha: 0.5)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: graphite.withValues(alpha: 0.85),
              height: 1.5)),
    );
  }

  Widget slCodeNote(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: silverMist.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(6),
        border: Border(
          left: BorderSide(color: slate, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: darkSlate,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: pencilLead)),
          ),
        ],
      ),
    );
  }

  Widget slChip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget slVisualCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ashGray.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: graphite.withValues(alpha: 0.06),
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
              color: ironGray.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkSlate)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget slTableRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader
            ? darkSlate.withValues(alpha: 0.08)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: ashGray.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((cell) {
          return Expanded(
            child: Text(cell,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? darkSlate : pencilLead)),
          );
        }).toList(),
      ),
    );
  }

  Widget slFlowDiagram(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? darkSlate : slate,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.arrow_forward, size: 14, color: graphite),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 1: What are semantic labels?
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-01] Section 1: What are semantic labels?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('01', 'What Are Semantic Labels?'),
      slExplanation(
        'Semantic labels are text descriptions attached to widgets so that '
        'assistive technologies (screen readers like TalkBack and VoiceOver) '
        'can announce them to users. Labels are the foundation of accessibility: '
        'they transform visual UI into spoken descriptions. Flutter provides '
        'multiple ways to attach, compose, merge, override, and order labels '
        'throughout the widget tree.',
      ),
      slVisualCard(
        'The Label Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            slFlowDiagram([
              'Widget tree',
              'Semantics nodes',
              'Label text',
              'Platform a11y',
              'Screen reader',
            ]),
            const SizedBox(height: 12),
            slCodeNote('label:', 'Short description of the element'),
            slCodeNote('value:', 'Current state/value of the element'),
            slCodeNote('hint:', 'Action guidance ("double tap to activate")'),
            slCodeNote('tooltip:', 'Extra context shown on hover/long-press'),
          ],
        ),
      ),
      slVisualCard(
        'Key Label Sources in Flutter',
        Column(
          children: [
            slTableRow(['Source', 'Example', 'Scope'], isHeader: true),
            slTableRow(['Semantics(label:)', '"Submit button"', 'Single node']),
            slTableRow(['TextSpan.semanticsLabel', '"dollar sign 5"', 'Inline text']),
            slTableRow(['Tooltip', '"Copy to clipboard"', 'Wrapping widget']),
            slTableRow(['Image.semanticLabel', '"Company logo"', 'Image widget']),
            slTableRow(['MergeSemantics', 'Combines children', 'Subtree merge']),
          ],
        ),
      ),
      // Live visual: a simple labeled icon vs unlabeled
      slVisualCard(
        'Labeled vs Unlabeled Icons',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Semantics(
                  label: 'Favorite this item',
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: darkSlate,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Icon(Icons.favorite, color: Colors.white, size: 28),
                  ),
                ),
                const SizedBox(height: 6),
                slChip('label: "Favorite this item"', fogWhite, darkSlate),
              ],
            ),
            Column(
              children: [
                ExcludeSemantics(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: ashGray,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Icon(Icons.favorite, color: ironGray, size: 28),
                  ),
                ),
                const SizedBox(height: 6),
                slChip('Excluded from semantics', ashGray, charcoal),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 2: Semantics(label:) — basic usage
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-02] Section 2: Semantics(label:) basic usage');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('02', 'Semantics(label:) — Basic Usage'),
      slExplanation(
        'The Semantics widget is the primary way to annotate any widget with '
        'an accessibility label. The label property is a simple string that '
        'screen readers announce when the node receives focus. It should be '
        'concise, descriptive, and in a natural sentence fragment.',
      ),
      slVisualCard(
        'Labeling a Container',
        Semantics(
          label: 'Graphite color swatch showing dark gray',
          child: Container(
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
              color: graphite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text('Graphite #383838',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          ),
        ),
      ),
      slVisualCard(
        'Multiple Labeled Controls',
        Column(
          children: [
            Semantics(
              label: 'Search field',
              textField: true,
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: fogWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: slate),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(Icons.search, color: slate, size: 20),
                    const SizedBox(width: 8),
                    Text('Search...',
                        style: TextStyle(color: ashGray, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    label: 'Cancel action',
                    button: true,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: ashGray,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Semantics(
                    label: 'Confirm action',
                    button: true,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: darkSlate,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text('Confirm',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      slCodeNote('label:', 'A concise description read by screen readers'),
      slCodeNote('button: true', 'Marks the node as a button role'),
      slCodeNote('textField: true', 'Marks the node as a text input role'),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 3: label + value + hint trifecta
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-03] Section 3: label + value + hint trifecta');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('03', 'Label + Value + Hint — The Trifecta'),
      slExplanation(
        'Screen readers typically announce three pieces of information: '
        'the label (what it is), the value (current state), and the hint '
        '(how to interact). Together they form the complete auditory picture. '
        'For example: "Volume, 70%, double tap to adjust".',
      ),
      slVisualCard(
        'Volume Slider Semantics',
        Semantics(
          label: 'Volume',
          value: '70%',
          hint: 'Double tap to adjust',
          slider: true,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.volume_up, color: darkSlate, size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: ashGray.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: darkSlate,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('70%',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: charcoal)),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: snowDrift,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: slate.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Screen reader announces:',
                        style: TextStyle(
                            fontSize: 11,
                            color: ironGray,
                            fontStyle: FontStyle.italic)),
                    const SizedBox(height: 4),
                    Text('"Volume, 70%, slider, double tap to adjust"',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: darkSlate)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      slVisualCard(
        'Trifecta Breakdown',
        Column(
          children: [
            slTableRow(['Property', 'Purpose', 'Announced'], isHeader: true),
            slTableRow(['label', 'Identity', 'First — "Volume"']),
            slTableRow(['value', 'Current state', 'Second — "70%"']),
            slTableRow(['hint', 'Interaction guide', 'Last — "double tap to adjust"']),
          ],
        ),
      ),
      // A different example: toggle switch
      slVisualCard(
        'Toggle Switch — Label, Value & Hint',
        Semantics(
          label: 'Dark mode',
          value: 'On',
          hint: 'Double tap to toggle',
          toggled: true,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: graphite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.dark_mode, color: Colors.white, size: 22),
                    const SizedBox(width: 10),
                    const Text('Dark Mode',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
                Container(
                  width: 44,
                  height: 24,
                  decoration: BoxDecoration(
                    color: slate,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 4: TextSpan.semanticsLabel
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-04] Section 4: TextSpan.semanticsLabel');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('04', 'TextSpan.semanticsLabel — Inline Override'),
      slExplanation(
        'TextSpan has a semanticsLabel property that overrides what screen '
        'readers announce for that span. This is essential when the visual text '
        'differs from what should be spoken — e.g., showing "\$5" visually '
        'but announcing "5 dollars", or showing an emoji with a description.',
      ),
      slVisualCard(
        'Price Display — Visual vs Spoken',
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: snowDrift,
                borderRadius: BorderRadius.circular(8),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$',
                      semanticsLabel: '',
                      style: TextStyle(
                          fontSize: 22, color: slate, fontWeight: FontWeight.w300),
                    ),
                    TextSpan(
                      text: '49',
                      semanticsLabel: '49 dollars',
                      style: TextStyle(
                          fontSize: 36,
                          color: darkSlate,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '.99',
                      semanticsLabel: 'and 99 cents',
                      style: TextStyle(
                          fontSize: 18, color: ironGray, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: fogWhite,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: ashGray.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      slChip('Visual', darkSlate, Colors.white),
                      const SizedBox(width: 8),
                      Text('\$49.99',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600, color: charcoal)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      slChip('Spoken', slate, Colors.white),
                      const SizedBox(width: 8),
                      Text('"49 dollars and 99 cents"',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: charcoal,
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      slVisualCard(
        'Emoji with Semantic Labels',
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: snowDrift,
            borderRadius: BorderRadius.circular(8),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 18, color: charcoal),
              children: [
                const TextSpan(text: 'Rating: '),
                TextSpan(
                  text: '\u2B50\u2B50\u2B50\u2B50',
                  semanticsLabel: '4 out of 5 stars',
                  style: const TextStyle(fontSize: 22),
                ),
                TextSpan(
                  text: '\u2606',
                  semanticsLabel: '',
                  style: TextStyle(fontSize: 22, color: ashGray),
                ),
              ],
            ),
          ),
        ),
      ),
      slCodeNote('semanticsLabel:', 'Overrides the spoken text for this span'),
      slCodeNote('Empty string ""', 'Suppresses announcement of that span entirely'),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 5: AttributedString — rich label annotations
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-05] Section 5: AttributedString rich label annotations');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('05', 'AttributedString — Rich Label Annotations'),
      slExplanation(
        'For more control than a plain label string, Flutter provides '
        'AttributedString with StringAttribute annotations. These allow '
        'attaching locale and spell-out hints to specific ranges within '
        'a semantic label. For example, marking a foreign word with its '
        'language so the screen reader pronounces it correctly.',
      ),
      slVisualCard(
        'AttributedString Anatomy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual: the string with highlighted attributed ranges
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: snowDrift,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Label: "Welcome to the café, enjoy your croissant"',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          color: charcoal)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Ranges:  ',
                          style: TextStyle(fontSize: 12, color: ironGray)),
                      slChip('café → fr', darkSlate, Colors.white),
                      const SizedBox(width: 6),
                      slChip('croissant → fr', slate, Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            slCodeNote('LocaleStringAttribute',
                'Tells the TTS engine to switch voice for that range'),
            slCodeNote('SpellOutStringAttribute',
                'Forces letter-by-letter reading (e.g., abbreviations)'),
          ],
        ),
      ),
      slVisualCard(
        'Spell-Out Pattern: Serial Number',
        Semantics(
          attributedLabel: AttributedString(
            'Serial: ABC123',
            attributes: <StringAttribute>[
              ui.SpellOutStringAttribute(range: const TextRange(start: 8, end: 14)),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: graphite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.qr_code, color: silverMist, size: 32),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Serial Number',
                        style: TextStyle(color: Colors.white70, fontSize: 11)),
                    const Text('ABC123',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                            letterSpacing: 3)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: fogWhite,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'Screen reader: "Serial: A, B, C, 1, 2, 3" (spells out each character)',
          style: TextStyle(
              fontSize: 12, fontStyle: FontStyle.italic, color: ironGray),
        ),
      ),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 6: RichText label composition
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-06] Section 6: RichText label composition');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('06', 'RichText — Composed Semantic Labels'),
      slExplanation(
        'When RichText contains multiple TextSpan children, Flutter composes '
        'the semantic label by concatenating each span\'s semanticsLabel (or '
        'text if no semanticsLabel). This automatic composition is how complex '
        'inline text stays accessible without manual label assembly.',
      ),
      slVisualCard(
        'Status Message Composition',
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: snowDrift,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 15, color: charcoal),
                  children: [
                    const TextSpan(text: 'Server '),
                    TextSpan(
                      text: 'prod-west-2',
                      semanticsLabel: 'production west 2',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkSlate,
                          fontFamily: 'monospace'),
                    ),
                    const TextSpan(text: ' has been '),
                    TextSpan(
                      text: 'UP',
                      semanticsLabel: 'running',
                      style: TextStyle(
                          color: const Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' for '),
                    TextSpan(
                      text: '14d 7h',
                      semanticsLabel: '14 days and 7 hours',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: darkSlate),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: slate.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Composed label:',
                        style: TextStyle(fontSize: 11, color: ironGray)),
                    const SizedBox(height: 3),
                    Text(
                      '"Server production west 2 has been running for 14 days and 7 hours"',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: darkSlate,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      slVisualCard(
        'Span-by-Span Breakdown',
        Column(
          children: [
            slTableRow(['Visual Text', 'semanticsLabel', 'Announced As'],
                isHeader: true),
            slTableRow(['"Server "', '(none)', '"Server "'], ),
            slTableRow(['"prod-west-2"', '"production west 2"', '"production west 2"']),
            slTableRow(['" has been "', '(none)', '" has been "']),
            slTableRow(['"UP"', '"running"', '"running"']),
            slTableRow(['" for "', '(none)', '" for "']),
            slTableRow(['"14d 7h"', '"14 days and 7 hours"', '"14 days and 7 hours"']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 7: MergeSemantics — combining children
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-07] Section 7: MergeSemantics — combining children');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('07', 'MergeSemantics — Combining Child Labels'),
      slExplanation(
        'MergeSemantics merges all descendant semantic nodes into a single '
        'node. This means screen readers announce the merged content as one '
        'entity rather than focusing on each child individually. Essential for '
        'list items, cards, and composite controls where multiple text and '
        'icon widgets form a single logical element.',
      ),
      slVisualCard(
        'Without MergeSemantics (3 focusable nodes)',
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: snowDrift,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ashGray),
              ),
              child: Row(
                children: [
                  Semantics(
                    label: 'User avatar',
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: slate,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 22),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          label: 'Jane Doe',
                          child: Text('Jane Doe',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: charcoal,
                                  fontSize: 14)),
                        ),
                        Semantics(
                          label: 'Online 5 minutes ago',
                          child: Text('Online 5 min ago',
                              style: TextStyle(fontSize: 12, color: ironGray)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            slChip('3 separate focus targets', ashGray, charcoal),
          ],
        ),
      ),
      slVisualCard(
        'With MergeSemantics (1 merged node)',
        Column(
          children: [
            MergeSemantics(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: snowDrift,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: darkSlate, width: 1.5),
                ),
                child: Row(
                  children: [
                    Semantics(
                      label: 'User avatar',
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: darkSlate,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.person, color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jane Doe',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: charcoal,
                                  fontSize: 14)),
                          Text('Online 5 min ago',
                              style: TextStyle(fontSize: 12, color: ironGray)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            slChip('1 merged focus target', darkSlate, Colors.white),
          ],
        ),
      ),
      slVisualCard(
        'Merge vs Separate — Decision Guide',
        Column(
          children: [
            slTableRow(['Scenario', 'Strategy', 'Why'], isHeader: true),
            slTableRow(['List item card', 'Merge', 'One logical entity']),
            slTableRow(['Form fields', 'Separate', 'Each needs individual focus']),
            slTableRow(['Nav bar item', 'Merge', 'Icon + label = one tab']),
            slTableRow(['Mixed buttons', 'Separate', 'Each has its own action']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 8: Tooltip labels
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-08] Section 8: Tooltip labels');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('08', 'Tooltip — Contextual Label Layer'),
      slExplanation(
        'Tooltip adds an extra semantic layer. On hover/long-press it shows a '
        'visual popup, but more importantly it contributes to the semantic tree. '
        'The tooltip message is announced by screen readers as additional context. '
        'When combined with a child that has its own label, both are available '
        'to assistive technology.',
      ),
      slVisualCard(
        'Icon Buttons with Tooltip Labels',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _slTooltipButton(Icons.content_copy, 'Copy', darkSlate, silverMist),
            _slTooltipButton(Icons.content_paste, 'Paste', charcoal, silverMist),
            _slTooltipButton(Icons.delete_outline, 'Delete', ironGray, silverMist),
            _slTooltipButton(Icons.share, 'Share', slate, silverMist),
          ],
        ),
      ),
      slVisualCard(
        'Tooltip vs Semantics Label',
        Column(
          children: [
            slTableRow(['Property', 'When Announced', 'Visual Effect'], isHeader: true),
            slTableRow(['Semantics(label:)', 'On focus', 'None']),
            slTableRow(['Tooltip(message:)', 'On focus + long-press', 'Popup shown']),
            slTableRow(['Both combined', 'Both announced', 'Popup + label']),
          ],
        ),
      ),
      slCodeNote('Tooltip(message:)',
          'Shows popup visually AND adds to semantic tree'),
      slCodeNote('excludeFromSemantics:',
          'Set true on Tooltip to suppress its semantic contribution'),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 9: Image semantic labeling
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-09] Section 9: Image semantic labeling');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('09', 'Image & Icon Semantic Labels'),
      slExplanation(
        'Images and icons are inherently non-textual. Without semantic labels, '
        'they are invisible to screen reader users. Flutter\'s Image widget has '
        'a semanticLabel parameter, and Icon widgets get their label from '
        'Semantics wrapping or the semanticLabel on Image.',
      ),
      slVisualCard(
        'Labeled Image Placeholders',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _slLabeledImage(Icons.landscape, 'Mountain landscape photo',
                darkSlate, 'Landscape'),
            _slLabeledImage(Icons.portrait, 'Portrait of a person',
                charcoal, 'Portrait'),
            _slLabeledImage(Icons.pets, 'Photo of a pet dog',
                ironGray, 'Pet photo'),
          ],
        ),
      ),
      slVisualCard(
        'Decorative vs Informative Images',
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    label: 'Company logo — Acme Corp',
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: darkSlate,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('ACME',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ExcludeSemantics(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: ashGray.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.texture, color: ashGray, size: 24),
                            const SizedBox(height: 4),
                            Text('Decorative',
                                style: TextStyle(
                                    fontSize: 10, color: ironGray)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: slChip('Informative: labeled', darkSlate, Colors.white)),
                const SizedBox(width: 8),
                Expanded(child: slChip('Decorative: excluded', ashGray, charcoal)),
              ],
            ),
          ],
        ),
      ),
      slCodeNote('Image.semanticLabel:', 'Direct label on Image widget'),
      slCodeNote('ExcludeSemantics', 'Removes decorative images from a11y tree'),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 10: Label ordering with SortKey
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-10] Section 10: Label ordering with SortKey');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('10', 'Label Ordering — OrdinalSortKey'),
      slExplanation(
        'By default, screen readers traverse the semantic tree in paint order '
        '(which follows the widget tree). OrdinalSortKey lets you override '
        'this to control the exact focus/traversal order. This is critical '
        'when the visual layout doesn\'t match the logical reading order.',
      ),
      slVisualCard(
        'Custom Reading Order',
        Column(
          children: [
            // A layout where visual order differs from logical order
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    sortKey: const OrdinalSortKey(2),
                    label: 'Product description — read second',
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: slate.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: slate),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Description',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkSlate)),
                            slChip('Sort: 2', slate, Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Semantics(
                    sortKey: const OrdinalSortKey(1),
                    label: 'Product title — read first',
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: darkSlate,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Title',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.white)),
                            slChip('Sort: 1', silverMist, darkSlate),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    sortKey: const OrdinalSortKey(3),
                    label: 'Buy button — read third',
                    button: true,
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: charcoal,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Buy Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            slChip('Sort: 3', silverMist, darkSlate),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            slFlowDiagram(['Title (1)', 'Description (2)', 'Buy Now (3)']),
          ],
        ),
      ),
      slCodeNote('OrdinalSortKey(n)', 'Lower values are traversed first'),
      slCodeNote('OrdinalSortKey(n, name:)',
          'Optional group name for scoped ordering'),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 11: ExcludeSemantics & BlockSemantics
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-11] Section 11: ExcludeSemantics & BlockSemantics');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('11', 'Removing Labels — Exclude & Block'),
      slExplanation(
        'Sometimes you need to REMOVE widgets from the semantic tree. '
        'ExcludeSemantics drops a subtree from semantics entirely. '
        'BlockSemantics prevents siblings painted BEFORE it from being '
        'included — like a dialog blocking the background page.',
      ),
      slVisualCard(
        'ExcludeSemantics — Hiding Decorative Content',
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Semantics(
                    label: 'Visible to screen readers',
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: darkSlate,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('Included',
                            style: TextStyle(color: Colors.white, fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  slChip('In a11y tree', darkSlate, Colors.white),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  ExcludeSemantics(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: ashGray.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: ashGray, style: BorderStyle.solid),
                      ),
                      child: Center(
                        child: Text('Excluded',
                            style: TextStyle(color: ironGray, fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  slChip('Not in a11y tree', ashGray, charcoal),
                ],
              ),
            ),
          ],
        ),
      ),
      slVisualCard(
        'BlockSemantics — Dialog Blocking Pattern',
        Stack(
          children: [
            // Background (would be blocked)
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: fogWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Background Content',
                      style: TextStyle(fontSize: 14, color: ashGray)),
                  Text('(blocked by dialog overlay)',
                      style: TextStyle(fontSize: 11, color: ashGray)),
                ],
              ),
            ),
            // Dialog overlay with BlockSemantics
            Positioned.fill(
              child: BlockSemantics(
                child: Container(
                  decoration: BoxDecoration(
                    color: charcoal.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Confirmation',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: charcoal)),
                          const SizedBox(height: 4),
                          Text('Only this dialog is in the a11y tree',
                              style: TextStyle(fontSize: 12, color: ironGray)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      slVisualCard(
        'Exclude vs Block Comparison',
        Column(
          children: [
            slTableRow(['Widget', 'What It Does', 'Use Case'], isHeader: true),
            slTableRow([
              'ExcludeSemantics',
              'Removes own subtree',
              'Decorative images',
            ]),
            slTableRow([
              'BlockSemantics',
              'Blocks earlier siblings',
              'Dialogs, overlays',
            ]),
            slTableRow([
              'Semantics(excludeSemantics:)',
              'Replaces children',
              'Custom summary',
            ]),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 12: Custom Semantics Actions
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-12] Section 12: Custom semantics actions');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('12', 'Custom Actions — Labeled Interactions'),
      slExplanation(
        'Beyond standard actions (tap, long-press, scroll), Semantics supports '
        'customSemanticsActions — a map of CustomSemanticsAction to callbacks. '
        'Each action has a label that screen readers announce, giving users '
        'access to custom gestures through the accessibility menu.',
      ),
      slVisualCard(
        'Swipe Actions on a List Item',
        Semantics(
          label: 'Email from John Smith',
          customSemanticsActions: <CustomSemanticsAction, VoidCallback>{
            const CustomSemanticsAction(label: 'Archive'): () {
              print('[sl] Custom action: Archive');
            },
            const CustomSemanticsAction(label: 'Mark as read'): () {
              print('[sl] Custom action: Mark as read');
            },
            const CustomSemanticsAction(label: 'Star'): () {
              print('[sl] Custom action: Star');
            },
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: snowDrift,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: slate.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: darkSlate,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Center(
                        child: Text('JS',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Smith',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: charcoal)),
                          Text('Meeting tomorrow at 10am',
                              style: TextStyle(fontSize: 12, color: ironGray)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    slChip('Archive', darkSlate, Colors.white),
                    const SizedBox(width: 6),
                    slChip('Mark as read', slate, Colors.white),
                    const SizedBox(width: 6),
                    slChip('Star', ironGray, Colors.white),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Custom actions available via a11y menu',
                    style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: ironGray)),
              ],
            ),
          ),
        ),
      ),
      slCodeNote('CustomSemanticsAction(label:)',
          'Each action gets a readable label for the a11y menu'),
      slCodeNote('customSemanticsActions:',
          'Map<CustomSemanticsAction, VoidCallback> on Semantics'),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 13: Semantic boolean flags
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-13] Section 13: Semantic boolean flags');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('13', 'Boolean Flags — Role & State Labels'),
      slExplanation(
        'Semantics has many boolean flags that implicitly add role labels. '
        'Setting button: true makes the node announce as a button. These '
        'flags generate platform-specific role descriptions that become '
        'part of the overall announcement, effectively adding "labels" '
        'that describe what the element IS, not just what it says.',
      ),
      slVisualCard(
        'Role Flags Gallery',
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _slFlagDemo('button: true', Icons.touch_app,
                      'Announces as button', darkSlate),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _slFlagDemo('link: true', Icons.link,
                      'Announces as link', charcoal),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _slFlagDemo('header: true', Icons.title,
                      'Announces as heading', slate),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _slFlagDemo('image: true', Icons.image,
                      'Announces as image', ironGray),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _slFlagDemo('slider: true', Icons.tune,
                      'Announces as slider', pencilLead),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _slFlagDemo('textField: true', Icons.edit,
                      'Announces as text field', graphite),
                ),
              ],
            ),
          ],
        ),
      ),
      slVisualCard(
        'State Flags',
        Column(
          children: [
            slTableRow(['Flag', 'Effect on Announcement', 'Example'],
                isHeader: true),
            slTableRow(['checked: true', '"checked"', 'Checkbox']),
            slTableRow(['selected: true', '"selected"', 'List item']),
            slTableRow(['toggled: true', '"on"', 'Switch']),
            slTableRow(['enabled: false', '"disabled"', 'Grayed out button']),
            slTableRow(['focused: true', '"focused"', 'Active field']),
            slTableRow(['hidden: true', 'Skipped by reader', 'Off-screen item']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 14: textDirection on labels
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-14] Section 14: textDirection on labels');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('14', 'Label Text Direction — RTL/LTR'),
      slExplanation(
        'Semantics has a textDirection property that tells the screen reader '
        'which direction the label text flows. This is essential for mixed-'
        'direction UIs where some labels are in Arabic/Hebrew (RTL) and '
        'others in English (LTR). Without correct textDirection, screen '
        'readers may mispronounce or jumble bidirectional text.',
      ),
      slVisualCard(
        'LTR vs RTL Label Direction',
        Column(
          children: [
            Semantics(
              label: 'Left to right label',
              textDirection: TextDirection.ltr,
              child: Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: darkSlate,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    const Text('English label (LTR)',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                    const Spacer(),
                    slChip('textDirection.ltr', silverMist, darkSlate),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            Semantics(
              label: 'Right to left label example',
              textDirection: TextDirection.rtl,
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: charcoal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    slChip('textDirection.rtl', silverMist, charcoal),
                    const Spacer(),
                    const Text('RTL label direction',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      slCodeNote('textDirection:', 'Controls announcement direction for the label'),
      slCodeNote('Important:', 'Inherited from ambient Directionality if not set'),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 15: Testing semantic labels
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-15] Section 15: Testing semantic labels');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('15', 'Testing Labels — Verification Patterns'),
      slExplanation(
        'Flutter provides tools for verifying semantic labels in widget tests: '
        'find.bySemanticsLabel() locates widgets by their announced label, '
        'SemanticsHandle exposes the tree for inspection, and the Semantics '
        'debugger overlay shows annotations visually during development.',
      ),
      slVisualCard(
        'Test Patterns Reference',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            slCodeNote('find.bySemanticsLabel()',
                'Locates widget by its semantic label string or RegExp'),
            slCodeNote('tester.getSemantics()',
                'Gets SemanticsNode for a finder result'),
            slCodeNote('SemanticsFlag',
                'Enum for checking specific flags on a node'),
            slCodeNote('SemanticsAction',
                'Enum for checking available actions on a node'),
          ],
        ),
      ),
      slVisualCard(
        'Common Label Mistakes to Test For',
        Column(
          children: [
            _slMistakeRow(Icons.warning, 'Missing labels on interactive elements',
                'Every button/link needs a label'),
            _slMistakeRow(Icons.warning, 'Redundant labels',
                '"Button button" when button: true + label: "Button"'),
            _slMistakeRow(Icons.warning, 'Labels that describe appearance',
                '"Red circle" instead of "Error indicator"'),
            _slMistakeRow(Icons.warning, 'Labels with technical jargon',
                '"onClick handler" instead of "Submit form"'),
            _slMistakeRow(Icons.check_circle, 'Good: functional description',
                '"Search for products" on search icon'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION 16: Summary Dashboard
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  print('[sl-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      slSectionBanner('16', 'Summary Dashboard'),
      // Feature coverage grid
      slVisualCard(
        'Label Building Features Covered',
        Column(
          children: [
            slTableRow(['Feature', 'Section', 'Key Takeaway'], isHeader: true),
            slTableRow(['Semantics(label:)', 'S02', 'Basic label on any widget']),
            slTableRow(['label + value + hint', 'S03', 'Complete trifecta']),
            slTableRow(['TextSpan.semanticsLabel', 'S04', 'Inline text override']),
            slTableRow(['AttributedString', 'S05', 'Locale & spell-out']),
            slTableRow(['RichText composition', 'S06', 'Auto-concatenation']),
            slTableRow(['MergeSemantics', 'S07', 'Combine children']),
            slTableRow(['Tooltip labels', 'S08', 'Contextual layer']),
            slTableRow(['Image labels', 'S09', 'Alt-text equivalent']),
            slTableRow(['OrdinalSortKey', 'S10', 'Custom reading order']),
            slTableRow(['Exclude/Block', 'S11', 'Removing from tree']),
            slTableRow(['Custom actions', 'S12', 'Labeled interactions']),
            slTableRow(['Boolean flags', 'S13', 'Role + state labels']),
            slTableRow(['textDirection', 'S14', 'RTL/LTR control']),
            slTableRow(['Testing labels', 'S15', 'Verification tools']),
          ],
        ),
      ),
      // Theme showcase
      slVisualCard(
        'Slate / Graphite Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _slColorDot('Slate', slate),
            _slColorDot('Graphite', graphite),
            _slColorDot('Charcoal', charcoal),
            _slColorDot('Silver', silverMist),
            _slColorDot('Dark Slate', darkSlate),
          ],
        ),
      ),
      // Final note
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkSlate, charcoal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('Semantic Label Building — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'Labels are the bridge between visual UI and spoken accessibility. '
              'This demo covered every mechanism Flutter provides for creating, '
              'composing, ordering, and filtering semantic labels.',
              style: TextStyle(
                  color: silverMist, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[sl] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Semantics Label Building'),
        backgroundColor: darkSlate,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF2F3F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
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
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers (declared outside build)
// ═══════════════════════════════════════════════════

Widget _slTooltipButton(IconData icon, String tip, Color bg, Color fg) {
  return Tooltip(
    message: tip,
    child: Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: fg, size: 22),
        ],
      ),
    ),
  );
}

Widget _slLabeledImage(
    IconData icon, String accessLabel, Color bg, String displayLabel) {
  return Semantics(
    label: accessLabel,
    image: true,
    child: Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 4),
        Text(displayLabel,
            style: TextStyle(fontSize: 11, color: bg)),
      ],
    ),
  );
}

Widget _slFlagDemo(String flag, IconData icon, String desc, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 6),
        Text(flag,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: color)),
        const SizedBox(height: 3),
        Text(desc,
            style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8)),
            textAlign: TextAlign.center),
      ],
    ),
  );
}

Widget _slMistakeRow(IconData icon, String title, String detail) {
  const Color ironGray = Color(0xFF52595D);
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            size: 18,
            color: icon == Icons.check_circle
                ? const Color(0xFF2E7D32)
                : const Color(0xFFE65100)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              Text(detail,
                  style: TextStyle(fontSize: 11, color: ironGray)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _slColorDot(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
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
      const SizedBox(height: 4),
      Text(name, style: const TextStyle(fontSize: 9)),
    ],
  );
}

// ignore_for_file: avoid_print
// D4rt deep demo: ScribbleClient — the interface that enables Apple
// Pencil Scribble handwriting-to-text input on iPadOS, allowing users
// to write directly into text fields with a stylus.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Teal / Cyan palette ───
  const Color teal = Color(0xFF0D9488);
  const Color cyan = Color(0xFF22D3EE);
  const Color deepTeal = Color(0xFF115E59);
  const Color paleCyan = Color(0xFFECFEFF);
  const Color aquamarine = Color(0xFF14B8A6);
  const Color pool = Color(0xFF99F6E4);
  const Color cerulean = Color(0xFF0891B2);
  const Color abyss = Color(0xFF134E4A);
  const Color mist = Color(0xFFCCFBF1);
  const Color lagoon = Color(0xFF2DD4BF);

  print('[wr] ===== SCRIBBLE CLIENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget wrBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [abyss, deepTeal],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: abyss.withValues(alpha: 0.35),
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
              color: teal,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: cyan, width: 1.5),
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

  Widget wrNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleCyan,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pool),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: abyss.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget wrCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pool.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: abyss.withValues(alpha: 0.06),
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
              color: teal.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: abyss)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget wrRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? teal.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: pool.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? abyss : deepTeal)),
          );
        }).toList(),
      ),
    );
  }

  Widget wrFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? abyss : deepTeal,
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
          child: Icon(Icons.arrow_forward, size: 12, color: teal),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is ScribbleClient? ━━━━━━
  print('[wr-01] Section 1: What is ScribbleClient?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('01', 'What Is ScribbleClient?'),
      wrNote(
        'ScribbleClient is the interface between Flutter text fields and '
        'Apple Pencil Scribble on iPadOS. When a user writes with a Pencil '
        'near a text field, the system performs handwriting recognition and '
        'inserts the recognized text into the field.',
      ),
      wrCard(
        'Scribble Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wrFlow(['Pencil stroke', 'iPadOS recognizes', 'ScribbleClient',
                'Text inserted', 'Field updated']),
            const SizedBox(height: 10),
            _wrFeatureBadge('Recognition', 'Handwriting to text conversion', abyss),
            _wrFeatureBadge('Insertion', 'Text placed at cursor position', deepTeal),
            _wrFeatureBadge('Selection', 'Pencil gestures select text', teal),
            _wrFeatureBadge('Deletion', 'Scratch-out gesture removes text', aquamarine),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: iPadOS integration ━━━━━━
  print('[wr-02] Section 2: iPadOS integration');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('02', 'iPadOS Integration'),
      wrNote(
        'Scribble was introduced in iPadOS 14. It works with any text field '
        'that implements UIScribbleInteraction (native) or ScribbleClient '
        '(Flutter). The system detects when the Pencil approaches a text '
        'field and begins recognizing handwriting.',
      ),
      wrCard(
        'Platform Requirements',
        Column(
          children: [
            wrRow(['Requirement', 'Value', 'Notes'], isHeader: true),
            wrRow(['iPadOS', '14+', 'First Scribble release']),
            wrRow(['Apple Pencil', '1st or 2nd gen', 'Any Pencil model']),
            wrRow(['Language', 'En, Zh, Pt, Fr, De, It, Es', 'Supported langs']),
            wrRow(['Flutter', 'Automatic', 'Built into EditableText']),
            wrRow(['Android', 'N/A', 'Stylus uses Handwriting — different API']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Client interface ━━━━━━
  print('[wr-03] Section 3: Client interface');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('03', 'ScribbleClient Interface'),
      wrNote(
        'The ScribbleClient mixin defines the contract a text field must '
        'implement to support Scribble. Key methods: isInScribbleRect() '
        'determines if the Pencil is near the field, and '
        'insertTextPlaceholder() / removeTextPlaceholder() manage the '
        'insertion animation space.',
      ),
      wrCard(
        'Interface Methods',
        Column(
          children: [
            wrRow(['Method', 'Return', 'Purpose'], isHeader: true),
            wrRow(['isInScribbleRect', 'bool', 'Hit test for Pencil proximity']),
            wrRow(['insertTextPlaceholder', 'void', 'Reserve space for incoming text']),
            wrRow(['removeTextPlaceholder', 'void', 'Clear placeholder after insert']),
            wrRow(['onScribbleFocus', 'void', 'Focus field when Pencil starts']),
            wrRow(['performAction', 'void', 'Execute action from recognition']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Hit testing ━━━━━━
  print('[wr-04] Section 4: Hit testing');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('04', 'Hit Testing & Proximity'),
      wrNote(
        'When the Pencil approaches the screen, iPadOS asks each ScribbleClient '
        'if the touch point is within its scribble rect. The rect is typically '
        'larger than the field itself to give a comfortable writing area. '
        'The closest qualifying field receives focus.',
      ),
      wrCard(
        'Hit Test Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wrFlow(['Pencil down', 'System queries', 'isInScribbleRect?',
                'Focus winner', 'Scribble begins']),
            const SizedBox(height: 10),
            _wrStepDetail(1, 'Pencil touches surface near a field', abyss),
            _wrStepDetail(2, 'iPadOS broadcasts scribble query to all clients', deepTeal),
            _wrStepDetail(3, 'Each client checks bounds + padding', teal),
            _wrStepDetail(4, 'Closest field with true wins focus', aquamarine),
            _wrStepDetail(5, 'Handwriting recognition begins', cerulean),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Text placeholders ━━━━━━
  print('[wr-05] Section 5: Text placeholders');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('05', 'Text Placeholders'),
      wrNote(
        'While the user writes, iPadOS needs space in the text layout for '
        'the upcoming characters. insertTextPlaceholder() adds an invisible '
        'inline box that pushes text aside. removeTextPlaceholder() removes '
        'it once the recognized text is committed.',
      ),
      wrCard(
        'Placeholder Lifecycle',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wrLifecycleRow(Icons.edit, 'Pencil begins stroke', abyss),
            _wrLifecycleRow(Icons.text_fields, 'Placeholder inserted', deepTeal),
            _wrLifecycleRow(Icons.space_bar, 'Text pushed aside', teal),
            _wrLifecycleRow(Icons.check, 'Recognition complete', aquamarine),
            _wrLifecycleRow(Icons.delete_outline, 'Placeholder removed', cerulean),
            _wrLifecycleRow(Icons.text_snippet, 'Recognized text inserted', lagoon),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Pencil gestures ━━━━━━
  print('[wr-06] Section 6: Pencil gestures');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('06', 'Pencil Gestures'),
      wrNote(
        'Scribble recognizes several gestures beyond writing: scratch-out '
        '(zig-zag to delete), select (draw line through text), insert space '
        '(tap and hold between words), join/split (vertical line between or '
        'within words).',
      ),
      wrCard(
        'Gesture Reference',
        Column(
          children: [
            wrRow(['Gesture', 'Action', 'Visual'], isHeader: true),
            wrRow(['Write', 'Insert text', 'Normal handwriting']),
            wrRow(['Scratch-out', 'Delete text', 'Zig-zag / scribble over']),
            wrRow(['Draw through', 'Select text', 'Horizontal line']),
            wrRow(['Tap & hold', 'Insert space', 'Hold between words']),
            wrRow(['Vertical line', 'Join/split words', 'Line between chars']),
            wrRow(['Circle', 'Select word', 'Draw around text']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Focus management ━━━━━━
  print('[wr-07] Section 7: Focus management');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('07', 'Focus Management'),
      wrNote(
        'When Scribble activates, onScribbleFocus() is called. This must '
        'request focus for the text field and show the cursor without '
        'opening the keyboard. The keyboard opens only if the user taps '
        'the field directly — Scribble replaces keyboard input.',
      ),
      wrCard(
        'Focus vs Keyboard',
        Column(
          children: [
            wrRow(['Input Mode', 'Focus', 'Keyboard', 'Cursor'], isHeader: true),
            wrRow(['Tap field', 'Yes', 'Opens', 'Visible']),
            wrRow(['Scribble', 'Yes', 'Hidden', 'Visible']),
            wrRow(['External keyboard', 'Yes', 'External', 'Visible']),
            wrRow(['Voice dictation', 'Yes', 'Hidden', 'Visible']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: EditableText integration ━━━━━━
  print('[wr-08] Section 8: EditableText');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('08', 'EditableText Integration'),
      wrNote(
        'Flutter\'s EditableText already implements ScribbleClient. TextField '
        'and CupertinoTextField both use EditableText internally, so Scribble '
        'works out of the box on all standard text fields. Custom fields need '
        'to mix in ScribbleClient.',
      ),
      wrCard(
        'Widget Support Matrix',
        Column(
          children: [
            wrRow(['Widget', 'Scribble', 'Notes'], isHeader: true),
            wrRow(['TextField', 'Auto', 'Via EditableText']),
            wrRow(['CupertinoTextField', 'Auto', 'Via EditableText']),
            wrRow(['TextFormField', 'Auto', 'Wraps TextField']),
            wrRow(['EditableText', 'Auto', 'Implements ScribbleClient']),
            wrRow(['SelectableText', 'No', 'Not editable']),
            wrRow(['Custom widget', 'Manual', 'Mixin ScribbleClient']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Handwriting recognition ━━━━━━
  print('[wr-09] Section 9: Handwriting recognition');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('09', 'Handwriting Recognition Pipeline'),
      wrNote(
        'Recognition is handled by iPadOS — Flutter receives the final text. '
        'The pipeline: stroke capture → local ML model → candidate text → '
        'context analysis → final text. The model runs entirely on-device '
        'with no network requirement.',
      ),
      wrCard(
        'Recognition Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wrFlow(['Stroke capture', 'ML model', 'Candidates',
                'Context filter', 'Final text']),
            const SizedBox(height: 10),
            wrRow(['Stage', 'Location', 'Output'], isHeader: true),
            wrRow(['Capture', 'iPadOS', 'Ink points']),
            wrRow(['Segment', 'iPadOS', 'Character boundaries']),
            wrRow(['Recognize', 'On-device ML', 'Candidate strings']),
            wrRow(['Rank', 'Language model', 'Best candidate']),
            wrRow(['Deliver', 'Platform channel', 'Text to Flutter']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Multi-field scribble ━━━━━━
  print('[wr-10] Section 10: Multi-field');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('10', 'Multi-Field Scribble'),
      wrNote(
        'When multiple text fields are nearby, the system resolves which '
        'field to target based on proximity. Writing can flow across fields — '
        'writing past a field boundary can move focus to the next field. '
        'This is called field-to-field continuation.',
      ),
      wrCard(
        'Multi-Field Behavior',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wrScenarioCard('Side-by-side', 'Pencil position picks closest field', abyss),
            _wrScenarioCard('Stacked', 'Vertical position determines field', deepTeal),
            _wrScenarioCard('Overlapping rects', 'Closest center wins', teal),
            _wrScenarioCard('Continuation', 'Writing past edge moves focus', aquamarine),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Toolbar integration ━━━━━━
  print('[wr-11] Section 11: Toolbar');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('11', 'Scribble Toolbar'),
      wrNote(
        'When Scribble is active, a floating toolbar appears near the writing '
        'area. It shows the current language, undo/redo, and a keyboard button. '
        'The toolbar is managed by iPadOS — Flutter controls only whether '
        'the field is Scribble-enabled.',
      ),
      wrCard(
        'Toolbar Controls',
        Column(
          children: [
            wrRow(['Control', 'Action', 'Managed By'], isHeader: true),
            wrRow(['Language', 'Switch recognition', 'iPadOS']),
            wrRow(['Undo', 'Revert last text', 'iPadOS']),
            wrRow(['Redo', 'Restore undone', 'iPadOS']),
            wrRow(['Keyboard', 'Show software keyboard', 'iPadOS']),
            wrRow(['Minimize', 'Collapse toolbar', 'iPadOS']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Custom ScribbleClient ━━━━━━
  print('[wr-12] Section 12: Custom client');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('12', 'Custom ScribbleClient'),
      wrNote(
        'For custom text rendering (e.g., code editors, rich text), you can '
        'implement ScribbleClient on your own RenderObject. Override '
        'isInScribbleRect to define the input area, and handle text '
        'insertion via your custom text model.',
      ),
      wrCard(
        'Custom Implementation Checklist',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wrCheckbox('Mixin ScribbleClient on State or RenderObject', abyss),
            _wrCheckbox('Override isInScribbleRect with bounds + padding', deepTeal),
            _wrCheckbox('Implement insertTextPlaceholder for animations', teal),
            _wrCheckbox('Implement removeTextPlaceholder for cleanup', aquamarine),
            _wrCheckbox('Handle onScribbleFocus to acquire focus', cerulean),
            _wrCheckbox('Register with Scribble system on attach', lagoon),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Text input connection ━━━━━━
  print('[wr-13] Section 13: TextInput connection');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('13', 'Text Input Connection'),
      wrNote(
        'Scribble works through the existing TextInputConnection. Recognized '
        'text arrives via the same setEditingState path as keyboard input. '
        'The field doesn\'t need to distinguish between Scribble and keyboard — '
        'it just receives text updates.',
      ),
      wrCard(
        'Input Path Comparison',
        Column(
          children: [
            wrRow(['Source', 'Path', 'Format'], isHeader: true),
            wrRow(['Keyboard', 'TextInputClient', 'TextEditingValue']),
            wrRow(['Scribble', 'TextInputClient', 'TextEditingValue']),
            wrRow(['Voice', 'TextInputClient', 'TextEditingValue']),
            wrRow(['Paste', 'TextInputClient', 'TextEditingValue']),
            wrRow(['Autofill', 'AutofillClient', 'TextEditingValue']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Accessibility ━━━━━━
  print('[wr-14] Section 14: Accessibility');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('14', 'Accessibility Integration'),
      wrNote(
        'Scribble enhances accessibility for Apple Pencil users who prefer '
        'writing over typing. It works alongside VoiceOver — the screen reader '
        'announces when Scribble is available. Users can also use Scribble '
        'in search fields, URL bars, and form fields.',
      ),
      wrCard(
        'Accessibility Features',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wrAccessRow(Icons.edit, 'Natural writing input', abyss),
            _wrAccessRow(Icons.hearing, 'VoiceOver compatible', deepTeal),
            _wrAccessRow(Icons.language, 'Multi-language support', teal),
            _wrAccessRow(Icons.speed, 'Low latency recognition', aquamarine),
            _wrAccessRow(Icons.gesture, 'Gesture shortcuts for editing', cerulean),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Limitations ━━━━━━
  print('[wr-15] Section 15: Limitations');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('15', 'Limitations & Edge Cases'),
      wrNote(
        'Scribble is iPadOS-only — no Android, macOS, or web support. '
        'Not all languages are supported. Very fast writing may have lower '
        'accuracy. Custom text fields need manual integration. Palm '
        'rejection is device-managed, not Flutter-managed.',
      ),
      wrCard(
        'Limitation Matrix',
        Column(
          children: [
            wrRow(['Limitation', 'Detail', 'Workaround'], isHeader: true),
            wrRow(['iPadOS only', 'No Android/Web', 'Platform check']),
            wrRow(['Language support', '7 languages', 'Keyboard fallback']),
            wrRow(['Custom fields', 'Manual mixin', 'Implement interface']),
            wrRow(['Accuracy', 'Speed-dependent', 'Write clearly']),
            wrRow(['Rich text', 'Plain text only', 'Post-process']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[wr-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      wrBanner('16', 'Summary Dashboard'),
      wrCard(
        'ScribbleClient — Complete',
        Column(
          children: [
            wrRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            wrRow(['What', 'S01', 'Pencil handwriting → text interface']),
            wrRow(['iPadOS', 'S02', 'iPadOS 14+, on-device ML']),
            wrRow(['Interface', 'S03', 'isInScribbleRect + placeholders']),
            wrRow(['Hit test', 'S04', 'Proximity-based field targeting']),
            wrRow(['Placeholders', 'S05', 'Reserve space for incoming text']),
            wrRow(['Gestures', 'S06', 'Scratch-out, select, join/split']),
            wrRow(['Focus', 'S07', 'Focus without keyboard']),
            wrRow(['EditableText', 'S08', 'Built-in on all standard fields']),
            wrRow(['Recognition', 'S09', 'On-device ML pipeline']),
            wrRow(['Multi-field', 'S10', 'Proximity + continuation']),
            wrRow(['Toolbar', 'S11', 'iPadOS-managed floating bar']),
            wrRow(['Custom', 'S12', 'Mixin on State/RenderObject']),
            wrRow(['TextInput', 'S13', 'Same path as keyboard input']),
            wrRow(['A11y', 'S14', 'VoiceOver + natural writing']),
            wrRow(['Limits', 'S15', 'iPadOS only, 7 languages']),
          ],
        ),
      ),
      wrCard(
        'Teal / Cyan Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _wrColorSwatch('Teal', teal),
            _wrColorSwatch('Cyan', cyan),
            _wrColorSwatch('Aqua', aquamarine),
            _wrColorSwatch('Cerulean', cerulean),
            _wrColorSwatch('Abyss', abyss),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [abyss, deepTeal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('ScribbleClient — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'Apple Pencil Scribble integration in Flutter: from hit testing '
              'and placeholder management through gesture recognition, toolbar '
              'interaction, and custom field implementation.',
              style: TextStyle(color: paleCyan, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[wr] palette: $lagoon, $mist, $pool, $paleCyan');
  print('[wr] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('ScribbleClient — Apple Pencil Input'),
        backgroundColor: abyss,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF0FFFE),
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

Widget _wrFeatureBadge(String feature, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(feature,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _wrStepDetail(int num, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _wrLifecycleRow(IconData icon, String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _wrScenarioCard(String title, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(title,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _wrCheckbox(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(Icons.check_box_outline_blank, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _wrAccessRow(IconData icon, String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 11, color: color)),
        ),
      ],
    ),
  );
}

Widget _wrColorSwatch(String name, Color color) {
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

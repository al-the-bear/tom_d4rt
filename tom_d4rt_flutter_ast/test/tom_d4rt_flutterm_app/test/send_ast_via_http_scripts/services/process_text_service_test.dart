// ignore_for_file: avoid_print
// D4rt deep demo: ProcessTextService — the Android-specific service that
// exposes text processing actions (translate, search, share) for the text
// selection toolbar.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Ruby / Rose palette ───
  const Color ruby = Color(0xFFBE123C);
  const Color rose = Color(0xFFFDA4AF);
  const Color deepRuby = Color(0xFF9F1239);
  const Color paleRose = Color(0xFFFFE4E6);
  const Color garnet = Color(0xFFE11D48);
  const Color blush = Color(0xFFFB7185);
  const Color coral = Color(0xFFF43F5E);
  const Color wine = Color(0xFF881337);
  const Color petal = Color(0xFFFECDD3);
  const Color scarlet = Color(0xFFFF0040);

  print('[pt] ===== PROCESS TEXT SERVICE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget ptBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [wine, deepRuby],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: wine.withValues(alpha: 0.35),
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
              color: garnet,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: rose, width: 1.5),
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

  Widget ptNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleRose,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: petal),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: wine.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget ptCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: rose.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: wine.withValues(alpha: 0.06),
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
              color: ruby.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: wine)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget ptRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? ruby.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: rose.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? wine : deepRuby)),
          );
        }).toList(),
      ),
    );
  }

  Widget ptFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? wine : deepRuby,
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
          child: Icon(Icons.arrow_forward, size: 12, color: garnet),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is ProcessTextService? ━━━━━━
  print('[pt-01] Section 1: What is ProcessTextService?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('01', 'What Is ProcessTextService?'),
      ptNote(
        'ProcessTextService is an interface for querying and launching '
        'text processing activities on Android. When a user selects text, '
        'the system can show actions like "Translate", "Search Web", '
        '"Share" — these come from apps that register PROCESS_TEXT '
        'intent filters. Flutter exposes this through ProcessTextService.',
      ),
      ptCard(
        'Service Architecture',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ptFlow(['Select text', 'Query actions', 'Show in toolbar',
                'User picks', 'Process text']),
            const SizedBox(height: 10),
            _ptRoleBadge('Queries', 'Available PROCESS_TEXT activities', wine),
            _ptRoleBadge('Launches', 'Selected processing action', deepRuby),
            _ptRoleBadge('Returns', 'Processed text (optional)', ruby),
            _ptRoleBadge('Integrates', 'Text selection toolbar', garnet),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: ProcessTextAction ━━━━━━
  print('[pt-02] Section 2: ProcessTextAction');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('02', 'ProcessTextAction'),
      ptNote(
        'Each discovered text processing activity is represented as a '
        'ProcessTextAction with an id (unique identifier) and a label '
        '(display name). The id is used to invoke the action, the label '
        'is shown to the user in the toolbar.',
      ),
      ptCard(
        'Action Properties',
        Column(
          children: [
            ptRow(['Property', 'Type', 'Purpose'], isHeader: true),
            ptRow(['id', 'String', 'Unique action identifier']),
            ptRow(['label', 'String', 'Human-readable name']),
          ],
        ),
      ),
      ptCard(
        'Example Actions',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptActionChip('Translate', Icons.translate, wine),
            _ptActionChip('Search Web', Icons.search, deepRuby),
            _ptActionChip('Share', Icons.share, ruby),
            _ptActionChip('Copy to Note', Icons.note_add, garnet),
            _ptActionChip('Define', Icons.menu_book, blush),
            _ptActionChip('Read Aloud', Icons.volume_up, coral),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Registration ━━━━━━
  print('[pt-03] Section 3: Registration');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('03', 'How Apps Register Actions'),
      ptNote(
        'Android apps register PROCESS_TEXT actions via intent filters in '
        'their AndroidManifest.xml. When Flutter queries for available '
        'actions, Android\'s PackageManager resolves all matching '
        'activities and returns them as a list.',
      ),
      ptCard(
        'Android Manifest Pattern',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: paleRose,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ptCodeLine('<activity android:name=".TranslateActivity">', wine),
              _ptCodeLine('  <intent-filter>', deepRuby),
              _ptCodeLine('    <action android:name=', deepRuby),
              _ptCodeLine('      "android.intent.action.PROCESS_TEXT"/>', deepRuby),
              _ptCodeLine('    <category android:name=', ruby),
              _ptCodeLine('      "android.intent.category.DEFAULT"/>', ruby),
              _ptCodeLine('    <data android:mimeType="text/plain"/>', ruby),
              _ptCodeLine('  </intent-filter>', deepRuby),
              _ptCodeLine('</activity>', wine),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Text selection integration ━━━━━━
  print('[pt-04] Section 4: Text selection');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('04', 'Text Selection Toolbar Integration'),
      ptNote(
        'Flutter\'s AdaptiveTextSelectionToolbar can include process text '
        'actions alongside standard cut/copy/paste buttons. The toolbar '
        'queries ProcessTextService for available actions and adds them '
        'as additional toolbar buttons.',
      ),
      ptCard(
        'Toolbar Button Order',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptToolbarItem(1, 'Cut', Icons.content_cut, 'Built-in', wine),
            _ptToolbarItem(2, 'Copy', Icons.content_copy, 'Built-in', deepRuby),
            _ptToolbarItem(3, 'Paste', Icons.content_paste, 'Built-in', ruby),
            _ptToolbarItem(4, 'Select All', Icons.select_all, 'Built-in', garnet),
            _ptToolbarItem(5, 'Translate', Icons.translate, 'ProcessText', blush),
            _ptToolbarItem(6, 'Search', Icons.search, 'ProcessText', coral),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Querying available actions ━━━━━━
  print('[pt-05] Section 5: Query actions');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('05', 'Querying Available Actions'),
      ptNote(
        'queryTextActions() asks the platform for all registered '
        'PROCESS_TEXT activities. The result is a list of ProcessTextAction '
        'objects. This should be called when building the text selection '
        'toolbar to populate extra buttons.',
      ),
      ptCard(
        'Query Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ptFlow(['queryTextActions()', 'Platform channel',
                'PackageManager query', 'List<ProcessTextAction>']),
            const SizedBox(height: 10),
            ptRow(['Step', 'Layer', 'Action'], isHeader: true),
            ptRow(['1', 'Dart', 'Call queryTextActions()']),
            ptRow(['2', 'Channel', 'Send to engine']),
            ptRow(['3', 'Android', 'PackageManager.queryIntentActivities']),
            ptRow(['4', 'Channel', 'Return action list']),
            ptRow(['5', 'Dart', 'Build ProcessTextAction objects']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Executing actions ━━━━━━
  print('[pt-06] Section 6: Execute actions');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('06', 'Executing a Text Action'),
      ptNote(
        'processTextAction(id, text) sends the selected text to the '
        'chosen activity. The activity may return modified text (e.g., '
        'translation result) or null (e.g., share action with no return). '
        'The return value can replace the selection.',
      ),
      ptCard(
        'Execution Pattern',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: paleRose,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ptCodeLine('final result = await processTextService', wine),
              _ptCodeLine('  .processTextAction(', wine),
              _ptCodeLine('    action.id,', deepRuby),
              _ptCodeLine('    selectedText,', deepRuby),
              _ptCodeLine('    readOnly: false,', deepRuby),
              _ptCodeLine('  );', wine),
              _ptCodeLine('if (result != null) {', garnet),
              _ptCodeLine('  replaceSelection(result);', garnet),
              _ptCodeLine('}', garnet),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Result handling ━━━━━━
  print('[pt-07] Section 7: Results');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('07', 'Result Handling'),
      ptNote(
        'Actions can return text or null. Read-only mode indicates the '
        'app only wants to display results, not modify the source text. '
        'The readOnly flag is passed to the native intent as '
        'EXTRA_PROCESS_TEXT_READONLY.',
      ),
      ptCard(
        'Result Types',
        Column(
          children: [
            ptRow(['Action', 'Returns', 'readOnly'], isHeader: true),
            ptRow(['Translate', 'Translated text', 'false']),
            ptRow(['Search Web', 'null (opens browser)', 'true']),
            ptRow(['Share', 'null (opens share sheet)', 'true']),
            ptRow(['Define', 'Definition text', 'true']),
            ptRow(['Auto-correct', 'Corrected text', 'false']),
            ptRow(['Summarize', 'Summary text', 'false']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Toolbar integration details ━━━━━━
  print('[pt-08] Section 8: Toolbar details');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('08', 'AdaptiveTextSelectionToolbar'),
      ptNote(
        'Flutter\'s text selection toolbar adapts to the platform. On '
        'Android, it includes overflow menu support, where process text '
        'actions appear when there are too many buttons. The toolbar auto-'
        'sizes and places buttons based on available space.',
      ),
      ptCard(
        'Toolbar Anatomy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptToolbarSection('Primary Bar', 'Cut, Copy, Paste, Select All', wine),
            _ptToolbarSection('Overflow ▸', 'Process text actions + more', deepRuby),
            _ptToolbarSection('Custom', 'App-specific actions', ruby),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Platform support ━━━━━━
  print('[pt-09] Section 9: Platform support');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('09', 'Platform Support'),
      ptNote(
        'ProcessTextService is Android-only (API 23+). iOS, web, and '
        'desktop have no equivalent. Flutter provides a no-op fallback on '
        'unsupported platforms — queryTextActions returns empty, '
        'processTextAction returns null.',
      ),
      ptCard(
        'Platform Matrix',
        Column(
          children: [
            ptRow(['Platform', 'Supported', 'Min Version'], isHeader: true),
            ptRow(['Android', 'Yes', 'API 23 (6.0)']),
            ptRow(['iOS', 'No', 'n/a']),
            ptRow(['Web', 'No', 'n/a']),
            ptRow(['macOS', 'No', 'n/a']),
            ptRow(['Windows', 'No', 'n/a']),
            ptRow(['Linux', 'No', 'n/a']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Action lifecycle ━━━━━━
  print('[pt-10] Section 10: Lifecycle');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('10', 'Action Lifecycle'),
      ptNote(
        'The lifecycle of a process text action: first the toolbar queries '
        'available actions (done once when toolbar is shown, cached). Then '
        'when the user taps an action, Flutter launches the intent. The '
        'activity runs, may show UI, and returns a result or nothing.',
      ),
      ptCard(
        'Lifecycle Timeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptLifecycleStep(1, 'User selects text', 'Selection triggers toolbar', wine),
            _ptLifecycleStep(2, 'Toolbar builds', 'queryTextActions() called', deepRuby),
            _ptLifecycleStep(3, 'Actions cached', 'Shown as buttons/overflow', ruby),
            _ptLifecycleStep(4, 'User taps action', 'processTextAction() called', garnet),
            _ptLifecycleStep(5, 'Android launches intent', 'Activity starts', blush),
            _ptLifecycleStep(6, 'Activity completes', 'Returns result or null', coral),
            _ptLifecycleStep(7, 'Flutter handles result', 'Replace or dismiss', wine),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Custom actions ━━━━━━
  print('[pt-11] Section 11: Custom actions');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('11', 'Custom Process Text Actions'),
      ptNote(
        'You can create custom process text actions in the host Android '
        'app or any installed app. Register an Activity with the '
        'PROCESS_TEXT intent filter. Receive the text via getIntent() '
        'extras, process it, and setResult with the modified text.',
      ),
      ptCard(
        'Custom Action Steps',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ptLifecycleStep(1, 'Create Activity', 'Extends AppCompatActivity', wine),
            _ptLifecycleStep(2, 'Add intent filter', 'PROCESS_TEXT + DEFAULT', deepRuby),
            _ptLifecycleStep(3, 'Read incoming text', 'getIntent().getCharSequenceExtra()', ruby),
            _ptLifecycleStep(4, 'Process text', 'Your logic here', garnet),
            _ptLifecycleStep(5, 'Return result', 'setResult(RESULT_OK, intent)', blush),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Security ━━━━━━
  print('[pt-12] Section 12: Security');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('12', 'Security Considerations'),
      ptNote(
        'Process text actions send text to third-party apps. Sensitive '
        'text (passwords, PII) should not be shared. Consider disabling '
        'process text actions for secure text fields. The readOnly flag '
        'prevents the third party from modifying the text but it still '
        'receives the content.',
      ),
      ptCard(
        'Security Checklist',
        Column(
          children: [
            ptRow(['Concern', 'Risk', 'Mitigation'], isHeader: true),
            ptRow(['PII exposure', 'Text sent to 3rd party', 'Disable for passwords']),
            ptRow(['Malicious return', 'Injected content', 'Sanitize result']),
            ptRow(['Intent spoofing', 'Fake action', 'Android verifies package']),
            ptRow(['Clipboard leak', 'Text in clipboard', 'Use direct intent']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Material integration ━━━━━━
  print('[pt-13] Section 13: Material integration');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('13', 'Material Text Selection Integration'),
      ptNote(
        'TextField, SelectableText, and EditableText all integrate with '
        'ProcessTextService through the selection toolbar delegate. The '
        'default AdaptiveTextSelectionToolbar automatically includes '
        'process text actions when running on Android.',
      ),
      ptCard(
        'Widget Integration',
        Column(
          children: [
            ptRow(['Widget', 'Supports?', 'Custom Toolbar?'], isHeader: true),
            ptRow(['TextField', 'Yes', 'Via toolbarBuilder']),
            ptRow(['SelectableText', 'Yes', 'Via contextMenuBuilder']),
            ptRow(['EditableText', 'Yes', 'Via contextMenuBuilder']),
            ptRow(['SelectionArea', 'Yes', 'Via contextMenuBuilder']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Error handling ━━━━━━
  print('[pt-14] Section 14: Error handling');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('14', 'Error Handling'),
      ptNote(
        'Text actions can fail: the target app may crash, the user may '
        'cancel, or the activity may not support the readOnly flag. '
        'processTextAction returns null on any failure — always handle '
        'the null case gracefully.',
      ),
      ptCard(
        'Error Scenarios',
        Column(
          children: [
            ptRow(['Scenario', 'Result', 'Handling'], isHeader: true),
            ptRow(['Activity crashes', 'null', 'Show nothing / dismiss']),
            ptRow(['User cancels', 'null', 'Keep original text']),
            ptRow(['readOnly ignored', 'Modified text', 'Ignore if readOnly']),
            ptRow(['App uninstalled', 'Action gone', 'Re-query next time']),
            ptRow(['No text selected', 'N/A', 'Disable actions']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing ━━━━━━
  print('[pt-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('15', 'Testing Process Text'),
      ptNote(
        'Test ProcessTextService with a mock implementation that returns '
        'hardcoded actions. Override the service in tests using '
        'TestWidgetsFlutterBinding.ensureInitialized() and setting '
        'a custom ProcessTextService on the binding.',
      ),
      ptCard(
        'Test Techniques',
        Column(
          children: [
            ptRow(['Technique', 'What', 'Verifies'], isHeader: true),
            ptRow(['Mock service', 'Return fake actions', 'Toolbar buttons']),
            ptRow(['Spy on calls', 'Log processTextAction', 'Correct id/text']),
            ptRow(['Return modified', 'Mock returns text', 'Text replacement']),
            ptRow(['Return null', 'Mock returns null', 'Graceful handling']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[pt-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ptBanner('16', 'Summary Dashboard'),
      ptCard(
        'ProcessTextService — Complete',
        Column(
          children: [
            ptRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            ptRow(['What', 'S01', 'Android PROCESS_TEXT bridge']),
            ptRow(['Action', 'S02', 'id + label per activity']),
            ptRow(['Registration', 'S03', 'Intent filter in manifest']),
            ptRow(['Selection', 'S04', 'Toolbar integration']),
            ptRow(['Query', 'S05', 'queryTextActions()']),
            ptRow(['Execute', 'S06', 'processTextAction(id, text)']),
            ptRow(['Results', 'S07', 'Nullable return text']),
            ptRow(['Toolbar', 'S08', 'Overflow menu for extras']),
            ptRow(['Platform', 'S09', 'Android only (API 23+)']),
            ptRow(['Lifecycle', 'S10', 'Query → tap → launch → return']),
            ptRow(['Custom', 'S11', 'Create your own Activity']),
            ptRow(['Security', 'S12', 'Don\'t send passwords']),
            ptRow(['Material', 'S13', 'Auto-included in toolbar']),
            ptRow(['Errors', 'S14', 'Always handle null']),
            ptRow(['Testing', 'S15', 'Mock service + spy']),
          ],
        ),
      ),
      ptCard(
        'Ruby / Rose Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ptColorSwatch('Ruby', ruby),
            _ptColorSwatch('Rose', rose),
            _ptColorSwatch('Garnet', garnet),
            _ptColorSwatch('Blush', blush),
            _ptColorSwatch('Wine', wine),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [wine, deepRuby],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('ProcessTextService — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From Android text processing intents through toolbar '
              'integration, action execution, result handling, security, '
              'and testing — the full process text story.',
              style: TextStyle(color: petal, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[pt] palette: $scarlet, $coral, $blush, $petal');
  print('[pt] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('ProcessTextService — Text Actions'),
        backgroundColor: wine,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFF5F6),
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

Widget _ptRoleBadge(String role, String desc, Color color) {
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
          width: 70,
          child: Text(role,
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

Widget _ptActionChip(String label, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    ),
  );
}

Widget _ptCodeLine(String text, Color color) {
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

Widget _ptToolbarItem(int num, String label, IconData icon, String source, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
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
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text(label,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Text(source,
            style: TextStyle(
                fontSize: 9, color: color.withValues(alpha: 0.6))),
      ],
    ),
  );
}

Widget _ptToolbarSection(String name, String desc, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _ptLifecycleStep(int num, String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ptColorSwatch(String name, Color color) {
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

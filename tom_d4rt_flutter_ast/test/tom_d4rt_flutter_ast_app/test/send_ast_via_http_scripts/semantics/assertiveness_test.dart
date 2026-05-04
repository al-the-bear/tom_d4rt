// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Assertiveness from semantics
// Deep Demo: Visual exploration of the Flutter Assertiveness enum used by
// SemanticsService.announce to control screen-reader announcement politeness.
//
// Assertiveness has two values: polite, assertive.
//   polite     -> wait until the screen reader is idle, then speak.
//                 Mirrors aria-live="polite" on the web.
//   assertive  -> interrupt whatever the screen reader is currently saying.
//                 Mirrors aria-live="assertive" on the web.
//
// This demo does NOT actually call SemanticsService.announce. It paints
// mock dialogue boxes and a mock screen-reader transcript so the difference
// between the two politeness modes is visible without producing audio.

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('Assertiveness Deep Demo executing');
  print('Flutter Assertiveness enum has ${Assertiveness.values.length} values');
  for (final v in Assertiveness.values) {
    print('  Assertiveness.${v.name} (index=${v.index})');
  }

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade600,
          Colors.blue.shade500,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.record_voice_over, size: 56.0, color: Colors.white),
            SizedBox(width: 16.0),
            Icon(Icons.hearing, size: 56.0, color: Colors.white70),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Assertiveness',
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Politeness modes for screen-reader announcements',
          style: TextStyle(fontSize: 15.0, color: Colors.white70),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: Text(
            'package:flutter/semantics.dart -> Assertiveness',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Hero header built');

  // ============================================================
  // SECTION 2: A11y context primer
  // ============================================================
  print('=== Section 2: A11y primer ===');

  final a11yPrimer = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new,
                color: Colors.teal.shade700, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Why politeness matters',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Screen readers are assistive software (TalkBack on Android, '
          'VoiceOver on iOS, NVDA / JAWS / Narrator on desktop, ChromeVox '
          'on the web) that read interface content aloud for users who are '
          'blind or have low vision.',
          style: TextStyle(fontSize: 13.5, color: Colors.teal.shade900),
        ),
        SizedBox(height: 10.0),
        Text(
          'When your app needs to surface a transient message that has no '
          'visible focus target (a snackbar, a banner, a validation error), '
          'you can ask the screen reader to speak it directly with '
          'SemanticsService.announce. The Assertiveness parameter decides '
          'whether the announcement waits its turn (polite) or barges in '
          '(assertive).',
          style: TextStyle(fontSize: 13.5, color: Colors.teal.shade900),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.teal.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.teal.shade800, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Default to polite. Reach for assertive only when the user '
                  'must hear the message *now*, even at the cost of cutting '
                  'off whatever else is being read.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.teal.shade900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('A11y primer built');

  // ============================================================
  // SECTION 3: Per-value cards
  // ============================================================
  print('=== Section 3: Per-value cards ===');

  final politeCard = _buildValueCard(
    value: Assertiveness.polite,
    title: 'Assertiveness.polite',
    subtitle: 'Wait your turn',
    icon: Icons.front_hand_outlined,
    primary: Colors.green.shade600,
    accent: Colors.lightGreen.shade300,
    queueDescription:
        'Queued. Spoken after the screen reader finishes its current '
        'utterance and any previously queued ones.',
    interrupts: false,
    ariaParallel: 'aria-live="polite"',
    sampleUtterance: '"Item added to cart."',
    realWorldFit:
        'Status updates, success toasts, non-urgent notifications, '
        'low-priority background changes.',
  );

  final assertiveCard = _buildValueCard(
    value: Assertiveness.assertive,
    title: 'Assertiveness.assertive',
    subtitle: 'Interrupt now',
    icon: Icons.priority_high,
    primary: Colors.red.shade600,
    accent: Colors.orange.shade300,
    queueDescription:
        'Interrupting. The screen reader stops the current utterance '
        'and clears its queue, then speaks the announcement immediately.',
    interrupts: true,
    ariaParallel: 'aria-live="assertive"',
    sampleUtterance: '"Error: card declined. Please review payment."',
    realWorldFit:
        'Form validation errors, security alerts, time-sensitive warnings, '
        'critical state changes the user must act on.',
  );
  print('Built per-value cards');

  // ============================================================
  // SECTION 4: Mock screen-reader transcript timeline
  // ============================================================
  print('=== Section 4: Mock transcript timeline ===');

  final timelineSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade900, Colors.indigo.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.5),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.graphic_eq, color: Colors.cyanAccent, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Mock screen-reader transcript',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Imagine the screen reader is currently reading: '
          '"Subscribe to our newsletter for weekly tips and product '
          'announcements". An announcement arrives at the marker.',
          style: TextStyle(fontSize: 12.5, color: Colors.white70),
        ),
        SizedBox(height: 18.0),

        // Time bar with marker
        _buildTimeBar(),
        SizedBox(height: 20.0),

        // Polite scenario
        _buildTranscriptScenario(
          label: 'POLITE',
          color: Colors.lightGreenAccent,
          accent: Colors.green.shade700,
          existing:
              '"Subscribe to our newsletter for weekly tips and product '
              'announcements"',
          announcement: '"Item added to cart."',
          behavior: 'Existing utterance plays in full. THEN the announcement.',
          existingFlex: 5,
          gapFlex: 1,
          announcementFlex: 3,
          interrupted: false,
        ),
        SizedBox(height: 14.0),

        // Assertive scenario
        _buildTranscriptScenario(
          label: 'ASSERTIVE',
          color: Colors.orangeAccent,
          accent: Colors.deepOrange.shade700,
          existing: '"Subscribe to our news—"',
          announcement: '"Error: card declined."',
          behavior:
              'Existing utterance is CUT OFF mid-word. Announcement speaks '
              'immediately. Any queued utterances are dropped.',
          existingFlex: 2,
          gapFlex: 0,
          announcementFlex: 6,
          interrupted: true,
        ),
      ],
    ),
  );
  print('Transcript timeline built');

  // ============================================================
  // SECTION 5: Recipe section - 4 real cases
  // ============================================================
  print('=== Section 5: Recipes ===');

  final recipeFormError = _buildRecipeCard(
    title: 'Form validation error',
    chosen: Assertiveness.assertive,
    rationale:
        'The user just submitted; they need to know immediately *why* '
        'the form did not go through. Any other speech is now stale.',
    primary: Colors.red.shade700,
    bgStart: Colors.red.shade50,
    bgEnd: Colors.pink.shade50,
    icon: Icons.error_outline,
    mockUi: _mockFormError(),
  );

  final recipeSuccessToast = _buildRecipeCard(
    title: 'Success toast',
    chosen: Assertiveness.polite,
    rationale:
        'The action already succeeded. The toast is feedback, not a call '
        'to action. Cutting off other speech would be rude and disorienting.',
    primary: Colors.green.shade700,
    bgStart: Colors.green.shade50,
    bgEnd: Colors.teal.shade50,
    icon: Icons.check_circle_outline,
    mockUi: _mockSuccessToast(),
  );

  final recipeNotificationBanner = _buildRecipeCard(
    title: 'Notification banner',
    chosen: Assertiveness.polite,
    rationale:
        'A new message or update is informational. The user can finish '
        'reading the current screen, then receive the notification.',
    primary: Colors.blue.shade700,
    bgStart: Colors.blue.shade50,
    bgEnd: Colors.indigo.shade50,
    icon: Icons.notifications_active_outlined,
    mockUi: _mockNotificationBanner(),
  );

  final recipeCriticalAlert = _buildRecipeCard(
    title: 'Critical alert dialog',
    chosen: Assertiveness.assertive,
    rationale:
        'A modal alert blocks interaction. The screen reader must say '
        'so RIGHT NOW so the user understands their input is captured.',
    primary: Colors.deepOrange.shade700,
    bgStart: Colors.orange.shade50,
    bgEnd: Colors.amber.shade50,
    icon: Icons.warning_amber_rounded,
    mockUi: _mockCriticalAlert(),
  );
  print('Built 4 recipe cards');

  // ============================================================
  // SECTION 6: Comparison table
  // ============================================================
  print('=== Section 6: Comparison table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade800, Colors.blueGrey.shade700],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
          ),
          child: Row(
            children: [
              Icon(Icons.table_chart, color: Colors.white, size: 22.0),
              SizedBox(width: 10.0),
              Text(
                'polite vs assertive — side by side',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        _buildTableHeader(),
        _buildTableRow(
          'Behaviour',
          'Wait, then speak',
          'Stop current speech, speak now',
          Colors.green.shade700,
          Colors.red.shade700,
        ),
        _buildTableRow(
          'Queueing',
          'Appended to queue',
          'Queue cleared, this jumps to front',
          Colors.green.shade700,
          Colors.red.shade700,
        ),
        _buildTableRow(
          'Interruption',
          'Never interrupts',
          'Always interrupts',
          Colors.green.shade700,
          Colors.red.shade700,
        ),
        _buildTableRow(
          'Recommended frequency',
          'Free to use often',
          'Sparingly — once per critical event',
          Colors.green.shade700,
          Colors.red.shade700,
        ),
        _buildTableRow(
          'Web ARIA parallel',
          'aria-live="polite"',
          'aria-live="assertive"',
          Colors.green.shade700,
          Colors.red.shade700,
        ),
        _buildTableRow(
          'Cognitive load',
          'Low',
          'High — every announcement steals focus',
          Colors.green.shade700,
          Colors.red.shade700,
        ),
        _buildTableRow(
          'Risk of misuse',
          'Spam if too chatty',
          'Hostile experience if overused',
          Colors.green.shade700,
          Colors.red.shade700,
          isLast: true,
        ),
      ],
    ),
  );
  print('Comparison table built');

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  print('=== Section 7: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.report_problem_outlined,
                color: Colors.deepOrange.shade700, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildPitfall(
          title: 'Over-using assertive',
          body:
              'Every assertive announcement steals focus from the user. '
              'When everything is "urgent", nothing is. The screen reader '
              'experience becomes hostile and users disable the app.',
          icon: Icons.volume_up,
        ),
        _buildPitfall(
          title: 'Internationalisation',
          body:
              'Always pass the right TextDirection alongside the message. '
              'A message announced in the wrong locale or direction can '
              'be unintelligible. Pull strings from your localisation '
              'pipeline, not hard-coded literals.',
          icon: Icons.translate,
        ),
        _buildPitfall(
          title: 'Announcement spam',
          body:
              'Polite is cheap, but it is not free. A list that announces '
              'every keystroke or scroll position will drown the user. '
              'Throttle, debounce, or only announce on meaningful change.',
          icon: Icons.repeat,
        ),
        _buildPitfall(
          title: 'No visible affordance',
          body:
              'Announcements are ephemeral. If the information also matters '
              'visually (e.g. an error), make sure a focusable visible '
              'widget carries the same content. Sighted users with motor '
              'difficulties may also need to revisit it.',
          icon: Icons.visibility_off,
        ),
        _buildPitfall(
          title: 'Testing only on one platform',
          body:
              'TalkBack, VoiceOver, NVDA, and JAWS handle the underlying '
              'platform announcement APIs slightly differently. Always '
              'verify on at least Android + iOS for mobile, and a desktop '
              'reader if you ship desktop.',
          icon: Icons.devices,
        ),
      ],
    ),
  );
  print('Pitfalls built');

  // ============================================================
  // SECTION 8: Decision flow
  // ============================================================
  print('=== Section 8: Decision flow ===');

  final decisionFlow = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.alt_route,
                color: Colors.deepPurple.shade700, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Choosing between polite and assertive',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _buildDecisionStep(
          step: '1',
          question:
              'Will the user lose information or fail their task if this '
              'message is delayed by a few seconds?',
          yesLabel: 'YES -> assertive',
          noLabel: 'NO -> continue',
          color: Colors.deepPurple,
        ),
        SizedBox(height: 10.0),
        _buildDecisionStep(
          step: '2',
          question:
              'Is this message a recovery action the user must take RIGHT '
              'NOW (e.g. invalid input, security alert)?',
          yesLabel: 'YES -> assertive',
          noLabel: 'NO -> continue',
          color: Colors.deepPurple,
        ),
        SizedBox(height: 10.0),
        _buildDecisionStep(
          step: '3',
          question:
              'Is the message non-blocking feedback the user can absorb '
              'after the current utterance completes?',
          yesLabel: 'YES -> polite',
          noLabel: 'Default -> polite',
          color: Colors.green,
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.tips_and_updates,
                  color: Colors.deepPurple.shade700, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'When in doubt, default to polite. The cost of a delayed '
                  'announcement is much smaller than the cost of an '
                  'interrupted one.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.deepPurple.shade900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Decision flow built');

  // ============================================================
  // SECTION 9: Code reference
  // ============================================================
  print('=== Section 9: Code reference ===');

  final codeReference = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyanAccent, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Reference snippets',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          '// Polite — default. Wait until the screen reader is idle.\n'
          'SemanticsService.announce(\n'
          "  'Item added to cart',\n"
          '  TextDirection.ltr,\n'
          '  assertiveness: Assertiveness.polite,\n'
          ');',
          Colors.lightGreenAccent,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Assertive — interrupt and speak now.\n'
          'SemanticsService.announce(\n'
          "  'Error: card declined',\n"
          '  TextDirection.ltr,\n'
          '  assertiveness: Assertiveness.assertive,\n'
          ');',
          Colors.orangeAccent,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Enumerating values at runtime.\n'
          'for (final v in Assertiveness.values) {\n'
          "  print('Assertiveness.\${v.name} -> \${v.index}');\n"
          '}',
          Colors.cyanAccent,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Underlying event constructor (used by SemanticsService).\n'
          'AnnounceSemanticsEvent(\n'
          "  'Saved',\n"
          '  TextDirection.ltr,\n'
          '  0, // viewId\n'
          '  assertiveness: Assertiveness.polite,\n'
          ');',
          Colors.purpleAccent,
        ),
      ],
    ),
  );
  print('Code reference built');

  // ============================================================
  // SECTION 10: Footer with file path + ASCII box
  // ============================================================
  print('=== Section 10: Footer ===');

  const filePath =
      'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
      'send_ast_via_http_scripts/semantics/assertiveness_test.dart';
  const asciiBox = '+----------------------------------------------------+\n'
      '|  Flutter Assertiveness — deep visual demo          |\n'
      '|  values: polite, assertive                         |\n'
      '|  consumed by: SemanticsService.announce            |\n'
      '|  web parallel: aria-live polite | assertive        |\n'
      '|  rule of thumb: default polite, escalate sparingly |\n'
      '+----------------------------------------------------+';

  final footer = Container(
    margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade100, Colors.grey.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.insert_drive_file_outlined,
                color: Colors.blueGrey.shade700, size: 20.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                filePath,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            asciiBox,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade400,
              height: 1.2,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'End of demo. Generated for the tom_d4rt_flutter_ast bridge '
          'verification suite.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.blueGrey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
  print('Footer built');

  print('Assertiveness Deep Demo composition complete');

  // ============================================================
  // Compose
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        SizedBox(height: 24.0),
        _sectionHeading('1. Why this enum exists'),
        a11yPrimer,
        SizedBox(height: 24.0),
        _sectionHeading('2. The two values'),
        politeCard,
        SizedBox(height: 12.0),
        assertiveCard,
        SizedBox(height: 24.0),
        _sectionHeading('3. Mock screen-reader transcript'),
        timelineSection,
        SizedBox(height: 24.0),
        _sectionHeading('4. Recipes — when to pick which'),
        recipeFormError,
        SizedBox(height: 12.0),
        recipeSuccessToast,
        SizedBox(height: 12.0),
        recipeNotificationBanner,
        SizedBox(height: 12.0),
        recipeCriticalAlert,
        SizedBox(height: 24.0),
        _sectionHeading('5. Side-by-side comparison'),
        comparisonTable,
        SizedBox(height: 24.0),
        _sectionHeading('6. Pitfalls to avoid'),
        pitfalls,
        SizedBox(height: 24.0),
        _sectionHeading('7. Decision flow'),
        decisionFlow,
        SizedBox(height: 24.0),
        _sectionHeading('8. Code reference'),
        codeReference,
        SizedBox(height: 24.0),
        _sectionHeading('9. Footer'),
        footer,
      ],
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

Widget _sectionHeading(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 26.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildValueCard({
  required Assertiveness value,
  required String title,
  required String subtitle,
  required IconData icon,
  required Color primary,
  required Color accent,
  required String queueDescription,
  required bool interrupts,
  required String ariaParallel,
  required String sampleUtterance,
  required String realWorldFit,
}) {
  return Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          primary.withValues(alpha: 0.10),
          accent.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: primary.withValues(alpha: 0.55), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: primary.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.4),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 28.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: primary.withValues(alpha: 0.8),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                'index ${value.index}',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _kvRow('Queueing', queueDescription, primary),
        _kvRow('Interrupts current speech', interrupts ? 'YES' : 'NO', primary),
        _kvRow('Web ARIA parallel', ariaParallel, primary),
        _kvRow('Real-world fit', realWorldFit, primary),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: primary.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.format_quote, color: primary, size: 22.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Sample utterance: $sampleUtterance',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: primary,
                    fontWeight: FontWeight.w500,
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

Widget _kvRow(String key, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160.0,
          child: Text(
            '$key:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
              color: color.withValues(alpha: 0.85),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimeBar() {
  return Container(
    height: 36.0,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        SizedBox(width: 8.0),
        Text('t=0',
            style: TextStyle(
                color: Colors.white70,
                fontFamily: 'monospace',
                fontSize: 11.0)),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            height: 2.0,
            color: Colors.white24,
          ),
        ),
        Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            color: Colors.cyanAccent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.cyanAccent.withValues(alpha: 0.6),
                blurRadius: 8.0,
              ),
            ],
          ),
        ),
        SizedBox(width: 6.0),
        Text('announce()',
            style: TextStyle(
                color: Colors.cyanAccent,
                fontFamily: 'monospace',
                fontSize: 11.0)),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            height: 2.0,
            color: Colors.white24,
          ),
        ),
        Text('t=end',
            style: TextStyle(
                color: Colors.white70,
                fontFamily: 'monospace',
                fontSize: 11.0)),
        SizedBox(width: 8.0),
      ],
    ),
  );
}

Widget _buildTranscriptScenario({
  required String label,
  required Color color,
  required Color accent,
  required String existing,
  required String announcement,
  required String behavior,
  required int existingFlex,
  required int gapFlex,
  required int announcementFlex,
  required bool interrupted,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                behavior,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        // Time-bar with two utterance segments
        Row(
          children: [
            Expanded(
              flex: existingFlex,
              child: _utteranceSegment(
                text: existing,
                color: Colors.blue.shade300,
                cutOff: interrupted,
              ),
            ),
            if (gapFlex > 0)
              Expanded(
                flex: gapFlex,
                child: Container(
                  height: 32.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      '...silence...',
                      style: TextStyle(
                        color: Colors.white54,
                        fontStyle: FontStyle.italic,
                        fontSize: 10.5,
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              flex: announcementFlex,
              child: _utteranceSegment(
                text: announcement,
                color: color,
                cutOff: false,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _utteranceSegment({
  required String text,
  required Color color,
  required bool cutOff,
}) {
  return Container(
    height: 56.0,
    margin: EdgeInsets.symmetric(horizontal: 2.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.7), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              cutOff ? Icons.cut : Icons.record_voice_over,
              size: 14.0,
              color: color,
            ),
            SizedBox(width: 6.0),
            Text(
              cutOff ? 'CUT OFF' : 'speech bubble',
              style: TextStyle(
                color: color,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipeCard({
  required String title,
  required Assertiveness chosen,
  required String rationale,
  required Color primary,
  required Color bgStart,
  required Color bgEnd,
  required IconData icon,
  required Widget mockUi,
}) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [bgStart, bgEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: primary.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: primary.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: primary, size: 26.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                'use ${chosen.name}',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Mock UI
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: mockUi,
        ),
        SizedBox(height: 10.0),
        // Rationale
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: primary, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  rationale,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: primary.withValues(alpha: 0.95),
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

Widget _mockFormError() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Email',
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700)),
      SizedBox(height: 4.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.red.shade400, width: 1.5),
        ),
        child: Text('not-an-email',
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Colors.red.shade900)),
      ),
      SizedBox(height: 6.0),
      Row(
        children: [
          Icon(Icons.error, size: 14.0, color: Colors.red.shade700),
          SizedBox(width: 4.0),
          Text('Please enter a valid email address.',
              style:
                  TextStyle(fontSize: 11.5, color: Colors.red.shade700)),
        ],
      ),
    ],
  );
}

Widget _mockSuccessToast() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade600, Colors.teal.shade500],
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: Colors.white, size: 18.0),
        SizedBox(width: 8.0),
        Text('Profile saved.',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

Widget _mockNotificationBanner() {
  return Row(
    children: [
      Container(
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
          color: Colors.blue.shade600,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.message, color: Colors.white, size: 20.0),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sam Patel',
                style: TextStyle(
                    fontSize: 12.5, fontWeight: FontWeight.bold)),
            Text('Sent you a new message about the design review.',
                style: TextStyle(
                    fontSize: 11.5, color: Colors.grey.shade700)),
          ],
        ),
      ),
      Text('2m',
          style: TextStyle(fontSize: 10.5, color: Colors.grey.shade500)),
    ],
  );
}

Widget _mockCriticalAlert() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.deepOrange.shade700, size: 22.0),
          SizedBox(width: 8.0),
          Text('Session expired',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade900)),
        ],
      ),
      SizedBox(height: 6.0),
      Text(
        'You have been signed out for security. Please sign in again to '
        'continue.',
        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade600,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text('Sign in',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ],
  );
}

Widget _buildTableHeader() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Aspect',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'polite',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.green.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'assertive',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.red.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTableRow(
  String aspect,
  String politeText,
  String assertiveText,
  Color politeColor,
  Color assertiveColor, {
  bool isLast = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: BoxDecoration(
      border: isLast
          ? null
          : Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
            ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            aspect,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: Colors.grey.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            politeText,
            style: TextStyle(
              fontSize: 12.0,
              color: politeColor,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            assertiveText,
            style: TextStyle(
              fontSize: 12.0,
              color: assertiveColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfall({
  required String title,
  required String body,
  required IconData icon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18.0, color: Colors.deepOrange.shade700),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.brown.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDecisionStep({
  required String step,
  required String question,
  required String yesLabel,
  required String noLabel,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.0),
              Row(
                children: [
                  _decisionPill(yesLabel, Colors.red.shade600),
                  SizedBox(width: 8.0),
                  _decisionPill(noLabel, Colors.green.shade700),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _decisionPill(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.5,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

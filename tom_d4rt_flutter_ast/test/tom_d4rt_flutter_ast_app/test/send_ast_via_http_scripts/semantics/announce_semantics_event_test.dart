// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: AnnounceSemanticsEvent — "Megaphone Brass" palette
// Hand-authored deep accessibility tour for screen-reader announcements.
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Megaphone Brass palette — warm metallic tones evoking a public-address
  // megaphone, with deep saffron and indigo accents to mirror voice waveforms.
  // ---------------------------------------------------------------------------
  final Color brassDeep = Color(0xFF6B4A12);
  final Color brassMid = Color(0xFFB07D2B);
  final Color brassBright = Color(0xFFE8B14F);
  final Color saffronGlow = Color(0xFFF6C94B);
  final Color saffronSoft = Color(0xFFFAE19A);
  final Color indigoNight = Color(0xFF1E1B4B);
  final Color indigoMid = Color(0xFF3F3A82);
  final Color indigoSoft = Color(0xFFB8B5E8);
  final Color paperCream = Color(0xFFFFF8E7);
  final Color paperWarm = Color(0xFFFAEFD6);
  final Color crimsonAlert = Color(0xFFB73734);
  final Color forestOk = Color(0xFF2F6B3D);
  final Color slateText = Color(0xFF2A2515);
  final Color slateSoft = Color(0xFF6A6248);
  final Color dividerTone = Color(0xFFD9C58A);

  // ---------------------------------------------------------------------------
  // Hero: try to instantiate AnnounceSemanticsEvent. Wrap in try/catch so the
  // demo renders even if the bridged constructor disagrees on positional vs
  // named arguments across Flutter versions.
  // ---------------------------------------------------------------------------
  String heroMessage = 'Item added to cart';
  String heroDirection = 'TextDirection.ltr';
  String heroViewId = '0';
  String heroType = '(unknown)';
  String heroRuntime = '(unknown)';
  String heroStatus = 'pending';
  String heroError = '';
  try {
    final probe = AnnounceSemanticsEvent(
      heroMessage,
      TextDirection.ltr,
      0,
    );
    heroType = '${probe.type}';
    heroRuntime = '${probe.runtimeType}';
    heroStatus = 'constructed';
  } catch (e) {
    heroError = '$e';
    heroStatus = 'fallback';
  }

  print('AnnounceSemanticsEvent visual demo executing');
  print('Hero status: $heroStatus, type: $heroType, runtime: $heroRuntime');
  if (heroError.isNotEmpty) {
    print('Hero fallback reason: $heroError');
  }

  // ---------------------------------------------------------------------------
  // API surface rows. We keep these as plain records of (name, type, default,
  // role) to render a uniform table and to print to the d4rt console.
  // ---------------------------------------------------------------------------
  final List<List<String>> apiRows = [
    [
      'message',
      'String',
      'required',
      'The text the screen reader speaks aloud — keep concise and meaningful.',
    ],
    [
      'textDirection',
      'TextDirection',
      'required',
      'Reading direction for the message — must match the locale of the words.',
    ],
    [
      'viewId',
      'int',
      '0',
      'Target FlutterView identifier; multi-window apps may dispatch per-view.',
    ],
    [
      'assertiveness',
      'Assertiveness',
      'polite',
      'polite waits for current speech, assertive interrupts immediately.',
    ],
    [
      'type',
      'String',
      "'announce'",
      'Engine-side discriminator on the platform channel payload.',
    ],
  ];
  print('API surface rows: ${apiRows.length}');

  // ---------------------------------------------------------------------------
  // Related semantics events catalog. Each entry models a sibling that
  // dispatches over the same flutter/accessibility channel.
  // ---------------------------------------------------------------------------
  final List<List<String>> relatedEvents = [
    [
      'TapSemanticEvent',
      'tap',
      'Synthesise a tap for assistive technologies — used by accessibility services that simulate a touch.',
    ],
    [
      'LongPressSemanticsEvent',
      'longPress',
      'Synthesise a long-press, typically for context menus or drag handles surfaced through a11y.',
    ],
    [
      'TooltipSemanticsEvent',
      'tooltip',
      'Forward tooltip text content to the platform so the screen reader can voice the hint.',
    ],
    [
      'FocusSemanticEvent',
      'focus',
      'Move accessibility focus to the node, also moving system reading cursor.',
    ],
    [
      'AnnounceSemanticsEvent',
      'announce',
      'Speak a transient message without changing focus or selection.',
    ],
  ];
  print('Related events catalog: ${relatedEvents.length}');

  // ---------------------------------------------------------------------------
  // Message-style gallery — alert / status / confirmation / error.
  // ---------------------------------------------------------------------------
  final List<List<String>> messageStyles = [
    [
      'alert',
      'assertive',
      'Severe weather warning issued for your area',
      'Use sparingly. Interrupts speech. Reserve for safety, security, or data-loss risks.',
    ],
    [
      'status',
      'polite',
      'Connecting to the brass band server',
      'Use for ambient progress and non-blocking transitions. Queues behind any current speech.',
    ],
    [
      'confirmation',
      'polite',
      'Item added to cart',
      'Confirm an action the user just initiated; shows TalkBack/VoiceOver the work is done.',
    ],
    [
      'error',
      'assertive',
      'Could not save form, please retry',
      'Surface validation or persistence failure that the user must address before continuing.',
    ],
    [
      'progress',
      'polite',
      'Upload at fifty seven percent',
      'Periodic numeric updates; throttle to avoid speech overflow on slow connections.',
    ],
    [
      'instruction',
      'polite',
      'Swipe right to reveal more actions',
      'Educational hints. Do not repeat once the user has demonstrated familiarity.',
    ],
  ];
  print('Message-style gallery: ${messageStyles.length}');

  // ---------------------------------------------------------------------------
  // TalkBack vs VoiceOver assertive vs polite assertion table.
  // ---------------------------------------------------------------------------
  final List<List<String>> readerMatrix = [
    [
      'TalkBack (Android)',
      'polite',
      'Queues behind current utterance — lossless if speech is short.',
    ],
    [
      'TalkBack (Android)',
      'assertive',
      'Truncates ongoing utterance; resumes nothing — chooses speed over context.',
    ],
    [
      'VoiceOver (iOS)',
      'polite',
      'Coalesces with prior queued announcements; may be dropped if too many fire quickly.',
    ],
    [
      'VoiceOver (iOS)',
      'assertive',
      'Plays immediately, supersedes pending announcements; user feels strong urgency.',
    ],
    [
      'NVDA/Narrator (desktop)',
      'polite',
      'Treated as live region polite — read after the user finishes navigation.',
    ],
    [
      'NVDA/Narrator (desktop)',
      'assertive',
      'Read at next safe boundary; less interrupt-friendly than mobile readers.',
    ],
  ];
  print('Reader matrix: ${readerMatrix.length}');

  // ---------------------------------------------------------------------------
  // Scenario panels.
  // ---------------------------------------------------------------------------
  final List<List<String>> scenarios = [
    [
      'Form saved confirmation',
      'After Settings > Save tap',
      'Settings saved successfully',
      'polite',
      'Pair with a brief visual toast; do not duplicate snackbar text verbatim if it adds no clarity.',
    ],
    [
      'Error toast',
      'Network call returned 500',
      'Could not save changes, please retry',
      'assertive',
      'Always include the suggested next action so the user is not stranded.',
    ],
    [
      'Page-loaded notice',
      'Route push from search to detail',
      'Detail page loaded for selected brass band',
      'polite',
      'Often redundant with focus shifts to the AppBar — measure before deploying.',
    ],
    [
      'Network state change',
      'Connectivity stream toggles to offline',
      'Offline mode enabled, edits will sync later',
      'polite',
      'Suppress repeats while state remains the same to avoid speech storms.',
    ],
    [
      'Time / percentage update',
      'Long upload tick crosses milestone',
      'Upload at twenty five percent',
      'polite',
      'Throttle to multiples of 25 percent; never every byte.',
    ],
    [
      'Asynchronous arrival',
      'Background fetch completes',
      'Three new messages received',
      'polite',
      'Do not over-announce when the user is focused on a different task.',
    ],
  ];
  print('Scenarios: ${scenarios.length}');

  // ---------------------------------------------------------------------------
  // Pitfalls catalog.
  // ---------------------------------------------------------------------------
  final List<List<String>> pitfalls = [
    [
      'Verbose announcements',
      'Trim to the essential subject and verb. "Saved" beats "Your settings have been successfully saved to disk".',
    ],
    [
      'RTL text direction mismatches',
      'Match TextDirection to the message locale, not the app default. Arabic message with ltr breaks bidi shaping.',
    ],
    [
      'Speech storms',
      'Multiple announcements in quick succession overwhelm; coalesce or throttle by 1-2 seconds.',
    ],
    [
      'Wrong assertiveness',
      'assertive interrupts the user — reserve for safety. Polite is almost always correct.',
    ],
    [
      'Shadowing focus shifts',
      'If you also push a route, the framework may already speak the new screen — duplicate announce becomes noise.',
    ],
    [
      'Localisation gaps',
      'Hard-coded English message inside a localised UI. Always run announce text through the same i18n layer.',
    ],
    [
      'Punctuation tics',
      'Some readers spell out emoji or special chars. Sanitise the message before dispatch.',
    ],
    [
      'Race against navigation',
      'Announce just before a route pop is often dropped — emit after the route settles or use post-frame callbacks.',
    ],
  ];
  print('Pitfalls: ${pitfalls.length}');

  // ---------------------------------------------------------------------------
  // Glossary entries.
  // ---------------------------------------------------------------------------
  final List<List<String>> glossary = [
    [
      'Assertiveness',
      'Hint to the platform on whether to interrupt current speech (assertive) or wait (polite).',
    ],
    [
      'SemanticsEvent',
      'Base class for messages dispatched on the flutter/accessibility platform channel.',
    ],
    [
      'SemanticsService',
      'Static facade with announce/tooltip helpers that wrap concrete SemanticsEvent subclasses.',
    ],
    [
      'Live region',
      'Semantics node flag that automatically announces when its child content changes.',
    ],
    [
      'TextDirection',
      'Reading direction enum controlling bidi layout and reader pronunciation.',
    ],
    [
      'TalkBack',
      "Android's screen reader, processes Flutter accessibility events through the AccessibilityBridge.",
    ],
    [
      'VoiceOver',
      "iOS's screen reader, consumes UIAccessibility notifications mapped from SemanticsEvent.",
    ],
    [
      'flutter/accessibility',
      'Platform method channel name used to forward semantics events to the host.',
    ],
    [
      'FlutterView',
      'A single rendered Flutter surface; viewId selects which one receives the announcement.',
    ],
    [
      'Polite vs assertive',
      'ARIA-aligned terminology mirrored by Flutter to express interrupt intent.',
    ],
  ];
  print('Glossary entries: ${glossary.length}');

  // ---------------------------------------------------------------------------
  // Palette swatches — name, hex, role.
  // ---------------------------------------------------------------------------
  final List<List<dynamic>> swatches = [
    ['Brass Deep', brassDeep, '#6B4A12', 'Heading and rule lines'],
    ['Brass Mid', brassMid, '#B07D2B', 'Borders and accent strokes'],
    ['Brass Bright', brassBright, '#E8B14F', 'Highlight chips and tabs'],
    ['Saffron Glow', saffronGlow, '#F6C94B', 'Hero gradient anchor'],
    ['Saffron Soft', saffronSoft, '#FAE19A', 'Card backgrounds'],
    ['Indigo Night', indigoNight, '#1E1B4B', 'Inverse panel base'],
    ['Indigo Mid', indigoMid, '#3F3A82', 'Inverse stroke and accents'],
    ['Indigo Soft', indigoSoft, '#B8B5E8', 'Inverse subdued text'],
    ['Paper Cream', paperCream, '#FFF8E7', 'Primary canvas'],
    ['Paper Warm', paperWarm, '#FAEFD6', 'Secondary canvas / stripes'],
    ['Crimson Alert', crimsonAlert, '#B73734', 'Error and assertive markers'],
    ['Forest OK', forestOk, '#2F6B3D', 'Success and confirmation marks'],
  ];
  print('Swatch count: ${swatches.length}');

  // ---------------------------------------------------------------------------
  // Comparison vs SemanticsService.announce.
  // ---------------------------------------------------------------------------
  final List<List<String>> comparison = [
    [
      'Public API',
      'AnnounceSemanticsEvent: low-level event class.',
      'SemanticsService.announce: ergonomic helper.',
    ],
    [
      'Binding',
      'Dispatched explicitly via SemanticsBinding.instance.',
      'Helper performs the dispatch internally for you.',
    ],
    [
      'Arguments',
      'Required: message, textDirection, viewId; optional assertiveness.',
      'Required: message, textDirection; assertiveness optional; viewId implicit.',
    ],
    [
      'Use case',
      'Custom infrastructure; multiple-view apps; testing the wire payload.',
      'Day-to-day app code emitting a polite announce.',
    ],
    [
      'Test surface',
      'Easier to unit-test toMap output and channel encoding.',
      'Easier to integrate; less to import.',
    ],
    [
      'Stability',
      'Constructor signature has shifted across Flutter versions.',
      'Helper signature has been stable longer.',
    ],
  ];
  print('Comparison rows: ${comparison.length}');

  // ---------------------------------------------------------------------------
  // Decision flow rows: when to choose live region vs announce vs label.
  // ---------------------------------------------------------------------------
  final List<List<String>> decisionRows = [
    [
      'Is the change tied to a stable widget already on screen?',
      'Yes -> Semantics(liveRegion: true) on that widget.',
    ],
    [
      'Is it a one-off, transient message with no permanent UI?',
      'Yes -> SemanticsService.announce() / AnnounceSemanticsEvent.',
    ],
    [
      'Is it static descriptive text for an existing node?',
      'Yes -> Semantics(label: ...) — no announce needed.',
    ],
    [
      'Does it require interrupting current speech (e.g. critical error)?',
      'Yes -> announce with Assertiveness.assertive.',
    ],
    [
      'Does it merely confirm an action the user took?',
      'Yes -> announce with Assertiveness.polite.',
    ],
    [
      'Will the route change anyway?',
      'Likely no announce — let route push speak the new screen.',
    ],
    [
      'Is the message localisation-ready and rate-limited?',
      'If not, fix that first — never bypass i18n for an announce.',
    ],
  ];
  print('Decision rows: ${decisionRows.length}');

  // ---------------------------------------------------------------------------
  // Helper builders. Defined as local closures so we avoid stateful classes.
  // ---------------------------------------------------------------------------
  Widget sectionHeader(String tag, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 28, 0, 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [brassMid, saffronGlow, paperCream],
        ),
        border: Border(
          left: BorderSide(color: brassDeep, width: 6),
          bottom: BorderSide(color: brassMid, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: indigoNight,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: saffronGlow,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: slateText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              color: slateSoft,
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget chip(String label, Color bg, Color fg) {
    return Container(
      margin: EdgeInsets.only(right: 6, bottom: 6),
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: fg.withValues(alpha: 0.35), width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget keyValue(String k, String v) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              k,
              style: TextStyle(
                color: brassDeep,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: TextStyle(
                color: slateText,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Build hero card.
  // ---------------------------------------------------------------------------
  final Widget heroCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [indigoNight, indigoMid, brassDeep],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: brassBright, width: 2),
      boxShadow: [
        BoxShadow(
          color: brassDeep.withValues(alpha: 0.45),
          offset: Offset(0, 6),
          blurRadius: 18,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: saffronGlow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'flutter/accessibility',
                style: TextStyle(
                  color: indigoNight,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: indigoSoft.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: indigoSoft, width: 1),
              ),
              child: Text(
                'SemanticsEvent',
                style: TextStyle(
                  color: indigoSoft,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Text(
          'AnnounceSemanticsEvent',
          style: TextStyle(
            color: saffronGlow,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Megaphone Brass — A deep visual tour of screen-reader announcements',
          style: TextStyle(
            color: paperCream,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paperCream.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: saffronGlow.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Probe instance',
                style: TextStyle(
                  color: saffronSoft,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'message: $heroMessage',
                style: TextStyle(
                  color: paperCream,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'textDirection: $heroDirection',
                style: TextStyle(
                  color: paperCream,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'viewId: $heroViewId',
                style: TextStyle(
                  color: paperCream,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'type: $heroType',
                style: TextStyle(
                  color: paperCream,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'runtimeType: $heroRuntime',
                style: TextStyle(
                  color: paperCream,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'status: $heroStatus',
                style: TextStyle(
                  color: heroStatus == 'constructed' ? saffronGlow : crimsonAlert,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        Wrap(
          children: [
            chip('polite', saffronGlow, indigoNight),
            chip('assertive', crimsonAlert, paperCream),
            chip('LTR / RTL', indigoSoft, indigoNight),
            chip('viewId-aware', brassBright, indigoNight),
            chip('no focus shift', paperCream, indigoNight),
            chip('toMap()', saffronSoft, indigoNight),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // API surface table widget.
  // ---------------------------------------------------------------------------
  final List<Widget> apiTableRows = <Widget>[];
  apiTableRows.add(Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: brassDeep,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            'Field',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: Text(
            'Type',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            'Default',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Role',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  ));
  for (int i = 0; i < apiRows.length; i++) {
    final List<String> row = apiRows[i];
    final Color zebra = i.isEven ? paperCream : paperWarm;
    apiTableRows.add(Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: zebra,
        border: Border(
          left: BorderSide(color: brassMid, width: 1),
          right: BorderSide(color: brassMid, width: 1),
          bottom: BorderSide(color: dividerTone, width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              row[0],
              style: TextStyle(
                color: indigoNight,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              row[1],
              style: TextStyle(
                color: brassDeep,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              row[2],
              style: TextStyle(
                color: slateSoft,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row[3],
              style: TextStyle(color: slateText, fontSize: 12),
            ),
          ),
        ],
      ),
    ));
  }
  apiTableRows.add(Container(
    height: 6,
    decoration: BoxDecoration(
      color: brassDeep,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
  ));

  // ---------------------------------------------------------------------------
  // Related events catalog cards.
  // ---------------------------------------------------------------------------
  final List<Widget> relatedCards = <Widget>[];
  for (int i = 0; i < relatedEvents.length; i++) {
    final List<String> row = relatedEvents[i];
    final bool isSelf = row[0] == 'AnnounceSemanticsEvent';
    relatedCards.add(Container(
      margin: EdgeInsets.only(bottom: 9),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelf ? saffronSoft : paperCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelf ? brassDeep : brassMid,
          width: isSelf ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  row[0],
                  style: TextStyle(
                    color: indigoNight,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: brassDeep,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "type='${row[1]}'",
                  style: TextStyle(
                    color: saffronGlow,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            row[2],
            style: TextStyle(color: slateText, fontSize: 12.5, height: 1.4),
          ),
          if (isSelf)
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                '<-- this demo focuses on this event',
                style: TextStyle(
                  color: brassDeep,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Message-style gallery cards.
  // ---------------------------------------------------------------------------
  final List<Widget> messageCards = <Widget>[];
  for (int i = 0; i < messageStyles.length; i++) {
    final List<String> row = messageStyles[i];
    final bool assertive = row[1] == 'assertive';
    final Color base = assertive ? crimsonAlert : forestOk;
    String tryStatus = 'pending';
    String tryError = '';
    try {
      final probe = AnnounceSemanticsEvent(
        row[2],
        TextDirection.ltr,
        0,
      );
      tryStatus = 'ok type=${probe.type}';
    } catch (e) {
      tryStatus = 'fallback';
      tryError = '$e';
    }
    if (tryError.isNotEmpty) {
      print('Style ${row[0]} fallback: $tryError');
    }
    messageCards.add(Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #82, P5(a)):
      // Original combined `borderRadius: 8` with a non-uniform `Border`
      // (left: base/5 vs top/right/bottom: dividerTone/0.7 — different
      // colors and widths). Flutter asserts uniform-colors-or-no-radius.
      // The messageCards loop renders one tile per styleRows entry. Drop
      // borderRadius; the heavy-left accent bar look survives via the
      // wider, saturated left BorderSide alone.
      decoration: BoxDecoration(
        color: paperCream,
        border: Border(
          left: BorderSide(color: base, width: 5),
          top: BorderSide(color: dividerTone, width: 0.7),
          right: BorderSide(color: dividerTone, width: 0.7),
          bottom: BorderSide(color: dividerTone, width: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: base,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  row[0].toUpperCase(),
                  style: TextStyle(
                    color: paperCream,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: base.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: base, width: 0.6),
                ),
                child: Text(
                  row[1],
                  style: TextStyle(
                    color: base,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Text(
                tryStatus,
                style: TextStyle(
                  color: slateSoft,
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: paperWarm,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: indigoNight,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'speak',
                    style: TextStyle(
                      color: saffronGlow,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '"${row[2]}"',
                    style: TextStyle(
                      color: indigoNight,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            row[3],
            style: TextStyle(color: slateText, fontSize: 12, height: 1.45),
          ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Reader matrix table.
  // ---------------------------------------------------------------------------
  final List<Widget> readerRows = <Widget>[];
  readerRows.add(Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    color: indigoNight,
    child: Row(
      children: [
        SizedBox(
          width: 160,
          child: Text(
            'Reader',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            'Mode',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Behavior',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  ));
  for (int i = 0; i < readerMatrix.length; i++) {
    final List<String> row = readerMatrix[i];
    final Color zebra = i.isEven ? paperCream : paperWarm;
    final bool assertive = row[1] == 'assertive';
    readerRows.add(Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      color: zebra,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              row[0],
              style: TextStyle(
                color: indigoNight,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              row[1],
              style: TextStyle(
                color: assertive ? crimsonAlert : forestOk,
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row[2],
              style: TextStyle(color: slateText, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // ASCII flow showing platform channel dispatch path.
  // ---------------------------------------------------------------------------
  final String asciiFlow = ''
      '  Dart side                                Platform side\n'
      '  +-------------------+                    +-------------------+\n'
      '  | App calls         |                    | Android TalkBack  |\n'
      '  | SemanticsService  |   flutter/         | iOS VoiceOver     |\n'
      '  | .announce(msg)    +------------------->+ NVDA / Narrator   |\n'
      '  +---------+---------+   accessibility    +---------+---------+\n'
      '            |                                        |\n'
      '            v                                        v\n'
      '  +---------+---------+                    +---------+---------+\n'
      '  | AnnounceSemantics |                    | Speech engine     |\n'
      '  | Event(message,    |                    | speaks the text   |\n'
      '  |   textDirection,  |                    | per assertiveness |\n'
      '  |   viewId,         |                    +-------------------+\n'
      '  |   assertiveness)  |\n'
      '  +---------+---------+\n'
      '            |\n'
      '            v\n'
      '  +-------------------+\n'
      '  | toMap() -> JSON   |\n'
      '  | over MethodChannel|\n'
      '  +-------------------+\n';

  final Widget asciiPanel = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: indigoNight,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: indigoMid, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: saffronGlow,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                'CHANNEL FLOW',
                style: TextStyle(
                  color: indigoNight,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'flutter/accessibility',
              style: TextStyle(
                color: indigoSoft,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          asciiFlow,
          style: TextStyle(
            color: paperCream,
            fontFamily: 'monospace',
            fontSize: 11,
            height: 1.25,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Scenarios panels.
  // ---------------------------------------------------------------------------
  final List<Widget> scenarioPanels = <Widget>[];
  for (int i = 0; i < scenarios.length; i++) {
    final List<String> row = scenarios[i];
    final bool assertive = row[3] == 'assertive';
    final Color accent = assertive ? crimsonAlert : forestOk;
    scenarioPanels.add(Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: paperCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: brassMid, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [brassDeep, brassMid],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: saffronGlow,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: indigoNight,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    row[0],
                    style: TextStyle(
                      color: paperCream,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row[3],
                    style: TextStyle(
                      color: paperCream,
                      fontSize: 10,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                keyValue('Trigger', row[1]),
                keyValue('Spoken', '"${row[2]}"'),
                keyValue('Mode', row[3]),
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    row[4],
                    style: TextStyle(
                      color: slateText,
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Pitfalls list.
  // ---------------------------------------------------------------------------
  final List<Widget> pitfallTiles = <Widget>[];
  for (int i = 0; i < pitfalls.length; i++) {
    final List<String> row = pitfalls[i];
    pitfallTiles.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(11),
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #82, P5(a)):
      // Original combined `borderRadius: 7` with `Border(left: crimsonAlert/4)` —
      // top/right/bottom default to BorderSide.none → non-uniform. Flutter
      // asserts uniform-colors-or-no-radius. The pitfallTiles loop produces
      // one tile per pitfalls entry. Drop borderRadius; the heavy-left accent
      // bar look survives via the colored left BorderSide alone.
      decoration: BoxDecoration(
        color: i.isEven ? paperCream : paperWarm,
        border: Border(left: BorderSide(color: crimsonAlert, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: crimsonAlert,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '!',
              style: TextStyle(
                color: paperCream,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row[0],
                  style: TextStyle(
                    color: indigoNight,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  row[1],
                  style: TextStyle(
                    color: slateText,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Glossary list.
  // ---------------------------------------------------------------------------
  final List<Widget> glossaryTiles = <Widget>[];
  for (int i = 0; i < glossary.length; i++) {
    final List<String> row = glossary[i];
    glossaryTiles.add(Container(
      margin: EdgeInsets.only(bottom: 7),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: paperCream,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: dividerTone, width: 0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              row[0],
              style: TextStyle(
                color: brassDeep,
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              row[1],
              style: TextStyle(color: slateText, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Palette swatches grid.
  // ---------------------------------------------------------------------------
  final List<Widget> swatchTiles = <Widget>[];
  for (int i = 0; i < swatches.length; i++) {
    final List<dynamic> row = swatches[i];
    final String name = row[0] as String;
    final Color color = row[1] as Color;
    final String hex = row[2] as String;
    final String role = row[3] as String;
    swatchTiles.add(Container(
      width: 230,
      margin: EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: paperCream,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: brassMid, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #82, P5(a)):
            // Original combined `BorderRadius.only(topLeft, bottomLeft)` with
            // `Border(right: brassMid/1)` — the other three sides default to
            // BorderSide.none → non-uniform. Flutter asserts uniform-colors-
            // or-no-radius. Drop borderRadius; the swatch divider strip retains
            // its right separator via the colored BorderSide alone (the corners
            // of this inner color block were never visually critical anyway —
            // the outer container at line 1450 still provides the rounded
            // pill shape).
            decoration: BoxDecoration(
              color: color,
              border: Border(
                right: BorderSide(color: brassMid, width: 1),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: indigoNight,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    hex,
                    style: TextStyle(
                      color: brassDeep,
                      fontSize: 11,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    role,
                    style: TextStyle(
                      color: slateSoft,
                      fontSize: 10.5,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Comparison table vs SemanticsService.announce.
  // ---------------------------------------------------------------------------
  final List<Widget> comparisonRows = <Widget>[];
  comparisonRows.add(Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    color: brassDeep,
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            'Aspect',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'AnnounceSemanticsEvent',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'SemanticsService.announce',
            style: TextStyle(
              color: saffronGlow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  ));
  for (int i = 0; i < comparison.length; i++) {
    final List<String> row = comparison[i];
    final Color zebra = i.isEven ? paperCream : paperWarm;
    comparisonRows.add(Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      color: zebra,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              row[0],
              style: TextStyle(
                color: indigoNight,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                row[1],
                style: TextStyle(
                  color: slateText,
                  fontSize: 11.5,
                  height: 1.4,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              row[2],
              style: TextStyle(color: slateText, fontSize: 11.5, height: 1.4),
            ),
          ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Decision flowchart.
  // ---------------------------------------------------------------------------
  final List<Widget> decisionTiles = <Widget>[];
  for (int i = 0; i < decisionRows.length; i++) {
    final List<String> row = decisionRows[i];
    decisionTiles.add(Container(
      margin: EdgeInsets.only(bottom: 9),
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: paperCream,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: brassMid, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: indigoNight,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'Q${i + 1}',
              style: TextStyle(
                color: saffronGlow,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row[0],
                  style: TextStyle(
                    color: indigoNight,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: saffronSoft,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: brassMid, width: 0.7),
                  ),
                  child: Text(
                    row[1],
                    style: TextStyle(
                      color: slateText,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Prose sections — TalkBack/VoiceOver assertive vs polite.
  // ---------------------------------------------------------------------------
  final Widget proseTalkBack = Container(
    padding: EdgeInsets.all(14),
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #82, P5(a)):
    // Original combined `borderRadius: 8` with `Border(left: brassDeep/5)` —
    // top/right/bottom default to BorderSide.none → non-uniform. Drop
    // borderRadius; the proseTalkBack prose card keeps its heavy-left
    // accent bar via the colored left BorderSide alone.
    decoration: BoxDecoration(
      color: paperCream,
      border: Border(left: BorderSide(color: brassDeep, width: 5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assertive vs polite — what the readers actually do',
          style: TextStyle(
            color: indigoNight,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'AnnounceSemanticsEvent carries an Assertiveness hint that closely mirrors the ARIA aria-live "polite" and "assertive" semantics. On Android, TalkBack queues polite announcements behind whatever utterance the engine is currently speaking, so a user reading a paragraph will hear your message at the next pause. Assertive announcements truncate the current utterance immediately — useful for genuine errors and safety alerts, hostile to user comfort if abused. On iOS, VoiceOver coalesces polite announcements; if many fire in quick succession the platform may silently drop intermediate ones, so you cannot use polite announcements as a reliable transport for stepwise progress. Assertive announcements always play, but if multiple assertives fire back-to-back the user only hears the last one. Desktop screen readers like NVDA and Narrator process Flutter accessibility events through an extra translation layer; their notion of "assertive" is closer to "next safe boundary" than "right now". Test announcements on at least one mobile and one desktop reader before shipping.',
          style: TextStyle(color: slateText, fontSize: 12.5, height: 1.55),
        ),
      ],
    ),
  );

  final Widget proseDirection = Container(
    padding: EdgeInsets.all(14),
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #82, P5(a)):
    // Original combined `borderRadius: 8` with `Border(left: indigoMid/5)` —
    // top/right/bottom default to BorderSide.none → non-uniform. Drop
    // borderRadius; the proseDirection prose card keeps its heavy-left
    // accent bar via the colored left BorderSide alone.
    decoration: BoxDecoration(
      color: paperWarm,
      border: Border(left: BorderSide(color: indigoMid, width: 5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TextDirection: more than a layout knob',
          style: TextStyle(
            color: indigoNight,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'TextDirection on AnnounceSemanticsEvent is required because the platform must know how to chunk and pronounce mixed-script content. A common bug is to pass the ambient TextDirection of the surrounding widget tree even when the message itself is in a different language. The fix is to derive direction from the message locale: pass TextDirection.rtl for Arabic, Hebrew, Persian, and Urdu announcements, even if the rest of the app reads left-to-right. Failure to do so manifests as garbled bidi shaping in the system speech log and, on some platforms, audibly wrong pronunciation of digits or English-loanwords inside the announcement.',
          style: TextStyle(color: slateText, fontSize: 12.5, height: 1.55),
        ),
      ],
    ),
  );

  final Widget proseViewId = Container(
    padding: EdgeInsets.all(14),
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #82, P5(a)):
    // Original combined `borderRadius: 8` with `Border(left: brassMid/5)` —
    // top/right/bottom default to BorderSide.none → non-uniform. Drop
    // borderRadius; the proseViewId prose card keeps its heavy-left accent
    // bar via the colored left BorderSide alone.
    decoration: BoxDecoration(
      color: paperCream,
      border: Border(left: BorderSide(color: brassMid, width: 5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'viewId for multi-window applications',
          style: TextStyle(
            color: indigoNight,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Most Flutter applications run in a single FlutterView whose id is 0. That default works for the vast majority of code that simply wants to announce something. Multi-window targets — desktop apps with detached panels, embedded engines, or modular tooling — own multiple FlutterView instances and must direct announcements to the right one. Routing an announcement to a hidden view leaves the user wondering where the voice came from. When in doubt, retrieve the active view from the View.of() lookup and pass its id.',
          style: TextStyle(color: slateText, fontSize: 12.5, height: 1.55),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Constructor playground — build a few well-formed instances and report
  // status. All wrapped in try/catch.
  // ---------------------------------------------------------------------------
  final List<List<String>> playgroundCases = [
    ['Polite LTR', 'Settings saved', 'ltr', '0', 'polite'],
    ['Assertive LTR', 'Network error, retrying', 'ltr', '0', 'assertive'],
    ['Polite RTL', 'تم الحفظ', 'rtl', '0', 'polite'],
    ['Polite secondary view', 'Inspector ready', 'ltr', '1', 'polite'],
    ['Assertive RTL', 'خطأ في النموذج', 'rtl', '0', 'assertive'],
  ];

  final List<Widget> playgroundCards = <Widget>[];
  for (int i = 0; i < playgroundCases.length; i++) {
    final List<String> row = playgroundCases[i];
    final TextDirection dir =
        row[2] == 'rtl' ? TextDirection.rtl : TextDirection.ltr;
    final int viewId = int.tryParse(row[3]) ?? 0;
    String status = 'pending';
    String evType = '';
    String evRuntime = '';
    try {
      final ev = AnnounceSemanticsEvent(
        row[1],
        dir,
        viewId,
      );
      status = 'constructed';
      evType = '${ev.type}';
      evRuntime = '${ev.runtimeType}';
    } catch (e) {
      status = 'fallback';
      evType = '(n/a)';
      evRuntime = '(n/a)';
      print('Playground ${row[0]} fallback: $e');
    }
    final bool ok = status == 'constructed';
    playgroundCards.add(Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: paperCream,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ok ? forestOk : crimsonAlert,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: ok ? forestOk : crimsonAlert,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    color: paperCream,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  row[0],
                  style: TextStyle(
                    color: indigoNight,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          keyValue('message', '"${row[1]}"'),
          keyValue('textDirection', 'TextDirection.${row[2]}'),
          keyValue('viewId', row[3]),
          keyValue('mode', row[4]),
          keyValue('type', evType),
          keyValue('runtimeType', evRuntime),
        ],
      ),
    ));
  }

  // ---------------------------------------------------------------------------
  // Footer signature panel.
  // ---------------------------------------------------------------------------
  final Widget footer = Container(
    margin: EdgeInsets.only(top: 28),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [indigoNight, indigoMid],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: saffronGlow, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Megaphone Brass demo — AnnounceSemanticsEvent',
          style: TextStyle(
            color: saffronGlow,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Hand-authored visual tour for the d4rt flutter AST runner. Single dynamic build(), no state, no async, index-based loops, withValues only.',
          style: TextStyle(
            color: paperCream,
            fontSize: 12,
            height: 1.45,
          ),
        ),
        SizedBox(height: 10),
        Opacity(
          opacity: 0.75,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: 0.95,
            child: Text(
              'animated as a still — no controllers, no setState',
              style: TextStyle(
                color: indigoSoft,
                fontSize: 10.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        FadeTransition(
          opacity: AlwaysStoppedAnimation<double>(0.85),
          child: Text(
            'Speak briefly. Speak truthfully. Do not interrupt.',
            style: TextStyle(
              color: saffronSoft,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Compose the final body.
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: paperCream,
    body: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(18, 22, 18, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heroCard,
          sectionHeader(
            'API SURFACE',
            'Constructor fields and engine-side metadata',
            'Every announcement is a struct — these are the slots you fill.',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: apiTableRows,
          ),
          sectionHeader(
            'RELATED EVENTS',
            'Siblings travelling the flutter/accessibility channel',
            'Announce is one of several SemanticsEvent subclasses — context matters.',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: relatedCards,
          ),
          sectionHeader(
            'MESSAGE STYLES',
            'Alert / status / confirmation / error / progress / instruction',
            'Six common idioms with their typical assertiveness and copy.',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: messageCards,
          ),
          sectionHeader(
            'READER MATRIX',
            'TalkBack vs VoiceOver vs desktop, polite vs assertive',
            'How each runtime resolves your assertiveness hint in practice.',
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: indigoNight, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: readerRows,
            ),
          ),
          sectionHeader(
            'PROSE',
            'Assertive vs polite, direction, viewId',
            'Three short essays that the reader matrix could not capture.',
          ),
          proseTalkBack,
          SizedBox(height: 10),
          proseDirection,
          SizedBox(height: 10),
          proseViewId,
          sectionHeader(
            'CHANNEL FLOW',
            'ASCII map of the platform channel dispatch',
            'Where the bytes go between your call and the speaker.',
          ),
          asciiPanel,
          sectionHeader(
            'SCENARIOS',
            'Form saved, error toast, page loaded, network, progress, async',
            'Six typical app moments that warrant a programmatic announce.',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: scenarioPanels,
          ),
          sectionHeader(
            'PITFALLS',
            'Eight ways announcements go wrong',
            'Read these before adding the seventh announce to a screen.',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: pitfallTiles,
          ),
          sectionHeader(
            'GLOSSARY',
            'Vocabulary used throughout this demo',
            'A compact dictionary of the surrounding semantic landscape.',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: glossaryTiles,
          ),
          sectionHeader(
            'PALETTE',
            'Megaphone Brass swatches',
            'Twelve named colours, their hexes, and the role each fills.',
          ),
          Wrap(children: swatchTiles),
          sectionHeader(
            'COMPARISON',
            'AnnounceSemanticsEvent vs SemanticsService.announce',
            'When to instantiate the event class vs use the helper.',
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: brassDeep, width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: comparisonRows,
            ),
          ),
          sectionHeader(
            'DECISION',
            'Live region vs announce vs label',
            'Seven yes/no questions that route you to the right primitive.',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: decisionTiles,
          ),
          sectionHeader(
            'PLAYGROUND',
            'Five well-formed AnnounceSemanticsEvent constructions',
            'Each wrapped in try/catch so the demo renders even on signature drift.',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: playgroundCards,
          ),
          footer,
        ],
      ),
    ),
  );
}

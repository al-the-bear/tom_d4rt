// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: FocusSemanticEvent showcase.
//
// Theme: "Spotlight Aurora" — magenta + violet + amber glow on dark slate.
// FocusSemanticEvent is the no-argument SemanticsEvent that the framework
// dispatches when a semantics node receives accessibility focus. Screen
// readers (VoiceOver, TalkBack) consume the event over the platform
// accessibility channel to announce the focused widget. The event has no
// payload — its semantic weight is entirely in its `type` string.
//
// Sections in this demo:
//   1. Header banner with palette swatches
//   2. Anatomy diagram of FocusSemanticEvent
//   3. Lifecycle / "who fires, who consumes" timeline
//   4. Simulated focus journey (tab traversal of fake widget tree)
//   5. Side panel listing the FocusSemanticEvent objects fired per stop
//   6. Comparison table card grid (Focus vs Announce vs LongPress vs Tap vs Tooltip)
//   7. Constructor & toMap dump grid (ten distinct instances)
//   8. Dispatch path diagram (engine -> platform -> screen reader)
//   9. Anti-patterns and best practices ledger
//  10. Footer legend with palette glossary

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('FocusSemanticEvent deep visual demo executing');
  print('=' * 60);

  // ============================================================
  // Palette: "Spotlight Aurora"
  // ============================================================
  final Color slateBackdrop = Color(0xFF0B0A1A);
  final Color slatePanel = Color(0xFF161430);
  final Color slatePanelAlt = Color(0xFF20194A);
  final Color slatePanelDeep = Color(0xFF0E0C22);
  final Color magentaBeam = Color(0xFFE040A8);
  final Color magentaSoft = Color(0xFFF378C2);
  final Color violetCore = Color(0xFF7A4DE0);
  final Color violetGlow = Color(0xFFA487F0);
  final Color amberSpot = Color(0xFFF7B93A);
  final Color amberSoft = Color(0xFFFFD884);
  final Color edgeRule = Color(0xFF34305A);
  final Color edgeRuleHot = Color(0xFF8C3070);
  final Color frostInk = Color(0xFFF1E8FF);
  final Color frostMuted = Color(0xFFAFA3D6);
  final Color codeInk = Color(0xFFCBE3FF);
  final Color codeBackdrop = Color(0xFF0A0820);
  final Color tealAccent = Color(0xFF35D6C2);

  print('Palette assembled: 14 hues for Spotlight Aurora.');

  // ============================================================
  // Build a roster of FocusSemanticEvent instances. The constructor
  // takes no arguments — every instance is structurally identical,
  // but we tag each one with its narrative role for the demo.
  // ============================================================
  final List<FocusSemanticEvent> events = <FocusSemanticEvent>[];
  for (int i = 0; i < 10; i++) {
    events.add(FocusSemanticEvent());
  }
  for (int i = 0; i < events.length; i++) {
    print('  events[$i] runtimeType=${events[i].runtimeType} '
        'type=${events[i].type}');
  }

  // Probe the type string and toMap once — they're identical for every
  // instance, but we materialize them so the visual sections can quote
  // the real values.
  final FocusSemanticEvent probe = FocusSemanticEvent();
  final String probeType = probe.type;
  Map<String, dynamic> probeMap;
  try {
    probeMap = probe.toMap();
  } catch (e) {
    print('toMap() failed: $e');
    probeMap = <String, dynamic>{'type': probeType};
  }
  print('Probe type     : $probeType');
  print('Probe toMap    : $probeMap');
  print('Probe toString : ${probe.toString()}');

  // The other SemanticsEvents we compare against. Some of these need an
  // argument (AnnounceSemanticsEvent and TooltipSemanticsEvent), the
  // rest are zero-arg like Focus.
  final SemanticsEvent compareFocus = FocusSemanticEvent();
  final SemanticsEvent compareAnnounce = AnnounceSemanticsEvent(
    'Login screen ready',
    TextDirection.ltr,
    0,
  );
  final SemanticsEvent compareLongPress = LongPressSemanticsEvent();
  final SemanticsEvent compareTap = TapSemanticEvent();
  final SemanticsEvent compareTooltip = TooltipSemanticsEvent(
    'Save your draft',
  );
  final List<SemanticsEvent> comparisonRoster = <SemanticsEvent>[
    compareFocus,
    compareAnnounce,
    compareLongPress,
    compareTap,
    compareTooltip,
  ];
  for (int i = 0; i < comparisonRoster.length; i++) {
    print('  compare[$i] type=${comparisonRoster[i].type}');
  }

  // ============================================================
  // Section 1: Header banner
  // ============================================================
  final Widget headerBanner = Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(28.0, 26.0, 28.0, 22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[slatePanelDeep, violetCore, magentaBeam],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: <double>[0.0, 0.55, 1.0],
      ),
      border: Border.all(color: edgeRuleHot, width: 1.6),
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: magentaBeam.withValues(alpha: 0.32),
          blurRadius: 18.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'FocusSemanticEvent',
          style: TextStyle(
            color: frostInk,
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Spotlight Aurora — a hand-authored snapshot demo',
          style: TextStyle(
            color: amberSoft,
            fontSize: 14.0,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          'FocusSemanticEvent is the zero-argument SemanticsEvent that '
          'Flutter dispatches when an accessibility node receives '
          'focus. Screen readers (VoiceOver, TalkBack, Narrator) listen '
          'on the platform channel and announce the focused widget. '
          'There is no payload: the event\'s identity is its type '
          'string "$probeType".',
          style: TextStyle(
            color: frostInk,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            _swatch(magentaBeam, 'magenta beam'),
            SizedBox(width: 8.0),
            _swatch(violetCore, 'violet core'),
            SizedBox(width: 8.0),
            _swatch(amberSpot, 'amber spot'),
            SizedBox(width: 8.0),
            _swatch(tealAccent, 'teal accent'),
            SizedBox(width: 8.0),
            _swatch(frostInk, 'frost ink'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // Section 2: Anatomy diagram
  // Stack of labeled rows describing the event's surface.
  // ============================================================
  final List<List<String>> anatomyRows = <List<String>>[
    <String>['constructor:', 'FocusSemanticEvent()', 'no arguments, no fields'],
    <String>['type:', '"$probeType"', 'identifier sent to the platform'],
    <String>[
      'toMap():',
      probeMap.toString(),
      'JSON-ready structure for the channel',
    ],
    <String>[
      'extends:',
      'SemanticsEvent',
      'shared abstract base for all semantics events',
    ],
    <String>[
      'dispatched by:',
      'SemanticsOwner.sendSemanticsEvent',
      'engine-side, after node gains a11y focus',
    ],
    <String>[
      'consumed by:',
      'platform accessibility services',
      'VoiceOver / TalkBack / Narrator etc.',
    ],
    <String>[
      'paired action:',
      'didGainAccessibilityFocus',
      'the SemanticsAction that triggers it',
    ],
    <String>[
      'lifecycle:',
      'fire-and-forget, single-shot',
      'no acknowledgement, no retry',
    ],
  ];

  final List<Color> anatomyHues = <Color>[
    magentaBeam,
    violetCore,
    amberSpot,
    tealAccent,
    magentaSoft,
    violetGlow,
    amberSoft,
    frostMuted,
  ];

  final List<Widget> anatomyBands = <Widget>[];
  for (int i = 0; i < anatomyRows.length; i++) {
    final Color hue = anatomyHues[i];
    anatomyBands.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              hue.withValues(alpha: 0.22),
              slatePanel.withValues(alpha: 0.95),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: Border(
            left: BorderSide(color: hue, width: 4.0),
            top: BorderSide(color: edgeRule, width: 0.5),
            right: BorderSide(color: edgeRule, width: 0.5),
            bottom: BorderSide(color: edgeRule, width: 0.5),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 130.0,
              child: Text(
                anatomyRows[i][0],
                style: TextStyle(
                  color: hue,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            SizedBox(
              width: 220.0,
              child: Text(
                anatomyRows[i][1],
                style: TextStyle(
                  color: frostInk,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                anatomyRows[i][2],
                style: TextStyle(
                  color: frostMuted,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget anatomyCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeRule, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Section 2 — Anatomy of FocusSemanticEvent',
          style: TextStyle(
            color: amberSpot,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The class has no fields. Its behavior is encoded entirely '
          'in the inherited `type` string and in the platform channel '
          'protocol. Each row below maps a single facet of the event.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: anatomyBands,
        ),
      ],
    ),
  );

  // ============================================================
  // Section 3: Lifecycle / dispatcher-consumer timeline
  // A horizontal strip of stations with connector arrows in between.
  // ============================================================
  final List<List<String>> lifecycleStations = <List<String>>[
    <String>['User', 'taps Tab key\nor swipes\nright'],
    <String>['Engine', 'shifts a11y\nfocus to next\nsemantics node'],
    <String>['Framework', 'creates a\nFocusSemantic-\nEvent()'],
    <String>['Owner', 'SemanticsOwner\n.sendSemantics-\nEvent dispatches'],
    <String>['Channel', 'platform channel\nflutter/accessibility\nreceives it'],
    <String>['OS', 'TalkBack /\nVoiceOver /\nNarrator hears it'],
    <String>['Speech', 'announces\nthe focused\nelement label'],
  ];
  final List<Color> stationHues = <Color>[
    tealAccent,
    violetGlow,
    magentaBeam,
    violetCore,
    amberSpot,
    magentaSoft,
    amberSoft,
  ];

  final List<Widget> lifecycleNodes = <Widget>[];
  for (int i = 0; i < lifecycleStations.length; i++) {
    lifecycleNodes.add(
      Container(
        width: 110.0,
        height: 130.0,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              stationHues[i].withValues(alpha: 0.85),
              stationHues[i].withValues(alpha: 0.30),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(color: stationHues[i], width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              lifecycleStations[i][0],
              style: TextStyle(
                color: slateBackdrop,
                fontWeight: FontWeight.w800,
                fontSize: 13.0,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              lifecycleStations[i][1],
              style: TextStyle(
                color: slatePanelDeep,
                fontSize: 10.5,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
    if (i < lifecycleStations.length - 1) {
      lifecycleNodes.add(
        Container(
          width: 18.0,
          height: 4.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                stationHues[i],
                stationHues[i + 1],
              ],
            ),
          ),
        ),
      );
    }
  }

  final Widget lifecycleCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slatePanelAlt,
      border: Border.all(color: edgeRule, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Section 3 — Lifecycle of a single FocusSemanticEvent',
          style: TextStyle(
            color: magentaSoft,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each station is one hop in the journey of a single Focus-'
          'SemanticEvent — from the user gesture that requests focus '
          'all the way to the spoken announcement.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: lifecycleNodes,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Section 4 + 5: Simulated focus journey — fake widget tree on the
  // left, side-panel list of FocusSemanticEvent dispatches on the right.
  // ============================================================
  final List<String> journeyLabels = <String>[
    'AppBar title "Compose"',
    'IconButton "Back"',
    'IconButton "Send"',
    'TextField "Subject"',
    'TextField "Body"',
    'ChoiceChip "Draft"',
    'ChoiceChip "Final"',
    'TextButton "Cancel"',
    'ElevatedButton "Save"',
  ];
  final int focusIndex = 4; // pretend the body field currently has focus

  final List<Widget> journeyNodes = <Widget>[];
  for (int i = 0; i < journeyLabels.length; i++) {
    final bool focused = i == focusIndex;
    final bool visited = i < focusIndex;
    Color border;
    Color fill;
    Color text;
    String marker;
    if (focused) {
      border = magentaBeam;
      fill = magentaBeam.withValues(alpha: 0.35);
      text = frostInk;
      marker = '\u25C9';
    } else if (visited) {
      border = violetGlow.withValues(alpha: 0.6);
      fill = violetCore.withValues(alpha: 0.18);
      text = frostMuted;
      marker = '\u25CB';
    } else {
      border = edgeRule;
      fill = slatePanelDeep;
      text = frostMuted;
      marker = '\u2022';
    }
    journeyNodes.add(
      Container(
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
        decoration: BoxDecoration(
          color: fill,
          border: Border.all(color: border, width: focused ? 2.0 : 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          boxShadow: focused
              ? <BoxShadow>[
                  BoxShadow(
                    color: magentaBeam.withValues(alpha: 0.45),
                    blurRadius: 12.0,
                    spreadRadius: 0.0,
                  ),
                ]
              : <BoxShadow>[],
        ),
        child: Row(
          children: <Widget>[
            Text(
              marker,
              style: TextStyle(
                color: focused ? amberSpot : border,
                fontSize: 14.0,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                journeyLabels[i],
                style: TextStyle(
                  color: text,
                  fontSize: 12.5,
                  fontWeight: focused ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
            Text(
              '#$i',
              style: TextStyle(
                color: text.withValues(alpha: 0.6),
                fontFamily: 'monospace',
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Widget> dispatchPanel = <Widget>[];
  for (int i = 0; i <= focusIndex; i++) {
    final FocusSemanticEvent fired = events[i];
    final bool current = i == focusIndex;
    dispatchPanel.add(
      Container(
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: current
              ? amberSpot.withValues(alpha: 0.18)
              : slatePanelDeep,
          border: Border.all(
            color: current ? amberSpot : edgeRule,
            width: current ? 1.8 : 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: current ? amberSpot : violetGlow,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  't=$i  ${fired.runtimeType}',
                  style: TextStyle(
                    color: current ? amberSoft : frostInk,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight:
                        current ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.0),
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'type=${fired.type}  payload=${fired.toMap()}',
                style: TextStyle(
                  color: frostMuted,
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget journeyCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[slatePanel, slatePanelDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: edgeRule, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Section 4 + 5 — Simulated focus journey',
          style: TextStyle(
            color: violetGlow,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Imagine the user tabbing through a Compose screen. The left '
          'panel paints the semantics tree; the right panel logs the '
          'FocusSemanticEvent objects fired on every advance. The '
          'highlighted node is the current focus owner.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: slatePanelDeep,
                  border: Border.all(color: edgeRule, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'semantics tree (snapshot)',
                      style: TextStyle(
                        color: amberSpot,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: journeyNodes,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: codeBackdrop,
                  border: Border.all(
                    color: amberSpot.withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'dispatched FocusSemanticEvent log',
                      style: TextStyle(
                        color: amberSpot,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: dispatchPanel,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // Section 6: Comparison table — five SemanticsEvent siblings.
  // ============================================================
  final List<List<String>> comparisonRows = <List<String>>[
    <String>[
      'FocusSemanticEvent',
      compareFocus.type,
      'no payload',
      'fires when a node gains a11y focus',
      'screen reader announces label',
    ],
    <String>[
      'AnnounceSemanticsEvent',
      compareAnnounce.type,
      'message + textDirection',
      'developer-triggered announcement',
      'screen reader speaks message verbatim',
    ],
    <String>[
      'LongPressSemanticsEvent',
      compareLongPress.type,
      'no payload',
      'long-press recognized by a11y',
      'used for contextual actions',
    ],
    <String>[
      'TapSemanticEvent',
      compareTap.type,
      'no payload',
      'tap recognized by a11y',
      'feedback for tap actions',
    ],
    <String>[
      'TooltipSemanticsEvent',
      compareTooltip.type,
      'message',
      'tooltip surfaced via a11y',
      'screen reader speaks tooltip text',
    ],
  ];
  final List<Color> compareHues = <Color>[
    magentaBeam,
    violetCore,
    amberSpot,
    tealAccent,
    magentaSoft,
  ];

  final List<Widget> compareCards = <Widget>[];
  for (int i = 0; i < comparisonRows.length; i++) {
    final Color hue = compareHues[i];
    final List<String> row = comparisonRows[i];
    final bool isHero = i == 0;
    compareCards.add(
      Container(
        width: 232.0,
        margin: EdgeInsets.only(right: 12.0, bottom: 12.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              hue.withValues(alpha: isHero ? 0.55 : 0.35),
              slatePanelDeep,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: isHero ? hue : hue.withValues(alpha: 0.7),
            width: isHero ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: isHero
              ? <BoxShadow>[
                  BoxShadow(
                    color: hue.withValues(alpha: 0.4),
                    blurRadius: 12.0,
                    spreadRadius: 0.5,
                  ),
                ]
              : <BoxShadow>[],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: hue,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    row[0],
                    style: TextStyle(
                      color: frostInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            _compareCell('type', row[1], frostInk, frostMuted),
            _compareCell('payload', row[2], frostInk, frostMuted),
            _compareCell('fires when', row[3], frostInk, frostMuted),
            _compareCell('effect', row[4], frostInk, frostMuted),
            if (isHero) ...<Widget>[
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: amberSpot,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Text(
                  'this demo\'s subject',
                  style: TextStyle(
                    color: slateBackdrop,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  final Widget comparisonCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeRule, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Section 6 — SemanticsEvent comparison',
          style: TextStyle(
            color: tealAccent,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Five siblings in the SemanticsEvent family. Focus is the '
          'one with no payload and a fire-on-focus contract; the '
          'others differ in payload and trigger.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: compareCards,
        ),
      ],
    ),
  );

  // ============================================================
  // Section 7: Constructor + toMap dump grid (10 instances).
  // Every instance is structurally identical; we lay them out anyway
  // to drive home the "same shape, different moments" point.
  // ============================================================
  final List<String> instanceCaptions = <String>[
    'AppBar title focus',
    'Back button focus',
    'Send button focus',
    'Subject field focus',
    'Body field focus',
    'Draft chip focus',
    'Final chip focus',
    'Cancel button focus',
    'Save button focus',
    'Snackbar action focus',
  ];
  final List<Widget> instanceTiles = <Widget>[];
  for (int i = 0; i < events.length; i++) {
    final FocusSemanticEvent ev = events[i];
    final Color hue = i.isEven ? violetGlow : magentaSoft;
    instanceTiles.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.only(right: 12.0, bottom: 12.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: slatePanelDeep,
          border: Border.all(color: hue.withValues(alpha: 0.65), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 22.0,
                  height: 22.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hue,
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: Text(
                    '$i',
                    style: TextStyle(
                      color: slateBackdrop,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    instanceCaptions[i],
                    style: TextStyle(
                      color: frostInk,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: codeBackdrop,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'final ev = FocusSemanticEvent();',
                    style: TextStyle(
                      color: codeInk,
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                    ),
                  ),
                  Text(
                    'ev.type    = "${ev.type}"',
                    style: TextStyle(
                      color: amberSoft,
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                    ),
                  ),
                  Text(
                    'ev.toMap() = ${ev.toMap()}',
                    style: TextStyle(
                      color: tealAccent,
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                    ),
                  ),
                  Text(
                    'ev.toString() snippet',
                    style: TextStyle(
                      color: frostMuted,
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget instancesCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slatePanelAlt,
      border: Border.all(color: edgeRule, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Section 7 — Ten constructor calls, ten identical shapes',
          style: TextStyle(
            color: amberSpot,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each tile constructs a fresh FocusSemanticEvent() and '
          'reads its `type` and `toMap()`. The values never change '
          'across instances — this class is a pure marker event.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: instanceTiles,
        ),
      ],
    ),
  );

  // ============================================================
  // Section 8: Dispatch path diagram — vertical stack of channel hops.
  // ============================================================
  final List<List<String>> dispatchHops = <List<String>>[
    <String>[
      'RenderObject',
      'sets `Semantics(onDidGainAccessibilityFocus: ...)`',
      'declarative configuration in the widget tree',
    ],
    <String>[
      'PipelineOwner',
      'calls SemanticsOwner.sendSemanticsEvent(FocusSemanticEvent())',
      'happens inside the next frame after focus changes',
    ],
    <String>[
      'SystemChannels.accessibility',
      'pushes {type: "focus"} over the platform channel',
      'message codec serializes the toMap() result',
    ],
    <String>[
      'Engine',
      'forwards the message to the embedder',
      'iOS, Android, Linux, Windows, macOS embedders all listen',
    ],
    <String>[
      'Platform a11y bridge',
      'translates into a UIAccessibility / TalkBack signal',
      'the platform layer owns the speech queue from here',
    ],
    <String>[
      'Screen reader',
      'speaks the focused widget\'s label and hint',
      'the user finally hears "Body, edit text, double tap to edit"',
    ],
  ];
  final List<Widget> dispatchHopWidgets = <Widget>[];
  for (int i = 0; i < dispatchHops.length; i++) {
    final Color hue = i.isEven ? violetCore : magentaBeam;
    dispatchHopWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              hue.withValues(alpha: 0.4),
              slatePanelDeep,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: Border.all(color: hue, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(9.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: hue,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: slateBackdrop,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    dispatchHops[i][0],
                    style: TextStyle(
                      color: frostInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    dispatchHops[i][1],
                    style: TextStyle(
                      color: amberSoft,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    dispatchHops[i][2],
                    style: TextStyle(
                      color: frostMuted,
                      fontStyle: FontStyle.italic,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget dispatchCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeRule, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Section 8 — Dispatch path through the engine',
          style: TextStyle(
            color: magentaBeam,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A FocusSemanticEvent travels through six layers before the '
          'user actually hears anything. Each hop adds context but '
          'never mutates the event itself — the payload is just '
          '{type: "focus"}.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: dispatchHopWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // Section 9: Anti-patterns and best practices ledger.
  // ============================================================
  final List<List<String>> ledger = <List<String>>[
    <String>[
      'good',
      'pair a Focus widget with onDidGainAccessibilityFocus',
      'the framework will fire FocusSemanticEvent automatically',
    ],
    <String>[
      'good',
      'rely on the platform channel for delivery',
      'no need to manually serialize toMap()',
    ],
    <String>[
      'good',
      'use AnnounceSemanticsEvent for ad-hoc speech',
      'Focus is for actual focus — not arbitrary announcements',
    ],
    <String>[
      'bad',
      'do NOT instantiate FocusSemanticEvent yourself',
      'the engine owns its lifecycle; manual sends will look spurious',
    ],
    <String>[
      'bad',
      'do NOT compare events by reference',
      'every FocusSemanticEvent() is a fresh, equal-but-not-identical instance',
    ],
    <String>[
      'bad',
      'do NOT add payload fields by subclassing',
      'screen readers ignore unknown semantics event types',
    ],
    <String>[
      'good',
      'co-locate semantics with logical focus',
      'use FocusableActionDetector or Focus + Semantics together',
    ],
    <String>[
      'good',
      'test with TalkBack and VoiceOver',
      'simulators can show fire counts but only real readers reveal UX',
    ],
  ];

  final List<Widget> ledgerRows = <Widget>[];
  for (int i = 0; i < ledger.length; i++) {
    final bool good = ledger[i][0] == 'good';
    final Color hue = good ? tealAccent : magentaBeam;
    ledgerRows.add(
      Container(
        margin: EdgeInsets.only(bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: slatePanelDeep,
          border: Border(
            left: BorderSide(color: hue, width: 4.0),
            top: BorderSide(color: edgeRule, width: 0.5),
            right: BorderSide(color: edgeRule, width: 0.5),
            bottom: BorderSide(color: edgeRule, width: 0.5),
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: hue,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: Text(
                good ? 'DO' : 'AVOID',
                style: TextStyle(
                  color: slateBackdrop,
                  fontWeight: FontWeight.w800,
                  fontSize: 10.5,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    ledger[i][1],
                    style: TextStyle(
                      color: frostInk,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    ledger[i][2],
                    style: TextStyle(
                      color: frostMuted,
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget ledgerCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slatePanelAlt,
      border: Border.all(color: edgeRule, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Section 9 — Practices ledger',
          style: TextStyle(
            color: tealAccent,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Eight rules for living comfortably with FocusSemanticEvent. '
          'Mostly: trust the framework, do not poke the engine.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: ledgerRows,
        ),
      ],
    ),
  );

  // ============================================================
  // Section 10: Footer legend with palette glossary.
  // ============================================================
  final List<List<dynamic>> legendEntries = <List<dynamic>>[
    <dynamic>[magentaBeam, 'magenta beam', 'the hero — focus arrival'],
    <dynamic>[magentaSoft, 'magenta soft', 'historical / visited'],
    <dynamic>[violetCore, 'violet core', 'engine + framework strata'],
    <dynamic>[violetGlow, 'violet glow', 'past focus traces'],
    <dynamic>[amberSpot, 'amber spot', 'the spotlight cue'],
    <dynamic>[amberSoft, 'amber soft', 'code + payload accents'],
    <dynamic>[tealAccent, 'teal accent', 'positive practices'],
    <dynamic>[frostInk, 'frost ink', 'primary text'],
    <dynamic>[frostMuted, 'frost muted', 'secondary prose'],
    <dynamic>[edgeRule, 'edge rule', 'card borders'],
    <dynamic>[edgeRuleHot, 'hot edge', 'hero card border'],
    <dynamic>[codeBackdrop, 'code well', 'monospace blocks'],
  ];

  final List<Widget> legendChips = <Widget>[];
  for (int i = 0; i < legendEntries.length; i++) {
    final Color hue = legendEntries[i][0] as Color;
    final String name = legendEntries[i][1] as String;
    final String role = legendEntries[i][2] as String;
    legendChips.add(
      Container(
        margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: slatePanelDeep,
          border: Border.all(color: edgeRule, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                color: hue,
                border: Border.all(color: frostMuted, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    color: frostInk,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    color: frostMuted,
                    fontSize: 10.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget legendCard = Container(
    width: double.infinity,
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[slatePanelDeep, slatePanel],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: edgeRule, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Section 10 — Spotlight Aurora palette glossary',
          style: TextStyle(
            color: amberSpot,
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each card in this demo borrows hues from the same twelve-'
          'tone palette. Below is the cheat sheet — colour, name, role.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: legendChips,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: codeBackdrop,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'session summary',
                style: TextStyle(
                  color: amberSpot,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'instances created : ${events.length}',
                style: TextStyle(
                  color: codeInk,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
              Text(
                'event type        : ${probe.type}',
                style: TextStyle(
                  color: codeInk,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
              Text(
                'event toMap       : $probeMap',
                style: TextStyle(
                  color: codeInk,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
              Text(
                'comparison roster : ${comparisonRoster.length} '
                'sibling event types',
                style: TextStyle(
                  color: codeInk,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
              Text(
                'sections rendered : 10 visual sections',
                style: TextStyle(
                  color: codeInk,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Final assembly.
  // ============================================================
  print('Assembling 10 visual sections.');
  print('=' * 60);
  print('FocusSemanticEvent deep visual demo complete.');

  return Scaffold(
    backgroundColor: slateBackdrop,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          headerBanner,
          SizedBox(height: 18.0),
          anatomyCard,
          SizedBox(height: 18.0),
          lifecycleCard,
          SizedBox(height: 18.0),
          journeyCard,
          SizedBox(height: 18.0),
          comparisonCard,
          SizedBox(height: 18.0),
          instancesCard,
          SizedBox(height: 18.0),
          dispatchCard,
          SizedBox(height: 18.0),
          ledgerCard,
          SizedBox(height: 18.0),
          legendCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// Small helper that paints a single colour swatch in the header. Kept as
// a top-level function (not a widget class) per the file rules.
Widget _swatch(Color color, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Color(0xFF0A0820),
      border: Border.all(color: color, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFF1E8FF),
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// Small helper for one labelled cell inside a comparison card.
Widget _compareCell(String label, String value, Color ink, Color muted) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: muted,
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: ink,
            fontSize: 11.5,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

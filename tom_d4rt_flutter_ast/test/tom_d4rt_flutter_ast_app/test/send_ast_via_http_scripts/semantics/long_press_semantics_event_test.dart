// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// D4rt deep visual demo: LongPressSemanticsEvent showcase.
// =============================================================================
//
// THEME: "Granite Watchtower"
//   A fortress-on-the-cliffs palette of slate, basalt, lichen-green, signal
//   amber and watch-fire orange laid against a fog-grey paper. The watchtower
//   metaphor maps onto the long-press gesture itself: the user climbs the
//   stairs (touch down), holds the rampart (the wait), and finally lights the
//   beacon (the dispatch). Each section of this demo is a torch on the wall.
//
// SUBJECT:
//   The class LongPressSemanticsEvent from package:flutter/semantics.dart is
//   a tiny but load-bearing piece of the accessibility pipeline. It is one
//   of the small concrete subclasses of SemanticsEvent that the framework
//   instantiates and forwards to the host platform — iOS VoiceOver, Android
//   TalkBack, or any custom accessibility bridge — to announce that a
//   long-press gesture has been recognised on a semantically-meaningful
//   widget. The class itself has:
//
//     - a default zero-argument constructor `LongPressSemanticsEvent()`,
//     - a fixed type string `'longPress'` (passed up to the SemanticsEvent
//       base class via `super('longPress')`),
//     - an override of `getDataMap()` that returns an empty const map,
//     - inherited `toMap({int? nodeId})` which packages type + data + (optional
//       nodeId) into the wire format consumed by the engine.
//
//   It carries no payload. Its very existence on the wire is the message:
//   "a long press happened on the node with this id". The platform layer
//   then chooses how to respond — speak a hint, announce a context-menu
//   availability, vibrate, etc.
//
// PHILOSOPHY:
//   This file is a snapshot. The d4rt interpreter that hosts it forbids
//   StatefulWidget, setState, controllers, timers, futures and streams.
//   Every "lifecycle" you see is rendered statically — the millisecond marks
//   on the long-press timeline are stacked Containers, the dispatch path is
//   a chain of Cards joined by arrow glyphs. We construct real
//   LongPressSemanticsEvent instances and call getDataMap() on them, so the
//   reader sees the actual runtime values, not just prose.
//
// SECTIONS:
//   1.  Title banner with palette swatches.
//   2.  Anatomy card — class hierarchy, role, screen-reader pipeline.
//   3.  Property anatomy panel — type, getDataMap, super class, no args.
//   4.  Long-press lifecycle timeline — touch down, hold, fire.
//   5.  Comparison table — Long vs Tap vs Focus, twelve+ rows.
//   6.  Construction gallery — many instances, each annotated.
//   7.  Dispatch path — six hops from Widget to platform.
//   8.  DO / AVOID callouts — six cards.
//   9.  Accessibility scenarios — five real-world use cases.
//  10.  Code-snippet cards — how the framework fires this event.
//  11.  Glossary — twelve+ terms.
//  12.  Recap footer.
//
// RULES OBSERVED:
//   - Imports limited to package:flutter/material.dart and
//     package:flutter/semantics.dart.
//   - File-level ignore on line 1, no other lint suppressions.
//   - .withValues(alpha: ...) instead of .withOpacity(...).
//   - At least four real LongPressSemanticsEvent() instances are built and
//     queried via getDataMap().
//   - 5-15 narrative print(...) calls inside build().
//   - dart analyze must pass with zero issues against this file.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('LongPressSemanticsEvent deep visual demo executing');
  print('Theme: Granite Watchtower');
  print('Subject: package:flutter/semantics.dart -> LongPressSemanticsEvent');

  // ===========================================================================
  // Palette: Granite Watchtower
  // ===========================================================================
  final Color fogPaper = const Color(0xFFE9ECEF);
  final Color fogPanel = const Color(0xFFD8DEE4);
  final Color fogPanelAlt = const Color(0xFFC4CCD4);
  final Color slateMid = const Color(0xFF6C757D);
  final Color slateDeep = const Color(0xFF3F454B);
  final Color basaltInk = const Color(0xFF22272B);
  final Color lichenSoft = const Color(0xFF9CB58E);
  final Color lichenMid = const Color(0xFF6F8E63);
  final Color signalAmber = const Color(0xFFE0A45A);
  final Color watchFire = const Color(0xFFD96A2E);
  final Color beaconRed = const Color(0xFFB13A3A);
  final Color skyMorning = const Color(0xFFB7C9D9);
  final Color skyDusk = const Color(0xFF6E7A8A);

  print('Palette built: 13 named colors locked in.');

  // ===========================================================================
  // Real LongPressSemanticsEvent instances (used throughout the tree).
  // ===========================================================================
  final LongPressSemanticsEvent eventAlpha = LongPressSemanticsEvent();
  final LongPressSemanticsEvent eventBravo = LongPressSemanticsEvent();
  final LongPressSemanticsEvent eventCharlie = LongPressSemanticsEvent();
  final LongPressSemanticsEvent eventDelta = LongPressSemanticsEvent();
  final LongPressSemanticsEvent eventEcho = LongPressSemanticsEvent();
  final LongPressSemanticsEvent eventFoxtrot = LongPressSemanticsEvent();
  final LongPressSemanticsEvent eventGolf = LongPressSemanticsEvent();
  final LongPressSemanticsEvent eventHotel = LongPressSemanticsEvent();

  final String typeAlpha = eventAlpha.type;
  final Map<String, dynamic> dataAlpha = eventAlpha.getDataMap();
  final Map<String, dynamic> dataBravo = eventBravo.getDataMap();
  final Map<String, dynamic> dataCharlie = eventCharlie.getDataMap();
  final Map<String, dynamic> dataDelta = eventDelta.getDataMap();
  final Map<String, dynamic> dataEcho = eventEcho.getDataMap();
  final Map<String, dynamic> dataFoxtrot = eventFoxtrot.getDataMap();
  final Map<String, dynamic> dataGolf = eventGolf.getDataMap();
  final Map<String, dynamic> dataHotel = eventHotel.getDataMap();

  print('Constructed 8 LongPressSemanticsEvent instances.');
  print('Alpha type: $typeAlpha');
  print('Alpha getDataMap(): $dataAlpha');
  print('Bravo getDataMap(): $dataBravo');
  print('Charlie getDataMap(): $dataCharlie');

  // Inherited toMap result (with and without a nodeId).
  final Map<String, dynamic> mapAlphaAnonymous = eventAlpha.toMap();
  final Map<String, dynamic> mapAlphaNode42 = eventAlpha.toMap(nodeId: 42);
  print('Alpha toMap() anonymous: $mapAlphaAnonymous');
  print('Alpha toMap(nodeId: 42): $mapAlphaNode42');

  // ===========================================================================
  // Reusable text styles.
  // ===========================================================================
  final TextStyle bannerTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: fogPaper,
    letterSpacing: 1.2,
  );
  final TextStyle bannerSub = TextStyle(
    fontSize: 14,
    color: fogPaper.withValues(alpha: 0.85),
    fontStyle: FontStyle.italic,
  );
  final TextStyle sectionTitle = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.bold,
    color: basaltInk,
  );
  final TextStyle sectionLead = TextStyle(
    fontSize: 13,
    color: slateDeep,
    height: 1.45,
  );
  final TextStyle bodyText = TextStyle(
    fontSize: 12.5,
    color: basaltInk,
    height: 1.4,
  );
  final TextStyle codeText = TextStyle(
    fontSize: 12,
    color: fogPaper,
    fontFamily: 'monospace',
    height: 1.45,
  );
  final TextStyle smallLabel = TextStyle(
    fontSize: 11,
    color: slateDeep,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
  );

  print('Text styles registered.');

  // ===========================================================================
  // Section 1: Title banner with palette swatches.
  // ===========================================================================
  final Widget section1Title = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [basaltInk, slateDeep, slateMid],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: signalAmber, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LongPressSemanticsEvent', style: bannerTitle),
        const SizedBox(height: 6),
        Text(
          'Granite Watchtower / a deep visual demo',
          style: bannerSub,
        ),
        const SizedBox(height: 14),
        Text(
          'package:flutter/semantics.dart',
          style: TextStyle(
            color: signalAmber,
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _swatch('fogPaper', fogPaper, fogPaper),
            _swatch('fogPanel', fogPanel, fogPaper),
            _swatch('fogPanelAlt', fogPanelAlt, fogPaper),
            _swatch('slateMid', slateMid, fogPaper),
            _swatch('slateDeep', slateDeep, fogPaper),
            _swatch('basaltInk', basaltInk, fogPaper),
            _swatch('lichenSoft', lichenSoft, fogPaper),
            _swatch('lichenMid', lichenMid, fogPaper),
            _swatch('signalAmber', signalAmber, fogPaper),
            _swatch('watchFire', watchFire, fogPaper),
            _swatch('beaconRed', beaconRed, fogPaper),
            _swatch('skyMorning', skyMorning, fogPaper),
            _swatch('skyDusk', skyDusk, fogPaper),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 2: Anatomy / hierarchy / pipeline prose.
  // ===========================================================================
  final Widget section2Anatomy = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1. Anatomy of the event', style: sectionTitle),
        const SizedBox(height: 10),
        Text(
          'LongPressSemanticsEvent is a leaf in the SemanticsEvent class '
          'tree. The base class SemanticsEvent is abstract; it carries a '
          'String `type` and an abstract Map<String, dynamic> getDataMap(). '
          'A small family of concrete subclasses fill in those slots — '
          'TapSemanticsEvent, FocusSemanticsEvent, AnnounceSemanticsEvent, '
          'TooltipSemanticsEvent, and LongPressSemanticsEvent among them.',
          style: sectionLead,
        ),
        const SizedBox(height: 10),
        Text('Hierarchy', style: smallLabel),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: basaltInk,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Object', style: codeText),
              Text('  └── SemanticsEvent (abstract)', style: codeText),
              Text('         ├── TapSemanticsEvent', style: codeText),
              Text('         ├── LongPressSemanticsEvent  ← this demo',
                  style: TextStyle(
                    color: signalAmber,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
              Text('         ├── FocusSemanticsEvent', style: codeText),
              Text('         ├── AnnounceSemanticsEvent', style: codeText),
              Text('         └── TooltipSemanticsEvent', style: codeText),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text('Screen-reader pipeline', style: smallLabel),
        const SizedBox(height: 6),
        Text(
          '1. The user performs a long press on a Semantics-annotated widget.\n'
          '2. The gesture recognizer detects the press-and-hold timeout.\n'
          '3. RenderObject.sendSemanticsEvent(LongPressSemanticsEvent()) is '
          'called.\n'
          '4. The framework looks up the closest SemanticsNode and asks the '
          'SemanticsOwner to forward the event.\n'
          '5. SemanticsOwner.sendSemanticsEvent serialises via toMap(nodeId: '
          'node.id) and pushes it across the platform channel.\n'
          '6. iOS / Android / Web bridges translate the wire payload into '
          'their native accessibility semantics.',
          style: bodyText,
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 3: Property anatomy panel.
  // ===========================================================================
  final Widget section3Properties = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanelAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('2. Property anatomy', style: sectionTitle),
        const SizedBox(height: 10),
        _propRow(
          'type',
          "'longPress'",
          'A const String passed to the super constructor. The platform '
              'channel uses this to dispatch to the right native handler.',
          basaltInk,
          fogPaper,
          watchFire,
        ),
        const SizedBox(height: 8),
        _propRow(
          'getDataMap()',
          'const <String, dynamic>{}',
          'Empty by design — long-press carries no payload beyond its '
              'identity. Compare with AnnounceSemanticsEvent which carries a '
              'message and text direction.',
          basaltInk,
          fogPaper,
          lichenMid,
        ),
        const SizedBox(height: 8),
        _propRow(
          'extends',
          'SemanticsEvent',
          'Inherits toMap({int? nodeId}) which builds the {type, data, '
              'nodeId?} envelope handed to the engine.',
          basaltInk,
          fogPaper,
          signalAmber,
        ),
        const SizedBox(height: 8),
        _propRow(
          'constructor',
          'LongPressSemanticsEvent()',
          'Zero arguments. Two long-press events are structurally equal but '
              'not identical — they are throwaway value objects.',
          basaltInk,
          fogPaper,
          beaconRed,
        ),
        const SizedBox(height: 8),
        _propRow(
          'runtimeType',
          eventAlpha.runtimeType.toString(),
          'Reflected via Dart core; useful in logs and assertion messages.',
          basaltInk,
          fogPaper,
          skyDusk,
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 4: Long-press lifecycle timeline.
  // ===========================================================================
  final Widget section4Timeline = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('3. Long-press lifecycle timeline', style: sectionTitle),
        const SizedBox(height: 8),
        Text(
          'A long press is the absence of motion under a finger for a full '
          'time-out. Below is the gesture as the framework sees it, mapped '
          'to wall-clock milliseconds.',
          style: sectionLead,
        ),
        const SizedBox(height: 14),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: basaltInk,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _timelineMark('0 ms', 'pointerDown', lichenSoft),
              _timelineRail(slateMid),
              _timelineMark('120 ms', 'frame', skyMorning),
              _timelineRail(slateMid),
              _timelineMark('250 ms', 'still', signalAmber),
              _timelineRail(slateMid),
              _timelineMark('500 ms', 'threshold', watchFire),
              _timelineRail(slateMid),
              _timelineMark('500+', 'fire', beaconRed),
              _timelineRail(slateMid),
              _timelineMark('upstream', 'platform', fogPaper),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'At ~500 ms with no motion, LongPressGestureRecognizer accepts the '
          'gesture. RenderObject.sendSemanticsEvent fires our event, and the '
          'platform channel delivers the long-press announcement to the '
          'native a11y stack.',
          style: bodyText,
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 5: Comparison table (12+ rows).
  // ===========================================================================
  final List<List<String>> compareRows = [
    [
      'class',
      'LongPressSemanticsEvent',
      'TapSemanticsEvent',
      'FocusSemanticsEvent',
    ],
    ['type string', 'longPress', 'tap', 'focus'],
    [
      'getDataMap()',
      'const {}',
      'const {}',
      'const {}',
    ],
    [
      'constructor args',
      'none',
      'none',
      'none',
    ],
    [
      'native trigger (iOS)',
      'VoiceOver double-tap-and-hold',
      'VoiceOver double-tap',
      'focus changed',
    ],
    [
      'native trigger (Android)',
      'TalkBack double-tap-and-hold',
      'TalkBack double-tap',
      'TalkBack focus',
    ],
    [
      'common widget',
      'Semantics(onLongPress: ...)',
      'Semantics(onTap: ...)',
      'Focus / FocusNode',
    ],
    [
      'payload size',
      '0 bytes',
      '0 bytes',
      '0 bytes',
    ],
    [
      'idempotent re-fire',
      'safe',
      'safe',
      'discouraged',
    ],
    [
      'raises context menu?',
      'often',
      'rarely',
      'never',
    ],
    [
      'expected duration',
      '~500 ms',
      '<200 ms',
      'instantaneous',
    ],
    [
      'analog mouse gesture',
      'right-click context',
      'left-click',
      'tab key',
    ],
    [
      'haptic by default',
      'yes',
      'no',
      'no',
    ],
    [
      'cancel on motion',
      'yes',
      'no',
      'n/a',
    ],
  ];

  final Widget section5Compare = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanelAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('4. Comparison table', style: sectionTitle),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: fogPaper,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: slateDeep.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              _compareHeader(compareRows[0], slateDeep, fogPaper),
              _compareRow(compareRows[1], fogPanel, basaltInk),
              _compareRow(compareRows[2], fogPaper, basaltInk),
              _compareRow(compareRows[3], fogPanel, basaltInk),
              _compareRow(compareRows[4], fogPaper, basaltInk),
              _compareRow(compareRows[5], fogPanel, basaltInk),
              _compareRow(compareRows[6], fogPaper, basaltInk),
              _compareRow(compareRows[7], fogPanel, basaltInk),
              _compareRow(compareRows[8], fogPaper, basaltInk),
              _compareRow(compareRows[9], fogPanel, basaltInk),
              _compareRow(compareRows[10], fogPaper, basaltInk),
              _compareRow(compareRows[11], fogPanel, basaltInk),
              _compareRow(compareRows[12], fogPaper, basaltInk),
              _compareRow(compareRows[13], fogPanel, basaltInk),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 6: Construction gallery (8 instances, real getDataMap calls).
  // ===========================================================================
  final Widget section6Gallery = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('5. Construction gallery', style: sectionTitle),
        const SizedBox(height: 6),
        Text(
          'Eight live instances. The constructor takes no arguments, so every '
          'card here is structurally identical — what differs is the '
          'surrounding intent: which widget would have fired it.',
          style: sectionLead,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _galleryCard(
              'Alpha — list tile',
              'Long press a list tile to open the actions sheet.',
              eventAlpha,
              dataAlpha,
              lichenMid,
              fogPaper,
            ),
            _galleryCard(
              'Bravo — drag handle',
              'Long press the drag handle to begin reordering items.',
              eventBravo,
              dataBravo,
              signalAmber,
              fogPaper,
            ),
            _galleryCard(
              'Charlie — chip',
              'Long press a chip to reveal its delete affordance.',
              eventCharlie,
              dataCharlie,
              watchFire,
              fogPaper,
            ),
            _galleryCard(
              'Delta — image',
              'Long press a thumbnail for the share-or-save menu.',
              eventDelta,
              dataDelta,
              beaconRed,
              fogPaper,
            ),
            _galleryCard(
              'Echo — link',
              'Long press a hyperlink to peek at its preview.',
              eventEcho,
              dataEcho,
              skyDusk,
              fogPaper,
            ),
            _galleryCard(
              'Foxtrot — message bubble',
              'Long press a message to react, copy, or quote.',
              eventFoxtrot,
              dataFoxtrot,
              slateDeep,
              fogPaper,
            ),
            _galleryCard(
              'Golf — map pin',
              'Long press a map pin to drop a custom waypoint.',
              eventGolf,
              dataGolf,
              lichenSoft,
              basaltInk,
            ),
            _galleryCard(
              'Hotel — calendar cell',
              'Long press a calendar cell to start a multi-day selection.',
              eventHotel,
              dataHotel,
              skyMorning,
              basaltInk,
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 7: Dispatch path (6 hops).
  // ===========================================================================
  final Widget section7Dispatch = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanelAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('6. Dispatch path', style: sectionTitle),
        const SizedBox(height: 8),
        Text(
          'Six hops carry the event from the gesture site to the operating '
          'system. Each hop has a single role.',
          style: sectionLead,
        ),
        const SizedBox(height: 14),
        Column(
          children: [
            _hopCard('1', 'Widget',
                'Semantics widget declares onLongPress.', signalAmber, basaltInk),
            _hopArrow(slateDeep),
            _hopCard('2', 'Element',
                'Element binds Widget to the RenderObject tree.', lichenMid,
                basaltInk),
            _hopArrow(slateDeep),
            _hopCard('3', 'RenderObject',
                'RenderSemanticsAnnotations.sendSemanticsEvent fires.',
                watchFire, fogPaper),
            _hopArrow(slateDeep),
            _hopCard('4', 'SemanticsNode',
                'Node id stamped onto the outgoing event envelope.',
                beaconRed, fogPaper),
            _hopArrow(slateDeep),
            _hopCard('5', 'SemanticsOwner',
                'Owner serialises via toMap(nodeId: node.id).',
                slateDeep, fogPaper),
            _hopArrow(slateDeep),
            _hopCard('6', 'Platform channel',
                'Engine forwards to iOS / Android / Web a11y bridge.',
                basaltInk, fogPaper),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 8: DO / AVOID callouts.
  // ===========================================================================
  final Widget section8Callouts = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('7. Do / Avoid', style: sectionTitle),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _calloutCard(
              true,
              'Use Semantics(onLongPress: ...)',
              'Let the framework wire LongPressSemanticsEvent for you. '
                  'Manual instantiation is rarely needed in app code.',
              lichenMid,
              fogPaper,
            ),
            _calloutCard(
              false,
              'Do not stuff data into a long-press event',
              'getDataMap() is intentionally empty. Use a SemanticsNode '
                  'label or hint instead of overloading this event.',
              beaconRed,
              fogPaper,
            ),
            _calloutCard(
              true,
              'Pair with onLongPressHint',
              'Setting Semantics(onLongPressHint: "Open menu") gives '
                  'screen readers a verb to speak.',
              lichenMid,
              fogPaper,
            ),
            _calloutCard(
              false,
              'Do not fire it from a tap callback',
              'A long press has cultural weight — firing it on a quick tap '
                  'will confuse VoiceOver / TalkBack users.',
              beaconRed,
              fogPaper,
            ),
            _calloutCard(
              true,
              'Mirror visual long-press affordance',
              'If sighted users get a context menu on long-press, fire the '
                  'event so a11y users get the same menu.',
              lichenMid,
              fogPaper,
            ),
            _calloutCard(
              false,
              'Do not require precise hold-time tuning',
              'Trust the recognizer\'s default 500 ms threshold. Custom '
                  'tuning fragments expectations across apps.',
              beaconRed,
              fogPaper,
            ),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 9: Accessibility scenarios.
  // ===========================================================================
  final Widget section9Scenarios = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanelAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('8. Accessibility scenarios', style: sectionTitle),
        const SizedBox(height: 8),
        Text(
          'Five places where firing LongPressSemanticsEvent meaningfully '
          'changes the experience for a screen-reader user.',
          style: sectionLead,
        ),
        const SizedBox(height: 14),
        _scenarioCard(
          'Lock-screen quick action',
          'Long press a notification on the lock screen to expand its '
              'actions. VoiceOver speaks "Activate quick actions" on '
              'firing.',
          signalAmber,
          basaltInk,
        ),
        const SizedBox(height: 10),
        _scenarioCard(
          'Drag-to-rearrange',
          'In a reorderable list, long press lifts the row. Without the '
              'event, TalkBack would never announce the lift.',
          watchFire,
          fogPaper,
        ),
        const SizedBox(height: 10),
        _scenarioCard(
          'Context menu',
          'Long pressing a message opens reactions. The event signals the '
              'menu opening even before the visual transition.',
          beaconRed,
          fogPaper,
        ),
        const SizedBox(height: 10),
        _scenarioCard(
          'Multi-select toggle',
          'Long press to enter selection mode in a gallery. Subsequent '
              'taps then toggle items.',
          lichenMid,
          fogPaper,
        ),
        const SizedBox(height: 10),
        _scenarioCard(
          'Map waypoint drop',
          'Long press a map to drop a pin. The screen reader confirms the '
              'pin coordinate after the event fires.',
          slateDeep,
          fogPaper,
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 10: Code-snippet cards.
  // ===========================================================================
  final String snippet1 =
      "// Inside _LongPressGestureRecognizer.dispatchSemanticsEvent\n"
      "void _dispatch(RenderObject renderObject) {\n"
      "  renderObject.sendSemanticsEvent(LongPressSemanticsEvent());\n"
      "}\n";

  final String snippet2 =
      "// Wiring on the widget side\n"
      "Semantics(\n"
      "  label: 'Message bubble',\n"
      "  onLongPress: () => showReactions(context),\n"
      "  onLongPressHint: 'Open reactions',\n"
      "  child: MessageBubble(message: m),\n"
      ");\n";

  final String snippet3 =
      "// What gets serialised across the channel\n"
      "final event = LongPressSemanticsEvent();\n"
      "event.toMap(nodeId: 42);\n"
      "// => { 'type': 'longPress', 'data': {}, 'nodeId': 42 }\n";

  final String snippet4 =
      "// Equality and identity\n"
      "final a = LongPressSemanticsEvent();\n"
      "final b = LongPressSemanticsEvent();\n"
      "identical(a, b);    // false — distinct instances\n"
      "a.type == b.type;   // true  — both 'longPress'\n";

  final Widget section10Snippets = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanel,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('9. Code snippets', style: sectionTitle),
        const SizedBox(height: 8),
        Text(
          'Four illustrative listings — the framework side, the widget side, '
          'the wire format, and a note on equality.',
          style: sectionLead,
        ),
        const SizedBox(height: 14),
        _codeCard('framework dispatch', snippet1, basaltInk, codeText,
            signalAmber),
        const SizedBox(height: 10),
        _codeCard('widget wiring', snippet2, basaltInk, codeText, lichenSoft),
        const SizedBox(height: 10),
        _codeCard('wire format', snippet3, basaltInk, codeText, watchFire),
        const SizedBox(height: 10),
        _codeCard('equality note', snippet4, basaltInk, codeText, beaconRed),
      ],
    ),
  );

  // ===========================================================================
  // Section 11: Glossary (12+ terms).
  // ===========================================================================
  final List<List<String>> glossary = [
    [
      'SemanticsEvent',
      'Abstract base for all framework-emitted accessibility events.',
    ],
    [
      'LongPressSemanticsEvent',
      'Concrete subclass with type "longPress" and an empty data map.',
    ],
    [
      'getDataMap()',
      'Subclass hook that returns the data portion of the wire envelope.',
    ],
    [
      'toMap()',
      'Inherited method that builds {type, data, nodeId?} for the engine.',
    ],
    [
      'SemanticsNode',
      'A node in the semantic tree, identified by an int node id.',
    ],
    [
      'SemanticsOwner',
      'Per-pipeline owner that batches and forwards semantic events.',
    ],
    [
      'RenderObject',
      'Layer of the rendering tree that emits semantic events upward.',
    ],
    [
      'Element',
      'Glue between Widget and RenderObject; participates in updates.',
    ],
    [
      'Widget',
      'Configuration leaf — Semantics widgets declare a11y intent.',
    ],
    [
      'Long-press recognizer',
      'Gesture detector that accepts the gesture after ~500 ms of stillness.',
    ],
    [
      'VoiceOver',
      'Apple\'s screen reader; emits long press as double-tap-and-hold.',
    ],
    [
      'TalkBack',
      'Google\'s screen reader; emits long press as double-tap-and-hold.',
    ],
    [
      'Hint',
      'A short verb-phrase the screen reader speaks for a gesture.',
    ],
    [
      'Platform channel',
      'The bridge between Dart and the host OS\'s a11y stack.',
    ],
  ];

  final Widget section11Glossary = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fogPanelAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: slateMid.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('10. Glossary', style: sectionTitle),
        const SizedBox(height: 12),
        Column(
          children: [
            _glossRow(glossary[0], fogPaper, basaltInk, signalAmber),
            _glossRow(glossary[1], fogPanel, basaltInk, watchFire),
            _glossRow(glossary[2], fogPaper, basaltInk, lichenMid),
            _glossRow(glossary[3], fogPanel, basaltInk, beaconRed),
            _glossRow(glossary[4], fogPaper, basaltInk, slateDeep),
            _glossRow(glossary[5], fogPanel, basaltInk, skyDusk),
            _glossRow(glossary[6], fogPaper, basaltInk, signalAmber),
            _glossRow(glossary[7], fogPanel, basaltInk, watchFire),
            _glossRow(glossary[8], fogPaper, basaltInk, lichenMid),
            _glossRow(glossary[9], fogPanel, basaltInk, beaconRed),
            _glossRow(glossary[10], fogPaper, basaltInk, slateDeep),
            _glossRow(glossary[11], fogPanel, basaltInk, skyDusk),
            _glossRow(glossary[12], fogPaper, basaltInk, signalAmber),
            _glossRow(glossary[13], fogPanel, basaltInk, watchFire),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // Section 12: Recap footer.
  // ===========================================================================
  final Widget section12Footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [slateDeep, basaltInk],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: signalAmber, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recap',
          style: TextStyle(
            color: signalAmber,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'LongPressSemanticsEvent is the smallest possible message: '
          'a typed announcement that a long press happened. It carries no '
          'payload, accepts no constructor arguments, and lives only long '
          'enough to ride the platform channel.',
          style: TextStyle(color: fogPaper, fontSize: 13, height: 1.45),
        ),
        const SizedBox(height: 12),
        Text(
          'Demo recorded 8 live instances — first instance type: $typeAlpha, '
          'getDataMap(): $dataAlpha, toMap(nodeId: 42): $mapAlphaNode42.',
          style: TextStyle(
            color: fogPaper.withValues(alpha: 0.85),
            fontSize: 12,
            fontStyle: FontStyle.italic,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '— end of Granite Watchtower —',
          style: TextStyle(
            color: signalAmber,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
      ],
    ),
  );

  print('All twelve sections built; assembling the Scaffold.');

  return Scaffold(
    backgroundColor: fogPaper,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          section1Title,
          const SizedBox(height: 16),
          section2Anatomy,
          const SizedBox(height: 16),
          section3Properties,
          const SizedBox(height: 16),
          section4Timeline,
          const SizedBox(height: 16),
          section5Compare,
          const SizedBox(height: 16),
          section6Gallery,
          const SizedBox(height: 16),
          section7Dispatch,
          const SizedBox(height: 16),
          section8Callouts,
          const SizedBox(height: 16),
          section9Scenarios,
          const SizedBox(height: 16),
          section10Snippets,
          const SizedBox(height: 16),
          section11Glossary,
          const SizedBox(height: 16),
          section12Footer,
        ],
      ),
    ),
  );
}

// ============================================================================
// Inline helper widget builders. These are top-level functions, not classes,
// so the d4rt interpreter treats them as plain function calls returning
// Widget instances.
// ============================================================================

Widget _swatch(String label, Color color, Color textColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: textColor.withValues(alpha: 0.4)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: textColor,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _propRow(
  String name,
  String value,
  String prose,
  Color ink,
  Color paper,
  Color accent,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(8),
      border: Border(
        left: BorderSide(color: accent, width: 4),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: ink,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          prose,
          style: TextStyle(color: ink, fontSize: 12, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _timelineMark(String time, String label, Color color) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE9ECEF), width: 2),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        time,
        style: TextStyle(
          color: color,
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        style: TextStyle(
          color: const Color(0xFFE9ECEF),
          fontSize: 10,
        ),
      ),
    ],
  );
}

Widget _timelineRail(Color color) {
  return Expanded(
    child: Container(
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: color.withValues(alpha: 0.6),
    ),
  );
}

Widget _compareHeader(List<String> cells, Color bg, Color fg) {
  return Container(
    decoration: BoxDecoration(
      color: bg,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            cells[0],
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cells[1],
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cells[2],
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cells[3],
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _compareRow(List<String> cells, Color bg, Color fg) {
  return Container(
    color: bg,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            cells[0],
            style: TextStyle(
              color: fg,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cells[1],
            style: TextStyle(color: fg, fontSize: 11, height: 1.35),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cells[2],
            style: TextStyle(color: fg, fontSize: 11, height: 1.35),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            cells[3],
            style: TextStyle(color: fg, fontSize: 11, height: 1.35),
          ),
        ),
      ],
    ),
  );
}

Widget _galleryCard(
  String title,
  String prose,
  LongPressSemanticsEvent event,
  Map<String, dynamic> data,
  Color bg,
  Color fg,
) {
  return Container(
    width: 240,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: fg.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: fg,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          prose,
          style: TextStyle(color: fg, fontSize: 11, height: 1.4),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: fg.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'type: ${event.type}',
                style: TextStyle(
                  color: fg,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
              Text(
                'getDataMap(): $data',
                style: TextStyle(
                  color: fg,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
              Text(
                'runtimeType: ${event.runtimeType}',
                style: TextStyle(
                  color: fg,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _hopCard(
  String index,
  String title,
  String prose,
  Color bg,
  Color fg,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fg.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Text(
            index,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: fg,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                prose,
                style: TextStyle(color: fg, fontSize: 12, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _hopArrow(Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Center(
      child: Text(
        '↓',
        style: TextStyle(
          color: color,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _calloutCard(
  bool good,
  String title,
  String prose,
  Color bg,
  Color fg,
) {
  return Container(
    width: 260,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border(
        top: BorderSide(color: fg.withValues(alpha: 0.5), width: 3),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fg.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Text(
                good ? '✓' : '✗',
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: fg,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          prose,
          style: TextStyle(color: fg, fontSize: 11.5, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _scenarioCard(
  String title,
  String prose,
  Color bg,
  Color fg,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: fg,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          prose,
          style: TextStyle(color: fg, fontSize: 12, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _codeCard(
  String label,
  String body,
  Color bg,
  TextStyle codeStyle,
  Color accent,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border(
        left: BorderSide(color: accent, width: 4),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        Text(body, style: codeStyle),
      ],
    ),
  );
}

Widget _glossRow(
  List<String> entry,
  Color bg,
  Color fg,
  Color accent,
) {
  return Container(
    width: double.infinity,
    color: bg,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170,
          child: Text(
            entry[0],
            style: TextStyle(
              color: accent,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            entry[1],
            style: TextStyle(color: fg, fontSize: 12, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

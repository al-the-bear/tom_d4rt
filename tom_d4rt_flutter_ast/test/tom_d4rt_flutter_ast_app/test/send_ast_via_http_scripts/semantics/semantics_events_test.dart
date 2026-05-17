// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_import, unnecessary_import
// D4rt visual demo: SemanticsEvent and its concrete subclasses.
//
// SemanticsEvent is the abstract base for one-shot accessibility events that
// Flutter ships from the framework down to the platform's accessibility
// services (TalkBack on Android, VoiceOver on iOS, NVDA / JAWS / Narrator on
// desktop, ChromeVox on the web). Unlike the static semantics tree — which
// describes *what* a widget IS — semantics events describe *what just
// happened* and are routed over the `flutter/accessibility` platform channel.
//
// Concrete subclasses covered in this demo:
//   - AnnounceSemanticsEvent  : speak a transient message (with politeness).
//   - TooltipSemanticsEvent   : announce a tooltip that just became visible.
//   - LongPressSemanticsEvent : signal that a long-press happened.
//   - TapSemanticEvent        : signal that a tap happened.
//   - FocusSemanticsEvent     : request a11y focus on a node in a view.
//
// The demo also includes the Assertiveness enum (polite vs assertive), a
// CustomPainter rendering the class hierarchy as a tree, and live
// `getDataMap()` / `toString()` output for instantiated events. The widget
// tree is hand-authored — no setState, Timer, Future, or AnimationController.
import 'dart:math' as math;
import 'dart:ui' show TextDirection;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsEvent deep demo executing');

  // ---------------------------------------------------------------------------
  // Palette — "Aurora Signal": a deep midnight-blue stage with neon mint and
  // magenta highlights, evoking signal traces on a dark accessibility console.
  // ---------------------------------------------------------------------------
  final Color midnight = Color(0xFF0B1733);
  final Color midnightSoft = Color(0xFF15224A);
  final Color midnightMist = Color(0xFF1E2D5C);
  final Color stageInk = Color(0xFF0E1A38);
  final Color neonMint = Color(0xFF5DF2C7);
  final Color neonMintSoft = Color(0xFFB8FBE5);
  final Color neonMagenta = Color(0xFFFF5DA8);
  final Color neonMagentaSoft = Color(0xFFFFB8D6);
  final Color neonAmber = Color(0xFFFFC857);
  final Color neonAmberSoft = Color(0xFFFFE7AE);
  final Color neonViolet = Color(0xFFB388FF);
  final Color neonVioletSoft = Color(0xFFE2D2FF);
  final Color paper = Color(0xFFF4F7FC);
  final Color paperTint = Color(0xFFE6ECF7);
  final Color dividerCool = Color(0xFF2A3B6E);
  final Color textOnDark = Color(0xFFEAF1FF);
  final Color textOnDarkSoft = Color(0xFFB7C2E0);
  final Color textOnLight = Color(0xFF12203F);
  final Color textOnLightSoft = Color(0xFF4A5680);

  // ---------------------------------------------------------------------------
  // Instantiate each concrete SemanticsEvent. We capture toString / getDataMap
  // for live rendering and printing. All four guarded with try/catch so the
  // demo renders even if a constructor signature drifts.
  // ---------------------------------------------------------------------------
  String announceToString = '(unbuilt)';
  // C18 workaround: the d4rt Map bridge's `nativeNames` list does not
  // include `_ConstMap`, the Dart-internal runtime class returned by
  // `const <K, V>{}` literals. Several `SemanticsEvent.getDataMap()`
  // implementations in Flutter (`LongPressSemanticsEvent`,
  // `TapSemanticEvent`, `FocusSemanticEvent`, and the
  // payload-free branches of others) return `const <String, Object>{}`
  // for events without data, so the assignment below would yield a
  // `_ConstMap` and a downstream `.entries` lookup throws
  // `Cannot access property 'entries' on target of type _ConstMap<String, dynamic>`.
  // Two precautions: (1) the default is a non-const literal so the
  // catch-block fallback is a regular LinkedHashMap; (2) the success
  // path copies the bridged map into a fresh `Map<String, dynamic>` so
  // it is always a regular LinkedHashMap regardless of what
  // `getDataMap()` returned.
  Map<String, dynamic> announceData = <String, dynamic>{};
  String announceType = 'announce';
  try {
    final probe = AnnounceSemanticsEvent('Item added to cart', TextDirection.ltr, 0);
    announceToString = probe.toString();
    announceData = Map<String, dynamic>.from(probe.getDataMap()); // C18: see comment above announceData
    announceType = probe.type;
  } catch (e) {
    announceToString = 'AnnounceSemanticsEvent(<construct failed: $e>)';
  }

  String announceRtlToString = '(unbuilt)';
  Map<String, dynamic> announceRtlData = <String, dynamic>{}; // C18: non-const, see comment above announceData
  try {
    final probe = AnnounceSemanticsEvent('تمت الإضافة', TextDirection.rtl, 1);
    announceRtlToString = probe.toString();
    announceRtlData = Map<String, dynamic>.from(probe.getDataMap()); // C18: see comment above announceData
  } catch (e) {
    announceRtlToString = 'AnnounceSemanticsEvent(<construct failed: $e>)';
  }

  String tooltipToString = '(unbuilt)';
  Map<String, dynamic> tooltipData = <String, dynamic>{}; // C18: non-const, see comment above announceData
  String tooltipType = 'tooltip';
  try {
    final probe = TooltipSemanticsEvent('Save document');
    tooltipToString = probe.toString();
    tooltipData = Map<String, dynamic>.from(probe.getDataMap()); // C18: see comment above announceData
    tooltipType = probe.type;
  } catch (e) {
    tooltipToString = 'TooltipSemanticsEvent(<construct failed: $e>)';
  }

  String longPressToString = '(unbuilt)';
  Map<String, dynamic> longPressData = <String, dynamic>{}; // C18: non-const, see comment above announceData
  String longPressType = 'longPress';
  try {
    final probe = LongPressSemanticsEvent();
    longPressToString = probe.toString();
    longPressData = Map<String, dynamic>.from(probe.getDataMap()); // C18: see comment above announceData
    longPressType = probe.type;
  } catch (e) {
    longPressToString = 'LongPressSemanticsEvent(<construct failed: $e>)';
  }

  String tapToString = '(unbuilt)';
  Map<String, dynamic> tapData = <String, dynamic>{}; // C18: non-const, see comment above announceData
  String tapType = 'tap';
  try {
    final probe = TapSemanticEvent();
    tapToString = probe.toString();
    tapData = Map<String, dynamic>.from(probe.getDataMap()); // C18: see comment above announceData
    tapType = probe.type;
  } catch (e) {
    tapToString = 'TapSemanticEvent(<construct failed: $e>)';
  }

  String focusToString = '(unbuilt)';
  Map<String, dynamic> focusData = <String, dynamic>{}; // C18: non-const, see comment above announceData
  String focusType = 'focus';
  try {
    final probe = FocusSemanticEvent();
    focusToString = probe.toString();
    focusData = Map<String, dynamic>.from(probe.getDataMap()); // C18: see comment above announceData
    focusType = probe.type;
  } catch (e) {
    focusToString = 'FocusSemanticEvent(<construct failed: $e>)';
  }

  print('AnnounceSemanticsEvent toString    : $announceToString');
  print('AnnounceSemanticsEvent getDataMap  : $announceData');
  print('AnnounceSemanticsEvent type        : $announceType');
  print('AnnounceSemanticsEvent (RTL) data  : $announceRtlData');
  print('TooltipSemanticsEvent  toString    : $tooltipToString');
  print('TooltipSemanticsEvent  getDataMap  : $tooltipData');
  print('TooltipSemanticsEvent  type        : $tooltipType');
  print('LongPressSemanticsEvent toString   : $longPressToString');
  print('LongPressSemanticsEvent getDataMap : $longPressData');
  print('LongPressSemanticsEvent type       : $longPressType');
  print('TapSemanticEvent       toString    : $tapToString');
  print('TapSemanticEvent       getDataMap  : $tapData');
  print('TapSemanticEvent       type        : $tapType');
  print('FocusSemanticsEvent    toString    : $focusToString');
  print('FocusSemanticsEvent    getDataMap  : $focusData');
  print('FocusSemanticsEvent    type        : $focusType');
  for (final v in Assertiveness.values) {
    print('Assertiveness.${v.name} (index=${v.index})');
  }

  // =========================================================================
  // SECTION 1 — Hero intro
  // =========================================================================
  final Widget hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [midnight, midnightSoft, midnightMist],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: [
        BoxShadow(
          color: neonMagenta.withValues(alpha: 0.30),
          blurRadius: 26.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: neonMint.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.broadcast_on_personal, color: neonMint, size: 48.0),
            SizedBox(width: 14.0),
            Icon(Icons.record_voice_over, color: neonMagenta, size: 48.0),
            SizedBox(width: 14.0),
            Icon(Icons.accessibility_new, color: neonAmber, size: 48.0),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'SemanticsEvent',
          style: TextStyle(
            fontSize: 38.0,
            fontWeight: FontWeight.bold,
            color: textOnDark,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'One-shot accessibility signals from Flutter to the platform',
          style: TextStyle(fontSize: 15.0, color: textOnDarkSoft),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('package:flutter/semantics.dart', neonMint, midnight),
            _heroChip('abstract base class', neonMagenta, midnight),
            _heroChip('5 concrete subclasses', neonAmber, midnight),
            _heroChip('flutter/accessibility channel', neonViolet, midnight),
            _heroChip('engine -> a11y bridge', neonMintSoft, midnight),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: stageInk.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: neonMint.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What it is',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: neonMint,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'A SemanticsEvent represents a transient, one-shot signal '
                'that the framework wants to deliver to the platform\'s '
                'assistive-technology layer. Unlike the persistent SemanticsNode '
                'tree (which describes the *state* of every widget that opted '
                'into the accessibility tree), an event fires once and goes.',
                style: TextStyle(fontSize: 12.5, color: textOnDarkSoft, height: 1.4),
              ),
              SizedBox(height: 10.0),
              Text(
                'Where it surfaces',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: neonMagenta,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'iOS  -> UIAccessibility.post (announcement / layoutChanged / screenChanged)\n'
                'Android -> AccessibilityEvent (TYPE_ANNOUNCEMENT, TYPE_VIEW_FOCUSED, ...)\n'
                'Web  -> aria-live polite / assertive regions and ARIA actions\n'
                'Desktop -> NVDA / JAWS / Narrator / VoiceOver speech',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: neonMintSoft,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 2 — Class hierarchy CustomPainter
  // =========================================================================
  final Widget hierarchyCard = Container(
    margin: EdgeInsets.symmetric(vertical: 14.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: dividerCool.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: midnight.withValues(alpha: 0.10),
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
            Icon(Icons.account_tree, color: midnight, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Class hierarchy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: textOnLight,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'SemanticsEvent (abstract) and its five concrete subclasses.',
          style: TextStyle(fontSize: 12.5, color: textOnLightSoft),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: 360.0,
          child: CustomPaint(
            painter: _HierarchyPainter(
              root: midnight,
              announce: neonMagenta,
              tooltip: neonAmber,
              longPress: neonMint,
              tap: neonViolet,
              focus: Color(0xFF4FC3F7),
              edge: dividerCool,
              label: textOnLight,
            ),
            size: Size.infinite,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'All five subclasses inherit a `type` discriminator and the '
          'inherited `toMap({int? nodeId})` packaging. Subclass-specific '
          'payload comes from `getDataMap()`.',
          style: TextStyle(fontSize: 12.0, color: textOnLightSoft, height: 1.4),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 3 — Event payload table
  // =========================================================================
  final List<List<String>> payloadRows = const <List<String>>[
    <String>[
      'AnnounceSemanticsEvent',
      'message: String, textDirection: TextDirection, viewId: int, assertiveness: Assertiveness',
      "'announce'",
      "{'message', 'textDirection', 'assertiveness', 'viewId'}",
    ],
    <String>[
      'TooltipSemanticsEvent',
      'message: String',
      "'tooltip'",
      "{'message'}",
    ],
    <String>[
      'LongPressSemanticsEvent',
      '(no parameters)',
      "'longPress'",
      '{}',
    ],
    <String>[
      'TapSemanticEvent',
      '(no parameters)',
      "'tap'",
      '{}',
    ],
    <String>[
      'FocusSemanticsEvent',
      '(no parameters)',
      "'focus'",
      '{}',
    ],
  ];

  final Widget payloadTable = Container(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: paperTint,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: dividerCool.withValues(alpha: 0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.table_chart_outlined, color: midnight, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Event payload table',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textOnLight,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Parameters, `type` discriminator and `getDataMap()` keys for each '
          'concrete SemanticsEvent.',
          style: TextStyle(fontSize: 12.0, color: textOnLightSoft),
        ),
        SizedBox(height: 14.0),
        _payloadHeaderRow(midnight, paper),
        for (int i = 0; i < payloadRows.length; i++)
          _payloadRow(
            payloadRows[i],
            i.isEven ? paper : paperTint,
            textOnLight,
            textOnLightSoft,
            dividerCool,
          ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 4 — Static gallery of styled "event cards"
  // =========================================================================
  final List<Widget> gallery = <Widget>[
    _eventCard(
      icon: Icons.campaign,
      title: 'AnnounceSemanticsEvent',
      subtitle: 'Speak a transient message',
      toStringText: announceToString,
      dataMap: announceData,
      typeName: announceType,
      primary: neonMagenta,
      ink: midnight,
      paperColor: paper,
      paperSoft: paperTint,
      textColor: textOnLight,
      mutedColor: textOnLightSoft,
    ),
    _eventCard(
      icon: Icons.translate,
      title: 'AnnounceSemanticsEvent (RTL)',
      subtitle: 'Arabic, TextDirection.rtl, viewId=1',
      toStringText: announceRtlToString,
      dataMap: announceRtlData,
      typeName: announceType,
      primary: neonViolet,
      ink: midnight,
      paperColor: paper,
      paperSoft: paperTint,
      textColor: textOnLight,
      mutedColor: textOnLightSoft,
    ),
    _eventCard(
      icon: Icons.info_outline,
      title: 'TooltipSemanticsEvent',
      subtitle: 'A tooltip just became visible',
      toStringText: tooltipToString,
      dataMap: tooltipData,
      typeName: tooltipType,
      primary: neonAmber,
      ink: midnight,
      paperColor: paper,
      paperSoft: paperTint,
      textColor: textOnLight,
      mutedColor: textOnLightSoft,
    ),
    _eventCard(
      icon: Icons.touch_app,
      title: 'LongPressSemanticsEvent',
      subtitle: 'Long-press just occurred',
      toStringText: longPressToString,
      dataMap: longPressData,
      typeName: longPressType,
      primary: neonMint,
      ink: midnight,
      paperColor: paper,
      paperSoft: paperTint,
      textColor: textOnLight,
      mutedColor: textOnLightSoft,
    ),
    _eventCard(
      icon: Icons.ads_click,
      title: 'TapSemanticEvent',
      subtitle: 'Tap just occurred',
      toStringText: tapToString,
      dataMap: tapData,
      typeName: tapType,
      primary: Color(0xFF4FC3F7),
      ink: midnight,
      paperColor: paper,
      paperSoft: paperTint,
      textColor: textOnLight,
      mutedColor: textOnLightSoft,
    ),
    _eventCard(
      icon: Icons.center_focus_strong,
      title: 'FocusSemanticsEvent',
      subtitle: 'Request a11y focus on a node',
      toStringText: focusToString,
      dataMap: focusData,
      typeName: focusType,
      primary: neonMagentaSoft,
      ink: midnight,
      paperColor: paper,
      paperSoft: paperTint,
      textColor: textOnLight,
      mutedColor: textOnLightSoft,
    ),
  ];

  final Widget gallerySection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(Icons.grid_view, color: midnight, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Live event gallery',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: textOnLight,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          'Each card was constructed from a real SemanticsEvent instance and '
          'shows the rendered `toString()` plus the `getDataMap()` payload.',
          style: TextStyle(fontSize: 12.0, color: textOnLightSoft, height: 1.4),
        ),
      ),
      for (final Widget c in gallery)
        Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: c,
        ),
    ],
  );

  // =========================================================================
  // SECTION 5 — Assertiveness comparison card
  // =========================================================================
  final Widget assertivenessCard = Container(
    margin: EdgeInsets.symmetric(vertical: 14.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [stageInk, midnight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: neonMagenta.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.equalizer, color: neonMagenta, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Assertiveness — polite vs assertive',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textOnDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Controls how `SemanticsService.announce` is queued by the '
          'screen reader.',
          style: TextStyle(fontSize: 12.5, color: textOnDarkSoft),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _politenessColumn(
                title: 'Assertiveness.polite',
                icon: Icons.front_hand_outlined,
                color: neonMint,
                description:
                    'Waits until the screen reader finishes its current '
                    'utterance and any already-queued ones, then speaks. '
                    'Mirrors `aria-live="polite"` on the web.',
                example:
                    "SemanticsService.announce('Saved.', TextDirection.ltr,\n"
                    '    assertiveness: Assertiveness.polite);',
                useCases: const <String>[
                  'Status toasts',
                  'Background sync results',
                  'Non-urgent banners',
                  'Quiet success confirmations',
                ],
                paperColor: paper,
                stageColor: stageInk,
                textColor: textOnDark,
                mutedColor: textOnDarkSoft,
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: _politenessColumn(
                title: 'Assertiveness.assertive',
                icon: Icons.priority_high,
                color: neonMagenta,
                description:
                    'Interrupts the screen reader immediately, clearing its '
                    'queue and speaking the message *now*. Mirrors '
                    '`aria-live="assertive"`.',
                example:
                    "SemanticsService.announce('Error: card declined.',\n"
                    '    TextDirection.ltr,\n'
                    '    assertiveness: Assertiveness.assertive);',
                useCases: const <String>[
                  'Form validation errors',
                  'Time-critical alerts',
                  'Security prompts',
                  'Destructive-action warnings',
                ],
                paperColor: paper,
                stageColor: stageInk,
                textColor: textOnDark,
                mutedColor: textOnDarkSoft,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: neonAmber.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: neonAmber.withValues(alpha: 0.6)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded, color: neonAmber, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Default is polite. Reach for assertive only when the user '
                  'truly must hear the message *now*. Over-using assertive '
                  'makes the entire UI feel hostile to screen-reader users.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: neonAmberSoft,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 6 — SemanticsService API card
  // =========================================================================
  final Widget apiCard = Container(
    margin: EdgeInsets.symmetric(vertical: 14.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: dividerCool.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: midnight.withValues(alpha: 0.10),
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
            Icon(Icons.api, color: midnight, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'SemanticsService API',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textOnLight,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Two static entry points wrap the underlying SemanticsEvent dispatch.',
          style: TextStyle(fontSize: 12.0, color: textOnLightSoft),
        ),
        SizedBox(height: 14.0),
        _apiRow(
          'SemanticsService.announce',
          'Future<void> announce(\n'
              '  String message,\n'
              '  TextDirection textDirection, {\n'
              '  Assertiveness assertiveness = Assertiveness.polite,\n'
              '});',
          'Constructs an AnnounceSemanticsEvent internally and ships it down '
              'the flutter/accessibility platform channel for the current view.',
          neonMagenta,
          paper,
          textOnLight,
          textOnLightSoft,
        ),
        SizedBox(height: 10.0),
        _apiRow(
          'SemanticsService.tooltip',
          'Future<void> tooltip(String message);',
          'Ships a TooltipSemanticsEvent so the screen reader can announce '
              'a tooltip that just became visible (analogue of '
              'UIAccessibility.post layout-changed with a string).',
          neonAmber,
          paper,
          textOnLight,
          textOnLightSoft,
        ),
        SizedBox(height: 10.0),
        _apiRow(
          'SemanticsService.performAction',
          'Future<void> performAction(\n'
              '  int id, SemanticsAction action, [Object? args]);',
          'Lower-level peer used by the framework to drive events with '
              'explicit nodeId targeting. Most apps will never call this.',
          neonMint,
          paper,
          textOnLight,
          textOnLightSoft,
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 7 — Annotated accessibility-tree CustomPainter
  // =========================================================================
  final Widget treeCard = Container(
    margin: EdgeInsets.symmetric(vertical: 14.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: dividerCool.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree_outlined, color: midnight, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Annotated accessibility tree',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textOnLight,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'A demo UI with overlaid SemanticsNode labels, each showing its '
          'SemanticsAction set and SemanticsFlag set.',
          style: TextStyle(fontSize: 12.0, color: textOnLightSoft),
        ),
        SizedBox(height: 14.0),
        SizedBox(
          height: 320.0,
          child: CustomPaint(
            painter: _AccessibilityTreePainter(
              ink: midnight,
              accentA: neonMagenta,
              accentB: neonMint,
              accentC: neonAmber,
              accentD: neonViolet,
              paperColor: paperTint,
              label: textOnLight,
              muted: textOnLightSoft,
            ),
            size: Size.infinite,
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 8 — Pitfalls
  // =========================================================================
  final List<Map<String, String>> pitfalls = const <Map<String, String>>[
    <String, String>{
      'title': 'Over-announcing',
      'body':
          'Firing AnnounceSemanticsEvent every time anything changes drowns '
              'the user. Prefer letting the existing semantics tree be read; '
              'announce only out-of-band events that have no visible focus.',
    },
    <String, String>{
      'title': 'Missing TextDirection',
      'body':
          'AnnounceSemanticsEvent requires a TextDirection. Using the wrong '
              'direction for RTL text (Arabic/Hebrew) causes mispronounced or '
              'reverse-ordered speech on some screen readers.',
    },
    <String, String>{
      'title': 'Conflicting Semantics widgets',
      'body':
          'Wrapping a subtree in two Semantics widgets with different labels '
              'creates two competing nodes. Pick one, or use MergeSemantics to '
              'collapse them into a single composite node.',
    },
    <String, String>{
      'title': 'Forgetting MergeSemantics',
      'body':
          'A Row of Icon + Text reads as two nodes by default. Wrap with '
              'MergeSemantics to read as a single labelled control. This is '
              'the most common a11y bug in custom buttons.',
    },
    <String, String>{
      'title': 'polite vs assertive misuse',
      'body':
          'Using assertive for non-critical updates interrupts the user. '
              'Using polite for a critical error means it may never be heard '
              'before the user navigates away. Match urgency to politeness.',
    },
  ];

  final Widget pitfallsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 14.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3E0F1F), Color(0xFF1F0A14)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: neonMagenta.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.report_problem_outlined, color: neonMagenta, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textOnDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Five mistakes that hurt screen-reader UX.',
          style: TextStyle(fontSize: 12.5, color: textOnDarkSoft),
        ),
        SizedBox(height: 14.0),
        for (int i = 0; i < pitfalls.length; i++)
          _pitfallRow(
            index: i + 1,
            title: pitfalls[i]['title'] ?? '',
            body: pitfalls[i]['body'] ?? '',
            accent: neonMagenta,
            ink: stageInk,
            textColor: textOnDark,
            mutedColor: textOnDarkSoft,
          ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 9 — Code-block cards (idioms)
  // =========================================================================
  final List<Map<String, String>> idioms = const <Map<String, String>>[
    <String, String>{
      'title': 'Announce after a successful save',
      'body':
          "await repository.save(doc);\n"
              "SemanticsService.announce(\n"
              "  'Document saved.',\n"
              "  Directionality.of(context),\n"
              ");",
    },
    <String, String>{
      'title': 'Announce a validation error assertively',
      'body':
          "SemanticsService.announce(\n"
              "  'Card number is invalid.',\n"
              "  Directionality.of(context),\n"
              "  assertiveness: Assertiveness.assertive,\n"
              ");",
    },
    <String, String>{
      'title': 'Tooltip pulse on focus',
      'body':
          "Focus(\n"
              "  onFocusChange: (gained) {\n"
              "    if (gained) {\n"
              "      SemanticsService.tooltip('Save document');\n"
              "    }\n"
              "  },\n"
              "  child: child,\n"
              ");",
    },
    <String, String>{
      'title': 'Custom semantics action',
      'body':
          "Semantics(\n"
              "  customSemanticsActions: <CustomSemanticsAction, VoidCallback>{\n"
              "    const CustomSemanticsAction(label: 'Archive'): _archive,\n"
              "    const CustomSemanticsAction(label: 'Pin'): _pin,\n"
              "  },\n"
              "  child: card,\n"
              ");",
    },
    <String, String>{
      'title': 'MergeSemantics composition',
      'body':
          "MergeSemantics(\n"
              "  child: Row(children: <Widget>[\n"
              "    const Icon(Icons.warning),\n"
              "    const SizedBox(width: 8),\n"
              "    Text(\"Battery low\"),\n"
              "  ]),\n"
              ");",
    },
  ];

  final Widget idiomsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 14.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: dividerCool.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: midnight, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Idioms — copy-paste recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textOnLight,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Five short patterns that exercise SemanticsEvent and its API.',
          style: TextStyle(fontSize: 12.0, color: textOnLightSoft),
        ),
        SizedBox(height: 14.0),
        for (int i = 0; i < idioms.length; i++)
          _idiomCard(
            index: i + 1,
            title: idioms[i]['title'] ?? '',
            body: idioms[i]['body'] ?? '',
            accent: i.isEven ? neonMint : neonMagenta,
            ink: midnight,
            paperColor: paperTint,
            textColor: textOnLight,
            mutedColor: textOnLightSoft,
          ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 10 — Real Semantics / MergeSemantics / ExcludeSemantics wrappers
  // =========================================================================
  final Widget liveSemanticsCard = Container(
    margin: EdgeInsets.symmetric(vertical: 14.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0A2933), Color(0xFF0F4F61)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: neonMint.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers_outlined, color: neonMint, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Live Semantics wrappers',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textOnDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'These three subtrees use real Semantics, MergeSemantics, and '
          'ExcludeSemantics widgets. They render with no binding driving them.',
          style: TextStyle(fontSize: 12.5, color: textOnDarkSoft),
        ),
        SizedBox(height: 14.0),
        Semantics(
          container: true,
          label: 'Battery status',
          value: '42 percent',
          hint: 'Low. Charge soon.',
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: stageInk.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: neonAmber.withValues(alpha: 0.6)),
            ),
            child: Row(
              children: [
                Icon(Icons.battery_2_bar, color: neonAmber, size: 28.0),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Semantics(label, value, hint)',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: neonAmberSoft,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Battery: 42% — Low. Charge soon.',
                        style: TextStyle(color: textOnDark, fontSize: 13.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        MergeSemantics(
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: stageInk.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: neonMint.withValues(alpha: 0.6)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: neonMint, size: 24.0),
                SizedBox(width: 10.0),
                Text(
                  'MergeSemantics(child: Row(Icon, Text))',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: neonMintSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        ExcludeSemantics(
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: stageInk.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: neonViolet.withValues(alpha: 0.6)),
            ),
            child: Row(
              children: [
                Icon(Icons.visibility_off, color: neonViolet, size: 24.0),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'ExcludeSemantics — purely decorative pattern '
                    'underneath, hidden from the a11y tree.',
                    style: TextStyle(
                      color: neonVioletSoft,
                      fontSize: 12.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 11 — Footer cheat-sheet
  // =========================================================================
  final Widget footer = Container(
    margin: EdgeInsets.only(top: 18.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [midnightMist, midnightSoft, midnight],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: neonAmber.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book_outlined, color: neonAmber, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Cheat-sheet',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textOnDark,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Things to remember when sending SemanticsEvents.',
          style: TextStyle(fontSize: 12.5, color: textOnDarkSoft),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _footerChip('announce', neonMagenta, midnight),
            _footerChip('tooltip', neonAmber, midnight),
            _footerChip('longPress', neonMint, midnight),
            _footerChip('tap', neonViolet, midnight),
            _footerChip('focus', Color(0xFF4FC3F7), midnight),
            _footerChip('polite default', neonMintSoft, midnight),
            _footerChip('assertive interrupts', neonMagentaSoft, midnight),
            _footerChip('TextDirection required', neonAmberSoft, midnight),
            _footerChip('MergeSemantics', neonVioletSoft, midnight),
            _footerChip('ExcludeSemantics', neonMintSoft, midnight),
            _footerChip('flutter/accessibility', neonMint, midnight),
            _footerChip('getDataMap', neonMagenta, midnight),
            _footerChip('toMap(nodeId)', neonAmber, midnight),
            _footerChip('SemanticsService', neonViolet, midnight),
            _footerChip('UIAccessibility.post', neonMintSoft, midnight),
            _footerChip('TYPE_ANNOUNCEMENT', neonAmberSoft, midnight),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: stageInk.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: neonMint.withValues(alpha: 0.5)),
          ),
          child: Text(
            'Rule of thumb: lean on the static semantics tree first. Reach '
            'for SemanticsEvents only for transient, focus-less updates. '
            'Default to polite, escalate to assertive only when blocking.',
            style: TextStyle(
              fontSize: 12.5,
              color: textOnDarkSoft,
              fontStyle: FontStyle.italic,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  print('SemanticsEvent deep demo widget tree assembled');

  // ---------------------------------------------------------------------------
  // Root MaterialApp wrapping everything in a scrollable column.
  // ---------------------------------------------------------------------------
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SemanticsEvent Deep Demo',
    home: Scaffold(
      backgroundColor: paperTint,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              hierarchyCard,
              payloadTable,
              gallerySection,
              assertivenessCard,
              apiCard,
              treeCard,
              pitfallsSection,
              idiomsSection,
              liveSemanticsCard,
              footer,
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Private helpers — chips
// =============================================================================
Widget _heroChip(String label, Color fill, Color ink) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: fill.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: fill.withValues(alpha: 0.7)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: fill,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _footerChip(String label, Color fill, Color ink) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: fill.withValues(alpha: 0.20),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: fill.withValues(alpha: 0.7)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: fill,
      ),
    ),
  );
}

// =============================================================================
// Private helpers — payload table
// =============================================================================
Widget _payloadHeaderRow(Color ink, Color paperColor) {
  final TextStyle hStyle = TextStyle(color: paperColor, fontWeight: FontWeight.bold, fontSize: 12.0, letterSpacing: 0.5);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: ink,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(flex: 3, child: Text('Class', style: hStyle)),
        Expanded(flex: 5, child: Text('Parameters', style: hStyle)),
        Expanded(flex: 2, child: Text('type', style: hStyle)),
        Expanded(flex: 4, child: Text('getDataMap keys', style: hStyle)),
      ],
    ),
  );
}

Widget _payloadRow(
  List<String> row,
  Color bg,
  Color textColor,
  Color mutedColor,
  Color divider,
) {
  final TextStyle keyStyle = TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 11.5, fontFamily: 'monospace');
  final TextStyle valStyle = TextStyle(color: mutedColor, fontSize: 11.0, fontFamily: 'monospace', height: 1.35);
  final TextStyle typeStyle = TextStyle(color: textColor, fontSize: 11.0, fontFamily: 'monospace');
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: bg,
      border: Border(bottom: BorderSide(color: divider.withValues(alpha: 0.25))),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 3, child: Text(row[0], style: keyStyle)),
        Expanded(flex: 5, child: Text(row[1], style: valStyle)),
        Expanded(flex: 2, child: Text(row[2], style: typeStyle)),
        Expanded(flex: 4, child: Text(row[3], style: valStyle)),
      ],
    ),
  );
}

// =============================================================================
// Private helpers — gallery event card
// =============================================================================
Widget _eventCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required String toStringText,
  required Map<String, dynamic> dataMap,
  required String typeName,
  required Color primary,
  required Color ink,
  required Color paperColor,
  required Color paperSoft,
  required Color textColor,
  required Color mutedColor,
}) {
  final List<MapEntry<String, dynamic>> entries = dataMap.entries.toList();
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: paperColor,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: primary.withValues(alpha: 0.6), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: primary.withValues(alpha: 0.15),
          blurRadius: 12.0,
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
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: primary, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: textColor)),
                  Text(subtitle, style: TextStyle(fontSize: 11.5, color: mutedColor)),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(color: primary.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(12.0)),
              child: Text("type='$typeName'", style: TextStyle(fontFamily: 'monospace', fontSize: 10.5, color: primary)),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: paperSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: primary.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('toString()', style: TextStyle(fontSize: 10.5, color: mutedColor, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              SizedBox(height: 4.0),
              Text(toStringText, style: TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: textColor, height: 1.35)),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: ink.withValues(alpha: 0.94), borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.data_object, color: primary, size: 14.0),
                  SizedBox(width: 6.0),
                  Text('getDataMap()', style: TextStyle(fontSize: 10.5, color: primary, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                ],
              ),
              SizedBox(height: 6.0),
              if (entries.isEmpty)
                Text('{}  // no payload — type alone is the signal',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: paperColor.withValues(alpha: 0.8), fontStyle: FontStyle.italic))
              else
                for (final MapEntry<String, dynamic> e in entries)
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0),
                    child: Text("  '${e.key}': ${e.value}",
                        style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: paperColor)),
                  ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Private helpers — politeness column
// =============================================================================
Widget _politenessColumn({
  required String title,
  required IconData icon,
  required Color color,
  required String description,
  required String example,
  required List<String> useCases,
  required Color paperColor,
  required Color stageColor,
  required Color textColor,
  required Color mutedColor,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: stageColor.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(title,
                  style: TextStyle(fontFamily: 'monospace', fontSize: 13.0, fontWeight: FontWeight.bold, color: color)),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(description, style: TextStyle(fontSize: 12.0, color: textColor, height: 1.4)),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF050913),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(example,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: color, height: 1.4)),
        ),
        SizedBox(height: 10.0),
        Text('Good for:',
            style: TextStyle(fontSize: 11.0, color: mutedColor, fontWeight: FontWeight.bold, letterSpacing: 0.4)),
        SizedBox(height: 4.0),
        for (final String u in useCases)
          Padding(
            padding: EdgeInsets.only(left: 6.0, top: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.fiber_manual_record, color: color, size: 7.0),
                SizedBox(width: 6.0),
                Expanded(child: Text(u, style: TextStyle(fontSize: 11.5, color: textColor, height: 1.35))),
              ],
            ),
          ),
      ],
    ),
  );
}

// =============================================================================
// Private helpers — API row, pitfall row, idiom card
// =============================================================================
Widget _apiRow(
  String name,
  String signature,
  String description,
  Color accent,
  Color paperColor,
  Color textColor,
  Color mutedColor,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: paperColor,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.withValues(alpha: 0.7)),
          ),
          child: Text(name,
              style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: accent, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Color(0xFF0A0F1E), borderRadius: BorderRadius.circular(8.0)),
          width: double.infinity,
          child: Text(signature,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: accent, height: 1.4)),
        ),
        SizedBox(height: 8.0),
        Text(description, style: TextStyle(fontSize: 12.0, color: mutedColor, height: 1.4)),
      ],
    ),
  );
}

Widget _pitfallRow({
  required int index,
  required String title,
  required String body,
  required Color accent,
  required Color ink,
  required Color textColor,
  required Color mutedColor,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: ink.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: accent.withValues(alpha: 0.7)),
          ),
          alignment: Alignment.center,
          child: Text('$index', style: TextStyle(color: accent, fontWeight: FontWeight.bold, fontSize: 14.0)),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: textColor)),
              SizedBox(height: 4.0),
              Text(body, style: TextStyle(fontSize: 12.0, color: mutedColor, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _idiomCard({
  required int index,
  required String title,
  required String body,
  required Color accent,
  required Color ink,
  required Color paperColor,
  required Color textColor,
  required Color mutedColor,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: paperColor,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(color: accent.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8.0)),
              child: Text('Idiom $index',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: accent, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: textColor)),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(8.0)),
          width: double.infinity,
          child: Text(body,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: accent, height: 1.45)),
        ),
      ],
    ),
  );
}

// =============================================================================
// CustomPainter — class hierarchy tree
// =============================================================================
class _HierarchyPainter extends CustomPainter {
  _HierarchyPainter({
    required this.root,
    required this.announce,
    required this.tooltip,
    required this.longPress,
    required this.tap,
    required this.focus,
    required this.edge,
    required this.label,
  });

  final Color root;
  final Color announce;
  final Color tooltip;
  final Color longPress;
  final Color tap;
  final Color focus;
  final Color edge;
  final Color label;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double rootX = w / 2.0;
    final double rootY = 32.0;
    final double leafY = h - 40.0;

    final List<List<dynamic>> leaves = <List<dynamic>>[
      <dynamic>['AnnounceSemanticsEvent', announce],
      <dynamic>['TooltipSemanticsEvent', tooltip],
      <dynamic>['LongPressSemanticsEvent', longPress],
      <dynamic>['TapSemanticEvent', tap],
      <dynamic>['FocusSemanticsEvent', focus],
    ];
    final int n = leaves.length;
    final double spacing = w / (n + 1);

    // Edges
    final Paint edgePaint = Paint()
      ..color = edge
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < n; i++) {
      final double lx = spacing * (i + 1);
      final Path p = Path();
      p.moveTo(rootX, rootY + 24.0);
      final double midY = (rootY + leafY) / 2.0;
      p.cubicTo(rootX, midY, lx, midY, lx, leafY - 24.0);
      canvas.drawPath(p, edgePaint);
    }

    // Root node
    _drawNode(
      canvas,
      Offset(rootX, rootY),
      'SemanticsEvent\n(abstract)',
      root,
      Colors.white,
      labelColor: Colors.white,
      width: 180.0,
      height: 48.0,
    );

    // Leaf nodes
    for (int i = 0; i < n; i++) {
      final double lx = spacing * (i + 1);
      _drawNode(
        canvas,
        Offset(lx, leafY),
        leaves[i][0] as String,
        leaves[i][1] as Color,
        Colors.white,
        labelColor: Colors.white,
        width: 140.0,
        height: 40.0,
      );
    }
  }

  void _drawNode(
    Canvas canvas,
    Offset center,
    String text,
    Color fill,
    Color stroke, {
    required Color labelColor,
    required double width,
    required double height,
  }) {
    final RRect r = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: height),
      Radius.circular(10.0),
    );
    final Paint fillP = Paint()..color = fill;
    final Paint strokeP = Paint()
      ..color = stroke.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRRect(r, fillP);
    canvas.drawRRect(r, strokeP);

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: labelColor,
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          height: 1.25,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 3,
    );
    tp.layout(maxWidth: width - 10.0);
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2.0, center.dy - tp.height / 2.0),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// CustomPainter — annotated accessibility tree
// =============================================================================
class _AccessibilityTreePainter extends CustomPainter {
  _AccessibilityTreePainter({
    required this.ink,
    required this.accentA,
    required this.accentB,
    required this.accentC,
    required this.accentD,
    required this.paperColor,
    required this.label,
    required this.muted,
  });

  final Color ink;
  final Color accentA;
  final Color accentB;
  final Color accentC;
  final Color accentD;
  final Color paperColor;
  final Color label;
  final Color muted;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Background grid hints
    final Paint grid = Paint()
      ..color = muted.withValues(alpha: 0.08)
      ..strokeWidth = 1.0;
    for (double y = 20.0; y < h; y += 28.0) {
      canvas.drawLine(Offset(0.0, y), Offset(w, y), grid);
    }

    // Root container
    final Rect rootRect =
        Rect.fromLTWH(12.0, 14.0, w - 24.0, h - 28.0);
    final RRect rootR = RRect.fromRectAndRadius(rootRect, Radius.circular(12.0));
    final Paint rootFill = Paint()..color = paperColor;
    final Paint rootStroke = Paint()
      ..color = ink.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRRect(rootR, rootFill);
    canvas.drawRRect(rootR, rootStroke);
    _drawText(
      canvas,
      'Scaffold (root node)  flags: {scopesRoute}  actions: {}',
      Offset(22.0, 22.0),
      label,
      11.0,
      maxWidth: w - 40.0,
      bold: true,
    );

    // App bar
    final Rect appBar = Rect.fromLTWH(24.0, 50.0, w - 48.0, 44.0);
    _drawZone(canvas, appBar, accentA, 'AppBar — flags: {hasEnabledState, isHeader}  actions: {}');

    // Save button
    final Rect saveBtn = Rect.fromLTWH(28.0, 110.0, 130.0, 60.0);
    _drawZone(
      canvas,
      saveBtn,
      accentB,
      'Save  flags: {isButton, hasEnabledState}\nactions: {tap, longPress}',
    );

    // Settings button
    final Rect setBtn = Rect.fromLTWH(170.0, 110.0, 130.0, 60.0);
    _drawZone(
      canvas,
      setBtn,
      accentB,
      'Settings  flags: {isButton}\nactions: {tap, focus}',
    );

    // Text field
    final Rect textField = Rect.fromLTWH(28.0, 184.0, w - 56.0, 50.0);
    _drawZone(
      canvas,
      textField,
      accentC,
      'TextField — flags: {isTextField, isFocused}\nactions: {setSelection, copy, paste, focus}',
    );

    // Tooltip overlay
    final Rect tip = Rect.fromLTWH(w - 200.0, 250.0, 180.0, 36.0);
    _drawZone(
      canvas,
      tip,
      accentD,
      'Tooltip — fires TooltipSemanticsEvent(message)',
    );
  }

  void _drawZone(Canvas canvas, Rect r, Color accent, String text) {
    final RRect rr = RRect.fromRectAndRadius(r, Radius.circular(8.0));
    final Paint fill = Paint()..color = accent.withValues(alpha: 0.13);
    final Paint stroke = Paint()
      ..color = accent.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    canvas.drawRRect(rr, fill);
    canvas.drawRRect(rr, stroke);
    _drawText(
      canvas,
      text,
      Offset(r.left + 8.0, r.top + 6.0),
      ink,
      10.5,
      maxWidth: r.width - 14.0,
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    Color color,
    double size, {
    required double maxWidth,
    bool bold = false,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.w500,
          height: 1.3,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 4,
    );
    tp.layout(maxWidth: maxWidth);
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  LIGHTHOUSE BEACON  ::  SemanticsEvent — Deep-Demo Field Manual
// =============================================================================
//
//  THEME
//  -----
//  "Lighthouse Beacon" is the design language we wear for this manual. Picture
//  a coastal lighthouse keeper's office at dusk: a brass-rimmed lamp rotates
//  its beam across a fog-bound sea, and every full revolution it pulses out a
//  signal that distant vessels can decode. In our metaphor, the rotating beam
//  IS the Flutter widget tree; the distant ship IS the assistive technology
//  on the user's device (TalkBack, VoiceOver, NVDA, JAWS, ChromeVox, Orca);
//  and the discrete pulses of light that travel between them are the
//  SemanticsEvent instances. Each pulse carries a tiny, structured message:
//  "I have just been tapped." "Pay attention to this announcement." "The
//  focus has moved to a new node." The keeper does not see the ship — only
//  the beam. The ship does not see the keeper — only the pulses. The
//  SemanticsEvent is the contract that makes that conversation legible.
//
//  SUBJECT
//  -------
//  SemanticsEvent (package:flutter/semantics.dart) is the abstract base class
//  for accessibility events that Flutter emits to the host platform. It is
//  the engine-side counterpart to a UIAccessibility notification on iOS, an
//  AccessibilityEvent on Android, and an aria-live region update on the web.
//
//  Concrete subclasses we will catalogue in this manual:
//
//   * AnnounceSemanticsEvent  — speak a string out loud now, regardless of
//                               what node the screen reader cursor is on.
//   * TooltipSemanticsEvent   — read a tooltip aloud (rarely-used, mostly
//                               replaced by SemanticsProperties.tooltip).
//   * TapSemanticEvent        — synthetic "this widget was just tapped"
//                               pulse, useful when a custom gesture has
//                               taken the place of a native tap.
//   * LongPressSemanticsEvent — synthetic "this widget was long-pressed"
//                               pulse, with the same intent.
//   * FocusSemanticEvent      — move the screen-reader cursor to a target
//                               node, even if input focus has not changed.
//
//  Every SemanticsEvent has two surface members:
//
//      String get type;            // identifies the event kind on the wire
//      Map<String, dynamic> toMap();  // serialises the event for the host
//
//  Engine-side, SemanticsOwner.sendSemanticsEvent(int nodeId, SemanticsEvent
//  event) is what flips these into a platform message on the
//  flutter/accessibility channel. From the widget layer the more common
//  entry points are:
//
//      SemanticsService.announce(message, textDirection,
//                                 assertiveness: Assertiveness.polite);
//      SemanticsService.tooltip(message);
//
//  Both helpers wrap a SemanticsEvent and route it through the binding.
//
//  PHILOSOPHY
//  ----------
//  Accessibility is not a Boolean. It is a contract, written in events, that
//  says: "When the visible UI changes in a way a sighted user notices, an
//  equivalent change must reach a non-sighted user." A focus ring that moves
//  must be paired with a FocusSemanticEvent. A live "saved" toast that
//  appears on screen must be paired with an AnnounceSemanticsEvent. A custom
//  tap target with no native InkWell must still emit a TapSemanticEvent so
//  the screen reader can confirm the action took place.
//
//  This manual demonstrates the API surface, the serialisation contract, and
//  the idioms — without simulating run-time behaviour, because D4rt scripts
//  build a snapshot tree exactly once and never re-render. We compute every
//  toMap() up-front, render every event as a card, and walk the reader
//  through the conversation in narrative form.
//
//  SECTIONS
//  --------
//   01. Cover banner — title, taxonomy, and the lighthouse motto.
//   02. Definition prose — what a SemanticsEvent IS and IS NOT.
//   03. Family of events — one card per subclass, with constructor + type.
//   04. Anatomy of a pulse — widget -> SemanticsNode -> engine -> AT.
//   05. Announcement Theatre — five themed AnnounceSemanticsEvent demos.
//   06. Tooltip / Tap / LongPress — sequenced rows of synthetic events.
//   07. Focus Routing — a navigation-tree mock with FocusSemanticEvent.
//   08. toMap Inspector — every event's serialised payload.
//   09. Platform routing matrix — iOS / Android / web / desktop dispatch.
//   10. Accessibility checklist — DO and AVOID rules for the careful keeper.
//   11. Glossary — terms a new keeper needs to know.
//   12. Recap footer — the keeper's closing motto.
//
//  D4RT RULES OF THE ROAD
//  ----------------------
//   * The single entry point is `dynamic build(BuildContext context)`.
//   * No StatefulWidget, no setState, no controllers, no Timers, no streams.
//   * No `for-in` over BridgedInstance values; use indexed `for` loops.
//   * No `.value` reads on Tween.animate(...); use `.transform(t)` directly.
//   * Use `Color.withValues(alpha: ...)` instead of `withOpacity(...)`.
//   * Real subclass identifiers from `package:flutter/semantics.dart`.
//   * Plain ASCII only, no emoji.
//
//  ATTRIBUTION
//  -----------
//  Lighthouse Beacon is a fictional design language invented for this
//  teaching artifact. It draws on coastal-station aesthetics, brass-and-fog
//  colour, and the philosophy of "events as pulses of structured light."
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

// ---------------------------------------------------------------------------
// PALETTE :: Lighthouse Beacon — fourteen named colours.
// ---------------------------------------------------------------------------
// These values are picked deliberately to evoke a maritime guidebook printed
// on heavy paper: navy blue for the deep sea, beacon yellow for the lamp,
// fog white for the page, charcoal for the typeset prose, brass for the
// instrument fittings, and a few accent shades for the diagrams that follow.
//
// We keep the swatches as plain `Color` constants inside `build` so the
// script remains a single self-contained function — D4rt scripts cannot
// rely on top-level state being preserved across calls in every host.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------------
  // SECTION 0 :: NARRATIVE PRELUDE
  // -------------------------------------------------------------------------
  // We narrate the script with print() lines so the test harness's stdout
  // captures a readable trace of what the demo *intends* to teach. The
  // prints do not affect the rendered tree; they are commentary for the
  // engineer scanning the test log.
  print('[lighthouse-beacon] SemanticsEvent deep-demo script booting...');
  print('[lighthouse-beacon] subject: package:flutter/semantics.dart');
  print('[lighthouse-beacon] family: AnnounceSemanticsEvent,');
  print('[lighthouse-beacon]         TooltipSemanticsEvent,');
  print('[lighthouse-beacon]         TapSemanticEvent,');
  print('[lighthouse-beacon]         LongPressSemanticsEvent,');
  print('[lighthouse-beacon]         FocusSemanticEvent.');
  print('[lighthouse-beacon] philosophy: pulses of structured light.');

  // -------------------------------------------------------------------------
  // PALETTE :: fourteen colours, navy / beacon / fog / charcoal / brass.
  // -------------------------------------------------------------------------
  final Color seaDeep = Color(0xFF0B1F3A);          // open ocean at dusk
  final Color seaSwell = Color(0xFF14315B);         // mid-water swell
  final Color seaFoam = Color(0xFFB8CFE3);          // foam at the rocks
  final Color fogPale = Color(0xFFEFEAD8);          // page-fog parchment
  final Color fogMist = Color(0xFFD8D2BD);          // older parchment
  final Color beaconCore = Color(0xFFF7C948);       // lamp core, hottest
  final Color beaconFlare = Color(0xFFFFE08A);      // outer halo
  final Color brassFitting = Color(0xFF8C6E2A);     // tarnished brass
  final Color brassPolished = Color(0xFFC8A24B);    // polished brass
  final Color charcoalInk = Color(0xFF161616);      // typeset ink
  final Color stormGray = Color(0xFF4A4A4A);        // overcast gray
  final Color rustEmber = Color(0xFFB23A1C);        // warning ember
  final Color mossGreen = Color(0xFF2E5D3A);        // safe-harbour green
  final Color tealCipher = Color(0xFF207A7A);       // signal teal

  print('[lighthouse-beacon] palette resolved (14 swatches).');

  // -------------------------------------------------------------------------
  // SECTION 0.1 :: instantiate one of every concrete SemanticsEvent.
  // -------------------------------------------------------------------------
  // We construct each subclass with a representative payload. These objects
  // are then rendered, inspected (via toMap), and narrated through the rest
  // of the manual. We *do not* dispatch them to the engine — D4rt scripts
  // run inside a snapshot harness with no live SemanticsOwner — but the
  // construction alone exercises the constructors and the type system.
  // -------------------------------------------------------------------------

  // The third positional argument to AnnounceSemanticsEvent is the
  // platform view id; for our snapshot we use 0 (the default flutter view).
  // In a live app you would pass `View.of(context).viewId`.
  const int viewIdMain = 0;
  final AnnounceSemanticsEvent announceBeaconRotating =
      AnnounceSemanticsEvent('Beacon rotating', TextDirection.ltr, viewIdMain);
  final AnnounceSemanticsEvent announceFogHorn =
      AnnounceSemanticsEvent('Fog horn engaged', TextDirection.ltr, viewIdMain);
  final AnnounceSemanticsEvent announceVesselApproaching =
      AnnounceSemanticsEvent('Vessel approaching from the south-east',
          TextDirection.ltr, viewIdMain);
  final AnnounceSemanticsEvent announceKeeperOnDuty = AnnounceSemanticsEvent(
      'Lighthouse keeper on duty', TextDirection.ltr, viewIdMain);
  final AnnounceSemanticsEvent announceAllClear = AnnounceSemanticsEvent(
      'All clear, harbour open', TextDirection.ltr, viewIdMain);

  final TooltipSemanticsEvent tooltipLamp =
      TooltipSemanticsEvent('Rotate the beacon lamp');
  final TooltipSemanticsEvent tooltipFog =
      TooltipSemanticsEvent('Engage the fog horn');
  final TooltipSemanticsEvent tooltipLog =
      TooltipSemanticsEvent('Open the keeper\'s log');

  final TapSemanticEvent tapBeacon = TapSemanticEvent();
  final TapSemanticEvent tapHorn = TapSemanticEvent();
  final TapSemanticEvent tapLog = TapSemanticEvent();

  final LongPressSemanticsEvent longPressBeacon = LongPressSemanticsEvent();
  final LongPressSemanticsEvent longPressFog = LongPressSemanticsEvent();

  final FocusSemanticEvent focusToLamp = FocusSemanticEvent();
  final FocusSemanticEvent focusToFog = FocusSemanticEvent();
  final FocusSemanticEvent focusToLog = FocusSemanticEvent();

  print('[lighthouse-beacon] events constructed:');
  print('  announceBeaconRotating.type = ${announceBeaconRotating.type}');
  print('  announceFogHorn.type        = ${announceFogHorn.type}');
  print('  announceVesselApproaching.type = ${announceVesselApproaching.type}');
  print('  announceKeeperOnDuty.type   = ${announceKeeperOnDuty.type}');
  print('  announceAllClear.type       = ${announceAllClear.type}');
  print('  tooltipLamp.type            = ${tooltipLamp.type}');
  print('  tooltipFog.type             = ${tooltipFog.type}');
  print('  tooltipLog.type             = ${tooltipLog.type}');
  print('  tapBeacon.type              = ${tapBeacon.type}');
  print('  longPressBeacon.type        = ${longPressBeacon.type}');
  print('  focusToLamp.type            = ${focusToLamp.type}');

  // -------------------------------------------------------------------------
  // SECTION 0.2 :: pre-compute toMap() payloads for the inspector section.
  // -------------------------------------------------------------------------
  // Calling `toMap()` here means we surface any errors immediately — and the
  // resulting Maps are what the rest of the manual renders as key/value
  // tables. Each map is a `Map<String, dynamic>`; for AnnounceSemanticsEvent
  // it contains 'message', 'textDirection', and 'assertiveness'; for
  // TooltipSemanticsEvent only 'message'; for the synthetic Tap/LongPress/
  // Focus events the map is empty because the event kind is encoded purely
  // by the `type` string.
  // -------------------------------------------------------------------------

  final Map<String, dynamic> mapAnnounceBeaconRotating =
      announceBeaconRotating.toMap();
  final Map<String, dynamic> mapAnnounceFogHorn = announceFogHorn.toMap();
  final Map<String, dynamic> mapAnnounceVessel =
      announceVesselApproaching.toMap();
  final Map<String, dynamic> mapAnnounceKeeper = announceKeeperOnDuty.toMap();
  final Map<String, dynamic> mapAnnounceAllClear = announceAllClear.toMap();
  final Map<String, dynamic> mapTooltipLamp = tooltipLamp.toMap();
  final Map<String, dynamic> mapTooltipFog = tooltipFog.toMap();
  final Map<String, dynamic> mapTooltipLog = tooltipLog.toMap();
  final Map<String, dynamic> mapTapBeacon = tapBeacon.toMap();
  final Map<String, dynamic> mapTapHorn = tapHorn.toMap();
  final Map<String, dynamic> mapTapLog = tapLog.toMap();
  final Map<String, dynamic> mapLongPressBeacon = longPressBeacon.toMap();
  final Map<String, dynamic> mapLongPressFog = longPressFog.toMap();
  final Map<String, dynamic> mapFocusToLamp = focusToLamp.toMap();
  final Map<String, dynamic> mapFocusToFog = focusToFog.toMap();
  final Map<String, dynamic> mapFocusToLog = focusToLog.toMap();

  print('[lighthouse-beacon] toMap() payloads:');
  print('  announceBeaconRotating -> $mapAnnounceBeaconRotating');
  print('  announceFogHorn        -> $mapAnnounceFogHorn');
  print('  announceVesselApproaching -> $mapAnnounceVessel');
  print('  tooltipLamp            -> $mapTooltipLamp');
  print('  tapBeacon              -> $mapTapBeacon');
  print('  longPressBeacon        -> $mapLongPressBeacon');
  print('  focusToLamp            -> $mapFocusToLamp');

  // -------------------------------------------------------------------------
  // HELPERS :: small UI builders that keep the section code readable.
  // -------------------------------------------------------------------------
  // We use closures inside build() rather than top-level functions so they
  // can capture the palette without a wider scope. D4rt is fine with
  // closures; the only restriction we observe is the iteration rule.
  // -------------------------------------------------------------------------

  Widget bandedLabel(String text, Color background, Color foreground) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget proseLine(String text, {Color? colour, double size = 14.0}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          color: colour ?? charcoalInk,
          fontSize: size,
          height: 1.45,
        ),
      ),
    );
  }

  Widget sectionHeader(String number, String title, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: charcoalInk.withValues(alpha: 0.18),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Text(
              number,
              style: TextStyle(
                color: fogPale,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: charcoalInk,
                fontWeight: FontWeight.w800,
                fontSize: 20,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget codeBlock(String code, {Color? background}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background ?? seaDeep,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: brassFitting, width: 1),
      ),
      child: Text(
        code,
        style: TextStyle(
          color: beaconCore,
          fontFamily: 'monospace',
          fontSize: 12.5,
          height: 1.45,
        ),
      ),
    );
  }

  Widget keyValueRow(String key, String value,
      {Color? keyColour, Color? valueColour}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              key,
              style: TextStyle(
                color: keyColour ?? brassFitting,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColour ?? charcoalInk,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 1 :: COVER BANNER
  // -------------------------------------------------------------------------
  // The cover sets the tone. Navy slab as background, beacon-yellow band
  // across the top half, brass borders, and a one-paragraph definition of
  // SemanticsEvent that the reader can absorb in fifteen seconds.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 01 :: cover banner.');

  final Widget coverBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [seaDeep, seaSwell, charcoalInk],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: brassPolished, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [beaconFlare, beaconCore, brassFitting],
                ),
                boxShadow: [
                  BoxShadow(
                    color: beaconCore.withValues(alpha: 0.6),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Center(
                child: Icon(Icons.flare, color: charcoalInk, size: 28),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LIGHTHOUSE BEACON',
                    style: TextStyle(
                      color: beaconFlare,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 3,
                    ),
                  ),
                  Text(
                    'SemanticsEvent — Field Manual',
                    style: TextStyle(
                      color: fogPale,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(height: 1, color: brassPolished),
        const SizedBox(height: 16),
        Text(
          'TAXONOMY',
          style: TextStyle(
            color: beaconCore,
            fontWeight: FontWeight.w800,
            fontSize: 11,
            letterSpacing: 2.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'package:flutter/semantics.dart >> abstract class SemanticsEvent\n'
          '  >> AnnounceSemanticsEvent(message, textDirection, {assertiveness})\n'
          '  >> TooltipSemanticsEvent(message)\n'
          '  >> TapSemanticEvent()\n'
          '  >> LongPressSemanticsEvent()\n'
          '  >> FocusSemanticEvent()',
          style: TextStyle(
            color: seaFoam,
            fontFamily: 'monospace',
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'DEFINITION',
          style: TextStyle(
            color: beaconCore,
            fontWeight: FontWeight.w800,
            fontSize: 11,
            letterSpacing: 2.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A SemanticsEvent is a structured pulse of metadata that Flutter '
          'sends from its rendering layer to the host platform\'s assistive '
          'technology stack. It is dispatched on the flutter/accessibility '
          'platform channel via SemanticsOwner.sendSemanticsEvent, which '
          'forwards it to UIAccessibility on iOS, AccessibilityManager on '
          'Android, ARIA-live regions on the web, and equivalents on '
          'desktop. The class itself is abstract; you instantiate one of '
          'its concrete subclasses. Each subclass overrides type (a String '
          'identifying the event kind on the wire) and toMap (a serialiser '
          'that returns the payload). The keeper rotates the lamp, the ship '
          'reads the pulses; that is the contract.',
          style: TextStyle(
            color: fogPale,
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            bandedLabel('NAVY', seaDeep, fogPale),
            const SizedBox(width: 6),
            bandedLabel('BEACON', beaconCore, charcoalInk),
            const SizedBox(width: 6),
            bandedLabel('FOG', fogPale, charcoalInk),
            const SizedBox(width: 6),
            bandedLabel('BRASS', brassPolished, charcoalInk),
            const SizedBox(width: 6),
            bandedLabel('CHARCOAL', charcoalInk, fogPale),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 :: PROSE ANATOMY — what a SemanticsEvent IS / IS NOT
  // -------------------------------------------------------------------------
  // Before showing code, we clarify the conceptual boundary. Many
  // engineers conflate SemanticsEvent with SemanticsAction or with the
  // properties carried by SemanticsConfiguration. This section draws
  // that line in fog-paper prose.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 02 :: prose anatomy.');

  final Widget proseAnatomy = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogPale,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('02', 'Anatomy of a SemanticsEvent', seaSwell),
        proseLine(
          'A SemanticsEvent is one-way, transient, and additive. It is not '
          'state — it is a notification. The host AT receives it, decides '
          'whether and how to surface it (speech, braille, haptics), and '
          'then forgets it. There is no equivalent of "set the value" here; '
          'for that you would update the SemanticsConfiguration of a '
          'widget instead.',
        ),
        proseLine(
          'A SemanticsEvent is also distinct from a SemanticsAction. '
          'Actions flow IN — the AT tells Flutter "the user just performed '
          'a longPress". Events flow OUT — Flutter tells the AT "I just '
          'rendered a confirmation toast, please announce it". The two '
          'meet at the SemanticsNode but travel in opposite directions.',
        ),
        proseLine(
          'A SemanticsEvent is small. Most subclasses serialise to a Map '
          'with at most three fields. The event is intended to be cheap to '
          'build and cheap to dispatch: announcing your save-success '
          'banner should never cost more than a few hundred microseconds.',
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: fogMist,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: stormGray.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IS / IS NOT',
                style: TextStyle(
                  color: charcoalInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 6),
              proseLine('IS:  abstract base; subclasses are sealed family.',
                  size: 12.5, colour: charcoalInk),
              proseLine('IS:  serialised by toMap() to Map<String, dynamic>.',
                  size: 12.5, colour: charcoalInk),
              proseLine('IS:  dispatched by SemanticsOwner.sendSemanticsEvent.',
                  size: 12.5, colour: charcoalInk),
              proseLine('IS:  consumed by host AT (TalkBack / VoiceOver / etc).',
                  size: 12.5, colour: charcoalInk),
              proseLine('IS NOT: a SemanticsAction (those flow IN to Flutter).',
                  size: 12.5, colour: rustEmber),
              proseLine('IS NOT: a SemanticsConfiguration (state, not pulse).',
                  size: 12.5, colour: rustEmber),
              proseLine('IS NOT: persistent (no replay, no buffer).',
                  size: 12.5, colour: rustEmber),
              proseLine('IS NOT: a substitute for proper semantic labels.',
                  size: 12.5, colour: rustEmber),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 :: THE FAMILY OF EVENTS — one card per concrete subclass
  // -------------------------------------------------------------------------
  // Each card carries: subclass name, constructor signature, the type
  // string, an example use, and a sample toMap() rendered as a code block.
  // Cards are stacked vertically so each one can breathe.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 03 :: family catalogue.');

  Widget familyCard({
    required String className,
    required String constructorSignature,
    required String typeString,
    required String typicalUse,
    required String sampleCall,
    required Map<String, dynamic> sampleMap,
    required Color accent,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: fogPale,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.bolt, color: fogPale, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    className,
                    style: TextStyle(
                      color: fogPale,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                bandedLabel('type: "$typeString"', fogPale, charcoalInk),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONSTRUCTOR',
                  style: TextStyle(
                    color: brassFitting,
                    fontWeight: FontWeight.w800,
                    fontSize: 10.5,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                codeBlock(constructorSignature),
                const SizedBox(height: 12),
                Text(
                  'TYPICAL USE',
                  style: TextStyle(
                    color: brassFitting,
                    fontWeight: FontWeight.w800,
                    fontSize: 10.5,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                proseLine(typicalUse, size: 13),
                const SizedBox(height: 8),
                Text(
                  'SAMPLE CALL',
                  style: TextStyle(
                    color: brassFitting,
                    fontWeight: FontWeight.w800,
                    fontSize: 10.5,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                codeBlock(sampleCall, background: charcoalInk),
                const SizedBox(height: 12),
                Text(
                  'SAMPLE toMap()',
                  style: TextStyle(
                    color: brassFitting,
                    fontWeight: FontWeight.w800,
                    fontSize: 10.5,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: fogMist,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: brassFitting),
                  ),
                  child: Text(
                    sampleMap.isEmpty
                        ? '{} // empty map; type carries all info'
                        : _renderMapPretty(sampleMap),
                    style: TextStyle(
                      color: charcoalInk,
                      fontFamily: 'monospace',
                      fontSize: 12,
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
  }

  final Widget familyCatalogue = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('03', 'The Family of Events', seaDeep),
        proseLine(
          'Five concrete subclasses populate the SemanticsEvent family. '
          'Each card below shows the constructor signature, the on-the-wire '
          'type string, a typical use, and a sample serialised payload.',
        ),
        const SizedBox(height: 10),
        familyCard(
          className: 'AnnounceSemanticsEvent',
          constructorSignature:
              'AnnounceSemanticsEvent(\n  String message,\n  TextDirection textDirection, {\n  Assertiveness assertiveness = Assertiveness.polite,\n});',
          typeString: 'announce',
          typicalUse:
              'Force the screen reader to speak a string immediately. Useful '
              'for ephemeral state changes like toasts, snackbars, and '
              'progress milestones that have no natural focus target.',
          sampleCall:
              'SemanticsService.announce(\n  "Save complete",\n  TextDirection.ltr,\n);',
          sampleMap: mapAnnounceBeaconRotating,
          accent: seaDeep,
        ),
        familyCard(
          className: 'TooltipSemanticsEvent',
          constructorSignature: 'TooltipSemanticsEvent(\n  String message,\n);',
          typeString: 'tooltip',
          typicalUse:
              'Read a tooltip aloud out-of-band. Largely superseded by the '
              'SemanticsProperties.tooltip field, but still available for '
              'cases where a tooltip is rendered without a Tooltip widget.',
          sampleCall:
              'SemanticsService.tooltip("Rotate the beacon lamp");',
          sampleMap: mapTooltipLamp,
          accent: seaSwell,
        ),
        familyCard(
          className: 'TapSemanticEvent',
          constructorSignature: 'TapSemanticEvent();',
          typeString: 'tap',
          typicalUse:
              'Synthetic confirmation that "this widget was just tapped". '
              'Emit when a custom gesture has effectively performed a tap '
              'but no native InkWell or GestureDetector has fired the '
              'standard SemanticsAction.tap.',
          sampleCall:
              'owner.sendSemanticsEvent(\n  node.id,\n  TapSemanticEvent(),\n);',
          sampleMap: mapTapBeacon,
          accent: brassFitting,
        ),
        familyCard(
          className: 'LongPressSemanticsEvent',
          constructorSignature: 'LongPressSemanticsEvent();',
          typeString: 'longPress',
          typicalUse:
              'Synthetic confirmation that a long-press has occurred. The '
              'AT may respond by playing a different audio cue than for a '
              'standard tap, signalling the heavier interaction.',
          sampleCall:
              'owner.sendSemanticsEvent(\n  node.id,\n  LongPressSemanticsEvent(),\n);',
          sampleMap: mapLongPressBeacon,
          accent: rustEmber,
        ),
        familyCard(
          className: 'FocusSemanticEvent',
          constructorSignature: 'FocusSemanticEvent();',
          typeString: 'focus',
          typicalUse:
              'Move the screen-reader cursor to the target SemanticsNode '
              'without changing input focus. Useful when a modal opens and '
              'you want the AT to begin reading from a particular header.',
          sampleCall:
              'owner.sendSemanticsEvent(\n  headerNode.id,\n  FocusSemanticEvent(),\n);',
          sampleMap: mapFocusToLamp,
          accent: mossGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 :: ANATOMY OF A PULSE — widget -> node -> engine -> AT
  // -------------------------------------------------------------------------
  // We illustrate the journey of a single SemanticsEvent through the
  // Flutter stack. This is not a literal flowchart widget; it is a
  // four-pane "stations of the cross" that the reader can scan top-to-bottom.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 04 :: anatomy of a pulse.');

  Widget pulseStation(String label, String body, IconData icon, Color band) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: fogPale,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: band, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 64,
            decoration: BoxDecoration(
              color: band,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7),
                bottomLeft: Radius.circular(7),
              ),
            ),
            child: Center(
              child: Icon(icon, color: fogPale, size: 28),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: charcoalInk,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: TextStyle(
                      color: charcoalInk,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget pulseAnatomy = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('04', 'Anatomy of a Pulse', seaSwell),
        proseLine(
          'When a widget decides to emit an accessibility event, the pulse '
          'travels through four stations before it is heard. Below: the '
          'beam is generated, focused, broadcast, and finally received.',
        ),
        const SizedBox(height: 10),
        pulseStation(
          'Station 1 :: Widget',
          'A widget builds and decides "this moment requires an '
              'announcement". It calls SemanticsService.announce(...) or '
              'constructs a SemanticsEvent directly.',
          Icons.widgets,
          seaDeep,
        ),
        pulseStation(
          'Station 2 :: SemanticsNode',
          'The event is associated with a SemanticsNode (often the root '
              'node for announcements; a specific node for tap / focus). '
              'The node\'s id becomes the pulse target.',
          Icons.account_tree,
          brassFitting,
        ),
        pulseStation(
          'Station 3 :: Engine bridge',
          'SemanticsOwner.sendSemanticsEvent(nodeId, event) serialises the '
              'event\'s toMap() and posts it on the flutter/accessibility '
              'platform channel. The Flutter engine forwards it to native.',
          Icons.cell_tower,
          beaconCore,
        ),
        pulseStation(
          'Station 4 :: Assistive Technology',
          'The host AT (TalkBack, VoiceOver, NVDA, JAWS, ChromeVox, Orca) '
              'decodes the pulse and, depending on user settings, speaks, '
              'shows on a braille display, or plays a haptic cue.',
          Icons.hearing,
          mossGreen,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: charcoalInk,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '// pseudo-flow:\n'
            'widget.build(context)\n'
            '   -> SemanticsService.announce("Saved", TextDirection.ltr)\n'
            '      -> SemanticsBinding.instance.platformDispatcher.\n'
            '         sendSemanticsEvent(rootNodeId, event)\n'
            '            -> engine -> host AT -> speech / braille / haptic.',
            style: TextStyle(
              color: beaconCore,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 :: ANNOUNCEMENT THEATRE — five themed announcements
  // -------------------------------------------------------------------------
  // Each announcement is rendered as a card with: lamp glyph, message,
  // text direction, and the toMap() shown beneath.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 05 :: announcement theatre.');

  Widget announcementCard(
    AnnounceSemanticsEvent event,
    Map<String, dynamic> map,
    String narrative,
    Color glow,
  ) {
    final String message = (map['message'] as String?) ?? '';
    final String direction = (map['textDirection']?.toString()) ?? '?';
    final String assertiveness =
        (map['assertiveness']?.toString()) ?? '(unset)';
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [seaDeep, charcoalInk],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: glow, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [beaconFlare, glow, charcoalInk],
              ),
              boxShadow: [
                BoxShadow(
                  color: glow.withValues(alpha: 0.55),
                  blurRadius: 18,
                ),
              ],
            ),
            child: Center(
              child: Icon(Icons.campaign, color: charcoalInk, size: 26),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: fogPale,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  narrative,
                  style: TextStyle(
                    color: seaFoam,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    bandedLabel('type: ${event.type}', beaconCore, charcoalInk),
                    bandedLabel(
                        'direction: $direction', brassPolished, charcoalInk),
                    bandedLabel('assertiveness: $assertiveness',
                        seaFoam, charcoalInk),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget announcementTheatre = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogPale,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('05', 'Announcement Theatre', beaconCore),
        proseLine(
          'Five hand-authored AnnounceSemanticsEvent instances, each one a '
          'pulse the keeper might emit during a single foggy night shift. '
          'Notice how the message is short, direct, and unambiguous — the '
          'AT does not buffer announcements, so each must stand alone.',
        ),
        const SizedBox(height: 10),
        announcementCard(
          announceBeaconRotating,
          mapAnnounceBeaconRotating,
          'The lamp begins its first rotation of the watch. Sighted lookouts '
          'see the beam sweep; the AT must hear it begin.',
          beaconCore,
        ),
        announcementCard(
          announceFogHorn,
          mapAnnounceFogHorn,
          'Visibility drops below the safe threshold. The fog horn is '
          'engaged, and the AT announces the audible signal.',
          rustEmber,
        ),
        announcementCard(
          announceVesselApproaching,
          mapAnnounceVessel,
          'Radar reports a vessel approaching from the south-east. The '
          'announcement gives the AT user the same situational awareness.',
          tealCipher,
        ),
        announcementCard(
          announceKeeperOnDuty,
          mapAnnounceKeeper,
          'The keeper has begun their shift; the system announces it so '
          'audit trails align across modalities.',
          mossGreen,
        ),
        announcementCard(
          announceAllClear,
          mapAnnounceAllClear,
          'Visibility restored, harbour open. A single calm announcement '
          'closes the incident loop.',
          beaconFlare,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 :: TOOLTIP / TAP / LONGPRESS — sequenced rows
  // -------------------------------------------------------------------------
  // We show how a single button can produce a sequence of three different
  // SemanticsEvents over its lifetime: tooltip on hover, tap on activation,
  // longPress on extended activation.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 06 :: tooltip / tap / longpress.');

  Widget sequenceRow({
    required String stage,
    required String description,
    required String typeString,
    required Map<String, dynamic> sample,
    required IconData icon,
    required Color accent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: fogPale,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(icon, color: fogPale, size: 24),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage,
                  style: TextStyle(
                    color: charcoalInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: stormGray,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              bandedLabel('type: $typeString', accent, fogPale),
              const SizedBox(height: 4),
              bandedLabel(
                sample.isEmpty ? 'toMap: {}' : 'toMap: $sample',
                fogMist,
                charcoalInk,
              ),
            ],
          ),
        ],
      ),
    );
  }

  final Widget tttSection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('06', 'Tooltip / Tap / LongPress', brassFitting),
        proseLine(
          'A single button — say, the BEACON ROTATE button on the keeper\'s '
          'console — can be the source of three distinct SemanticsEvents '
          'during a session. Below: the lifecycle of one button, in three '
          'pulses.',
        ),
        const SizedBox(height: 10),
        sequenceRow(
          stage: 'Stage 1 :: Hover / explore-by-touch',
          description:
              'The user explores the screen. The AT highlights the BEACON '
              'ROTATE button and reads its tooltip. A TooltipSemanticsEvent '
              'fires with message = "Rotate the beacon lamp".',
          typeString: tooltipLamp.type,
          sample: mapTooltipLamp,
          icon: Icons.touch_app,
          accent: seaSwell,
        ),
        sequenceRow(
          stage: 'Stage 2 :: Tap',
          description:
              'The user double-taps to activate. After the custom gesture '
              'fires, our code emits a TapSemanticEvent so the AT confirms '
              'the action acoustically.',
          typeString: tapBeacon.type,
          sample: mapTapBeacon,
          icon: Icons.radio_button_checked,
          accent: beaconCore,
        ),
        sequenceRow(
          stage: 'Stage 3 :: Long-press',
          description:
              'The user holds the button to access the configuration sheet. '
              'A LongPressSemanticsEvent confirms the heavier interaction; '
              'the AT plays a different audio cue from a normal tap.',
          typeString: longPressBeacon.type,
          sample: mapLongPressBeacon,
          icon: Icons.front_hand,
          accent: rustEmber,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: charcoalInk,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '// In code:\n'
            'final tooltip = TooltipSemanticsEvent("Rotate the beacon lamp");\n'
            'final tap     = TapSemanticEvent();\n'
            'final long    = LongPressSemanticsEvent();\n'
            '// dispatched via SemanticsOwner.sendSemanticsEvent(node.id, e).',
            style: TextStyle(
              color: beaconCore,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 :: FOCUS ROUTING — a navigation-tree mock
  // -------------------------------------------------------------------------
  // We render a small mock of a side-navigation tree, with three items, and
  // show how a FocusSemanticEvent can be dispatched to move the screen
  // reader cursor between them. This is purely visual; no real focus is
  // moved — the demo is a frozen snapshot.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 07 :: focus routing.');

  Widget focusItem(String label, String route, bool isCursor, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isCursor ? accent : fogPale,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isCursor ? beaconCore : stormGray.withValues(alpha: 0.4),
          width: isCursor ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isCursor ? Icons.my_location : Icons.location_searching,
            color: isCursor ? fogPale : stormGray,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isCursor ? fogPale : charcoalInk,
                fontWeight:
                    isCursor ? FontWeight.w800 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            route,
            style: TextStyle(
              color: isCursor ? fogMist : brassFitting,
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }

  final Widget focusRouting = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogPale,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('07', 'Focus Routing', mossGreen),
        proseLine(
          'When a modal opens, the screen-reader cursor often needs to be '
          'redirected to the modal\'s primary heading. Dispatching a '
          'FocusSemanticEvent at the heading\'s SemanticsNode achieves '
          'this without altering input focus.',
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: fogMist,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: stormGray.withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BEFORE :: cursor on first item',
                      style: TextStyle(
                        color: charcoalInk,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    focusItem('Lamp control', '/lamp', true, seaDeep),
                    focusItem('Fog horn',     '/fog',  false, seaDeep),
                    focusItem('Keeper log',   '/log',  false, seaDeep),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 36,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Icon(Icons.east, color: brassFitting, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: fogMist,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: stormGray.withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AFTER :: cursor moved to keeper log',
                      style: TextStyle(
                        color: charcoalInk,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    focusItem('Lamp control', '/lamp', false, seaDeep),
                    focusItem('Fog horn',     '/fog',  false, seaDeep),
                    focusItem('Keeper log',   '/log',  true, mossGreen),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: charcoalInk,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '// In code:\n'
            'final node = keeperLogNode; // SemanticsNode\n'
            'final event = FocusSemanticEvent();\n'
            'node.owner!.sendSemanticsEvent(node.id, event);\n'
            '// the AT cursor now reads "Keeper log" without input focus moving.',
            style: TextStyle(
              color: beaconCore,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 10),
        proseLine(
          'CAUTION: do not abuse FocusSemanticEvent. The screen-reader '
          'cursor is the user\'s reading position; moving it without their '
          'consent is intrusive. Reserve focus pulses for moments where the '
          'visible UI also moves the sighted user\'s attention.',
          colour: rustEmber,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 :: toMap INSPECTOR
  // -------------------------------------------------------------------------
  // For each event we built in section 0.1, we render the serialised map
  // as a key/value table. This is the on-the-wire view the engine sees
  // when it forwards the event to the platform channel.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 08 :: toMap inspector.');

  Widget toMapTable(String title, String typeStr, Map<String, dynamic> map,
      Color accent) {
    final List<MapEntry<String, dynamic>> entries = map.entries.toList();
    final List<Widget> rows = [];
    for (var i = 0; i < entries.length; i++) {
      final MapEntry<String, dynamic> entry = entries[i];
      rows.add(keyValueRow(entry.key, entry.value.toString()));
    }
    if (rows.isEmpty) {
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          '(empty map; the type field is sufficient)',
          style: TextStyle(
            color: stormGray,
            fontStyle: FontStyle.italic,
            fontSize: 12.5,
          ),
        ),
      ));
    }
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: fogPale,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: accent, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: charcoalInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              bandedLabel('type: "$typeStr"', accent, fogPale),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: fogMist,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows,
            ),
          ),
        ],
      ),
    );
  }

  final Widget mapInspector = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('08', 'toMap() Inspector', tealCipher),
        proseLine(
          'Each SemanticsEvent serialises its payload through toMap(). The '
          'tables below show the exact key/value pairs for every event we '
          'instantiated in this manual. AnnounceSemanticsEvent carries '
          'three keys (message, textDirection, assertiveness); '
          'TooltipSemanticsEvent carries one (message); the synthetic '
          'Tap / LongPress / Focus events carry none — their type field '
          'alone is sufficient to identify them.',
        ),
        const SizedBox(height: 10),
        toMapTable('announceBeaconRotating', announceBeaconRotating.type,
            mapAnnounceBeaconRotating, seaDeep),
        toMapTable('announceFogHorn', announceFogHorn.type,
            mapAnnounceFogHorn, rustEmber),
        toMapTable('announceVesselApproaching',
            announceVesselApproaching.type, mapAnnounceVessel, tealCipher),
        toMapTable('announceKeeperOnDuty', announceKeeperOnDuty.type,
            mapAnnounceKeeper, mossGreen),
        toMapTable('announceAllClear', announceAllClear.type,
            mapAnnounceAllClear, beaconFlare),
        toMapTable('tooltipLamp', tooltipLamp.type, mapTooltipLamp, seaSwell),
        toMapTable('tooltipFog', tooltipFog.type, mapTooltipFog, seaSwell),
        toMapTable('tooltipLog', tooltipLog.type, mapTooltipLog, seaSwell),
        toMapTable('tapBeacon', tapBeacon.type, mapTapBeacon, beaconCore),
        toMapTable('tapHorn', tapHorn.type, mapTapHorn, beaconCore),
        toMapTable('tapLog', tapLog.type, mapTapLog, beaconCore),
        toMapTable('longPressBeacon', longPressBeacon.type,
            mapLongPressBeacon, rustEmber),
        toMapTable('longPressFog', longPressFog.type, mapLongPressFog,
            rustEmber),
        toMapTable('focusToLamp', focusToLamp.type, mapFocusToLamp, mossGreen),
        toMapTable('focusToFog', focusToFog.type, mapFocusToFog, mossGreen),
        toMapTable('focusToLog', focusToLog.type, mapFocusToLog, mossGreen),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 :: PLATFORM ROUTING MATRIX
  // -------------------------------------------------------------------------
  // For every (event-kind, platform) pair, what does the host AT actually
  // do with it? This matrix shows the canonical translation.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 09 :: platform routing matrix.');

  Widget routingHeaderCell(String text, Color background, Color foreground) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: charcoalInk.withValues(alpha: 0.18)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w800,
          fontSize: 11.5,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget routingCell(String text, {Color? background}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: background ?? fogPale,
        border: Border.all(color: charcoalInk.withValues(alpha: 0.12)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: charcoalInk,
          fontSize: 11.5,
          height: 1.3,
        ),
      ),
    );
  }

  TableRow routingRow(String label, List<String> cells, Color rowAccent) {
    final List<Widget> children = [];
    children.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: rowAccent,
        border: Border.all(color: charcoalInk.withValues(alpha: 0.15)),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          color: fogPale,
          fontWeight: FontWeight.w800,
          fontSize: 11.5,
        ),
      ),
    ));
    for (var i = 0; i < cells.length; i++) {
      children.add(routingCell(cells[i]));
    }
    return TableRow(children: children);
  }

  final Widget routingMatrix = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogPale,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('09', 'Platform Routing Matrix', seaDeep),
        proseLine(
          'How the engine translates a SemanticsEvent into a host-platform '
          'notification. The cells describe the typical effect on each '
          'platform; specific AT software may render differently.',
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: stormGray.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.4),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(2),
            },
            children: [
              TableRow(children: [
                routingHeaderCell('Event', seaDeep, fogPale),
                routingHeaderCell('iOS / VoiceOver', seaSwell, fogPale),
                routingHeaderCell('Android / TalkBack', seaSwell, fogPale),
                routingHeaderCell('Web / ARIA', seaSwell, fogPale),
                routingHeaderCell('Desktop AT', seaSwell, fogPale),
              ]),
              routingRow('announce', [
                'UIAccessibility.post(notification: .announcement)',
                'AccessibilityManager.interrupt then announce',
                'aria-live region update (polite or assertive)',
                'SAPI / ATK / NSAccessibility announcement',
              ], seaDeep),
              routingRow('tooltip', [
                'VoiceOver reads the tooltip string',
                'TalkBack reads as content description',
                'aria-describedby update',
                'Tooltip read on focus',
              ], seaSwell),
              routingRow('tap', [
                'Tap action confirmed by VoiceOver',
                'Tap confirmation sound + speak action',
                'Click event proxied to AT',
                'Action announced as "activated"',
              ], brassFitting),
              routingRow('longPress', [
                '"Activated" with long-press cue',
                'Long-press confirmation distinct from tap',
                'Custom event proxied; AT may differ',
                'Announced as "context activated"',
              ], rustEmber),
              routingRow('focus', [
                'VoiceOver cursor jumps; "Focused on ..."',
                'TalkBack focus moves; reads node text',
                'aria-activedescendant or .focus()',
                'AT cursor moves; reads new node',
              ], mossGreen),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 :: ACCESSIBILITY CHECKLIST — DO and AVOID
  // -------------------------------------------------------------------------
  // Twelve rules the careful keeper observes. We split them into two
  // colour-coded columns: green for DO, ember for AVOID.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 10 :: accessibility checklist.');

  Widget checkBullet(String text, IconData icon, Color accent,
      {Color? textColour}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColour ?? charcoalInk,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget checklist = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogMist,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('10', 'The Keeper\'s Checklist', mossGreen),
        proseLine(
          'Twelve rules of practice. Six things to do; six to avoid. '
          'Print them, pin them to the lamp room wall.',
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: mossGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: mossGreen, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DO',
                      style: TextStyle(
                        color: mossGreen,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    checkBullet(
                        'Use SemanticsService.announce for ephemeral '
                        'state changes that have no natural focus target.',
                        Icons.check_circle,
                        mossGreen),
                    checkBullet(
                        'Pair every visible toast with an announcement so '
                        'sighted and non-sighted users see the same event.',
                        Icons.check_circle,
                        mossGreen),
                    checkBullet(
                        'Provide a TextDirection for every announcement so '
                        'the AT can pick a correct voice profile.',
                        Icons.check_circle,
                        mossGreen),
                    checkBullet(
                        'Use Assertiveness.assertive sparingly: it '
                        'interrupts the user\'s current reading.',
                        Icons.check_circle,
                        mossGreen),
                    checkBullet(
                        'Test announcements with the actual AT, not just '
                        'with the SemanticsDebugger.',
                        Icons.check_circle,
                        mossGreen),
                    checkBullet(
                        'Keep messages short (one sentence, no jargon, no '
                        'emoji).',
                        Icons.check_circle,
                        mossGreen),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: rustEmber.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: rustEmber, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AVOID',
                      style: TextStyle(
                        color: rustEmber,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    checkBullet(
                        'Spamming announcements every frame; the AT cannot '
                        'queue them and they overlap into noise.',
                        Icons.cancel,
                        rustEmber),
                    checkBullet(
                        'Using FocusSemanticEvent to forcibly steal cursor '
                        'attention without a corresponding visual cue.',
                        Icons.cancel,
                        rustEmber),
                    checkBullet(
                        'Embedding emoji or rich punctuation in '
                        'announcements; many AT engines mispronounce them.',
                        Icons.cancel,
                        rustEmber),
                    checkBullet(
                        'Sending TapSemanticEvent when a native InkWell or '
                        'GestureDetector has already produced one.',
                        Icons.cancel,
                        rustEmber),
                    checkBullet(
                        'Treating SemanticsEvent as a substitute for proper '
                        'semantic labelling on widgets.',
                        Icons.cancel,
                        rustEmber),
                    checkBullet(
                        'Forgetting to localise announcement strings; the '
                        'AT speaks them verbatim.',
                        Icons.cancel,
                        rustEmber),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 :: GLOSSARY
  // -------------------------------------------------------------------------
  // A list of terms a new keeper needs. Sixteen entries, formatted as a
  // simple two-column read-out.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 11 :: glossary.');

  Widget glossaryEntry(String term, String definition) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: fogPale,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: stormGray.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            term,
            style: TextStyle(
              color: seaDeep,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 3),
          Text(
            definition,
            style: TextStyle(
              color: charcoalInk,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  final Widget glossary = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: fogPale,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: brassFitting),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('11', 'Glossary', brassPolished),
        proseLine(
          'Sixteen terms a new keeper learns in their first watch.',
        ),
        const SizedBox(height: 10),
        glossaryEntry('SemanticsEvent',
            'Abstract base class for accessibility events emitted from the '
                'Flutter engine to the host AT.'),
        glossaryEntry('AnnounceSemanticsEvent',
            'A SemanticsEvent that carries a string the AT should speak '
                'immediately. Maps to UIAccessibility.announcement on iOS.'),
        glossaryEntry('TooltipSemanticsEvent',
            'A SemanticsEvent that requests the AT speak a tooltip string '
                'out-of-band. Largely superseded by SemanticsProperties.tooltip.'),
        glossaryEntry('TapSemanticEvent',
            'Synthetic acknowledgement that "this widget was just tapped". '
                'Useful with custom gesture pipelines.'),
        glossaryEntry('LongPressSemanticsEvent',
            'Synthetic acknowledgement that "this widget was just '
                'long-pressed". Distinct audio cue on most ATs.'),
        glossaryEntry('FocusSemanticEvent',
            'Moves the AT cursor to a target SemanticsNode without changing '
                'input focus.'),
        glossaryEntry('SemanticsOwner',
            'Owns the semantics tree for a single render layer. Exposes '
                'sendSemanticsEvent(int nodeId, SemanticsEvent event).'),
        glossaryEntry('SemanticsNode',
            'A node in the semantics tree, mirroring (a subset of) the '
                'render tree. Each node has an id used to dispatch events.'),
        glossaryEntry('SemanticsService',
            'Convenience facade with announce(...) and tooltip(...) helpers '
                'that wrap the underlying SemanticsEvent dispatch.'),
        glossaryEntry('SemanticsAction',
            'IN-bound counterpart to SemanticsEvent: the AT telling Flutter '
                '"the user tapped this node".'),
        glossaryEntry('SemanticsConfiguration',
            'The bag of properties a widget exposes to the semantics tree '
                '(label, value, hint, flags, actions). Persistent state.'),
        glossaryEntry('Assertiveness',
            'Enum with .polite and .assertive, controlling whether an '
                'announcement interrupts the user\'s current reading.'),
        glossaryEntry('TextDirection',
            'LTR or RTL. Affects voice profile selection for announcements '
                'and reading order on bidirectional content.'),
        glossaryEntry('Accessibility channel',
            'The flutter/accessibility platform channel over which '
                'SemanticsEvent serialisations travel.'),
        glossaryEntry('AT (Assistive Technology)',
            'Software that consumes accessibility events: TalkBack, '
                'VoiceOver, NVDA, JAWS, ChromeVox, Orca, etc.'),
        glossaryEntry('SemanticsBinding',
            'The binding that wires the engine\'s accessibility surface to '
                'the framework\'s SemanticsOwner instances.'),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 12 :: RECAP FOOTER
  // -------------------------------------------------------------------------
  // The keeper\'s closing motto. A single calm paragraph and a row of
  // palette swatches as visual coda.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] composing section 12 :: recap footer.');

  final Widget recapFooter = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [seaDeep, charcoalInk],
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: brassPolished, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KEEPER\'S MOTTO',
          style: TextStyle(
            color: beaconCore,
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Every pulse is a promise. The lamp owes the ship a steady, '
          'legible signal — not a flood of light, not a flicker, but a '
          'cadence of small, well-formed events the navigator can decode '
          'without effort. SemanticsEvent is the contract that keeps that '
          'promise. Build them deliberately, dispatch them sparingly, '
          'localise them honestly, and the harbour will stay open through '
          'every fog.',
          style: TextStyle(
            color: fogPale,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 14),
        Container(height: 1, color: brassPolished),
        const SizedBox(height: 14),
        Row(
          children: [
            bandedLabel('end of manual', beaconCore, charcoalInk),
            const SizedBox(width: 6),
            bandedLabel('Lighthouse Beacon', fogPale, charcoalInk),
            const SizedBox(width: 6),
            bandedLabel('SemanticsEvent', seaFoam, charcoalInk),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // FINAL ASSEMBLY :: stitch every section into one scrollable column
  // -------------------------------------------------------------------------
  // We use a Scaffold with a SingleChildScrollView so the manual reads
  // top-to-bottom on any screen size. The body padding is generous so the
  // content does not feel cramped against the device edges.
  // -------------------------------------------------------------------------
  print('[lighthouse-beacon] assembling final tree (12 sections)...');

  final Widget body = Scaffold(
    backgroundColor: fogPale,
    appBar: AppBar(
      backgroundColor: seaDeep,
      foregroundColor: fogPale,
      elevation: 0,
      title: Text(
        'SemanticsEvent — Lighthouse Beacon',
        style: TextStyle(
          color: beaconCore,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          coverBanner,
          const SizedBox(height: 24),
          proseAnatomy,
          const SizedBox(height: 24),
          familyCatalogue,
          const SizedBox(height: 24),
          pulseAnatomy,
          const SizedBox(height: 24),
          announcementTheatre,
          const SizedBox(height: 24),
          tttSection,
          const SizedBox(height: 24),
          focusRouting,
          const SizedBox(height: 24),
          mapInspector,
          const SizedBox(height: 24),
          routingMatrix,
          const SizedBox(height: 24),
          checklist,
          const SizedBox(height: 24),
          glossary,
          const SizedBox(height: 24),
          recapFooter,
          const SizedBox(height: 24),
        ],
      ),
    ),
  );

  print('[lighthouse-beacon] manual ready :: returning the rendered tree.');
  print('[lighthouse-beacon] keeper signs off; the lamp continues to turn.');

  return body;
}

// =============================================================================
//  HELPER :: pretty-print a Map<String, dynamic> as a compact code block
// =============================================================================
//
// We render the toMap() outputs as a single string using this helper so the
// family-card section can show each subclass\'s payload in a uniform style.
// The function is intentionally simple — it does not handle nested maps,
// because no SemanticsEvent in this manual produces nested values. If a
// future subclass starts producing nested payloads, this helper should be
// extended to recurse.
// =============================================================================
String _renderMapPretty(Map<String, dynamic> map) {
  if (map.isEmpty) {
    return '{} // empty';
  }
  final List<MapEntry<String, dynamic>> entries = map.entries.toList();
  final StringBuffer buffer = StringBuffer();
  buffer.writeln('{');
  for (var i = 0; i < entries.length; i++) {
    final MapEntry<String, dynamic> entry = entries[i];
    final String comma = (i == entries.length - 1) ? '' : ',';
    buffer.writeln('  "${entry.key}": ${entry.value}$comma');
  }
  buffer.write('}');
  return buffer.toString();
}

// =============================================================================
//  END OF FILE  ::  Lighthouse Beacon — SemanticsEvent Field Manual
// =============================================================================

// D4rt test script: Deep visual demo of ObjectDisposed (foundation).
//
// =============================================================================
// ObjectDisposed Deep Demo
// -----------------------------------------------------------------------------
// `ObjectDisposed` is the lifecycle event signal that
// `FlutterMemoryAllocations` dispatches when a tracked object — for example a
// `ChangeNotifier`, `Stream`, or `RenderObject` — is disposed. It is the
// counterpart to `ObjectCreated`, and the pair together describe the lifetime
// of every memory-tracked allocation that flows through the Flutter engine.
//
// This script does not actually invoke `dispatchObjectDisposed`. Instead it
// renders an information-dense visual explanation of the event, the registry
// that fans it out, the consumers (DevTools, custom listeners), and the
// caveats developers must remember when wiring leak detectors or allocation
// dashboards on top of it.
//
// The widget tree is intentionally pure: there is no state, no animation
// driver, no async work. Every visual is built from `Container`, `Column`,
// `Row`, `Wrap`, `Text`, `Icon`, and `Stack`, with a single shared palette so
// that the eleven sections share a single visual language.
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// PALETTE
// -----------------------------------------------------------------------------
// Charcoal-and-coal base, with emerald accent for the "disposed!" highlight
// and amber for warnings/caveats. Every section reaches into this palette
// rather than hard-coding colours inline.
// -----------------------------------------------------------------------------

const Color kCoalBlack = Color(0xFF0E0E10);
const Color kCoalDeep = Color(0xFF1A1A1F);
const Color kCoalMid = Color(0xFF26262E);
const Color kCoalSoft = Color(0xFF35353F);
const Color kCoalEdge = Color(0xFF4A4A56);
const Color kAshGrey = Color(0xFF6F6F7A);
const Color kBoneWhite = Color(0xFFE8E8EE);
const Color kFogWhite = Color(0xFFC7C7CF);
const Color kEmeraldHi = Color(0xFF2EE6A8);
const Color kEmeraldMid = Color(0xFF14B97F);
const Color kEmeraldDeep = Color(0xFF0A7C56);
const Color kAmberHi = Color(0xFFFFB347);
const Color kAmberMid = Color(0xFFD98E2B);
const Color kRoseAccent = Color(0xFFE85A8C);
const Color kBlueIce = Color(0xFF6FB3FF);

// -----------------------------------------------------------------------------
// LAYOUT CONSTANTS
// -----------------------------------------------------------------------------

const double kSectionGap = 18.0;
const double kCardPadding = 18.0;
const double kCardRadius = 14.0;
const double kHeaderRadius = 22.0;
const double kBadgeRadius = 999.0;
const double kCodeFont = 12.5;
const double kBodyFont = 13.5;
const double kHeadingFont = 17.0;
const double kHeroTitleFont = 30.0;

// -----------------------------------------------------------------------------
// TEXT STYLES
// -----------------------------------------------------------------------------

const TextStyle kHeroTitle = TextStyle(
  color: kBoneWhite,
  fontSize: kHeroTitleFont,
  fontWeight: FontWeight.w800,
  letterSpacing: 1.4,
);

const TextStyle kHeroSubtitle = TextStyle(
  color: kFogWhite,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.6,
  height: 1.4,
);

const TextStyle kSectionHeading = TextStyle(
  color: kBoneWhite,
  fontSize: kHeadingFont,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.6,
);

const TextStyle kSectionLabel = TextStyle(
  color: kEmeraldHi,
  fontSize: 11.0,
  fontWeight: FontWeight.w700,
  letterSpacing: 1.6,
);

const TextStyle kBodyText = TextStyle(
  color: kFogWhite,
  fontSize: kBodyFont,
  fontWeight: FontWeight.w400,
  height: 1.45,
);

const TextStyle kBodyStrong = TextStyle(
  color: kBoneWhite,
  fontSize: kBodyFont,
  fontWeight: FontWeight.w600,
  height: 1.45,
);

const TextStyle kCodeText = TextStyle(
  color: kEmeraldHi,
  fontSize: kCodeFont,
  fontFamily: 'monospace',
  height: 1.5,
);

const TextStyle kCodeKeyword = TextStyle(
  color: kRoseAccent,
  fontSize: kCodeFont,
  fontFamily: 'monospace',
  fontWeight: FontWeight.w700,
);

const TextStyle kCodeIdent = TextStyle(
  color: kBlueIce,
  fontSize: kCodeFont,
  fontFamily: 'monospace',
);

const TextStyle kCodeComment = TextStyle(
  color: kAshGrey,
  fontSize: kCodeFont,
  fontFamily: 'monospace',
  fontStyle: FontStyle.italic,
);

const TextStyle kChipText = TextStyle(
  color: kBoneWhite,
  fontSize: 11.5,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.4,
);

// -----------------------------------------------------------------------------
// REUSABLE BUILDER HELPERS
// -----------------------------------------------------------------------------
// Each section composes the page from these small primitives. The helpers
// take simple value parameters and return widgets, which keeps the section
// builders readable even though the page is dense.
// -----------------------------------------------------------------------------

Widget buildSectionFrame({
  required String label,
  required String title,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: kSectionGap / 2),
    padding: const EdgeInsets.all(kCardPadding),
    decoration: BoxDecoration(
      color: kCoalDeep,
      borderRadius: const BorderRadius.all(Radius.circular(kCardRadius)),
      border: const Border.fromBorderSide(BorderSide(color: kCoalEdge, width: 1.0)),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x66000000), blurRadius: 18.0, offset: Offset(0.0, 8.0)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(label, style: kSectionLabel),
        const SizedBox(height: 6.0),
        Text(title, style: kSectionHeading),
        const SizedBox(height: 14.0),
        body,
      ],
    ),
  );
}

Widget buildBadge(String text, Color background, Color foreground) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: const BorderRadius.all(Radius.circular(kBadgeRadius)),
      border: Border.fromBorderSide(BorderSide(color: foreground.withValues(alpha: 0.5), width: 1.0)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: foreground,
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget buildIconTile({
  required IconData icon,
  required Color iconBackground,
  required Color iconColor,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: const BoxDecoration(
      color: kCoalMid,
      borderRadius: BorderRadius.all(Radius.circular(kCardRadius)),
      border: Border.fromBorderSide(BorderSide(color: kCoalSoft, width: 1.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Icon(icon, color: iconColor, size: 22.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: kBodyStrong),
              const SizedBox(height: 4.0),
              Text(body, style: kBodyText),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCodeBlock(List<Widget> lines) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    decoration: BoxDecoration(
      color: kCoalBlack,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.fromBorderSide(BorderSide(color: kEmeraldDeep.withValues(alpha: 0.6), width: 1.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: lines,
    ),
  );
}

Widget buildCodeLine(List<TextSpan> spans) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: RichText(
      text: TextSpan(style: kCodeText, children: spans),
    ),
  );
}

Widget buildBulletRow(IconData icon, Color color, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0, right: 8.0),
          child: Icon(icon, color: color, size: 16.0),
        ),
        Expanded(child: Text(text, style: kBodyText)),
      ],
    ),
  );
}

Widget buildArrow({Color color = kAshGrey}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Icon(Icons.arrow_forward_rounded, color: color, size: 18.0),
  );
}

// =============================================================================
// SECTION 1: HERO HEADER
// -----------------------------------------------------------------------------
// Gradient deep-grey to coal, with the recycle / dispose icon and the title.
// The hero also exposes a compact summary line and two badges that establish
// the topic and its place in the API surface.
// =============================================================================

Widget buildHero() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
    padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kCoalEdge, kCoalDeep, kCoalBlack],
      ),
      borderRadius: const BorderRadius.all(Radius.circular(kHeaderRadius)),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: Color(0x99000000), blurRadius: 22.0, offset: Offset(0.0, 10.0)),
      ],
      border: Border.fromBorderSide(BorderSide(color: kEmeraldDeep.withValues(alpha: 0.7), width: 1.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 76.0,
          height: 76.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[kEmeraldMid, kEmeraldDeep],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: kEmeraldHi.withValues(alpha: 0.25), blurRadius: 18.0, spreadRadius: 1.0),
            ],
          ),
          child: const Icon(Icons.recycling_rounded, color: kBoneWhite, size: 42.0),
        ),
        const SizedBox(width: 22.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildBadge('foundation', kCoalSoft, kBoneWhite),
                  const SizedBox(width: 8.0),
                  buildBadge('lifecycle event', kEmeraldDeep, kEmeraldHi),
                ],
              ),
              const SizedBox(height: 10.0),
              const Text('ObjectDisposed', style: kHeroTitle),
              const SizedBox(height: 8.0),
              const Text(
                'Lifecycle signal dispatched by FlutterMemoryAllocations when a '
                'tracked object is released. The companion to ObjectCreated and '
                'the foundation of leak detection in DevTools.',
                style: kHeroSubtitle,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 2: CONCEPTUAL FLOW
// -----------------------------------------------------------------------------
// A horizontal diagram describing the journey of a tracked object: it is
// created, dispatched as `ObjectCreated`, observed live, eventually disposed,
// at which point the `ObjectDisposed` event is fanned out to listeners such
// as DevTools.
// =============================================================================

Widget buildFlowStep({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color accent,
  bool highlight = false,
}) {
  return Container(
    width: 138.0,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
    decoration: BoxDecoration(
      color: highlight ? kCoalSoft : kCoalMid,
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      border: Border.fromBorderSide(BorderSide(
        color: highlight ? accent : kCoalEdge,
        width: highlight ? 1.6 : 1.0,
      )),
      boxShadow: highlight
          ? <BoxShadow>[BoxShadow(color: accent.withValues(alpha: 0.25), blurRadius: 18.0)]
          : const <BoxShadow>[],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Icon(icon, color: accent, size: 22.0),
        ),
        const SizedBox(height: 10.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: kBodyStrong,
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: kAshGrey, fontSize: 11.0, height: 1.3),
        ),
      ],
    ),
  );
}

Widget buildConceptualFlow() {
  return buildSectionFrame(
    label: 'SECTION 02',
    title: 'Conceptual flow: how a disposal becomes a signal',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Every tracked object travels through six logical stations. Only two '
          'of them produce events on the FlutterMemoryAllocations bus: the '
          'creation and disposal moments. The rest are pure runtime states.',
          style: kBodyText,
        ),
        const SizedBox(height: 16.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildFlowStep(
                icon: Icons.add_circle_outline_rounded,
                title: 'Allocate',
                subtitle: 'constructor runs',
                accent: kBlueIce,
              ),
              buildArrow(),
              buildFlowStep(
                icon: Icons.bolt_rounded,
                title: 'ObjectCreated',
                subtitle: 'event dispatched',
                accent: kBlueIce,
              ),
              buildArrow(),
              buildFlowStep(
                icon: Icons.visibility_rounded,
                title: 'Live & tracked',
                subtitle: 'used by app',
                accent: kFogWhite,
              ),
              buildArrow(),
              buildFlowStep(
                icon: Icons.power_settings_new_rounded,
                title: 'Dispose called',
                subtitle: 'cleanup begins',
                accent: kAmberHi,
              ),
              buildArrow(color: kEmeraldHi),
              buildFlowStep(
                icon: Icons.recycling_rounded,
                title: 'ObjectDisposed',
                subtitle: 'event dispatched',
                accent: kEmeraldHi,
                highlight: true,
              ),
              buildArrow(),
              buildFlowStep(
                icon: Icons.delete_sweep_rounded,
                title: 'Garbage collected',
                subtitle: 'memory reclaimed',
                accent: kAshGrey,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kEmeraldDeep.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.fromBorderSide(BorderSide(color: kEmeraldDeep, width: 1.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.info_outline_rounded, color: kEmeraldHi, size: 18.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Disposal does not imply garbage collection. The Dart VM is '
                  'free to keep the memory live until the next collection. '
                  'ObjectDisposed signals intent, not the actual memory '
                  'reclamation moment.',
                  style: kBodyText.copyWith(color: kEmeraldHi),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3: ANATOMY
// -----------------------------------------------------------------------------
// A single card describing the three properties carried by `ObjectDisposed`:
// `library`, `className`, and `object`. Each row exposes the type and a short
// prose description.
// =============================================================================

Widget buildAnatomyRow({
  required String name,
  required String type,
  required String prose,
  required Color accent,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kCoalMid,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.fromBorderSide(BorderSide(color: accent.withValues(alpha: 0.5), width: 1.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        const SizedBox(width: 12.0),
        SizedBox(
          width: 110.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(name, style: kBodyStrong),
              const SizedBox(height: 4.0),
              Text(
                type,
                style: const TextStyle(
                  color: kBlueIce,
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(child: Text(prose, style: kBodyText)),
      ],
    ),
  );
}

Widget buildAnatomy() {
  return buildSectionFrame(
    label: 'SECTION 03',
    title: 'Anatomy of an ObjectDisposed event',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Each event carries the metadata required by DevTools to render a '
          'leak report and the original object reference for advanced '
          'consumers that want to walk the object graph or inspect runtime '
          'identity.',
          style: kBodyText,
        ),
        const SizedBox(height: 14.0),
        buildAnatomyRow(
          name: 'library',
          type: 'String',
          prose: 'The library where the object lives, in the form '
              '"package:flutter/foundation.dart". Used by DevTools to group '
              'allocations by package.',
          accent: kBlueIce,
        ),
        buildAnatomyRow(
          name: 'className',
          type: 'String',
          prose: 'The runtime class name as a stable identifier. Pre-baked '
              'so listeners do not need to call runtimeType.toString() on the '
              'hot path.',
          accent: kAmberHi,
        ),
        buildAnatomyRow(
          name: 'object',
          type: 'Object',
          prose: 'The disposed object itself. Listeners may keep a weak '
              'reference for diagnostics, but should never retain a strong '
              'one — that would defeat the very leak tracking the event '
              'enables.',
          accent: kEmeraldHi,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4: LIFECYCLE TIMELINE
// -----------------------------------------------------------------------------
// Five-phase vertical timeline highlighting the disposed phase with the
// emerald accent. Each phase has a description and a "produces event" tag.
// =============================================================================

Widget buildTimelinePhase({
  required String phase,
  required String name,
  required String description,
  required bool emitsEvent,
  required IconData icon,
  required Color accent,
  bool highlight = false,
  bool isLast = false,
}) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 56.0,
          child: Column(
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: highlight ? accent : kCoalSoft,
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  border: Border.fromBorderSide(BorderSide(
                    color: highlight ? accent : kCoalEdge,
                    width: 2.0,
                  )),
                ),
                child: Icon(
                  icon,
                  color: highlight ? kCoalBlack : kFogWhite,
                  size: 20.0,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.0,
                    color: kCoalEdge,
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 4.0, right: 0.0, bottom: isLast ? 0.0 : 12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: highlight ? accent.withValues(alpha: 0.12) : kCoalMid,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.fromBorderSide(BorderSide(
                color: highlight ? accent : kCoalEdge,
                width: 1.0,
              )),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      phase,
                      style: TextStyle(
                        color: kAshGrey,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    if (emitsEvent)
                      buildBadge(
                        'EMITS EVENT',
                        accent.withValues(alpha: 0.2),
                        accent,
                      ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(name, style: kBodyStrong),
                const SizedBox(height: 4.0),
                Text(description, style: kBodyText),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildLifecycleTimeline() {
  return buildSectionFrame(
    label: 'SECTION 04',
    title: 'Memory-allocation lifecycle timeline',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'A tracked object passes through five logical phases. Two of these '
          'phases (Created, Disposed) emit a corresponding lifecycle event '
          'onto the FlutterMemoryAllocations bus.',
          style: kBodyText,
        ),
        const SizedBox(height: 16.0),
        buildTimelinePhase(
          phase: 'PHASE 01',
          name: 'not-created',
          description: 'The class exists but no instance has been allocated. '
              'No memory is associated with the object yet.',
          emitsEvent: false,
          icon: Icons.crop_free_rounded,
          accent: kAshGrey,
        ),
        buildTimelinePhase(
          phase: 'PHASE 02',
          name: 'Created (event)',
          description: 'A constructor returned. FlutterMemoryAllocations '
              'fans out an ObjectCreated event with library, className, and '
              'the new object reference.',
          emitsEvent: true,
          icon: Icons.add_box_rounded,
          accent: kBlueIce,
        ),
        buildTimelinePhase(
          phase: 'PHASE 03',
          name: 'live',
          description: 'The object participates in the running app. Observers '
              'do not receive periodic events — only listeners from outside '
              'the registry observe state, e.g. via direct API calls.',
          emitsEvent: false,
          icon: Icons.flash_on_rounded,
          accent: kFogWhite,
        ),
        buildTimelinePhase(
          phase: 'PHASE 04',
          name: 'Disposed (event)',
          description: 'dispose() was invoked or the framework released the '
              'object. ObjectDisposed is dispatched. This is the moment '
              'leak detectors check whether the corresponding ObjectCreated '
              'was already paired with a previous Disposed.',
          emitsEvent: true,
          icon: Icons.recycling_rounded,
          accent: kEmeraldHi,
          highlight: true,
        ),
        buildTimelinePhase(
          phase: 'PHASE 05',
          name: 'garbage-collected',
          description: 'Some time later, the Dart VM reclaims the memory. '
              'No event is produced here — disposal and collection are '
              'deliberately decoupled.',
          emitsEvent: false,
          icon: Icons.delete_outline_rounded,
          accent: kAshGrey,
          isLast: true,
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5: TRACKED TYPES SHOWCASE
// -----------------------------------------------------------------------------
// A grid of chips for the eight Flutter types that participate in the
// allocations bus. Each chip carries an icon, the type name, and a tooltip
// (rendered as a soft caption beneath the chip).
// =============================================================================

Widget buildTrackedChip({
  required IconData icon,
  required String name,
  required String hint,
  required Color accent,
}) {
  return Container(
    width: 220.0,
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: kCoalMid,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.fromBorderSide(BorderSide(color: accent.withValues(alpha: 0.6), width: 1.0)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Icon(icon, color: accent, size: 18.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(name, style: kChipText),
              const SizedBox(height: 2.0),
              Text(
                hint,
                style: const TextStyle(color: kAshGrey, fontSize: 10.5, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTrackedTypes() {
  return buildSectionFrame(
    label: 'SECTION 05',
    title: 'Tracked types that produce ObjectDisposed',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Eight foundational Flutter types fire ObjectCreated and '
          'ObjectDisposed events through their constructors and dispose '
          'paths. Custom classes can opt in by manually invoking '
          'dispatchObjectCreated and dispatchObjectDisposed.',
          style: kBodyText,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            buildTrackedChip(
              icon: Icons.notifications_active_rounded,
              name: 'ChangeNotifier',
              hint: 'core listenable, leak risk',
              accent: kEmeraldHi,
            ),
            buildTrackedChip(
              icon: Icons.water_drop_rounded,
              name: 'Stream',
              hint: 'broadcast & single-sub',
              accent: kBlueIce,
            ),
            buildTrackedChip(
              icon: Icons.image_rounded,
              name: 'ImageCache entries',
              hint: 'evicted decoded images',
              accent: kAmberHi,
            ),
            buildTrackedChip(
              icon: Icons.layers_rounded,
              name: 'RenderObject',
              hint: 'paint & layout nodes',
              accent: kRoseAccent,
            ),
            buildTrackedChip(
              icon: Icons.hearing_rounded,
              name: 'Listenable',
              hint: 'Listenable/ValueListenable',
              accent: kEmeraldMid,
            ),
            buildTrackedChip(
              icon: Icons.swap_vert_rounded,
              name: 'ScrollController',
              hint: 'scroll position holder',
              accent: kBlueIce,
            ),
            buildTrackedChip(
              icon: Icons.center_focus_strong_rounded,
              name: 'FocusNode',
              hint: 'keyboard focus tree',
              accent: kAmberMid,
            ),
            buildTrackedChip(
              icon: Icons.movie_filter_rounded,
              name: 'AnimationController',
              hint: 'tickers & vsync',
              accent: kRoseAccent,
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 6: API SURFACE
// -----------------------------------------------------------------------------
// Two stacked code blocks rendered with `Container` + `RichText`: the first
// shows the dispatch call site, the second shows the listener pattern.
// =============================================================================

Widget buildApiSurface() {
  return buildSectionFrame(
    label: 'SECTION 06',
    title: 'API surface',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Two methods anchor the API: a dispatch call invoked from the '
          'object being released, and a listener registration on the '
          'singleton bus.',
          style: kBodyText,
        ),
        const SizedBox(height: 14.0),
        Text('Dispatching from a disposable owner', style: kBodyStrong),
        const SizedBox(height: 8.0),
        buildCodeBlock(<Widget>[
          buildCodeLine(<TextSpan>[
            TextSpan(text: '@override', style: kCodeKeyword),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: 'void ', style: kCodeKeyword),
            TextSpan(text: 'dispose', style: kCodeIdent),
            TextSpan(text: '() {'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '  FlutterMemoryAllocations', style: kCodeIdent),
            TextSpan(text: '.instance'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '      .dispatchObjectDisposed', style: kCodeIdent),
            TextSpan(text: '(object: '),
            TextSpan(text: 'this', style: kCodeKeyword),
            TextSpan(text: ');'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '  super', style: kCodeKeyword),
            TextSpan(text: '.dispose();'),
          ]),
          buildCodeLine(<TextSpan>[TextSpan(text: '}')]),
        ]),
        const SizedBox(height: 14.0),
        Text('Subscribing to the bus', style: kBodyStrong),
        const SizedBox(height: 8.0),
        buildCodeBlock(<Widget>[
          buildCodeLine(<TextSpan>[
            TextSpan(text: 'FlutterMemoryAllocations', style: kCodeIdent),
            TextSpan(text: '.instance.addListener('),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '  ('),
            TextSpan(text: 'MemoryAllocationsEvent ', style: kCodeIdent),
            TextSpan(text: 'event) {'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '    if', style: kCodeKeyword),
            TextSpan(text: ' (event '),
            TextSpan(text: 'is', style: kCodeKeyword),
            TextSpan(text: ' '),
            TextSpan(text: 'ObjectDisposed', style: kCodeIdent),
            TextSpan(text: ') {'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '      // event.library, event.className,', style: kCodeComment),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '      // event.object are now available.', style: kCodeComment),
          ]),
          buildCodeLine(<TextSpan>[TextSpan(text: '    }')]),
          buildCodeLine(<TextSpan>[TextSpan(text: '  },')]),
          buildCodeLine(<TextSpan>[TextSpan(text: ');')]),
        ]),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7: DEVTOOLS INTEGRATION
// -----------------------------------------------------------------------------
// A hand-drawn diagram showing the flow from FlutterMemoryAllocations to
// DevTools' "Memory" tab via the service protocol, ending in a leak summary.
// =============================================================================

Widget buildDevToolsBlock({
  required IconData icon,
  required String title,
  required String body,
  required Color accent,
}) {
  return Container(
    width: 200.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kCoalMid,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.fromBorderSide(BorderSide(color: accent.withValues(alpha: 0.6), width: 1.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 18.0),
            const SizedBox(width: 8.0),
            Expanded(child: Text(title, style: kBodyStrong)),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(body, style: kBodyText),
      ],
    ),
  );
}

Widget buildDevToolsIntegration() {
  return buildSectionFrame(
    label: 'SECTION 07',
    title: 'DevTools integration',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'DevTools subscribes to the same bus and projects the events into '
          'two visible surfaces: the "Memory" tab class chart, and the leak '
          'tracker overlay.',
          style: kBodyText,
        ),
        const SizedBox(height: 16.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildDevToolsBlock(
                icon: Icons.memory_rounded,
                title: 'Flutter app',
                body: 'Dispatches ObjectCreated and ObjectDisposed via the '
                    'FlutterMemoryAllocations bus during normal execution.',
                accent: kBlueIce,
              ),
              buildArrow(),
              buildDevToolsBlock(
                icon: Icons.cable_rounded,
                title: 'VM service',
                body: 'Delivers events as service-protocol notifications to '
                    'connected DevTools sessions.',
                accent: kAmberHi,
              ),
              buildArrow(),
              buildDevToolsBlock(
                icon: Icons.analytics_rounded,
                title: 'DevTools Memory',
                body: 'Tallies allocations per class. Uses ObjectDisposed to '
                    'decrement the live count for each class.',
                accent: kEmeraldHi,
              ),
              buildArrow(),
              buildDevToolsBlock(
                icon: Icons.bug_report_rounded,
                title: 'Leak summary',
                body: 'Surfaces classes whose ObjectCreated count outweighs '
                    'their ObjectDisposed count after a forced GC.',
                accent: kRoseAccent,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kCoalMid,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: const Border.fromBorderSide(BorderSide(color: kCoalSoft, width: 1.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.lightbulb_outline_rounded, color: kAmberHi, size: 18.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'DevTools never holds a strong reference to event.object. '
                  'It records (library, className) tuples and uses weak '
                  'references for object identity tracking, allowing the GC '
                  'to claim memory the dispatched event referred to.',
                  style: kBodyText,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8: CUSTOM SUBSCRIBER EXAMPLE
// -----------------------------------------------------------------------------
// A code block that shows how a developer would write a small per-class
// disposal counter and read it later to compare with the creation counter.
// =============================================================================

Widget buildCustomSubscriber() {
  return buildSectionFrame(
    label: 'SECTION 08',
    title: 'Custom subscriber: per-type disposal counter',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'A common pattern is to maintain a Map<String, int> keyed by '
          'className that records how many times each class fired '
          'ObjectDisposed. Compared against the equivalent ObjectCreated '
          'counter it gives a fast leak suspicion list.',
          style: kBodyText,
        ),
        const SizedBox(height: 14.0),
        buildCodeBlock(<Widget>[
          buildCodeLine(<TextSpan>[
            TextSpan(text: 'final', style: kCodeKeyword),
            TextSpan(text: ' '),
            TextSpan(text: 'Map', style: kCodeIdent),
            TextSpan(text: '<String, int> disposed = <String, int>{};'),
          ]),
          buildCodeLine(<TextSpan>[TextSpan(text: '')]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: 'void', style: kCodeKeyword),
            TextSpan(text: ' '),
            TextSpan(text: 'recordDisposal', style: kCodeIdent),
            TextSpan(text: '('),
            TextSpan(text: 'MemoryAllocationsEvent', style: kCodeIdent),
            TextSpan(text: ' event) {'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '  if', style: kCodeKeyword),
            TextSpan(text: ' (event '),
            TextSpan(text: 'is', style: kCodeKeyword),
            TextSpan(text: ' '),
            TextSpan(text: 'ObjectDisposed', style: kCodeIdent),
            TextSpan(text: ') {'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '    disposed.update('),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '      event.className,'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '      ('),
            TextSpan(text: 'int', style: kCodeIdent),
            TextSpan(text: ' n) => n + 1,'),
          ]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: '      ifAbsent: () => 1,'),
          ]),
          buildCodeLine(<TextSpan>[TextSpan(text: '    );')]),
          buildCodeLine(<TextSpan>[TextSpan(text: '  }')]),
          buildCodeLine(<TextSpan>[TextSpan(text: '}')]),
          buildCodeLine(<TextSpan>[TextSpan(text: '')]),
          buildCodeLine(<TextSpan>[
            TextSpan(text: 'FlutterMemoryAllocations', style: kCodeIdent),
            TextSpan(text: '.instance.addListener(recordDisposal);'),
          ]),
        ]),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kEmeraldDeep.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.fromBorderSide(BorderSide(color: kEmeraldDeep, width: 1.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.code_rounded, color: kEmeraldHi, size: 18.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'The same listener can branch on event.runtimeType to keep '
                  'separate counters for ObjectCreated and ObjectDisposed, '
                  'giving a real-time imbalance dashboard for the running '
                  'application.',
                  style: kBodyText.copyWith(color: kEmeraldHi),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 9: REAL-WORLD CONSUMER USE CASES
// -----------------------------------------------------------------------------
// Four cards: leak detector, dispose-without-create assertion, memory-pressure
// response, and allocation tracing. Each card carries an icon and prose.
// =============================================================================

Widget buildUseCaseCard({
  required IconData icon,
  required Color accent,
  required String title,
  required String body,
}) {
  return Container(
    width: 280.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kCoalMid,
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      border: Border.fromBorderSide(BorderSide(color: accent.withValues(alpha: 0.5), width: 1.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
              ),
              child: Icon(icon, color: accent, size: 20.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(child: Text(title, style: kBodyStrong)),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(body, style: kBodyText),
      ],
    ),
  );
}

Widget buildUseCases() {
  return buildSectionFrame(
    label: 'SECTION 09',
    title: 'Real-world consumers of ObjectDisposed',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Four production patterns sit on top of ObjectDisposed. Each uses '
          'the event for a slightly different purpose, and together they '
          'cover the leak-tracking design space.',
          style: kBodyText,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            buildUseCaseCard(
              icon: Icons.bug_report_rounded,
              accent: kEmeraldHi,
              title: 'Leak detector',
              body: 'After a forced GC, any object whose ObjectDisposed has '
                  'never fired but whose owner is unreachable is flagged as '
                  'a candidate leak.',
            ),
            buildUseCaseCard(
              icon: Icons.report_gmailerrorred_rounded,
              accent: kAmberHi,
              title: 'Dispose-without-create',
              body: 'Defensive assertion: catch tests where dispose() runs '
                  'twice or where dispose() is called for an object the '
                  'registry never observed creating.',
            ),
            buildUseCaseCard(
              icon: Icons.battery_alert_rounded,
              accent: kRoseAccent,
              title: 'Memory pressure response',
              body: 'Aggregating disposal rates over time is a cheap signal '
                  'for memory pressure; spikes can drive cache eviction or '
                  'preload pause behaviour.',
            ),
            buildUseCaseCard(
              icon: Icons.timeline_rounded,
              accent: kBlueIce,
              title: 'Allocation tracing',
              body: 'Pairing ObjectCreated with the matching ObjectDisposed '
                  'gives per-instance lifetimes, which can be visualised as '
                  'a flame chart in DevTools.',
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 10: CAVEATS
// -----------------------------------------------------------------------------
// Five cards covering the most common pitfalls when building tooling on top
// of ObjectDisposed.
// =============================================================================

Widget buildCaveatCard({
  required IconData icon,
  required Color accent,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kCoalMid,
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      border: Border.fromBorderSide(BorderSide(color: accent.withValues(alpha: 0.5), width: 1.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
          ),
          child: Icon(icon, color: accent, size: 20.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: kBodyStrong),
              const SizedBox(height: 4.0),
              Text(body, style: kBodyText),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCaveats() {
  return buildSectionFrame(
    label: 'SECTION 10',
    title: 'Caveats and gotchas',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Five facts that bite teams writing custom tooling on top of '
          'ObjectDisposed. None of them are bugs, but each surprises at '
          'least one developer per quarter.',
          style: kBodyText,
        ),
        const SizedBox(height: 14.0),
        buildCaveatCard(
          icon: Icons.power_settings_new_rounded,
          accent: kAmberHi,
          title: 'Events fire only when kFlutterMemoryAllocationsEnabled is true',
          body: 'In release mode the constant is false by default; the '
              'dispatch sites short-circuit and no listeners are notified. '
              'At the moment of compilation this build observed '
              'kFlutterMemoryAllocationsEnabled = '
              '${kFlutterMemoryAllocationsEnabled ? "true" : "false"}.',
        ),
        const SizedBox(height: 10.0),
        buildCaveatCard(
          icon: Icons.handyman_rounded,
          accent: kBlueIce,
          title: 'Debug-mode bias',
          body: 'Even when enabled, profile builds may discard events for '
              'performance. Treat the bus as a debugging-only signal unless '
              'the surrounding tooling explicitly opts in.',
        ),
        const SizedBox(height: 10.0),
        buildCaveatCard(
          icon: Icons.merge_type_rounded,
          accent: kEmeraldHi,
          title: 'Listener thread-safety',
          body: 'All events fire on the platform thread. Listeners must not '
              'block; offload heavy work to an Isolate or a microtask. '
              'Throwing from a listener is reported but does not abort the '
              'fan-out.',
        ),
        const SizedBox(height: 10.0),
        buildCaveatCard(
          icon: Icons.shuffle_rounded,
          accent: kRoseAccent,
          title: 'Ordering with ObjectCreated',
          body: 'ObjectCreated always arrives before ObjectDisposed for the '
              'same object, but unrelated events from other objects can '
              'interleave freely. Build state machines per-object, not '
              'globally.',
        ),
        const SizedBox(height: 10.0),
        buildCaveatCard(
          icon: Icons.delete_sweep_rounded,
          accent: kFogWhite,
          title: 'GC vs dispose distinction',
          body: 'ObjectDisposed marks the contractual end of an object — '
              'when its owner declared it done. The Dart VM may keep the '
              'underlying memory live until the next garbage collection, '
              'so the event is NOT a memory-reclamation signal.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 11: FOOTER
// -----------------------------------------------------------------------------
// Charcoal accent strip with takeaways and an evaluation marker.
// =============================================================================

Widget buildFooter() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
    padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kCoalDeep, kCoalBlack],
      ),
      borderRadius: const BorderRadius.all(Radius.circular(kHeaderRadius)),
      border: Border.fromBorderSide(BorderSide(color: kEmeraldDeep.withValues(alpha: 0.6), width: 1.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 26.0,
              decoration: const BoxDecoration(
                color: kEmeraldHi,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
            const SizedBox(width: 12.0),
            const Text('Takeaways', style: kSectionHeading),
          ],
        ),
        const SizedBox(height: 14.0),
        buildBulletRow(
          Icons.check_circle_outline_rounded,
          kEmeraldHi,
          'ObjectDisposed is a lifecycle event — not a memory-reclamation '
              'event. Pair it with ObjectCreated for full lifetimes.',
        ),
        buildBulletRow(
          Icons.check_circle_outline_rounded,
          kEmeraldHi,
          'It is dispatched through FlutterMemoryAllocations.instance — a '
              'singleton bus shared by the whole engine.',
        ),
        buildBulletRow(
          Icons.check_circle_outline_rounded,
          kEmeraldHi,
          'Listeners must be lightweight, weak-reference friendly, and '
              'aware of debug-only behaviour.',
        ),
        buildBulletRow(
          Icons.check_circle_outline_rounded,
          kEmeraldHi,
          'DevTools and custom dashboards consume the same event stream — '
              'so does your future leak detector.',
        ),
      ],
    ),
  );
}

// =============================================================================
// BUILD ENTRYPOINT
// -----------------------------------------------------------------------------
// Composes the eleven sections into a single SingleChildScrollView served by
// a Scaffold whose background is the deepest coal in the palette.
// =============================================================================

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kCoalBlack,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildHero(),
          buildConceptualFlow(),
          buildAnatomy(),
          buildLifecycleTimeline(),
          buildTrackedTypes(),
          buildApiSurface(),
          buildDevToolsIntegration(),
          buildCustomSubscriber(),
          buildUseCases(),
          buildCaveats(),
          buildFooter(),
        ],
      ),
    ),
  );
}

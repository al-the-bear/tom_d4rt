// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  BELL LAVENDER  --  A Campanile Keeper's Diary of ValueListenableBuilder
// =============================================================================
//
//  Theme        : Bell Lavender. Picture a stone bell tower at twilight, the
//                 air heavy with the scent of lavender from the cloister
//                 garden below, and a row of small brass bells hanging from
//                 ivory beams. Each bell, when struck, sends a single chime
//                 down the corridor; each chime is observed by an attentive
//                 keeper who notes the time, the pitch, and the bell that
//                 sounded. The bells are ValueListenables. The keepers are
//                 the builder callbacks. The chime-zones below are the
//                 widget subtrees that get rebuilt when a bell rings.
//
//  Subject      : `ValueListenableBuilder<T>` from package:flutter/widgets.dart.
//                 A widget that listens to a `ValueListenable<T>` and rebuilds
//                 its `builder` callback every time the value changes. Comes
//                 with an optional `child` parameter for the parts of the
//                 subtree that do NOT depend on the value, so they can be
//                 built once and reused across rebuilds.
//
//  Surface      : ValueListenableBuilder<T>({
//                   Key? key,
//                   required ValueListenable<T> valueListenable,
//                   required ValueWidgetBuilder<T> builder,
//                   Widget? child,
//                 });
//
//                 typedef ValueWidgetBuilder<T> =
//                   Widget Function(BuildContext context, T value, Widget? child);
//
//  Companion    : `ValueNotifier<T>` is the canonical concrete
//                 ValueListenable. It stores a single value and notifies
//                 listeners whenever that value is reassigned to a new
//                 instance (using == for comparison). Other ValueListenables
//                 include `Animation<double>` (the readonly Listenable
//                 produced by an AnimationController) and any custom class
//                 mixing in `ChangeNotifier` and exposing a `value` getter.
//
//  D4rt notes   : `build()` is invoked exactly ONCE under the d4rt smoke
//                 harness. The returned widget tree is rendered as a static
//                 snapshot. We construct ValueNotifier instances inside
//                 build(), but we do NOT mutate them after the first frame:
//                 no `notifier.value = x`, no setState, no notifyListeners,
//                 no dispose. Every ValueListenableBuilder fires its builder
//                 ONCE during the initial render and that single rendered
//                 tree is what the harness inspects. There are no
//                 StatefulWidgets, no AnimationControllers, no scroll or
//                 text controllers, no timers, no streams, no futures.
//                 Indexed `for (int i = 0; ...)` loops only -- no for-in
//                 over BridgedInstance values. No `.value` reads on
//                 Tween.animate -- use `.transform(t)`. Alpha colours use
//                 `.withValues(alpha: ...)` instead of withOpacity.
//
//  Audience     : Flutter engineers wiring observable state into a tree,
//                 anyone weighing ValueListenableBuilder against
//                 ListenableBuilder / AnimatedBuilder / StreamBuilder, and
//                 the curious reader of the Tom AI flutter ast harness who
//                 wants to see ten variants of the same widget rendered as
//                 brass bells in a campanile rather than as a generic chip
//                 row.
//
//  Length goal  : 1900+ lines so the harness can stretch its legs and the
//                 reader can leaf through the file like a small bound diary.
//
// -----------------------------------------------------------------------------
//  Bell Lavender palette
// -----------------------------------------------------------------------------
//    lavenderPale     #E8DFF4  morning light on the bell-rope
//    lavenderSoft     #C9B6E0  cushion under each bell
//    lavenderMid      #9B7DC3  middle-tone of the cloister wall
//    lavenderDeep     #6E4FA0  deep purple of the bell shadow
//    lavenderInk      #3E2A66  ink used for the keeper's marginalia
//    brassBell        #C9A464  polished brass face of a bell
//    brassDeep        #8C6B2C  shadow on the lip of the bell
//    brassGlow        #E5C68C  highlight on the curved brass surface
//    ivoryFrame       #F4ECDD  ivory beam from which the bells hang
//    ivoryShadow      #C8B98A  the underside of the ivory beam
//    chimeMint        #B6CFA8  pale green halo of a freshly-struck chime
//    chimeRose        #E5B6BD  a rose-tinted chime late in the day
//    chimeSky         #A8C2DA  the cool blue chime of the dawn bell
//    stoneCool        #B0A8B8  cool stone of the tower wall
//    stoneWarm        #A89A82  warmer stone where the sun has bleached it
//    parchmentBell    #F8F1E0  parchment of the keeper's notebook
//    inkDeep          #2E2440  the deepest ink
//    inkSoft          #5C4D7A  softer ink for sub-headings
//    accentRope       #8C6F3A  the bell-rope itself
//
// -----------------------------------------------------------------------------
//  Diagram (rendered later as a series of cards):
//
//      +---------------------+         +-------------------------+
//      |   ValueNotifier<T>  |  ---->  |   ValueListenableBuilder|
//      |   (the bell)        |  rings  |   (the keeper)          |
//      |   .value : T        |         |   builder(ctx, T, child)|
//      |   addListener(...)  |         |   child? : Widget       |
//      |   removeListener... |         |                         |
//      +---------------------+         +-------------------------+
//                                            |
//                                            v
//                                      Element.markNeedsBuild()
//                                      => _BuilderState builds again
//                                      => new Widget subtree
//
//  When the bell rings (notifier.value = newValue), the
//  ValueListenableBuilder's State object hears it via _valueChanged, calls
//  setState which marks its Element dirty, and on the next frame the
//  builder callback runs again -- but ONLY the builder callback. The
//  widget passed via `child` is captured in the State's `widget.child`
//  field and is reused across rebuilds. That is the optimisation: the
//  child subtree's Element is not rebuilt, only re-parented.
//
//  In d4rt we never reach the second frame, so the optimisation is
//  invisible at runtime; we exercise it for shape only.
//
// =============================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Bell Lavender palette -- one declaration, used everywhere below.
// ---------------------------------------------------------------------------
const Color cLavenderPale = Color(0xFFE8DFF4);
const Color cLavenderSoft = Color(0xFFC9B6E0);
const Color cLavenderMid = Color(0xFF9B7DC3);
const Color cLavenderDeep = Color(0xFF6E4FA0);
const Color cLavenderInk = Color(0xFF3E2A66);
const Color cBrassBell = Color(0xFFC9A464);
const Color cBrassDeep = Color(0xFF8C6B2C);
const Color cBrassGlow = Color(0xFFE5C68C);
const Color cIvoryFrame = Color(0xFFF4ECDD);
const Color cIvoryShadow = Color(0xFFC8B98A);
const Color cChimeMint = Color(0xFFB6CFA8);
const Color cChimeRose = Color(0xFFE5B6BD);
const Color cChimeSky = Color(0xFFA8C2DA);
const Color cStoneCool = Color(0xFFB0A8B8);
const Color cStoneWarm = Color(0xFFA89A82);
const Color cParchmentBell = Color(0xFFF8F1E0);
const Color cInkDeep = Color(0xFF2E2440);
const Color cInkSoft = Color(0xFF5C4D7A);
const Color cAccentRope = Color(0xFF8C6F3A);

// ---------------------------------------------------------------------------
// Typography helpers. The keeper's diary uses one serif for prose and one
// monospaced face for code. We do not load any custom fonts -- those
// constants would not survive the d4rt bridge -- but we set fontFamily
// strings so the rendered tree shows the intent.
// ---------------------------------------------------------------------------
const String kSerif = 'Georgia';
const String kMono = 'Courier New';

TextStyle headingStyle({double size = 22, Color color = cInkDeep}) {
  return TextStyle(
    fontFamily: kSerif,
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: 0.4,
    height: 1.2,
  );
}

TextStyle subheadingStyle({double size = 16, Color color = cLavenderDeep}) {
  return TextStyle(
    fontFamily: kSerif,
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.3,
    height: 1.25,
  );
}

TextStyle proseStyle({double size = 13, Color color = cInkSoft}) {
  return TextStyle(
    fontFamily: kSerif,
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: color,
    height: 1.5,
  );
}

TextStyle italicStyle({double size = 13, Color color = cLavenderInk}) {
  return TextStyle(
    fontFamily: kSerif,
    fontSize: size,
    fontStyle: FontStyle.italic,
    color: color,
    height: 1.45,
  );
}

TextStyle codeStyle({double size = 12, Color color = cInkDeep}) {
  return TextStyle(
    fontFamily: kMono,
    fontSize: size,
    color: color,
    height: 1.45,
  );
}

TextStyle labelStyle({double size = 11, Color color = cBrassDeep}) {
  return TextStyle(
    fontFamily: kSerif,
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.5,
  );
}

// ---------------------------------------------------------------------------
// A small data class used by one of the ValueNotifier examples below. The
// keeper notes a chime by its index, its pitch, and the colour of its halo.
// We deliberately keep this immutable so the equality semantics match what
// ValueNotifier expects.
// ---------------------------------------------------------------------------
class ChimeNote {
  final int index;
  final String pitch;
  final Color halo;
  const ChimeNote(this.index, this.pitch, this.halo);

  @override
  String toString() => 'ChimeNote(#$index, $pitch)';
}

// ---------------------------------------------------------------------------
// SectionHeader -- a single horizontal band with a Roman numeral, a title,
// and a subtitle. Used to open every major section of the diary so the
// reader knows which "chapter" of the campanile they have entered.
// ---------------------------------------------------------------------------
Widget sectionHeader({
  required String numeral,
  required String title,
  required String subtitle,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 28, bottom: 14),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      color: cIvoryFrame,
      border: Border(
        left: BorderSide(color: cLavenderDeep, width: 4),
        top: BorderSide(color: cIvoryShadow, width: 1),
        bottom: BorderSide(color: cIvoryShadow, width: 1),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: cLavenderDeep,
            shape: BoxShape.circle,
            border: Border.all(color: cBrassBell, width: 2),
          ),
          child: Text(
            numeral,
            style: TextStyle(
              fontFamily: kSerif,
              color: cParchmentBell,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: headingStyle(size: 22)),
              const SizedBox(height: 4),
              Text(subtitle, style: italicStyle(size: 13)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// proseParagraph -- a block of the keeper's prose, padded and styled
// uniformly. Used liberally to fill the file with explanatory text. We
// pass the raw string so each section can speak in its own voice.
// ---------------------------------------------------------------------------
Widget proseParagraph(String text, {EdgeInsets? margin}) {
  return Container(
    margin: margin ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
    child: Text(text, style: proseStyle()),
  );
}

// ---------------------------------------------------------------------------
// codeBlock -- a charcoal-on-parchment block of code. The keeper pastes
// snippets from the framework source into the margin of the diary so the
// reader can compare prose against API surface.
// ---------------------------------------------------------------------------
Widget codeBlock(String code, {String? caption}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    decoration: BoxDecoration(
      color: cInkDeep,
      border: Border.all(color: cLavenderDeep, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (caption != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: cLavenderDeep,
            child: Text(
              caption,
              style: TextStyle(
                fontFamily: kMono,
                fontSize: 11,
                color: cParchmentBell,
                letterSpacing: 0.4,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: kMono,
              fontSize: 11.5,
              color: cParchmentBell,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// keeperMargin -- a single italic note in a thin lavender frame, like
// margin commentary in an old book. Used as a visual breather between
// heavier sections.
// ---------------------------------------------------------------------------
Widget keeperMargin(String note) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: cLavenderPale,
      border: Border(
        left: BorderSide(color: cLavenderMid, width: 3),
      ),
    ),
    child: Text(note, style: italicStyle(size: 12, color: cLavenderInk)),
  );
}

// ---------------------------------------------------------------------------
// brassPlaque -- a small brass-coloured caption used to label a bell with
// its pitch and its keeper's name.
// ---------------------------------------------------------------------------
Widget brassPlaque(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: cBrassBell,
      border: Border.all(color: cBrassDeep, width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: kSerif,
        fontSize: 10,
        color: cInkDeep,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// bellShape -- draws a small, stylised bell using nested Containers. The
// shape is purely decorative and deterministic, so the d4rt harness
// renders the same shape every time.
// ---------------------------------------------------------------------------
Widget bellShape({double size = 60, Color body = cBrassBell, Color rim = cBrassDeep}) {
  return Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // The bell body
        Container(
          width: size * 0.85,
          height: size * 0.7,
          decoration: BoxDecoration(
            color: body,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size * 0.4),
              topRight: Radius.circular(size * 0.4),
              bottomLeft: Radius.circular(size * 0.1),
              bottomRight: Radius.circular(size * 0.1),
            ),
            border: Border.all(color: rim, width: 1.2),
          ),
        ),
        // The hanger at the top
        Positioned(
          top: 0,
          child: Container(
            width: size * 0.12,
            height: size * 0.18,
            decoration: BoxDecoration(
              color: cAccentRope,
              borderRadius: BorderRadius.circular(size * 0.04),
            ),
          ),
        ),
        // The clapper
        Positioned(
          bottom: size * 0.05,
          child: Container(
            width: size * 0.12,
            height: size * 0.12,
            decoration: BoxDecoration(
              color: cBrassDeep,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// chimeHalo -- a soft horizontal band that wraps a builder's output in a
// halo of colour to emphasise that this is the "rebuilt zone" of the bell.
// ---------------------------------------------------------------------------
Widget chimeHalo({required Widget child, Color color = cChimeMint}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.45),
      border: Border.all(color: color, width: 1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: child,
  );
}

// ---------------------------------------------------------------------------
// bellCard -- a complete frame for a single ValueListenableBuilder
// demonstration. Includes the bell shape on the left, a brass plaque, a
// title, a body that hosts the actual ValueListenableBuilder widget, and
// a footer caption.
// ---------------------------------------------------------------------------
Widget bellCard({
  required String number,
  required String title,
  required String description,
  required Widget body,
  String? footer,
  Color haloColor = cChimeMint,
  Color bellBody = cBrassBell,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cParchmentBell,
      border: Border.all(color: cIvoryShadow, width: 1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bell column on the left
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 12,
              decoration: BoxDecoration(
                color: cIvoryFrame,
                border: Border.all(color: cIvoryShadow, width: 1),
              ),
            ),
            bellShape(size: 70, body: bellBody),
            const SizedBox(height: 6),
            brassPlaque(number),
          ],
        ),
        const SizedBox(width: 14),
        // Body column on the right
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: subheadingStyle(size: 15)),
              const SizedBox(height: 4),
              Text(description, style: proseStyle(size: 12)),
              const SizedBox(height: 10),
              chimeHalo(child: body, color: haloColor),
              if (footer != null) ...[
                const SizedBox(height: 6),
                Text(footer, style: italicStyle(size: 11)),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// twoColumnFact -- a small two-column row with a label on the left and a
// value on the right. Used in tables comparing builders.
// ---------------------------------------------------------------------------
Widget twoColumnFact(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(label, style: labelStyle(size: 11)),
        ),
        Expanded(
          child: Text(value, style: proseStyle(size: 12)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// comparisonRow -- one row of the comparison table between
// ValueListenableBuilder, ListenableBuilder, AnimatedBuilder, and
// StreamBuilder. Renders four cells with consistent widths.
// ---------------------------------------------------------------------------
Widget comparisonRow({
  required String label,
  required String vlb,
  required String lb,
  required String ab,
  required String sb,
  bool header = false,
}) {
  TextStyle s = header
      ? labelStyle(size: 11, color: cParchmentBell)
      : proseStyle(size: 11);
  Color bg = header ? cLavenderDeep : cParchmentBell;
  return Container(
    color: bg,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 110, child: Text(label, style: s)),
        Expanded(child: Text(vlb, style: s)),
        Expanded(child: Text(lb, style: s)),
        Expanded(child: Text(ab, style: s)),
        Expanded(child: Text(sb, style: s)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// dividerRule -- a thin horizontal rule with a colour appropriate to the
// section. Used between subsections inside the prose flow.
// ---------------------------------------------------------------------------
Widget dividerRule({Color color = cLavenderSoft, double thickness = 1, double indent = 18}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: indent, vertical: 8),
    height: thickness,
    color: color,
  );
}

// ===========================================================================
// build()
// ---------------------------------------------------------------------------
// The single entry point invoked by the d4rt smoke harness. Returns one
// large widget tree assembled from every section of the diary. Print
// statements narrate the construction so a tail of the script log reads
// like a guided tour of the campanile.
// ===========================================================================
dynamic build(BuildContext context) {
  print('[bell-lavender] keeper opens the diary at twilight');
  print('[bell-lavender] subject  : ValueListenableBuilder<T>');
  print('[bell-lavender] companion: ValueNotifier<T>');
  print('[bell-lavender] mode     : single-frame, no mutation');

  // -------------------------------------------------------------------------
  // Construct ALL ValueNotifier instances up-front. We never touch their
  // .value setter again in this script. Each notifier corresponds to one
  // bell on the campanile beam and rings exactly ONCE during the first
  // frame: the ValueListenableBuilder reads the initial .value the moment
  // its State subscribes, and the resulting builder call is the only
  // observation we make.
  // -------------------------------------------------------------------------
  print('[bell-lavender] casting the bells (constructing ValueNotifiers)');

  final ValueNotifier<int> bellCounter = ValueNotifier<int>(7);
  print('[bell-lavender]   bell #1: ValueNotifier<int>(7) -- counter');

  final ValueNotifier<bool> bellToggle = ValueNotifier<bool>(true);
  print('[bell-lavender]   bell #2: ValueNotifier<bool>(true) -- toggle');

  final ValueNotifier<String> bellMessage = ValueNotifier<String>('vespers');
  print('[bell-lavender]   bell #3: ValueNotifier<String>(vespers) -- message');

  final ValueNotifier<double> bellSlider = ValueNotifier<double>(0.62);
  print('[bell-lavender]   bell #4: ValueNotifier<double>(0.62) -- slider');

  final ValueNotifier<Color> bellColor = ValueNotifier<Color>(cLavenderDeep);
  print('[bell-lavender]   bell #5: ValueNotifier<Color>(lavenderDeep) -- color');

  final ValueNotifier<List<int>> bellList =
      ValueNotifier<List<int>>(<int>[3, 5, 7, 11, 13]);
  print('[bell-lavender]   bell #6: ValueNotifier<List<int>>([3,5,7,11,13]) -- list');

  final ValueNotifier<MapEntry<String, int>> bellEntry =
      ValueNotifier<MapEntry<String, int>>(const MapEntry<String, int>('lauds', 6));
  print('[bell-lavender]   bell #7: ValueNotifier<MapEntry>(lauds:6) -- entry');

  final ValueNotifier<ChimeNote> bellChime =
      ValueNotifier<ChimeNote>(const ChimeNote(3, 'F#4', cChimeMint));
  print('[bell-lavender]   bell #8: ValueNotifier<ChimeNote>(#3, F#4) -- custom');

  final ValueNotifier<int> bellChildOpt = ValueNotifier<int>(42);
  print('[bell-lavender]   bell #9: ValueNotifier<int>(42) -- child-optimisation');

  final ValueNotifier<int> bellOuter = ValueNotifier<int>(2);
  final ValueNotifier<String> bellInner = ValueNotifier<String>('matins');
  print('[bell-lavender]   bell #10a: ValueNotifier<int>(2) -- outer of nested');
  print('[bell-lavender]   bell #10b: ValueNotifier<String>(matins) -- inner of nested');

  final ValueNotifier<int> bellComparison = ValueNotifier<int>(99);
  print('[bell-lavender]   bell #c: ValueNotifier<int>(99) -- comparison example');

  print('[bell-lavender] all bells cast; assembling sections');

  // -------------------------------------------------------------------------
  // Container for the entire diary. We accumulate a List<Widget> of
  // sections and feed it to a Column at the end. Sections are constructed
  // in declaration order so the print log reads top-to-bottom.
  // -------------------------------------------------------------------------
  final List<Widget> sections = <Widget>[];

  // -------------------------------------------------------------------------
  // Title plate
  // -------------------------------------------------------------------------
  print('[bell-lavender] section 0: title plate');
  sections.add(Container(
    margin: const EdgeInsets.fromLTRB(18, 24, 18, 8),
    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
    decoration: BoxDecoration(
      color: cLavenderDeep,
      border: Border.all(color: cBrassBell, width: 3),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BELL LAVENDER',
          style: TextStyle(
            fontFamily: kSerif,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: cParchmentBell,
            letterSpacing: 3.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'A Campanile Keeper\'s Diary of ValueListenableBuilder',
          style: TextStyle(
            fontFamily: kSerif,
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: cBrassGlow,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 14),
        Container(height: 1, color: cBrassBell),
        const SizedBox(height: 12),
        Text(
          'In which a keeper of bells writes down everything she has '
          'learned about the small Flutter widget that listens to a '
          'single observable value and rebuilds a chime-zone whenever '
          'the bell-rope is pulled. The diary is one snapshot, taken at '
          'twilight; the bells will not ring twice within these pages.',
          style: TextStyle(
            fontFamily: kSerif,
            fontSize: 13,
            color: cParchmentBell,
            height: 1.55,
          ),
        ),
      ],
    ),
  ));

  // -------------------------------------------------------------------------
  // SECTION I -- The ValueListenable taxonomy
  // -------------------------------------------------------------------------
  print('[bell-lavender] section I: ValueListenable taxonomy');
  sections.add(sectionHeader(
    numeral: 'I',
    title: 'The ValueListenable Taxonomy',
    subtitle: 'A keeper learns the family tree of the bells',
  ));
  sections.add(proseParagraph(
    'A ValueListenable<T> is the framework\'s smallest contract for an '
    'observable value. It exposes exactly two things: a getter named '
    'value of type T, and the ability to register and unregister '
    'listeners that should be notified when the value changes. The '
    'contract is so small that several distinct objects in the '
    'framework happen to satisfy it without sharing a common base '
    'class beyond the abstract one. In Bell Lavender we treat each '
    'ValueListenable as a bell: pulling its rope (the assignment to '
    '.value) sends a chime out to every keeper who has registered for '
    'updates.',
  ));
  sections.add(codeBlock(
    'abstract class ValueListenable<T> extends Listenable {\n'
    '  T get value;\n'
    '}\n\n'
    '// Concrete implementors found in the framework:\n'
    '//   ValueNotifier<T>           -- single-value mutable holder\n'
    '//   Animation<double>          -- read-only view of an AnimationController\n'
    '//   ProxyAnimation             -- forwards another Animation\n'
    '//   AlwaysStoppedAnimation<T>  -- never changes value\n'
    '//   CurvedAnimation            -- transforms a parent Animation\n'
    '//   ReverseAnimation           -- inverts a parent Animation',
    caption: 'package:flutter/foundation.dart  (slice)',
  ));
  sections.add(proseParagraph(
    'The diary is mostly concerned with ValueNotifier, the simplest of '
    'the bells. ValueNotifier<T> stores one T, exposes it via .value, '
    'and notifies listeners when assignment to .value would change it '
    '(equality is checked with ==, so assigning the same value twice '
    'does not ring the bell). All the other ValueListenables in the '
    'list above are produced by the animation system or by user-defined '
    'classes that mix in ChangeNotifier. The relationship between '
    'ValueListenable and Listenable is a strict subtype: every '
    'ValueListenable is a Listenable, but not every Listenable carries '
    'a typed value -- some, like an AnimationController without an '
    'attached Animation, simply notify and let the listener pull state '
    'out of fields. ListenableBuilder is the broader cousin that '
    'works with any Listenable; ValueListenableBuilder narrows the '
    'contract to specifically pass the typed value to the builder.',
  ));
  sections.add(keeperMargin(
    'A note from the keeper: I once mistook a ChangeNotifier without a '
    'value getter for a ValueListenable, and spent an hour trying to '
    'pass it to a ValueListenableBuilder. The compiler caught me before '
    'the bells rang. The framework\'s discipline is gentle but firm.',
  ));
  sections.add(dividerRule());
  sections.add(proseParagraph(
    'The fundamental shape of any listenable interaction is: someone '
    'holds a reference to the listenable, asks to be notified, then '
    'either polls .value or stores it in their own state when the '
    'notification arrives. ValueListenableBuilder hides all of that '
    'plumbing inside a State subclass. The keeper does not have to '
    'remember to call addListener in initState and removeListener in '
    'dispose -- the framework does it. The keeper does not have to '
    'remember to call setState when the bell rings -- the framework '
    'does it. The keeper writes only the builder, which is the part '
    'that actually says "given this value, here is the chime-zone."',
  ));
  sections.add(codeBlock(
    '// Pseudocode of what ValueListenableBuilder hides for you:\n'
    'class _ValueListenableBuilderState<T> extends State<ValueListenableBuilder<T>> {\n'
    '  late T value;\n'
    '\n'
    '  @override\n'
    '  void initState() {\n'
    '    super.initState();\n'
    '    value = widget.valueListenable.value;\n'
    '    widget.valueListenable.addListener(_valueChanged);\n'
    '  }\n'
    '\n'
    '  @override\n'
    '  void didUpdateWidget(ValueListenableBuilder<T> old) {\n'
    '    if (old.valueListenable != widget.valueListenable) {\n'
    '      old.valueListenable.removeListener(_valueChanged);\n'
    '      value = widget.valueListenable.value;\n'
    '      widget.valueListenable.addListener(_valueChanged);\n'
    '    }\n'
    '    super.didUpdateWidget(old);\n'
    '  }\n'
    '\n'
    '  @override\n'
    '  void dispose() {\n'
    '    widget.valueListenable.removeListener(_valueChanged);\n'
    '    super.dispose();\n'
    '  }\n'
    '\n'
    '  void _valueChanged() {\n'
    '    setState(() { value = widget.valueListenable.value; });\n'
    '  }\n'
    '\n'
    '  @override\n'
    '  Widget build(BuildContext context) =>\n'
    '      widget.builder(context, value, widget.child);\n'
    '}',
    caption: 'sketch :: framework/lib/src/widgets/value_listenable_builder.dart',
  ));
  sections.add(proseParagraph(
    'The didUpdateWidget hook is the subtle one. If a parent rebuilds '
    'and passes a different ValueListenable, the State must unsubscribe '
    'from the old one, capture the new initial value, and subscribe to '
    'the new one. If the same listenable is passed across rebuilds, '
    'the listener stays registered and no work is done. This is why '
    'you can safely return a fresh ValueListenableBuilder from a parent '
    'build method on every frame: the State persists across frames as '
    'long as its position in the tree is stable, and only the cheap '
    'identity check on valueListenable runs.',
  ));

  // -------------------------------------------------------------------------
  // SECTION II -- ValueNotifier construction patterns
  // -------------------------------------------------------------------------
  print('[bell-lavender] section II: ValueNotifier construction patterns');
  sections.add(sectionHeader(
    numeral: 'II',
    title: 'ValueNotifier Construction Patterns',
    subtitle: 'How a keeper hangs each bell from the ivory beam',
  ));
  sections.add(proseParagraph(
    'A ValueNotifier is constructed once, lived with for as long as its '
    'owning State or controller is alive, and disposed when that owner '
    'is no longer needed. The constructor takes the initial value as '
    'its only argument. The type parameter is usually inferred from '
    'that argument, but in practice a keeper writes the type out '
    'explicitly because the inferred type can be too narrow (or, with '
    'literal nulls, ambiguous). In this script we always write the '
    'type out: ValueNotifier<int>(0), not ValueNotifier(0).',
  ));
  sections.add(codeBlock(
    '// Common construction patterns:\n'
    '\n'
    '// 1. Inside a StatefulWidget\'s State (typical):\n'
    'class _MyWidgetState extends State<MyWidget> {\n'
    '  final ValueNotifier<int> _counter = ValueNotifier<int>(0);\n'
    '\n'
    '  @override\n'
    '  void dispose() {\n'
    '    _counter.dispose();\n'
    '    super.dispose();\n'
    '  }\n'
    '}\n'
    '\n'
    '// 2. Inside a controller class shared between widgets:\n'
    'class FormController {\n'
    '  final ValueNotifier<bool> isValid = ValueNotifier<bool>(false);\n'
    '  final ValueNotifier<String> message = ValueNotifier<String>(\'\');\n'
    '  void dispose() {\n'
    '    isValid.dispose();\n'
    '    message.dispose();\n'
    '  }\n'
    '}\n'
    '\n'
    '// 3. Top-level (rare; only when truly app-wide):\n'
    'final ValueNotifier<ThemeMode> kThemeMode =\n'
    '    ValueNotifier<ThemeMode>(ThemeMode.system);',
    caption: 'idioms :: where a ValueNotifier should live',
  ));
  sections.add(proseParagraph(
    'The reason the keeper hangs each bell from a single beam is that '
    'identity matters. A ValueListenableBuilder uses its valueListenable '
    'field by identity (== on the listenable instance) to decide '
    'whether to resubscribe. If a parent build method created a fresh '
    'ValueNotifier on every frame, the State of the child '
    'ValueListenableBuilder would unsubscribe and resubscribe on every '
    'rebuild -- and worse, every frame would start from the constructor\'s '
    'initial value, throwing away any change the previous notifier had '
    'recorded. The ValueNotifier must be held by something whose '
    'lifecycle outlives a single frame: a State, a controller, a '
    'singleton, or the application object itself.',
  ));
  sections.add(keeperMargin(
    'Beware the seductive pattern of writing ValueNotifier<T>(initial) '
    'directly inside a build method. It compiles, it even runs, and it '
    'looks tidy. But every frame you create a new bell, hang it from '
    'the beam, ring it once, and then drop it on the floor. The diary '
    'fills with broken bells.',
  ));
  sections.add(dividerRule());
  sections.add(proseParagraph(
    'ValueNotifier publishes a notification ONLY when the assigned '
    'value is not equal (==) to the previously stored value. This means '
    'two things in practice. First, primitives like int, bool, double, '
    'and String benefit naturally: writing notifier.value = 42 when it '
    'was already 42 is a no-op, no listeners run. Second, mutable '
    'collections like List and Map are dangerous: mutating the list '
    'in place and reassigning the same reference (notifier.value = '
    'list..add(x)) does NOT publish, because == is reference equality '
    'for default List. The keeper either reassigns to a fresh list '
    '(notifier.value = [...notifier.value, x]) or uses a different '
    'tool such as a custom ChangeNotifier that calls notifyListeners '
    'explicitly after each mutation.',
  ));
  sections.add(codeBlock(
    '// WRONG -- does NOT notify, because the list reference is identical:\n'
    'final ValueNotifier<List<int>> ringHistory = ValueNotifier<List<int>>([]);\n'
    'void recordWrong(int hour) {\n'
    '  ringHistory.value.add(hour);          // mutate in place\n'
    '  ringHistory.value = ringHistory.value; // same reference => no notify\n'
    '}\n'
    '\n'
    '// RIGHT -- assign a new list:\n'
    'void recordRight(int hour) {\n'
    '  ringHistory.value = [...ringHistory.value, hour]; // new reference\n'
    '}\n'
    '\n'
    '// ALTERNATIVE -- a custom ChangeNotifier:\n'
    'class RingHistory extends ChangeNotifier implements ValueListenable<List<int>> {\n'
    '  final List<int> _hours = <int>[];\n'
    '  @override List<int> get value => List.unmodifiable(_hours);\n'
    '  void record(int hour) { _hours.add(hour); notifyListeners(); }\n'
    '}',
    caption: 'pitfall :: in-place mutation and ValueNotifier',
  ));
  sections.add(proseParagraph(
    'Disposal is mandatory. ValueNotifier extends ChangeNotifier, which '
    'allocates a small linked list of listeners; failing to call dispose '
    'leaves that list pinned in memory along with any closures that '
    'reference UI state. In Bell Lavender we do not call dispose anywhere '
    'because the script\'s lifetime is one frame and the entire process '
    'is torn down moments later, but in production code dispose is the '
    'matching half of every constructor call.',
  ));

  // -------------------------------------------------------------------------
  // SECTION III -- The builder signature anatomy
  // -------------------------------------------------------------------------
  print('[bell-lavender] section III: builder signature anatomy');
  sections.add(sectionHeader(
    numeral: 'III',
    title: 'The Builder Signature, Dissected',
    subtitle: 'Three arguments, one return, no surprises',
  ));
  sections.add(proseParagraph(
    'The builder function signature is short enough to memorise and '
    'rich enough to repay study. It takes a BuildContext, the typed '
    'value, and an optional Widget child, and returns a Widget. Each '
    'of the three inputs has a distinct purpose. The BuildContext '
    'allows the builder to look up inherited widgets such as Theme, '
    'MediaQuery, or DefaultTextStyle without having to thread them '
    'through; the value is the freshly observed T from the listenable; '
    'and the child is whatever the parent passed via the child '
    'parameter, untouched and reusable.',
  ));
  sections.add(codeBlock(
    'typedef ValueWidgetBuilder<T> = Widget Function(\n'
    '  BuildContext context,\n'
    '  T value,\n'
    '  Widget? child,\n'
    ');\n'
    '\n'
    '// In use:\n'
    'ValueListenableBuilder<int>(\n'
    '  valueListenable: counter,\n'
    '  builder: (BuildContext context, int value, Widget? child) {\n'
    '    final TextStyle style = DefaultTextStyle.of(context).style;\n'
    '    return Row(\n'
    '      children: <Widget>[\n'
    '        Text(\'Count: \$value\', style: style),\n'
    '        if (child != null) child,\n'
    '      ],\n'
    '    );\n'
    '  },\n'
    '  child: const Icon(Icons.notifications_outlined),\n'
    ')',
    caption: 'typedef and use site',
  ));
  sections.add(proseParagraph(
    'A common mistake is to ignore the child parameter and capture an '
    'expensive widget directly inside the builder closure. That works, '
    'but it discards the child-optimisation: every time the value '
    'changes, the captured widget is rebuilt as part of the closure\'s '
    'execution. Threading the static parts through child preserves '
    'their Element across rebuilds, so only the bits that actually '
    'depend on value change identity. Section IV is dedicated to this '
    'optimisation; here we only note that the child parameter exists '
    'and is the recommended channel for static subtrees.',
  ));
  sections.add(keeperMargin(
    'A bell ringer once told me that the builder is the keeper\'s '
    'pencil, the value is the bell\'s voice, and the child is a '
    'pre-printed letterhead -- the keeper does not redraw the '
    'letterhead each time, only the new line of news.',
  ));
  sections.add(dividerRule());
  sections.add(proseParagraph(
    'The BuildContext passed to the builder is the BuildContext of the '
    'ValueListenableBuilder itself, which means inherited-widget '
    'lookups (Theme.of(context), Directionality.of(context), and so '
    'on) will resolve relative to where the ValueListenableBuilder '
    'sits in the tree, not where it was first constructed. This makes '
    'ValueListenableBuilder safe to use inside Theme overrides, inside '
    'a Builder that flips Directionality, inside a MediaQuery sub-tree, '
    'and so on. The builder closure does not need to capture the '
    'outer context; it should always use the context argument it '
    'receives.',
  ));
  sections.add(codeBlock(
    '// CORRECT -- uses the inner context, picks up nearest Theme:\n'
    'Theme(\n'
    '  data: ThemeData(brightness: Brightness.dark),\n'
    '  child: ValueListenableBuilder<int>(\n'
    '    valueListenable: counter,\n'
    '    builder: (BuildContext context, int value, Widget? child) {\n'
    '      return Text(\'\$value\', style: Theme.of(context).textTheme.bodyMedium);\n'
    '      // Theme.of(context) sees the dark Theme above.\n'
    '    },\n'
    '  ),\n'
    ')\n'
    '\n'
    '// SUSPICIOUS -- captures the outer context, may pick up wrong Theme:\n'
    'Widget buildSuspicious(BuildContext outer) {\n'
    '  return Theme(\n'
    '    data: ThemeData(brightness: Brightness.dark),\n'
    '    child: ValueListenableBuilder<int>(\n'
    '      valueListenable: counter,\n'
    '      builder: (BuildContext _, int value, Widget? child) {\n'
    '        return Text(\'\$value\', style: Theme.of(outer).textTheme.bodyMedium);\n'
    '        // Theme.of(outer) sees the OUTER theme, not the dark override.\n'
    '      },\n'
    '    ),\n'
    '  );\n'
    '}',
    caption: 'BuildContext discipline',
  ));

  // -------------------------------------------------------------------------
  // SECTION IV -- When to use the child parameter
  // -------------------------------------------------------------------------
  print('[bell-lavender] section IV: when to use the child parameter');
  sections.add(sectionHeader(
    numeral: 'IV',
    title: 'The child Parameter and the Cost of Rebuilds',
    subtitle: 'Reusing the letterhead while the news changes',
  ));
  sections.add(proseParagraph(
    'The child parameter is the most under-appreciated feature of '
    'ValueListenableBuilder. It is opt-in, costs nothing when ignored, '
    'and saves real work when used. The contract is simple: anything '
    'you would otherwise put inline inside the builder that does NOT '
    'depend on the value can be lifted out and passed via child. The '
    'framework holds onto that widget across rebuilds, so its Element '
    'tree is preserved, its State (if any) is preserved, and only the '
    'bits the builder produces are rebuilt.',
  ));
  sections.add(codeBlock(
    '// Without child -- the Container with its expensive decoration\n'
    '// is reconstructed on every notify:\n'
    'ValueListenableBuilder<int>(\n'
    '  valueListenable: counter,\n'
    '  builder: (ctx, value, _) {\n'
    '    return Row(children: [\n'
    '      Container(\n'
    '        padding: const EdgeInsets.all(8),\n'
    '        decoration: BoxDecoration(\n'
    '          gradient: LinearGradient(colors: [...]),\n'
    '          borderRadius: BorderRadius.circular(12),\n'
    '          boxShadow: [BoxShadow(...)]),\n'
    '        child: const Icon(Icons.notifications),\n'
    '      ),\n'
    '      Text(\'\$value\'),\n'
    '    ]);\n'
    '  },\n'
    ');\n'
    '\n'
    '// With child -- the Container is built ONCE, threaded through:\n'
    'ValueListenableBuilder<int>(\n'
    '  valueListenable: counter,\n'
    '  builder: (ctx, value, child) {\n'
    '    return Row(children: [child!, Text(\'\$value\')]);\n'
    '  },\n'
    '  child: Container(\n'
    '    padding: const EdgeInsets.all(8),\n'
    '    decoration: BoxDecoration(\n'
    '      gradient: LinearGradient(colors: [...]),\n'
    '      borderRadius: BorderRadius.circular(12),\n'
    '      boxShadow: [BoxShadow(...)]),\n'
    '    child: const Icon(Icons.notifications),\n'
    '  ),\n'
    ');',
    caption: 'idiom :: using child to skip rebuilds',
  ));

  sections.add(proseParagraph(
    'How much does this matter? In a typical app the answer is '
    '"sometimes a little, occasionally a lot." A Container with a '
    'gradient and a shadow is cheap to construct; the saving is '
    'invisible. A nested widget that includes a CustomPainter, a '
    'large RichText, or a third-party widget that performs work in '
    'its own build method can dominate the rebuild budget; lifting '
    'it through child can shave milliseconds off each frame. The '
    'rule of thumb: always pass child when you have a static subtree '
    'that has nothing to do with the value, and never inline a '
    'widget that you would not want to recreate sixty times a second.',
  ));
  sections.add(keeperMargin(
    'A reminder pinned to the back of the diary: the optimisation is '
    'about identity, not about cleverness. Flutter compares the new '
    'widget tree to the previous one, sees the same instance under '
    'child, and reuses the corresponding Element. That is all.',
  ));
  sections.add(dividerRule());

  // -------------------------------------------------------------------------
  // SECTION V -- Ten illustrative samples (the bell row)
  // -------------------------------------------------------------------------
  print('[bell-lavender] section V: ten illustrative samples');
  sections.add(sectionHeader(
    numeral: 'V',
    title: 'Ten Bells, Ten Lessons',
    subtitle: 'A row of brass examples on the ivory beam',
  ));
  sections.add(proseParagraph(
    'What follows is a row of ten ValueListenableBuilder instances, '
    'each one a small bell with its own keeper. Every bell rings '
    'exactly once during this single frame; the rendered chime-zone '
    'is the snapshot of that initial value. Read across them in '
    'order and the diary moves from primitives, through small '
    'aggregates, to the child-parameter optimisation, and finally to '
    'a nested pair of bells that demonstrates how to listen to two '
    'observables at once.',
  ));

  // -- Bell 1: int counter -------------------------------------------------
  print('[bell-lavender]   building bell #1: int counter');
  final Widget bellBody1 = ValueListenableBuilder<int>(
    valueListenable: bellCounter,
    builder: (BuildContext ctx, int value, Widget? child) {
      print('[bell-lavender]   bell #1 builder fires with value=\$value');
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            color: cLavenderDeep,
            child: Text(
              'count',
              style: TextStyle(
                fontFamily: kSerif,
                fontSize: 11,
                color: cParchmentBell,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value.toString(),
            style: TextStyle(
              fontFamily: kMono,
              fontSize: 22,
              color: cInkDeep,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    },
  );
  sections.add(bellCard(
    number: 'I',
    title: 'Bell I -- ValueNotifier<int>',
    description:
        'The simplest bell. A single int observed by a single keeper. '
        'The builder reads the value and renders it as a number. The '
        'rebuild contract is straight-forward: when notifier.value '
        'changes, the keeper re-runs and the chime-zone is replaced.',
    body: bellBody1,
    footer: 'initial value: 7  (vespers count)',
    haloColor: cChimeMint,
    bellBody: cBrassBell,
  ));

  // -- Bell 2: bool toggle -------------------------------------------------
  print('[bell-lavender]   building bell #2: bool toggle');
  final Widget bellBody2 = ValueListenableBuilder<bool>(
    valueListenable: bellToggle,
    builder: (BuildContext ctx, bool value, Widget? child) {
      print('[bell-lavender]   bell #2 builder fires with value=\$value');
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: value ? cLavenderDeep : cStoneCool,
              shape: BoxShape.circle,
              border: Border.all(color: cBrassBell, width: 1.5),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value ? 'rope is taut' : 'rope is slack',
            style: TextStyle(
              fontFamily: kSerif,
              fontSize: 13,
              color: cInkDeep,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    },
  );
  sections.add(bellCard(
    number: 'II',
    title: 'Bell II -- ValueNotifier<bool>',
    description:
        'A toggle bell. When the rope is taut the keeper sees the '
        'lavender-deep dot; when slack, the cool stone. ValueNotifier '
        'compares booleans with == so toggling true to true does not '
        'fire a notification.',
    body: bellBody2,
    footer: 'initial value: true  (the rope is taut at twilight)',
    haloColor: cChimeRose,
    bellBody: cBrassGlow,
  ));

  // -- Bell 3: String message ----------------------------------------------
  print('[bell-lavender]   building bell #3: string message');
  final Widget bellBody3 = ValueListenableBuilder<String>(
    valueListenable: bellMessage,
    builder: (BuildContext ctx, String value, Widget? child) {
      print('[bell-lavender]   bell #3 builder fires with value="\$value"');
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: cLavenderPale,
          border: Border.all(color: cLavenderMid, width: 1),
        ),
        child: Text(
          'Tonight\'s service: \$value',
          style: TextStyle(
            fontFamily: kSerif,
            fontSize: 13,
            color: cLavenderInk,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.4,
          ),
        ),
      );
    },
  );
  sections.add(bellCard(
    number: 'III',
    title: 'Bell III -- ValueNotifier<String>',
    description:
        'A textual bell. The keeper announces the name of the next '
        'service. String equality is value-based in Dart, so writing '
        'notifier.value = \'vespers\' twice in a row does not ring '
        'the bell. The chime-zone is a small parchment label.',
    body: bellBody3,
    footer: 'initial value: vespers  (the evening service)',
    haloColor: cChimeSky,
    bellBody: cBrassBell,
  ));

  // -- Bell 4: double slider ----------------------------------------------
  print('[bell-lavender]   building bell #4: double slider');
  final Widget bellBody4 = ValueListenableBuilder<double>(
    valueListenable: bellSlider,
    builder: (BuildContext ctx, double value, Widget? child) {
      print('[bell-lavender]   bell #4 builder fires with value=\$value');
      final double clamped = value.clamp(0.0, 1.0);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'rope tension: \${(clamped * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              fontFamily: kMono,
              fontSize: 12,
              color: cInkDeep,
            ),
          ),
          const SizedBox(height: 6),
          Stack(
            children: <Widget>[
              Container(
                width: 220,
                height: 10,
                decoration: BoxDecoration(
                  color: cLavenderPale,
                  border: Border.all(color: cLavenderMid, width: 1),
                ),
              ),
              Container(
                width: 220 * clamped,
                height: 10,
                decoration: BoxDecoration(
                  color: cLavenderDeep,
                  border: Border.all(color: cLavenderInk, width: 1),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
  sections.add(bellCard(
    number: 'IV',
    title: 'Bell IV -- ValueNotifier<double>',
    description:
        'A continuous bell. The keeper draws the rope tension as a '
        'horizontal bar. doubles are equality-compared, so two values '
        'that are bit-identical will coalesce, but two values that '
        'differ in the last decimal will fire.',
    body: bellBody4,
    footer: 'initial value: 0.62  (about two-thirds tension)',
    haloColor: cChimeMint,
    bellBody: cBrassDeep,
  ));

  // -- Bell 5: Color -------------------------------------------------------
  print('[bell-lavender]   building bell #5: color');
  final Widget bellBody5 = ValueListenableBuilder<Color>(
    valueListenable: bellColor,
    builder: (BuildContext ctx, Color value, Widget? child) {
      print('[bell-lavender]   bell #5 builder fires with color value');
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: value,
              border: Border.all(color: cInkDeep, width: 1),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: value.withValues(alpha: 0.55),
              border: Border.all(color: cInkDeep, width: 1),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: value.withValues(alpha: 0.20),
              border: Border.all(color: cInkDeep, width: 1),
            ),
          ),
        ],
      );
    },
  );
  sections.add(bellCard(
    number: 'V',
    title: 'Bell V -- ValueNotifier<Color>',
    description:
        'A chromatic bell. The keeper renders the value at full alpha, '
        'then at .55, then at .20 using the modern .withValues '
        'constructor. Color equality is field-based in Flutter; '
        'reassigning the same shade will not ring.',
    body: bellBody5,
    footer: 'initial value: lavenderDeep  (#6E4FA0)',
    haloColor: cChimeRose,
    bellBody: cBrassBell,
  ));

  // -- Bell 6: List<int> ---------------------------------------------------
  print('[bell-lavender]   building bell #6: list of ints');
  final Widget bellBody6 = ValueListenableBuilder<List<int>>(
    valueListenable: bellList,
    builder: (BuildContext ctx, List<int> value, Widget? child) {
      print('[bell-lavender]   bell #6 builder fires with list length=\${value.length}');
      // Use indexed loop to honour the no-for-in-on-BridgedInstance rule.
      final List<Widget> chips = <Widget>[];
      for (int i = 0; i < value.length; i++) {
        chips.add(Container(
          margin: const EdgeInsets.only(right: 6, bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: cLavenderSoft,
            border: Border.all(color: cLavenderDeep, width: 1),
          ),
          child: Text(
            value[i].toString(),
            style: TextStyle(
              fontFamily: kMono,
              fontSize: 12,
              color: cInkDeep,
              fontWeight: FontWeight.w600,
            ),
          ),
        ));
      }
      return Wrap(children: chips);
    },
  );
  sections.add(bellCard(
    number: 'VI',
    title: 'Bell VI -- ValueNotifier<List<int>>',
    description:
        'A list-valued bell. The keeper renders each element as a chip. '
        'Mind that List equality is reference-based by default: assign '
        'a fresh list to ring, never mutate in place.',
    body: bellBody6,
    footer: 'initial value: [3, 5, 7, 11, 13]  (small primes)',
    haloColor: cChimeSky,
    bellBody: cBrassGlow,
  ));

  // -- Bell 7: MapEntry ----------------------------------------------------
  print('[bell-lavender]   building bell #7: map entry');
  final Widget bellBody7 = ValueListenableBuilder<MapEntry<String, int>>(
    valueListenable: bellEntry,
    builder: (BuildContext ctx, MapEntry<String, int> value, Widget? child) {
      print('[bell-lavender]   bell #7 builder fires with entry \${value.key}:\${value.value}');
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: cLavenderDeep,
            child: Text(
              value.key,
              style: TextStyle(
                fontFamily: kSerif,
                fontSize: 12,
                color: cParchmentBell,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: cBrassBell,
            child: Text(
              value.value.toString(),
              style: TextStyle(
                fontFamily: kMono,
                fontSize: 12,
                color: cInkDeep,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
    },
  );
  sections.add(bellCard(
    number: 'VII',
    title: 'Bell VII -- ValueNotifier<MapEntry<String, int>>',
    description:
        'A pair-valued bell. The keeper splits the entry into a key '
        'plate and a value plate. MapEntry has structural equality on '
        'recent Dart, so two equivalent entries do not ring.',
    body: bellBody7,
    footer: 'initial value: lauds:6  (six o\'clock at lauds)',
    haloColor: cChimeMint,
    bellBody: cBrassBell,
  ));

  // -- Bell 8: custom data class ------------------------------------------
  print('[bell-lavender]   building bell #8: custom data class');
  final Widget bellBody8 = ValueListenableBuilder<ChimeNote>(
    valueListenable: bellChime,
    builder: (BuildContext ctx, ChimeNote value, Widget? child) {
      print('[bell-lavender]   bell #8 builder fires with \$value');
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: value.halo,
              shape: BoxShape.circle,
              border: Border.all(color: cInkDeep, width: 1),
            ),
            child: Text(
              value.index.toString(),
              style: TextStyle(
                fontFamily: kSerif,
                fontSize: 12,
                color: cInkDeep,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value.pitch,
            style: TextStyle(
              fontFamily: kMono,
              fontSize: 14,
              color: cInkDeep,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'pitch of bell #\${value.index}',
            style: italicStyle(size: 11),
          ),
        ],
      );
    },
  );
  sections.add(bellCard(
    number: 'VIII',
    title: 'Bell VIII -- ValueNotifier<ChimeNote>',
    description:
        'A custom-typed bell. The keeper renders a small data class '
        'describing one chime: index, pitch, halo colour. ChimeNote is '
        'immutable; changing its fields requires constructing a new '
        'instance and assigning it back to the notifier.',
    body: bellBody8,
    footer: 'initial value: ChimeNote(#3, F#4, mint halo)',
    haloColor: cChimeMint,
    bellBody: cBrassDeep,
  ));

  // -- Bell 9: child parameter optimisation -------------------------------
  print('[bell-lavender]   building bell #9: child-parameter optimisation');
  final Widget staticLetterhead = Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: cBrassGlow,
      border: Border.all(color: cBrassDeep, width: 1.2),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: cLavenderDeep,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'KEEPER OF BELLS',
          style: TextStyle(
            fontFamily: kSerif,
            fontSize: 10,
            color: cInkDeep,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
      ],
    ),
  );
  final Widget bellBody9 = ValueListenableBuilder<int>(
    valueListenable: bellChildOpt,
    builder: (BuildContext ctx, int value, Widget? child) {
      print('[bell-lavender]   bell #9 builder fires with value=\$value (child preserved)');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ?child,
          const SizedBox(height: 8),
          Text(
            'today\'s tally: \$value chimes',
            style: TextStyle(
              fontFamily: kMono,
              fontSize: 13,
              color: cInkDeep,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '(the letterhead above was built once; only this line rebuilds)',
            style: italicStyle(size: 11),
          ),
        ],
      );
    },
    child: staticLetterhead,
  );
  sections.add(bellCard(
    number: 'IX',
    title: 'Bell IX -- the child Parameter',
    description:
        'The optimisation bell. The brass-glow letterhead is constructed '
        'once and threaded through the child parameter; only the tally '
        'line below it is touched on each notification. The keeper '
        'preserves the letterhead\'s Element across rebuilds.',
    body: bellBody9,
    footer: 'initial value: 42  (the answer, of course)',
    haloColor: cChimeRose,
    bellBody: cBrassGlow,
  ));

  // -- Bell 10: nested ValueListenableBuilder -----------------------------
  print('[bell-lavender]   building bell #10: nested builders (outer int, inner string)');
  final Widget bellBody10 = ValueListenableBuilder<int>(
    valueListenable: bellOuter,
    builder: (BuildContext ctxOuter, int outerValue, Widget? outerChild) {
      print('[bell-lavender]   bell #10 outer builder fires with outerValue=\$outerValue');
      return ValueListenableBuilder<String>(
        valueListenable: bellInner,
        builder: (BuildContext ctxInner, String innerValue, Widget? innerChild) {
          print('[bell-lavender]   bell #10 inner builder fires with innerValue="\$innerValue"');
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cLavenderPale,
              border: Border.all(color: cLavenderDeep, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'tier #\$outerValue, service "\$innerValue"',
                  style: TextStyle(
                    fontFamily: kSerif,
                    fontSize: 13,
                    color: cInkDeep,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'the outer keeper hears the int bell, the inner keeper '
                  'hears the string bell, both rebuild their chime-zones '
                  'independently when their respective bells ring',
                  style: italicStyle(size: 11),
                ),
              ],
            ),
          );
        },
      );
    },
  );
  sections.add(bellCard(
    number: 'X',
    title: 'Bell X -- Nested ValueListenableBuilders',
    description:
        'Two bells, two keepers, one chime-zone. The outer builder '
        'captures the int; the inner builder captures the string. Each '
        'rebuild path is scoped: a change to the inner notifier does '
        'not invalidate the outer chime-zone, and vice-versa.',
    body: bellBody10,
    footer: 'initial values: outer=2, inner="matins"',
    haloColor: cChimeSky,
    bellBody: cBrassBell,
  ));

  // -------------------------------------------------------------------------
  // SECTION VI -- Comparison with sibling builders
  // -------------------------------------------------------------------------
  print('[bell-lavender] section VI: comparison with sibling builders');
  sections.add(sectionHeader(
    numeral: 'VI',
    title: 'Sibling Builders, Side by Side',
    subtitle: 'When a different keeper would suit the bell better',
  ));
  sections.add(proseParagraph(
    'ValueListenableBuilder has three close cousins in the framework, '
    'each tuned to a slightly different observable. ListenableBuilder '
    'works with any Listenable, even one without a typed value, but '
    'leaves the keeper to pull state out of fields. AnimatedBuilder '
    'is the eldest sibling, predating ListenableBuilder and historically '
    'used for AnimationController-driven rebuilds; today it is a thin '
    'alias around the same machinery. StreamBuilder is the cousin '
    'from a different family: it listens to a Stream, not a Listenable, '
    'and exposes an AsyncSnapshot rather than a value directly.',
  ));
  sections.add(Container(
    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    decoration: BoxDecoration(border: Border.all(color: cLavenderDeep, width: 1)),
    child: Column(
      children: <Widget>[
        comparisonRow(
          header: true,
          label: 'aspect',
          vlb: 'ValueListenableBuilder',
          lb: 'ListenableBuilder',
          ab: 'AnimatedBuilder',
          sb: 'StreamBuilder',
        ),
        comparisonRow(
          label: 'observes',
          vlb: 'ValueListenable<T>',
          lb: 'Listenable',
          ab: 'Listenable',
          sb: 'Stream<T>',
        ),
        comparisonRow(
          label: 'value typed?',
          vlb: 'yes, T',
          lb: 'no, pull yourself',
          ab: 'no, pull yourself',
          sb: 'wrapped in AsyncSnapshot<T>',
        ),
        comparisonRow(
          label: 'child param?',
          vlb: 'yes',
          lb: 'yes',
          ab: 'yes',
          sb: 'no',
        ),
        comparisonRow(
          label: 'initial frame',
          vlb: 'reads .value synchronously',
          lb: 'reads field synchronously',
          ab: 'reads field synchronously',
          sb: 'AsyncSnapshot.waiting until first event',
        ),
        comparisonRow(
          label: 'cleanup',
          vlb: 'auto removeListener',
          lb: 'auto removeListener',
          ab: 'auto removeListener',
          sb: 'auto stream subscription cancel',
        ),
        comparisonRow(
          label: 'typical use',
          vlb: 'single observable value',
          lb: 'multi-field controller',
          ab: 'AnimationController curves',
          sb: 'platform channels, web sockets',
        ),
      ],
    ),
  ));
  sections.add(proseParagraph(
    'The decision tree is nearly mechanical. If the source is a Stream, '
    'use StreamBuilder. If the source is a Listenable that exposes a '
    'single typed value via .value, use ValueListenableBuilder. If the '
    'source is a Listenable with multiple interesting fields and you '
    'will read several of them inside the builder, use ListenableBuilder. '
    'AnimatedBuilder remains in the codebase for historical reasons '
    'and is essentially identical to ListenableBuilder; new code should '
    'prefer ListenableBuilder for clarity, but reading older code you '
    'will see AnimatedBuilder used wherever an AnimationController is '
    'driving a rebuild.',
  ));
  sections.add(codeBlock(
    '// ValueListenableBuilder -- when a single typed value is enough\n'
    'ValueListenableBuilder<int>(\n'
    '  valueListenable: counter,\n'
    '  builder: (ctx, value, child) => Text(\'\$value\'),\n'
    ');\n'
    '\n'
    '// ListenableBuilder -- when reading several fields off a controller\n'
    'ListenableBuilder(\n'
    '  listenable: formController,\n'
    '  builder: (ctx, child) => Text(\n'
    '    \'\${formController.name} -- \${formController.email}\',\n'
    '  ),\n'
    ');\n'
    '\n'
    '// AnimatedBuilder -- legacy alias, identical machinery\n'
    'AnimatedBuilder(\n'
    '  animation: animationController,\n'
    '  builder: (ctx, child) => Opacity(\n'
    '    opacity: animationController.value,\n'
    '    child: child,\n'
    '  ),\n'
    '  child: const Icon(Icons.lightbulb),\n'
    ');\n'
    '\n'
    '// StreamBuilder -- async source, snapshot-based\n'
    'StreamBuilder<int>(\n'
    '  stream: tickerStream,\n'
    '  initialData: 0,\n'
    '  builder: (ctx, snapshot) {\n'
    '    if (snapshot.hasError) return const Text(\'error\');\n'
    '    if (!snapshot.hasData) return const CircularProgressIndicator();\n'
    '    return Text(\'\${snapshot.data}\');\n'
    '  },\n'
    ');',
    caption: 'four builders, four observable contracts',
  ));
  sections.add(keeperMargin(
    'A small subtlety: ValueListenableBuilder REBUILDS only when the '
    'value\'s == reports a change. ListenableBuilder REBUILDS on every '
    'notifyListeners call, regardless of any value comparison. If your '
    'controller calls notifyListeners frequently with no actual change '
    'in the field you display, prefer ValueListenableBuilder over a '
    'specific ValueNotifier extracted from that controller.',
  ));

  // -- Comparison sample: same data through ListenableBuilder ---------------
  print('[bell-lavender]   building comparison: ListenableBuilder around bellComparison');
  final Widget comparisonBody = ListenableBuilder(
    listenable: bellComparison,
    builder: (BuildContext ctx, Widget? child) {
      print('[bell-lavender]   ListenableBuilder fires (untyped); pulls value manually');
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: cLavenderPale,
          border: Border.all(color: cLavenderMid, width: 1),
        ),
        child: Text(
          'ListenableBuilder pulls .value manually: \${bellComparison.value}',
          style: TextStyle(
            fontFamily: kMono,
            fontSize: 12,
            color: cInkDeep,
          ),
        ),
      );
    },
  );
  sections.add(bellCard(
    number: 'C',
    title: 'Comparison -- the same bell, but a ListenableBuilder',
    description:
        'The same ValueNotifier observed through the broader '
        'ListenableBuilder. Note the keeper now pulls .value out of '
        'the notifier closure rather than receiving it as a typed '
        'argument. This is the trade-off: more flexibility, less '
        'type-safety at the call site.',
    body: comparisonBody,
    footer: 'initial value: 99  (the comparison bell)',
    haloColor: cChimeSky,
    bellBody: cStoneCool,
  ));

  // -------------------------------------------------------------------------
  // SECTION VII -- Wiring patterns and lifting state
  // -------------------------------------------------------------------------
  print('[bell-lavender] section VII: wiring patterns and lifting state');
  sections.add(sectionHeader(
    numeral: 'VII',
    title: 'Wiring Patterns and Lifting State',
    subtitle: 'Where the bells hang, who pulls the rope',
  ));
  sections.add(proseParagraph(
    'A ValueListenableBuilder is only as useful as the discipline of '
    'whoever owns the ValueNotifier on the other end. The keeper must '
    'decide where the bell hangs: in the State of the widget that '
    'displays it, in a controller that several widgets share, in an '
    'inherited widget that descendants can read, or in a top-level '
    'singleton. The choice determines who can ring the bell, who can '
    'observe it, and how testing is organised.',
  ));
  sections.add(codeBlock(
    '// Pattern 1: bell lives in State, ringer is a private method.\n'
    'class _CounterPageState extends State<CounterPage> {\n'
    '  final ValueNotifier<int> _count = ValueNotifier<int>(0);\n'
    '  void _ring() => _count.value = _count.value + 1;\n'
    '  @override Widget build(BuildContext ctx) {\n'
    '    return Column(children: [\n'
    '      ValueListenableBuilder<int>(\n'
    '        valueListenable: _count,\n'
    '        builder: (ctx, value, _) => Text(\'\$value\'),\n'
    '      ),\n'
    '      ElevatedButton(onPressed: _ring, child: const Text(\'ring\')),\n'
    '    ]);\n'
    '  }\n'
    '  @override void dispose() { _count.dispose(); super.dispose(); }\n'
    '}\n'
    '\n'
    '// Pattern 2: bell lives in a controller class, several widgets ring.\n'
    'class CartController {\n'
    '  final ValueNotifier<int> itemCount = ValueNotifier<int>(0);\n'
    '  void add() => itemCount.value = itemCount.value + 1;\n'
    '  void clear() => itemCount.value = 0;\n'
    '  void dispose() => itemCount.dispose();\n'
    '}\n'
    '\n'
    '// Pattern 3: bell exposed via InheritedNotifier for tree-wide reads.\n'
    'class CartScope extends InheritedNotifier<ValueNotifier<int>> {\n'
    '  const CartScope({super.key, required ValueNotifier<int> count, required Widget child})\n'
    '      : super(notifier: count, child: child);\n'
    '  static ValueNotifier<int> of(BuildContext ctx) =>\n'
    '      ctx.dependOnInheritedWidgetOfExactType<CartScope>()!.notifier!;\n'
    '}',
    caption: 'three places a bell can hang',
  ));
  sections.add(proseParagraph(
    'Lifting state means moving a ValueNotifier upward in the tree '
    'until it reaches a node whose lifecycle covers all the widgets '
    'that need to read or write it. If two siblings both display '
    'the count, the bell belongs in their nearest common ancestor; '
    'if the bell needs to survive a pop-and-push, it belongs higher '
    'still, perhaps in a Provider scope or an inherited notifier. '
    'The keeper resists the urge to rebuild the bell on every parent '
    'rebuild: the bell is the constant, the chimes are the variable.',
  ));
  sections.add(keeperMargin(
    'Lifting too far is also a hazard. A bell hung from the cathedral '
    'roof when only the chapel needs it still rings the cathedral. '
    'Place each bell at the lowest common ancestor of its observers, '
    'not at the highest convenient node.',
  ));
  sections.add(dividerRule());

  // -------------------------------------------------------------------------
  // SECTION VIII -- Test and debug guidance
  // -------------------------------------------------------------------------
  print('[bell-lavender] section VIII: test and debug guidance');
  sections.add(sectionHeader(
    numeral: 'VIII',
    title: 'Testing and Debugging the Bells',
    subtitle: 'How a keeper checks each chime against the score',
  ));
  sections.add(proseParagraph(
    'A ValueListenableBuilder is friendly to tests because the '
    'observation contract is explicit. In a widget test, pump the '
    'widget, find the chime-zone, change the underlying notifier, '
    'pump a frame, and assert that the chime-zone reflects the new '
    'value. The mutability is contained in the notifier, not in the '
    'widget, so tests do not have to reach inside private State.',
  ));
  sections.add(codeBlock(
    '// Widget test pattern:\n'
    'final notifier = ValueNotifier<int>(0);\n'
    'await tester.pumpWidget(MaterialApp(\n'
    '  home: ValueListenableBuilder<int>(\n'
    '    valueListenable: notifier,\n'
    '    builder: (ctx, value, _) => Text(\'\$value\', textDirection: TextDirection.ltr),\n'
    '  ),\n'
    '));\n'
    'expect(find.text(\'0\'), findsOneWidget);\n'
    '\n'
    'notifier.value = 7;\n'
    'await tester.pump(); // schedule the rebuild\n'
    'expect(find.text(\'7\'), findsOneWidget);\n'
    '\n'
    'notifier.dispose();',
    caption: 'flutter_test :: widget test for ValueListenableBuilder',
  ));
  sections.add(proseParagraph(
    'Debugging a bell that is not ringing is a matter of checking the '
    'three places it could fail. First, is the listener actually '
    'subscribed? If a parent is rebuilding the ValueListenableBuilder '
    'with a fresh ValueNotifier on every frame, the State sees a new '
    'listenable, unsubscribes from the old, subscribes to the new, '
    'and the old bell\'s ringing falls on deaf ears. Second, is the '
    'value actually different? ValueNotifier checks == before '
    'notifying; assigning the same primitive twice is a no-op. Third, '
    'is the listener still attached? If you have manually called '
    'removeListener or dispose, the bell rings into a void. Print '
    'inside the builder, print inside the ringer, and the answer '
    'usually emerges within a frame or two.',
  ));
  sections.add(codeBlock(
    '// Diagnostic prints to drop into a misbehaving bell:\n'
    'final notifier = ValueNotifier<int>(0);\n'
    '\n'
    'notifier.addListener(() {\n'
    '  debugPrint(\'[diag] bell rang, .value is now \${notifier.value}\');\n'
    '});\n'
    '\n'
    '// Inside the builder:\n'
    'ValueListenableBuilder<int>(\n'
    '  valueListenable: notifier,\n'
    '  builder: (ctx, value, child) {\n'
    '    debugPrint(\'[diag] keeper rebuilds with value=\$value\');\n'
    '    return Text(\'\$value\');\n'
    '  },\n'
    ');\n'
    '\n'
    '// At the ringing site:\n'
    'void _ring(int next) {\n'
    '  debugPrint(\'[diag] about to ring; old=\${notifier.value}, new=\$next\');\n'
    '  notifier.value = next;\n'
    '  debugPrint(\'[diag] ring complete; .value=\${notifier.value}\');\n'
    '}',
    caption: 'three prints :: subscriber, builder, ringer',
  ));
  sections.add(keeperMargin(
    'A persistent silence almost always means the keeper changed the '
    'reference of the listenable instead of the value inside it. The '
    'bell is fine. The keeper just keeps swapping it for an identical '
    'twin and ringing the twin instead.',
  ));

  // -------------------------------------------------------------------------
  // Closing colophon
  // -------------------------------------------------------------------------
  print('[bell-lavender] closing colophon');
  sections.add(Container(
    margin: const EdgeInsets.fromLTRB(18, 24, 18, 24),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    decoration: BoxDecoration(
      color: cLavenderPale,
      border: Border.all(color: cLavenderDeep, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Colophon',
          style: TextStyle(
            fontFamily: kSerif,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: cLavenderInk,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This diary was set in Georgia for the prose and Courier New '
          'for the code, printed on parchment-bell paper, and bound in '
          'lavender-deep cloth with brass-bell endpapers. The keeper '
          'thanks the framework authors for designing a contract small '
          'enough to fit on a postcard, and rich enough to fill a '
          'campanile. Good night, and may your bells ring true.',
          style: italicStyle(size: 12),
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: cLavenderDeep),
        const SizedBox(height: 8),
        Text(
          'snapshot taken at twilight   ::   one frame, no second chime',
          style: TextStyle(
            fontFamily: kMono,
            fontSize: 11,
            color: cInkSoft,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
  ));

  // -------------------------------------------------------------------------
  // Final assembly. Every section becomes a child of the outer Column,
  // wrapped in a Container that paints the cloister-wall background and
  // gives the diary a uniform width.
  // -------------------------------------------------------------------------
  print('[bell-lavender] final assembly: \${sections.length} sections');
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #138, P2)
  // ---------------------------------------------------------------------------
  // Baseline frameworkErrors=1: "A RenderFlex overflowed by 10044 pixels on
  // the bottom." The page root packs all dossier sections (anchor, banner,
  // anatomy, gallery, recipes, …) into a Container > Column with no scroll
  // ancestor. Combined intrinsic height ≈ 10044 px, vastly exceeding any
  // desktop viewport — exact match to the baseline overflow delta.
  //
  // Plan label was P1+P2, but grep across the file confirms no
  // `CrossAxisAlignment.stretch` site exists anywhere — the page-root Column
  // uses CrossAxisAlignment.start. P1 (IntrinsicHeight wrap) therefore does
  // not materialise; the fix reduces to a P2-only page-root SCV wrap (same
  // pattern as items 104, 105, 120, 133, 136).
  //
  // The gradient `Container(decoration: …)` stays *outside* the SCV so the
  // cloister-wall backdrop fills the whole viewport rather than just the
  // scrolled content. The 12 px symmetric vertical padding moves onto the
  // SCV so the top/bottom inset is preserved.
  final Widget body = Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[cIvoryFrame, cLavenderPale],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: sections,
      ),
    ),
  );

  print('[bell-lavender] keeper closes the diary; the bells fall silent');
  return body;
}

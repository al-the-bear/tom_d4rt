// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
//  TIDE LIMESTONE                                                            //
//  A hand-written demo for: PersistentHeaderShowOnScreenConfiguration        //
//                                                                            //
//  This script is intentionally long and explanatory. It is a teaching       //
//  artifact more than a unit test: every section is meant to be read,        //
//  studied, and copied into other places where the reader needs to bring     //
//  a sliver persistent header up onto the screen for accessibility.          //
//                                                                            //
//  ------------------------------------------------------------------------- //
//  WHY DOES THIS CLASS EXIST?                                                //
//  ------------------------------------------------------------------------- //
//                                                                            //
//  Flutter's sliver protocol lets a header pin or float above scrolling      //
//  content. When the platform asks the framework to scroll something         //
//  ON-SCREEN -- for example because the screen reader's focus rectangle      //
//  has just landed there, or because a text field requested to be shown --   //
//  the framework asks each ancestor in turn to "make room".                  //
//                                                                            //
//  RenderSliverPersistentHeader.showOnScreen is the place where, for a       //
//  pinned/floating header, we decide HOW MUCH of the header to expose.       //
//  Sometimes a 16-pixel sliver is enough. Sometimes you must reveal the      //
//  whole 120-pixel banner because a screen-reader user needs to read         //
//  every word of it. PersistentHeaderShowOnScreenConfiguration is the        //
//  little value object that carries that decision.                           //
//                                                                            //
//  ------------------------------------------------------------------------- //
//  CONSTRUCTOR SHAPE                                                         //
//  ------------------------------------------------------------------------- //
//                                                                            //
//    const PersistentHeaderShowOnScreenConfiguration({                       //
//      double minShowOnScreenExtent = double.negativeInfinity,               //
//      double maxShowOnScreenExtent = double.infinity,                       //
//    })                                                                      //
//                                                                            //
//  ------------------------------------------------------------------------- //
//  THEME                                                                     //
//  ------------------------------------------------------------------------- //
//                                                                            //
//  This file paints itself in TIDE LIMESTONE -- a palette of pale stone,     //
//  weathered driftwood, sea-glass green, and the damp grey of a tide pool    //
//  in early morning. The palette is defined in code below; treat the       //
//  comments as the artist's notes: every colour has a job and a memory.     //
//                                                                            //
//  ------------------------------------------------------------------------- //
//  D4RT NOTES                                                                //
//  ------------------------------------------------------------------------- //
//                                                                            //
//  * No StatefulWidget, no setState, no controllers, no timers/futures.      //
//  * build() is called exactly once, returning a static snapshot.           //
//  * Avoid for-in over BridgedInstance; build the lists explicitly.         //
//  * Use Color.withValues(alpha: ...) instead of withOpacity.               //
//                                                                            //
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ---------------------------------------------------------------------------
// PALETTE  -- "Tide Limestone"
// ---------------------------------------------------------------------------
//
// Twelve named colours. Each one is used at least once in the demo body.
// Names are deliberately evocative -- "BleachedDriftwood" is a colour that
// tells you what it wants to be next to.
//

const Color kTideLimestone       = Color(0xFFEDE6D6); // background, soft ivory stone
const Color kBleachedDriftwood   = Color(0xFFC8B79A); // section card surface
const Color kHarbourFog          = Color(0xFFB8C2C0); // muted grey-green dividers
const Color kSeaglassPale        = Color(0xFFA8C4B0); // accent for "default" values
const Color kSeaglassDeep        = Color(0xFF5F8A77); // accent for "constrained" values
const Color kTidepoolNight       = Color(0xFF1F2D2B); // primary text
const Color kSaltSpray           = Color(0xFFF6F1E4); // raised tile
const Color kRustyAnchor         = Color(0xFFB35F3D); // warning / AVOID
const Color kKelpShadow          = Color(0xFF3B4F3F); // strong text
const Color kCoralBleach         = Color(0xFFE8B4A2); // soft warning highlight
const Color kSandbarHighlight    = Color(0xFFD9C9A8); // matrix highlight
const Color kFoamWhite           = Color(0xFFFAF6EC); // inner card surface
const Color kStormGlass          = Color(0xFF26393A); // diagram fills
const Color kBeachPlumPurple     = Color(0xFF7A5C7A); // glossary accent

// ---------------------------------------------------------------------------
// TYPOGRAPHY HELPERS
// ---------------------------------------------------------------------------

TextStyle _h1() => const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: kTidepoolNight,
      letterSpacing: 0.4,
    );

TextStyle _h2() => const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: kKelpShadow,
      letterSpacing: 0.2,
    );

TextStyle _h3() => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: kKelpShadow,
    );

TextStyle _body() => const TextStyle(
      fontSize: 13,
      height: 1.45,
      color: kTidepoolNight,
    );

TextStyle _mono() => const TextStyle(
      fontSize: 12.5,
      fontFamily: 'monospace',
      color: kTidepoolNight,
      height: 1.4,
    );

TextStyle _label() => const TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: kSeaglassDeep,
    );

// ---------------------------------------------------------------------------
// LITTLE BUILDING BLOCKS
// ---------------------------------------------------------------------------

Widget _gap(double h) => SizedBox(height: h);
Widget _gapW(double w) => SizedBox(width: w);

Widget _divider() => Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: kHarbourFog.withValues(alpha: 0.6),
    );

Widget _swatch(Color c, String name, String purpose) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.all(8),
    width: 168,
    decoration: BoxDecoration(
      color: kFoamWhite,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kHarbourFog),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: kTidepoolNight.withValues(alpha: 0.25)),
          ),
        ),
        _gapW(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: kTidepoolNight)),
              _gap(2),
              Text(purpose,
                  style: const TextStyle(
                      fontSize: 10.5,
                      color: kKelpShadow,
                      height: 1.2)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionCard({required String tag, required String title, required Widget child}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kBleachedDriftwood.withValues(alpha: 0.40),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: kHarbourFog.withValues(alpha: 0.7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: kSeaglassDeep,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(tag,
                  style: const TextStyle(
                      color: kFoamWhite,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0)),
            ),
            _gapW(10),
            Expanded(child: Text(title, style: _h2())),
          ],
        ),
        _gap(10),
        child,
      ],
    ),
  );
}

Widget _kvLine(String k, String v, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Text(k,
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: accent ?? kKelpShadow)),
        ),
        Expanded(child: Text(v, style: _mono())),
      ],
    ),
  );
}

Widget _bullet(String s) {
  return Padding(
    padding: const EdgeInsets.only(left: 6, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('-  ',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: kSeaglassDeep)),
        Expanded(child: Text(s, style: _body())),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kStormGlass,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: kFoamWhite,
            height: 1.4)),
  );
}

Widget _calloutDo(String head, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kSeaglassPale.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(6),
      border: Border(left: BorderSide(width: 4, color: kSeaglassDeep)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DO  $head', style: _label()),
        _gap(4),
        Text(body, style: _body()),
      ],
    ),
  );
}

Widget _calloutAvoid(String head, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: kCoralBleach.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(6),
      border: const Border(left: BorderSide(width: 4, color: kRustyAnchor)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AVOID  $head',
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: kRustyAnchor)),
        _gap(4),
        Text(body, style: _body()),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// build()
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('========================================================');
  print('Tide Limestone -- PersistentHeaderShowOnScreenConfiguration');
  print('========================================================');
  print('Constructing 10+ configurations to inspect their fields.');

  // Construct several configurations. We will read .min/.max from each into
  // Text widgets later, so each one is observably distinct. We deliberately
  // mix sentinel values (negativeInfinity, infinity) and finite values.
  final cfgDefault = PersistentHeaderShowOnScreenConfiguration();
  final cfgZeroToHundred = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 100.0,
  );
  final cfgFiftyTwoHundred = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 50.0,
    maxShowOnScreenExtent: 200.0,
  );
  final cfgPinned = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 56.0,
    maxShowOnScreenExtent: 56.0,
  );
  final cfgZeroZero = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 0.0,
  );
  final cfgFloating = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: double.infinity,
  );
  final cfgWide = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 24.0,
    maxShowOnScreenExtent: 320.0,
  );
  final cfgScreenReader = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 88.0,
    maxShowOnScreenExtent: double.infinity,
  );
  final cfgClampSmall = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 16.0,
    maxShowOnScreenExtent: 32.0,
  );
  final cfgLargeBanner = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 120.0,
    maxShowOnScreenExtent: 240.0,
  );

  print('cfgDefault       min=${cfgDefault.minShowOnScreenExtent}'
      ' max=${cfgDefault.maxShowOnScreenExtent}');
  print('cfgZeroToHundred min=${cfgZeroToHundred.minShowOnScreenExtent}'
      ' max=${cfgZeroToHundred.maxShowOnScreenExtent}');
  print('cfgPinned        min=${cfgPinned.minShowOnScreenExtent}'
      ' max=${cfgPinned.maxShowOnScreenExtent}');
  print('cfgFloating      min=${cfgFloating.minShowOnScreenExtent}'
      ' max=${cfgFloating.maxShowOnScreenExtent}');
  print('cfgScreenReader  min=${cfgScreenReader.minShowOnScreenExtent}'
      ' max=${cfgScreenReader.maxShowOnScreenExtent}');
  print('cfgLargeBanner   min=${cfgLargeBanner.minShowOnScreenExtent}'
      ' max=${cfgLargeBanner.maxShowOnScreenExtent}');
  print('Sections built: 12. Returning snapshot tree.');

  // -------------------------------------------------------------------------
  // SECTION 1 -- TITLE BANNER + PALETTE SWATCHES
  // -------------------------------------------------------------------------
  final s1 = Container(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          kSeaglassDeep.withValues(alpha: 0.95),
          kKelpShadow.withValues(alpha: 0.95),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TIDE LIMESTONE',
            style: TextStyle(
                color: kSaltSpray,
                fontSize: 12,
                letterSpacing: 4.0,
                fontWeight: FontWeight.w700)),
        _gap(6),
        Text('PersistentHeaderShowOnScreenConfiguration',
            style: _h1().copyWith(color: kFoamWhite, fontSize: 24)),
        _gap(6),
        Text(
          'A small immutable value object that tells a sliver persistent '
          'header how much of itself to reveal when an accessibility '
          'request -- like screen-reader focus or a textfield asking to '
          'be visible -- arrives via showOnScreen.',
          style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: kSaltSpray.withValues(alpha: 0.95)),
        ),
        _gap(14),
        Text('PALETTE -- TIDE LIMESTONE',
            style: TextStyle(
                color: kSandbarHighlight.withValues(alpha: 0.9),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6)),
        _gap(8),
        Wrap(
          children: [
            _swatch(kTideLimestone, 'TideLimestone', 'page background, ivory stone'),
            _swatch(kBleachedDriftwood, 'BleachedDriftwood', 'section card surface'),
            _swatch(kHarbourFog, 'HarbourFog', 'dividers and rules'),
            _swatch(kSeaglassPale, 'SeaglassPale', 'soft accent (default)'),
            _swatch(kSeaglassDeep, 'SeaglassDeep', 'strong accent (set value)'),
            _swatch(kTidepoolNight, 'TidepoolNight', 'primary text'),
            _swatch(kSaltSpray, 'SaltSpray', 'raised tile background'),
            _swatch(kRustyAnchor, 'RustyAnchor', 'AVOID warning'),
            _swatch(kKelpShadow, 'KelpShadow', 'heading text'),
            _swatch(kCoralBleach, 'CoralBleach', 'soft warning highlight'),
            _swatch(kSandbarHighlight, 'SandbarHighlight', 'matrix highlight'),
            _swatch(kFoamWhite, 'FoamWhite', 'inner card surface'),
            _swatch(kStormGlass, 'StormGlass', 'code-block fill'),
            _swatch(kBeachPlumPurple, 'BeachPlumPurple', 'glossary accent'),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 -- PROSE ANATOMY
  // -------------------------------------------------------------------------
  final s2 = _sectionCard(
    tag: '02 PROSE',
    title: 'Anatomy: persistent headers, sliver protocols, showOnScreen',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A persistent header is a sliver that stays at the top (or bottom) '
          'of a viewport while content scrolls past it. SliverAppBar, '
          'SliverPersistentHeader, and the pinned/floating variants are '
          'all examples. Internally these are RenderObject subclasses of '
          'RenderSliverPersistentHeader.',
          style: _body(),
        ),
        _gap(8),
        Text(
          'When something below the header asks the framework to scroll itself '
          'on-screen -- a TextField requesting visibility, an a11y focus '
          'rectangle landing on a button, an explicit Scrollable.ensureVisible '
          'call -- the request walks up the render tree. Each ancestor that '
          'can scroll cooperates. The persistent header is one of those '
          'ancestors.',
          style: _body(),
        ),
        _gap(8),
        Text(
          'For pinned and floating headers, the question becomes: "How much '
          'of MYSELF should I reveal so that the descendant is visible AND '
          'enough of me is visible too?" That is the question this '
          'configuration object answers.',
          style: _body(),
        ),
        _gap(10),
        _bullet('minShowOnScreenExtent: the LEAST the header is willing to expose.'),
        _bullet('maxShowOnScreenExtent: the MOST the header is willing to expose.'),
        _bullet('Both are clamped against the header\'s natural extent range.'),
        _bullet('Defaults are sentinels (-inf, +inf) meaning "do not constrain me".'),
        _bullet('The configuration is immutable. Build a new one to change behaviour.'),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 -- PROPERTY ANATOMY
  // -------------------------------------------------------------------------
  final s3 = _sectionCard(
    tag: '03 PROPS',
    title: 'Properties: minShowOnScreenExtent / maxShowOnScreenExtent',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _kvLine('Property', 'Type / Default / Sentinel'),
        _divider(),
        _kvLine('minShowOnScreenExtent',
            'double  =  double.negativeInfinity  (sentinel: "no minimum")'),
        _kvLine('maxShowOnScreenExtent',
            'double  =  double.infinity          (sentinel: "no maximum")'),
        _gap(8),
        Text(
          'A sentinel value of double.negativeInfinity for the minimum means '
          '"I have no opinion about a lower bound -- let the underlying header '
          'decide". The same idea applies to double.infinity for the maximum. '
          'These are the values you read on a default-constructed instance.',
          style: _body(),
        ),
        _gap(8),
        _kvLine('cfgDefault.minShowOnScreenExtent',
            cfgDefault.minShowOnScreenExtent.toString()),
        _kvLine('cfgDefault.maxShowOnScreenExtent',
            cfgDefault.maxShowOnScreenExtent.toString()),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 -- CONSTRUCTION GALLERY (8+ live instances)
  // -------------------------------------------------------------------------
  Widget instanceTile(String label, String descr,
      PersistentHeaderShowOnScreenConfiguration cfg) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
      width: 280,
      decoration: BoxDecoration(
        color: kFoamWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kHarbourFog),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _h3()),
          _gap(2),
          Text(descr,
              style: const TextStyle(
                  fontSize: 11.5,
                  color: kKelpShadow,
                  height: 1.3)),
          _gap(6),
          Text('min  =  ${cfg.minShowOnScreenExtent}', style: _mono()),
          Text('max  =  ${cfg.maxShowOnScreenExtent}', style: _mono()),
        ],
      ),
    );
  }

  final s4 = _sectionCard(
    tag: '04 GALLERY',
    title: 'Construction gallery: 10 instances with varied extents',
    child: Wrap(
      children: [
        instanceTile('cfgDefault',
            'no min, no max -- header decides on its own.', cfgDefault),
        instanceTile('cfgZeroToHundred',
            'expose between 0 and 100 logical pixels.', cfgZeroToHundred),
        instanceTile('cfgFiftyTwoHundred',
            'expose at least 50, at most 200.', cfgFiftyTwoHundred),
        instanceTile('cfgPinned',
            'force exactly the pinned extent (56=56).', cfgPinned),
        instanceTile('cfgZeroZero',
            'never reveal more than the pinned remainder.', cfgZeroZero),
        instanceTile('cfgFloating',
            'expose any amount up to infinity.', cfgFloating),
        instanceTile('cfgWide',
            'allow large reveals -- e.g. SliverAppBar.large.', cfgWide),
        instanceTile('cfgScreenReader',
            'guarantee 88px so a screen reader can read the title.',
            cfgScreenReader),
        instanceTile('cfgClampSmall',
            'narrow band (16..32) for compact headers.', cfgClampSmall),
        instanceTile('cfgLargeBanner',
            'between 120 and 240 -- a tall hero banner.', cfgLargeBanner),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 -- LIFECYCLE DIAGRAM
  // -------------------------------------------------------------------------
  Widget lifecycleStep(String n, String title, String body, Color accent) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
      width: 220,
      decoration: BoxDecoration(
        color: kFoamWhite,
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(width: 4, color: accent)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('STEP $n', style: _label()),
          _gap(4),
          Text(title, style: _h3()),
          _gap(4),
          Text(body, style: _body()),
        ],
      ),
    );
  }

  final s5 = _sectionCard(
    tag: '05 LIFECYCLE',
    title: 'Show-on-screen lifecycle: focus -> request -> reveal',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The lifecycle below is what happens when, for example, a screen '
          'reader walks to a button that lives behind a pinned header. The '
          'numbers correspond to the steps below.',
          style: _body(),
        ),
        _gap(8),
        Wrap(
          children: [
            lifecycleStep('1', 'Accessibility focus',
                'Platform delivers focus to a Semantics node nested in a sliver list.',
                kSeaglassDeep),
            lifecycleStep('2', 'showOnScreen call',
                'The framework calls showOnScreen on the focused RenderObject.',
                kSeaglassDeep),
            lifecycleStep('3', 'Walk to ancestors',
                'The call walks up the tree, asking each scrollable ancestor.',
                kKelpShadow),
            lifecycleStep('4', 'Header asked',
                'RenderSliverPersistentHeader.showOnScreen is invoked.',
                kKelpShadow),
            lifecycleStep('5', 'Configuration consulted',
                'The header reads minShowOnScreenExtent / maxShowOnScreenExtent.',
                kSeaglassDeep),
            lifecycleStep('6', 'Geometry computed',
                'A target extent is chosen, clamped to the header\'s natural extent.',
                kSeaglassDeep),
            lifecycleStep('7', 'Scroll dispatched',
                'The Scrollable receives a request to scroll by the difference.',
                kRustyAnchor),
            lifecycleStep('8', 'Animation runs',
                'Default Curves.ease over 100ms unless caller overrides.',
                kRustyAnchor),
            lifecycleStep('9', 'Frame painted',
                'Header now visible enough to satisfy the focused descendant.',
                kBeachPlumPurple),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 -- 4x3 EXTENT MATRIX
  // -------------------------------------------------------------------------
  Widget cell(String s, {Color? bg, bool head = false}) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bg ?? (head ? kSeaglassDeep : kFoamWhite),
        border: Border.all(color: kHarbourFog),
      ),
      child: Text(s,
          style: TextStyle(
              fontSize: 11.5,
              color: head ? kFoamWhite : kTidepoolNight,
              fontWeight: head ? FontWeight.w700 : FontWeight.w400,
              height: 1.3)),
    );
  }

  Widget matrixRow(List<Widget> cells) {
    return Row(children: cells);
  }

  final s6 = _sectionCard(
    tag: '06 MATRIX',
    title: 'Extent matrix: 4 mins x 3 maxes -> 12 expected behaviours',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        matrixRow([
          cell('min \\ max', head: true),
          cell('max = 0', head: true),
          cell('max = 100', head: true),
          cell('max = +inf (default)', head: true),
        ]),
        matrixRow([
          cell('min = -inf (default)', head: true),
          cell('Reveal nothing extra. Header keeps pinned remainder only.'),
          cell('Reveal up to 100; less is fine.', bg: kSandbarHighlight.withValues(alpha: 0.45)),
          cell('Reveal as much as the natural extent allows. CLASSIC default.'),
        ]),
        matrixRow([
          cell('min = 0', head: true),
          cell('Same as 0/0 -- never grow. Pinned-only.'),
          cell('Free band 0..100.'),
          cell('At least 0, no upper limit -- floating.'),
        ]),
        matrixRow([
          cell('min = 56', head: true),
          cell('INCONSISTENT: min > max. Behaviour clamped to max=0.', bg: kCoralBleach.withValues(alpha: 0.55)),
          cell('Force at least 56, allow up to 100.'),
          cell('Force at least 56, no upper limit.'),
        ]),
        matrixRow([
          cell('min = 120', head: true),
          cell('INCONSISTENT.', bg: kCoralBleach.withValues(alpha: 0.55)),
          cell('INCONSISTENT (min > max).', bg: kCoralBleach.withValues(alpha: 0.55)),
          cell('Force a tall reveal (>=120) for hero banners.'),
        ]),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 -- PINNED vs FLOATING (8+ rows)
  // -------------------------------------------------------------------------
  Widget compareRow(String topic, String pinned, String floating) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kHarbourFog.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 160,
              child: Text(topic,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: kKelpShadow))),
          Expanded(child: Text(pinned, style: _body())),
          _gapW(8),
          Expanded(child: Text(floating, style: _body())),
        ],
      ),
    );
  }

  final s7 = _sectionCard(
    tag: '07 COMPARE',
    title: 'Pinned vs floating headers: how this configuration is used',
    child: Column(
      children: [
        Row(
          children: [
            const SizedBox(
                width: 160,
                child: Text('Topic',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: kSeaglassDeep,
                        letterSpacing: 1.0))),
            Expanded(
                child: Text('PINNED', style: _label())),
            _gapW(8),
            Expanded(
                child: Text('FLOATING', style: _label())),
          ],
        ),
        _gap(6),
        compareRow('Render type',
            'RenderSliverPinnedPersistentHeader',
            'RenderSliverFloatingPersistentHeader'),
        compareRow('Resting size',
            'Stays visible at minExtent while scrolling.',
            'Goes off-screen when fully scrolled out.'),
        compareRow('On a11y focus',
            'Often only needs to confirm minExtent.',
            'Must scroll itself back in before revealing more.'),
        compareRow('Default config',
            'min=-inf max=+inf is fine -- the pinned remainder dominates.',
            'min=-inf max=+inf is fine but tends to expose the full header.'),
        compareRow('Custom config use',
            'Force min=56 to keep the title row in view for screen readers.',
            'Force max=100 to avoid covering content with the full hero.'),
        compareRow('Animation',
            'Smooth slide of the variable extent.',
            'Often a snap when a floating header re-enters.'),
        compareRow('Risk',
            'Hiding the focused widget behind the pinned bar.',
            'Re-entry hiding the focused widget if min not set.'),
        compareRow('Mitigation',
            'Use min >= height of focusable controls in the header.',
            'Use min equal to the header content height for clarity.'),
        compareRow('Test hook',
            'showOnScreenInternal called with a Rect overlap.',
            'Same, plus an extra scroll request on the parent.'),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 -- CODE TRACE DIAGRAM
  // -------------------------------------------------------------------------
  final s8 = _sectionCard(
    tag: '08 TRACE',
    title: 'Code-trace: which RenderObject method consumes this',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'When showOnScreen lands on a sliver persistent header, this is the '
          'rough call sequence (Flutter 3.22+). The configuration is read at '
          'the marked line.',
          style: _body(),
        ),
        _gap(8),
        _codeBlock(
          'RenderObject.showOnScreen(descendant, rect, duration, curve)\n'
          '  -> _SliverPersistentHeader._showOnScreenForLeadingEdge(\n'
          '       leadingEdgeOffset,\n'
          '     )\n'
          '  -> RenderSliverPersistentHeader.showOnScreen(\n'
          '       descendant,\n'
          '       rect,\n'
          '       duration,\n'
          '       curve,\n'
          '     )\n'
          '       |   reads:\n'
          '       |     this.showOnScreenConfiguration\n'
          '       |       .minShowOnScreenExtent     <-- HERE\n'
          '       |       .maxShowOnScreenExtent     <-- HERE\n'
          '       v\n'
          '  -> Scrollable.ensureVisible( ...clamped extent... )\n'
          '  -> ScrollPosition.animateTo(target, duration, curve)',
        ),
        _gap(8),
        Text(
          'The configuration acts as a clamp: the header computes the natural '
          'amount of itself it would reveal, then forces it into the [min,max] '
          'band defined by these two doubles.',
          style: _body(),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 -- DO / AVOID CALLOUTS
  // -------------------------------------------------------------------------
  final s9 = _sectionCard(
    tag: '09 RULES',
    title: 'Do / Avoid: choosing min and max',
    child: Column(
      children: [
        _calloutDo('Use defaults first',
            'For most apps, the default (-inf, +inf) is correct. Override only '
            'when you have evidence of an a11y or layout problem.'),
        _calloutDo('Pin the focusable area',
            'If your header contains a TextField or buttons, set min to at '
            'least the height of those controls so they cannot hide behind '
            'a partially-revealed header.'),
        _calloutDo('Cap large hero banners',
            'For SliverAppBar.large, set max to the visible content height '
            '(say, 160) so the banner does not eclipse the focused item.'),
        _calloutDo('Express intent in code',
            'Name your configuration: cfgScreenReader, cfgPinnedTitle, etc. '
            'Document why the constants exist.'),
        _calloutAvoid('min > max',
            'Never set min greater than max. The framework clamps it but the '
            'behaviour is hard to read.'),
        _calloutAvoid('Magic numbers',
            'Do not hard-code "56" with no explanation. Use a named constant '
            'or comment with the reason (kPinnedTitleHeight).'),
        _calloutAvoid('Mutating mid-scroll',
            'Do not allocate a fresh configuration on every layout call. '
            'Cache one instance per delegate.'),
        _calloutAvoid('Ignoring tests',
            'showOnScreen behaviour changes with curves and durations. Cover '
            'it with widget tests using WidgetTester.ensureVisible.'),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 -- CODE SNIPPET CARDS
  // -------------------------------------------------------------------------
  Widget snippetCard(String title, String descr, String code) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kSaltSpray,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kHarbourFog),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _h3()),
          _gap(4),
          Text(descr, style: _body()),
          _gap(8),
          _codeBlock(code),
        ],
      ),
    );
  }

  final s10 = _sectionCard(
    tag: '10 SNIPPETS',
    title: 'Five recipes',
    child: Column(
      children: [
        snippetCard(
          'Recipe 1 - Default (no constraints)',
          'Use the empty constructor when the header should follow the natural '
          'showOnScreen behaviour with no clamping.',
          'final cfg = PersistentHeaderShowOnScreenConfiguration();',
        ),
        snippetCard(
          'Recipe 2 - Force a minimum reveal for screen readers',
          'Guarantee that 88 logical pixels of the header are exposed so the '
          'title row stays readable when focus arrives below it.',
          'final cfg = PersistentHeaderShowOnScreenConfiguration(\n'
          '  minShowOnScreenExtent: 88.0,\n'
          ');',
        ),
        snippetCard(
          'Recipe 3 - Cap a hero SliverAppBar.large',
          'Keep the hero banner from covering the focused widget by capping '
          'the maximum reveal at 160 pixels.',
          'final cfg = PersistentHeaderShowOnScreenConfiguration(\n'
          '  maxShowOnScreenExtent: 160.0,\n'
          ');',
        ),
        snippetCard(
          'Recipe 4 - Pinned-only behaviour',
          'When you really do not want the header to grow on showOnScreen, '
          'set both min and max to zero. The pinned remainder still applies.',
          'final cfg = PersistentHeaderShowOnScreenConfiguration(\n'
          '  minShowOnScreenExtent: 0.0,\n'
          '  maxShowOnScreenExtent: 0.0,\n'
          ');',
        ),
        snippetCard(
          'Recipe 5 - Custom RenderSliverPinnedPersistentHeader',
          'In a custom render object, expose the configuration via a '
          'getter so subclasses and tests can replace it without rebuilding '
          'the whole render tree.',
          'class MyPinnedHeader extends RenderSliverPinnedPersistentHeader {\n'
          '  @override\n'
          '  PersistentHeaderShowOnScreenConfiguration\n'
          '      get showOnScreenConfiguration =>\n'
          '          const PersistentHeaderShowOnScreenConfiguration(\n'
          '            minShowOnScreenExtent: 56.0,\n'
          '          );\n'
          '}',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 -- GLOSSARY (12+ terms)
  // -------------------------------------------------------------------------
  Widget glossEntry(String term, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 230,
            child: Text(term,
                style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: kBeachPlumPurple)),
          ),
          Expanded(child: Text(body, style: _body())),
        ],
      ),
    );
  }

  final s11 = _sectionCard(
    tag: '11 GLOSSARY',
    title: 'Glossary',
    child: Column(
      children: [
        glossEntry('Sliver',
            'A scrollable widget primitive that lays out lazily within a viewport.'),
        glossEntry('Persistent header',
            'A sliver that retains a presence at the leading edge while content scrolls.'),
        glossEntry('Pinned header',
            'A persistent header that never scrolls completely out of view.'),
        glossEntry('Floating header',
            'A persistent header that can leave the viewport but jumps back when scrolling reverses.'),
        glossEntry('showOnScreen',
            'A RenderObject method that asks the render tree to scroll a region into view.'),
        glossEntry('minShowOnScreenExtent',
            'Lower clamp on how much of the header is exposed during showOnScreen.'),
        glossEntry('maxShowOnScreenExtent',
            'Upper clamp on how much of the header is exposed during showOnScreen.'),
        glossEntry('Sentinel value',
            'A value (here -inf or +inf) that signals "no opinion" rather than a real number.'),
        glossEntry('Natural extent',
            'The header\'s preferred extent computed from its delegate, before clamping.'),
        glossEntry('Pinned remainder',
            'The portion of a pinned header that always remains visible at minExtent.'),
        glossEntry('Accessibility focus',
            'The platform-tracked region a screen reader is currently announcing.'),
        glossEntry('Scrollable.ensureVisible',
            'High-level helper that drives showOnScreen with a duration and curve.'),
        glossEntry('SliverConstraints',
            'The geometric input the sliver receives during layout.'),
        glossEntry('SliverGeometry',
            'The geometric output the sliver produces during layout.'),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 12 -- RECAP FOOTER
  // -------------------------------------------------------------------------
  final s12 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: kKelpShadow,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('RECAP',
            style: TextStyle(
                color: kSandbarHighlight.withValues(alpha: 0.95),
                fontSize: 11,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w800)),
        _gap(6),
        const Text(
          'PersistentHeaderShowOnScreenConfiguration is a tiny, immutable, '
          'two-double clamp.',
          style: TextStyle(
              color: kFoamWhite, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        _gap(8),
        Text(
          'Its only job is to put a floor and a ceiling on how much of a '
          'sliver persistent header is revealed when showOnScreen runs. The '
          'defaults (-inf, +inf) are correct most of the time. Reach for '
          'custom values when accessibility focus, hero banners, or pinned '
          'controls require predictable behaviour.',
          style: TextStyle(
              color: kSaltSpray.withValues(alpha: 0.9),
              fontSize: 13,
              height: 1.5),
        ),
        _gap(10),
        Text('cfgPinned         -> ${cfgPinned.minShowOnScreenExtent}'
            ' .. ${cfgPinned.maxShowOnScreenExtent}',
            style: const TextStyle(
                color: kFoamWhite, fontFamily: 'monospace', fontSize: 12)),
        Text('cfgScreenReader   -> ${cfgScreenReader.minShowOnScreenExtent}'
            ' .. ${cfgScreenReader.maxShowOnScreenExtent}',
            style: const TextStyle(
                color: kFoamWhite, fontFamily: 'monospace', fontSize: 12)),
        Text('cfgLargeBanner    -> ${cfgLargeBanner.minShowOnScreenExtent}'
            ' .. ${cfgLargeBanner.maxShowOnScreenExtent}',
            style: const TextStyle(
                color: kFoamWhite, fontFamily: 'monospace', fontSize: 12)),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // ASSEMBLE
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: kTideLimestone,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          s1,
          s2,
          s3,
          s4,
          s5,
          s6,
          s7,
          s8,
          s9,
          s10,
          s11,
          s12,
        ],
      ),
    ),
  );
}

// ============================================================================
// END OF FILE -- TIDE LIMESTONE                                              //
// ============================================================================
//                                                                            //
//  Reading notes for whoever opens this next:                                //
//                                                                            //
//  * The configuration is a value object. Equality / hashCode are not        //
//    overridden in the public API as of writing; do not rely on              //
//    structural equality across instances.                                   //
//                                                                            //
//  * The defaults are sentinel infinities. Reading them as literal numbers   //
//    inside arithmetic will misbehave; always treat them as "no opinion"     //
//    sentinels.                                                              //
//                                                                            //
//  * showOnScreen is reached not only via Scrollable.ensureVisible but also  //
//    via a11y semantics actions (scrollTo) and via Focus.onFocusChange       //
//    when an autofocus widget appears below a pinned header.                 //
//                                                                            //
//  * In tests, prefer WidgetTester.ensureVisible or render-object level      //
//    invocations of showOnScreen with explicit Rects. Mocking the platform   //
//    a11y focus is brittle.                                                  //
//                                                                            //
//  * Inside d4rt the value object is bridged like any other Flutter class:   //
//    BridgedInstance wraps it, getters return doubles, the constructor       //
//    accepts named arguments. The script above demonstrates ten distinct     //
//    bridged constructions to verify generator coverage.                     //
//                                                                            //
//  * If you fork this file, keep the palette, the section count, and the    //
//    "build is called once" property. The d4rt harness explicitly relies on  //
//    a single static snapshot tree and on the absence of state.              //
//                                                                            //
//  * The point of the gallery in section 4 is not visual decoration; each    //
//    tile reads a real .min / .max from a real instance, exercising the      //
//    bridged getter wiring on the path the generator emits.                  //
//                                                                            //
//  * Always remember: this class is a CLAMP. If you find yourself reaching   //
//    for a third value, you are looking for something else (showOnScreen     //
//    duration, curve, alignment policy) -- not this configuration.           //
//                                                                            //
//  --                                                                        //
//  Tide Limestone, written by hand, line by line, for readers and bridges.   //
// ============================================================================
//                                                                            //
// ============================================================================
//  APPENDIX A -- A LONGER WALK THROUGH SHOW-ON-SCREEN                        //
// ============================================================================
//                                                                            //
//  The following appendix is an extended narrative that complements the      //
//  visual sections above. It exists in comment form so that it never adds    //
//  to the rendered tree but always travels with the file. If you are        //
//  diffing this file you can ignore the appendix; if you are reading it     //
//  to learn, the appendix is the textbook.                                  //
//                                                                            //
//  A.1  WHAT IS A "SLIVER"?                                                  //
//  -----------------------------------------------------------------------   //
//  A sliver is a piece of a scrollable area. The big, recognizable           //
//  ListView is, internally, a SliverList wrapped in a Viewport. Each row     //
//  in a list is laid out lazily as scrolling brings it into the visible     //
//  region. The Sliver protocol is the contract that lets viewports hand     //
//  out viewport-shaped constraints to children that do not yet know how    //
//  big they need to be.                                                      //
//                                                                            //
//  Slivers communicate via two records:                                     //
//                                                                            //
//    * SliverConstraints  -- input  -- "here is your axis, your scroll      //
//      offset, your remaining paint extent, and so on".                     //
//    * SliverGeometry     -- output -- "here is how much I painted, how    //
//      much I want to scroll, whether I want to keep painting".             //
//                                                                            //
//  Persistent headers are slivers that paint a fixed-shape header. The      //
//  header has a minExtent and a maxExtent (decided by the delegate) and    //
//  varies between them based on scroll offset.                             //
//                                                                            //
//  A.2  WHEN DOES showOnScreen RUN?                                          //
//  -----------------------------------------------------------------------   //
//  showOnScreen is the framework's mechanism for "make this visible".        //
//  It is invoked in a number of situations:                                  //
//                                                                            //
//    * Scrollable.ensureVisible -- explicit programmatic call.              //
//    * Focus.requestFocus when policy is to scroll the focused widget       //
//      into view.                                                            //
//    * Screen-reader focus arriving on a Semantics node that is currently   //
//      partly or wholly off-screen.                                          //
//    * EditableText reacting to selection changes and the soft keyboard     //
//      pushing content up.                                                   //
//    * Custom render objects that opt-in by calling showOnScreen on their   //
//      parents.                                                              //
//                                                                            //
//  In all of these cases the request travels up the render tree, stopping   //
//  at every ancestor that overrides showOnScreen. RenderSliverPersistent-   //
//  Header is one such ancestor, and the configuration object documented in  //
//  this file is what it consults to decide how much of itself to expose.    //
//                                                                            //
//  A.3  WHY IS THE DEFAULT [-INF, +INF]?                                    //
//  -----------------------------------------------------------------------   //
//  Sentinels for "no opinion" are a recurring pattern in Flutter:           //
//                                                                            //
//    * BoxConstraints.unbounded  uses double.infinity to mean "no max".     //
//    * RenderBox uses double.nan / -1 in some places for "unset".           //
//    * SliverConstraints.precedingScrollExtent can also use infinity.        //
//                                                                            //
//  PersistentHeaderShowOnScreenConfiguration follows the same convention.   //
//  When you see (-inf, +inf) you should think "the configuration object     //
//  declines to constrain me; I, the header, decide".                        //
//                                                                            //
//  A.4  CHOOSING A MIN -- A WORKED EXAMPLE                                   //
//  -----------------------------------------------------------------------   //
//  Suppose you have a SliverAppBar pinned at the top with a TextField in    //
//  its title slot. The TextField is itself focusable. When the user taps    //
//  it, the framework scrolls the TextField on-screen. If the SliverAppBar  //
//  has shrunk to its pinned remainder (say 56 pixels), and the TextField   //
//  needs 48 pixels to be readable, the request will pass through the       //
//  SliverAppBar without growing it. This is correct -- the TextField is    //
//  inside the pinned remainder.                                              //
//                                                                            //
//  But suppose the SliverAppBar has multiple rows -- a title and a search   //
//  bar below it -- and only the search bar is in the pinned remainder.     //
//  When the user focuses a button in the title row (above the search bar)  //
//  the request will reach the SliverAppBar and ask it to grow. Without a   //
//  configuration, the appbar may grow only enough to expose a sliver of    //
//  the title. With min=120 you guarantee that the entire title row is      //
//  exposed.                                                                  //
//                                                                            //
//  A.5  CHOOSING A MAX -- A WORKED EXAMPLE                                   //
//  -----------------------------------------------------------------------   //
//  Now suppose your SliverAppBar.large has a 320-pixel hero banner. The    //
//  user has scrolled down so only the small (56-pixel) collapsed bar is    //
//  visible. They tap a control deep in the list. The framework would       //
//  happily grow the appbar all the way back to 320 pixels just to honour   //
//  showOnScreen, eclipsing the focused control. Setting max=160 keeps the  //
//  reveal modest -- enough to show context, not enough to hide intent.     //
//                                                                            //
//  A.6  INTERACTION WITH minExtent / maxExtent OF THE DELEGATE              //
//  -----------------------------------------------------------------------   //
//  The configuration's clamps are applied AFTER the header has computed   //
//  its natural reveal. The natural reveal is itself bounded by the         //
//  delegate's minExtent and maxExtent. So the final exposed extent is:    //
//                                                                            //
//    expose = clamp(                                                        //
//      natural_extent,                                                       //
//      max(delegate.minExtent, configuration.minShowOnScreenExtent),        //
//      min(delegate.maxExtent, configuration.maxShowOnScreenExtent)         //
//    );                                                                      //
//                                                                            //
//  Notice the OUTER clamp uses max() of the lower bounds and min() of the  //
//  upper bounds -- the more restrictive of the two wins.                   //
//                                                                            //
//  A.7  IMMUTABILITY AND ALLOCATION                                         //
//  -----------------------------------------------------------------------   //
//  The class is immutable: there are no setters. All instances are safe to  //
//  share across builds. Prefer to declare your configurations as            //
//  top-level const variables and reference them in delegates, rather than  //
//  building a fresh one on every layout.                                   //
//                                                                            //
//    static const PersistentHeaderShowOnScreenConfiguration                 //
//      kTitleHeaderConfig = PersistentHeaderShowOnScreenConfiguration(     //
//        minShowOnScreenExtent: 56.0,                                       //
//      );                                                                    //
//                                                                            //
//  A.8  WHEN NOT TO USE IT AT ALL                                           //
//  -----------------------------------------------------------------------   //
//  If you do not need accessibility focus or programmatic ensureVisible    //
//  to pop the header into view, you do not need this object at all. The    //
//  default behaviour is the right behaviour for almost every app.          //
//                                                                            //
//  Reach for it when:                                                       //
//                                                                            //
//    * Screen-reader testers report that focus jumps behind a pinned bar.  //
//    * UX requires that hero banners do not eclipse the focused widget.    //
//    * You are building a custom RenderSliverPersistentHeader subclass and  //
//      want consistent behaviour with the framework defaults.              //
//                                                                            //
//  A.9  TESTING NOTES                                                       //
//  -----------------------------------------------------------------------   //
//  Test the behaviour with WidgetTester:                                   //
//                                                                            //
//    testWidgets('focus reveals at least minShowOnScreenExtent',            //
//      (tester) async {                                                     //
//        await tester.pumpWidget(... appbar with min=88 ...);              //
//        await tester.tap(find.byKey(const Key('button-below')));          //
//        await tester.pumpAndSettle();                                     //
//        final RenderSliverPinnedPersistentHeader header =                  //
//          tester.renderObject(find.byType(SliverAppBar));                  //
//        expect(header.geometry!.paintExtent, greaterThanOrEqualTo(88.0)); //
//      },                                                                   //
//    );                                                                     //
//                                                                            //
//  A.10 BRIDGE NOTES (D4RT-SPECIFIC)                                        //
//  -----------------------------------------------------------------------   //
//  The bridge generator wraps each instance in a BridgedInstance. Reading  //
//  .minShowOnScreenExtent returns a Dart double. Constructor calls accept  //
//  named arguments matching the original signature. Equality on bridged    //
//  instances is reference-based, not structural -- if you need structural   //
//  equality, build a small helper that compares the two doubles.           //
//                                                                            //
// ============================================================================
//  APPENDIX B -- DIAGRAM IN ASCII                                            //
// ============================================================================
//                                                                            //
//  +---------------------------------------------------------------------+   //
//  |                          VIEWPORT                                   |   //
//  |  +---------------------------------------------------------------+  |   //
//  |  |                  SliverPersistentHeader                       |  |   //
//  |  |                                                               |  |   //
//  |  |   minExtent (delegate)         maxExtent (delegate)           |  |   //
//  |  |   |--------------------------------------------------|        |  |   //
//  |  |                                                               |  |   //
//  |  |   minShowOnScreenExtent ===\                                  |  |   //
//  |  |                             \                                 |  |   //
//  |  |                              CLAMP -> exposed extent          |  |   //
//  |  |                             /                                 |  |   //
//  |  |   maxShowOnScreenExtent ===/                                  |  |   //
//  |  +---------------------------------------------------------------+  |   //
//  |                                                                     |   //
//  |        ... rest of slivers (lists, grids, footers) ...              |   //
//  |                                                                     |   //
//  +---------------------------------------------------------------------+   //
//                                                                            //
//  Read the diagram top-down: a viewport contains a persistent header at    //
//  the top and other slivers below. The header itself has a delegate that  //
//  decides minExtent / maxExtent. When showOnScreen runs, the configuration //
//  object clamps the requested exposure to a band [min, max], producing the //
//  final exposed extent.                                                     //
//                                                                            //
// ============================================================================
//  APPENDIX C -- FREQUENTLY ASKED QUESTIONS                                   //
// ============================================================================
//                                                                            //
//  Q1. Can I read minShowOnScreenExtent on a default-constructed instance?  //
//  A1. Yes. It returns double.negativeInfinity. Treat that as "no opinion". //
//                                                                            //
//  Q2. What happens if min > max?                                            //
//  A2. The framework will clamp; behaviour is implementation-defined and    //
//      hard to read. Do not do it.                                           //
//                                                                            //
//  Q3. Does the configuration animate the reveal?                            //
//  A3. No. It only chooses the target extent. Animation is the caller's     //
//      responsibility (Scrollable.animateTo, with a duration and curve).    //
//                                                                            //
//  Q4. Can I change the configuration mid-scroll?                            //
//  A4. You can replace the configuration on a custom subclass at any time   //
//      but the change only takes effect on the next showOnScreen call.     //
//                                                                            //
//  Q5. Is this class const-constructable?                                    //
//  A5. Yes. Both fields are double, both have default values. Prefer const. //
//                                                                            //
//  Q6. Does it survive hot-reload?                                           //
//  A6. The class is immutable, so values you wrote in code persist after    //
//      hot-reload as long as the new build emits the same values.          //
//                                                                            //
//  Q7. What about RTL?                                                       //
//  A7. The configuration is independent of writing direction. minExtent is  //
//      a "leading edge" extent, which the framework interprets correctly   //
//      according to AxisDirection.                                          //
//                                                                            //
//  Q8. What about horizontal scrolling?                                     //
//  A8. The same rules apply, with extents measured along the scroll axis.  //
//                                                                            //
//  Q9. Can I observe how often showOnScreen runs?                            //
//  A9. Use the timeline (debugProfileShowOnScreen) or wrap your render     //
//      object in a debug-only counter. The configuration itself is silent.//
//                                                                            //
//  Q10. Can I subclass PersistentHeaderShowOnScreenConfiguration?           //
//  A10. Technically yes, but the API only reads the two doubles. Prefer    //
//       composition: build a factory that returns a configured instance.  //
//                                                                            //
// ============================================================================
//  APPENDIX D -- READING ORDER                                                //
// ============================================================================
//                                                                            //
//  If this is your first time reading this file, the suggested order is:    //
//                                                                            //
//    1. Section 1 -- title banner; pick up the colour vocabulary.           //
//    2. Section 2 -- prose anatomy; understand the goal.                    //
//    3. Section 3 -- property anatomy; learn the two doubles.               //
//    4. Section 4 -- gallery; see ten real instances.                       //
//    5. Section 5 -- lifecycle; understand the runtime sequence.            //
//    6. Section 8 -- code-trace; tie the lifecycle to a method.             //
//    7. Section 6 -- matrix; reason about combinations.                     //
//    8. Section 7 -- pinned vs floating; pick a default.                    //
//    9. Section 9 -- do/avoid rules; internalize the do's and don'ts.       //
//   10. Section 10 -- recipes; copy code into your project.                 //
//   11. Section 11 -- glossary; pin down vocabulary.                        //
//   12. Section 12 -- recap; close the loop.                                //
//   13. Appendix A through D -- when you have a quiet afternoon.            //
//                                                                            //
// ============================================================================
//  APPENDIX E -- COLOUR PROVENANCE                                           //
// ============================================================================
//                                                                            //
//  TideLimestone (#EDE6D6)      -- the ivory of damp stone in early light.  //
//  BleachedDriftwood (#C8B79A)  -- weathered wood washed up after storms.   //
//  HarbourFog (#B8C2C0)         -- the colour of fog over a stone harbour. //
//  SeaglassPale (#A8C4B0)       -- pale sea-glass found at low tide.       //
//  SeaglassDeep (#5F8A77)       -- deeper sea-glass, near old lichens.     //
//  TidepoolNight (#1F2D2B)      -- the dark of a tide pool before dawn.    //
//  SaltSpray (#F6F1E4)          -- the bone-white of salt on dark stone.   //
//  RustyAnchor (#B35F3D)        -- the rust of an old harbour anchor.      //
//  KelpShadow (#3B4F3F)         -- the green-black of kelp under water.    //
//  CoralBleach (#E8B4A2)        -- bleached coral fragments, near pink.    //
//  SandbarHighlight (#D9C9A8)   -- the gold of a sandbar at midday.        //
//  FoamWhite (#FAF6EC)          -- the white of sea foam holding for a sec.//
//  StormGlass (#26393A)         -- the green-black of storm glass at sea.  //
//  BeachPlumPurple (#7A5C7A)    -- the colour of beach plums in late fall. //
//                                                                            //
// ============================================================================
//  APPENDIX F -- LICENCE                                                     //
// ============================================================================
//                                                                            //
//  This file is part of the tom_d4rt_flutter_ast test suite. It is provided //
//  under the same licence as the surrounding workspace. The text and       //
//  diagrams may be reused in tutorials and internal training materials.    //
//                                                                            //
// ============================================================================
//  APPENDIX G -- EXTENDED CASE STUDIES                                       //
// ============================================================================
//                                                                            //
//  G.1  CASE: A CHAT APP WITH A PINNED COMPOSER                              //
//  -----------------------------------------------------------------------   //
//  In a chat app the message composer often lives at the bottom of the     //
//  screen as a pinned bottom sliver. When the keyboard opens, the focus   //
//  moves into the TextField inside the composer. Without a configuration  //
//  the framework will reveal exactly the natural extent of the composer   //
//  -- which may not be enough to expose the typing line above the         //
//  keyboard. With a configuration that sets min equal to the composer's   //
//  full height, the framework guarantees the typing line is in view.      //
//                                                                            //
//  G.2  CASE: A NEWSPAPER WITH A LARGE HERO IMAGE                            //
//  -----------------------------------------------------------------------   //
//  A long-form article uses SliverAppBar.large to show a 320-pixel hero    //
//  image. As the user reads, the appbar collapses to its 56-pixel pinned  //
//  remainder. If the user taps a "back to top" button -- which scrolls to //
//  the top via Scrollable.ensureVisible -- the appbar would naturally     //
//  re-grow to its full 320 pixels, jarring the eye. A max of 200 pixels   //
//  produces a softer reveal.                                                //
//                                                                            //
//  G.3  CASE: A SETTINGS SCREEN WITH NESTED HEADERS                         //
//  -----------------------------------------------------------------------   //
//  A settings screen uses several SliverPersistentHeader instances as      //
//  section dividers. Each section header is pinned. When the user navi-   //
//  gates with a switch-control or screen reader, focus travels from one   //
//  setting to the next. Without configurations, focus arriving inside a   //
//  section may bring up the section header above and obscure the focused  //
//  control. Each section header should set min=0 and max equal to its     //
//  natural extent (no growth on focus); the lifecycle ensures the focused //
//  control is exposed by the surrounding Scrollable, not by the header.   //
//                                                                            //
//  G.4  CASE: A KEYBOARD-DRIVEN TABLE                                       //
//  -----------------------------------------------------------------------   //
//  A keyboard-driven table places the column-header row inside a pinned   //
//  sliver. When focus moves down a column, the framework calls show-     //
//  OnScreen on each cell. The pinned column-header row should not grow   //
//  -- it is already pinned. min=0, max=0 keeps the header stable.        //
//                                                                            //
//  G.5  CASE: A FORM WITH AUTOFOCUS                                         //
//  -----------------------------------------------------------------------   //
//  A form opens with an autofocused field below a SliverAppBar. The auto- //
//  focus triggers showOnScreen automatically. If the appbar contains a   //
//  small "submit" button, set min equal to the button's height plus         //
//  padding so the user can see the affordance before they start typing.  //
//                                                                            //
//  G.6  CASE: A MAP WITH A FLOATING SEARCH BAR                              //
//  -----------------------------------------------------------------------   //
//  A map screen uses a floating SliverAppBar with a search bar. When the //
//  user taps the search bar, focus moves into a TextField. The appbar    //
//  re-floats; without a configuration, the natural reveal is the full   //
//  search bar height. min=that height, max=that height makes the reveal  //
//  exact.                                                                   //
//                                                                            //
//  G.7  CASE: A CALENDAR WITH A PINNED MONTH-NAME                          //
//  -----------------------------------------------------------------------   //
//  A calendar pins the month name as a sliver header. As the user scrolls //
//  to a date, focus jumps onto the day cell. The month-name should NOT   //
//  grow. min=0 max=0.                                                     //
//                                                                            //
//  G.8  CASE: A CHATBOT WITH AVATARS                                       //
//  -----------------------------------------------------------------------   //
//  A chatbot UI shows the active assistant's avatar inside a pinned     //
//  appbar at the top. When focus jumps to a quick-reply button below     //
//  the appbar, the avatar should remain visible. min=avatar-height       //
//  guarantees that.                                                       //
//                                                                            //
// ============================================================================
//  APPENDIX H -- CHEAT-SHEET OF NUMBERS                                      //
// ============================================================================
//                                                                            //
//   pinned bar typical height ............... 56                            //
//   large appbar collapsed height ........... 56                            //
//   large appbar expanded height ............ 152                           //
//   hero banner expanded height ............. 320                           //
//   section header typical height ........... 48                            //
//   chat composer single-line height ........ 56                            //
//   chat composer multi-line max ............ 144                           //
//   form field touch target ................. 48                            //
//   keyboard reserved (mobile) .............. 260                           //
//   text-field padding (vertical) ........... 12                            //
//   accessibility minimum target ............ 48                            //
//                                                                            //
//  These numbers are rules of thumb, not contracts. They are useful when  //
//  you sit down to write a min or a max and want to start from a sensible //
//  default rather than a literal "56" with no explanation.                //
//                                                                            //
// ============================================================================
//  APPENDIX I -- CROSS-REFERENCES                                            //
// ============================================================================
//                                                                            //
//  Related Flutter classes:                                                  //
//                                                                            //
//    * RenderSliverPersistentHeader -- the abstract render object that     //
//      reads this configuration.                                          //
//    * RenderSliverPinnedPersistentHeader -- pinned variant.              //
//    * RenderSliverFloatingPersistentHeader -- floating variant.          //
//    * SliverPersistentHeader -- the public widget.                       //
//    * SliverPersistentHeaderDelegate -- the contract that decides       //
//      minExtent and maxExtent.                                           //
//    * Scrollable.ensureVisible -- the high-level entry point.            //
//    * RenderObject.showOnScreen -- the low-level entry point.            //
//    * SliverAppBar -- the most common consumer.                          //
//    * SliverAppBar.large -- the hero variant.                            //
//                                                                            //
//  Related accessibility entry points:                                       //
//                                                                            //
//    * SemanticsAction.showOnScreen.                                        //
//    * Focus.requestFocus with policy.                                     //
//    * FocusNode.ensureVisible.                                            //
//    * EditableText.bringIntoView.                                         //
//                                                                            //
// ============================================================================
//  APPENDIX J -- WHAT THIS FILE IS NOT                                       //
// ============================================================================
//                                                                            //
//  * It is not a unit test in the traditional sense; nothing here calls    //
//    expect() or fails on a value mismatch. It is a snapshot demo that    //
//    exercises the bridge generator's coverage of                         //
//    PersistentHeaderShowOnScreenConfiguration.                            //
//                                                                            //
//  * It is not an example of best practice for a real app; the gallery   //
//    layout is exhaustive on purpose so the bridge generator's output    //
//    can be inspected.                                                    //
//                                                                            //
//  * It is not a documentation file; it is a working Dart file that       //
//    happens to carry a great deal of commentary. Treat the comments as  //
//    teaching notes, not API documentation.                               //
//                                                                            //
//  * It is not state-aware; everything you see is computed once during    //
//    build() and never updated. There is no animation, no controller,    //
//    no timer, no future, no stream.                                      //
//                                                                            //
// ============================================================================
//  APPENDIX K -- A WALK ALONG THE BEACH                                      //
// ============================================================================
//                                                                            //
//  Picture the colours. Tide Limestone is the floor of an ivory beach.    //
//  Bleached driftwood lies in low piles. Harbour fog drifts in from the   //
//  north. Sea-glass tumbles between your fingers, pale and deep. The     //
//  tide pool at your feet is so still it looks like night. Salt spray   //
//  catches the light. A rusty anchor hides behind a mound. Kelp-shadow   //
//  greens the rocks. Coral fragments pink. The sandbar lights gold. Foam //
//  white slips up and back. Storm glass glints from the wreck. Beach     //
//  plums purple the dunes.                                                //
//                                                                            //
//  Now picture a screen reader's focus rectangle landing somewhere below //
//  a sliver of the beach. The framework asks the beach: how much of     //
//  yourself should you reveal? The configuration answers: at least this  //
//  much, at most that much. The beach exposes itself within those       //
//  bounds. The reader reads. The user moves on. The tide returns.       //
//                                                                            //
//  This file is the conversation between that beach and that focus.     //
//                                                                            //
// ============================================================================
//                            END OF FILE                                     //
// ============================================================================

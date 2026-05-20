// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: Flexible widget exhaustive showcase.
//
// Theme: "Verdant Linen, Brass Compass, Frost Lattice, Twilight Quay" --
// a deliberately distinctive palette of mossy greens, oxidized brass,
// chilled indigo-ice, and deep harbor purples. Every section uses one
// of these four palette families so the eye can quickly pin a topic to
// a color region.
//
// Focus axis (vs. Batch 6 expanded_test.dart):
//   * expanded_test.dart leaned on flex-ratio matrices and ASCII tables.
//   * THIS file leans on FlexFit comparison (loose vs tight semantics),
//     Flexible's role as the *compromising* sibling of Expanded inside
//     nested Row/Column trees, and the failure modes that emerge when
//     a child has no Flexible/Expanded wrapper at all.
//
// Sections in order:
//   1.  Hero card                       (Verdant Linen)
//   2.  Palette table                   (mixed)
//   3.  Glossary                        (Frost Lattice)
//   4.  FlexFit.loose vs FlexFit.tight  (Brass Compass)
//   5.  Ratio matrix with diverse weights
//   6.  Nested Row/Column mixing Flexible+Expanded
//   7.  Edge case: no Flexible at all   (Twilight Quay)
//   8.  ASCII layout diagrams
//   9.  Decision flowchart prose
//  10.  Pitfalls panel (RenderFlex overflow)
//  11.  Recipe cards
//  12.  Before/after panel
//  13.  Palette swatches
//  14.  Closing prose blocks
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// PALETTE -- the "Verdant Linen / Brass Compass / Frost Lattice / Twilight
// Quay" four-family palette. Each family has 5 swatches plus one accent.
// ---------------------------------------------------------------------------

const Color verdantLinen1 = Color(0xFFEFF3E6); // pale linen
const Color verdantLinen2 = Color(0xFFCFD9B5); // soft moss
const Color verdantLinen3 = Color(0xFF8FA670); // verdant body
const Color verdantLinen4 = Color(0xFF5C6F40); // deep verdant
const Color verdantLinen5 = Color(0xFF2F3B1F); // pine shadow
const Color verdantAccent = Color(0xFFB8C97A); // chartreuse highlight

const Color brassCompass1 = Color(0xFFFBEFD6); // beeswax
const Color brassCompass2 = Color(0xFFE4C58B); // polished brass
const Color brassCompass3 = Color(0xFFB08A3C); // antique brass
const Color brassCompass4 = Color(0xFF7A5C20); // weathered brass
const Color brassCompass5 = Color(0xFF3F2F0E); // bronze shadow
const Color brassAccent = Color(0xFFD89B2A); // compass needle

const Color frostLattice1 = Color(0xFFEDF3FA); // hoarfrost
const Color frostLattice2 = Color(0xFFC6D7E8); // pale ice
const Color frostLattice3 = Color(0xFF8AA3BC); // chilled blue
const Color frostLattice4 = Color(0xFF4F6A85); // frost steel
const Color frostLattice5 = Color(0xFF22384F); // glacier shadow
const Color frostAccent = Color(0xFF4FB8D9); // crystal accent

const Color twilightQuay1 = Color(0xFFEDE7F2); // dusk veil
const Color twilightQuay2 = Color(0xFFB8A6CC); // lilac mist
const Color twilightQuay3 = Color(0xFF7A5F94); // twilight body
const Color twilightQuay4 = Color(0xFF4A3460); // dusk shadow
const Color twilightQuay5 = Color(0xFF1F1430); // harbor night
const Color twilightAccent = Color(0xFF9B6FD3); // lantern accent

const Color inkPrimary = Color(0xFF161B22); // body text
const Color inkSecondary = Color(0xFF40484F); // secondary text
const Color paperBg = Color(0xFFF7F5EE); // canvas off-white
const Color hairline = Color(0xFFD8D3C2); // section rule

// ---------------------------------------------------------------------------
// build()
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('Flexible deep-demo: starting Verdant Linen palette construction.');

  // -------------------------------------------------------------------------
  // 1. Hero card
  // -------------------------------------------------------------------------
  Widget heroCard;
  try {
    heroCard = Container(
      padding: EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [verdantLinen5, verdantLinen4, verdantLinen3],
        ),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: verdantAccent, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: verdantLinen5.withValues(alpha: 0.35),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: verdantAccent,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: verdantLinen1, width: 2.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Fx',
                  style: TextStyle(
                    color: verdantLinen5,
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(width: 14.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Flexible',
                      style: TextStyle(
                        color: verdantLinen1,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'the polite sibling of Expanded',
                      style: TextStyle(
                        color: verdantAccent,
                        fontSize: 13.0,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Container(height: 1.0, color: verdantAccent.withValues(alpha: 0.5)),
          SizedBox(height: 12.0),
          Text(
            'Flexible governs how a child of a Row, Column, or Flex shares '
            'leftover space along the main axis. Unlike Expanded -- which '
            'always forces FlexFit.tight -- Flexible defaults to FlexFit.loose, '
            'meaning the child may take *less* than its assigned slice. This '
            'demo walks loose vs. tight, mixed nested usage, ratio matrices, '
            'and the failure mode of forgetting to wrap an unbounded child.',
            style: TextStyle(
              color: verdantLinen1,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              _heroChip('flex: int', verdantAccent, verdantLinen5),
              SizedBox(width: 8.0),
              _heroChip('fit: FlexFit', brassAccent, brassCompass5),
              SizedBox(width: 8.0),
              _heroChip('child: Widget', frostAccent, frostLattice5),
            ],
          ),
        ],
      ),
    );
  } catch (e) {
    print('hero build failed: $e');
    heroCard = _errorBlock('hero', e);
  }

  // -------------------------------------------------------------------------
  // 2. Palette table -- one row per palette family, swatches inside.
  // -------------------------------------------------------------------------
  final paletteFamilies = <_PaletteFamily>[
    _PaletteFamily(
      name: 'Verdant Linen',
      tagline: 'mossy greens, calm body copy',
      swatches: [
        verdantLinen1,
        verdantLinen2,
        verdantLinen3,
        verdantLinen4,
        verdantLinen5,
      ],
      accent: verdantAccent,
    ),
    _PaletteFamily(
      name: 'Brass Compass',
      tagline: 'oxidized brass, navigation hints',
      swatches: [
        brassCompass1,
        brassCompass2,
        brassCompass3,
        brassCompass4,
        brassCompass5,
      ],
      accent: brassAccent,
    ),
    _PaletteFamily(
      name: 'Frost Lattice',
      tagline: 'chilled indigo, structural rules',
      swatches: [
        frostLattice1,
        frostLattice2,
        frostLattice3,
        frostLattice4,
        frostLattice5,
      ],
      accent: frostAccent,
    ),
    _PaletteFamily(
      name: 'Twilight Quay',
      tagline: 'harbor purples, edge-case warnings',
      swatches: [
        twilightQuay1,
        twilightQuay2,
        twilightQuay3,
        twilightQuay4,
        twilightQuay5,
      ],
      accent: twilightAccent,
    ),
  ];

  final paletteRows = <Widget>[];
  paletteRows.add(_paletteHeaderRow());
  for (int i = 0; i < paletteFamilies.length; i = i + 1) {
    paletteRows.add(_paletteFamilyRow(paletteFamilies[i], i));
  }

  Widget paletteTable;
  try {
    paletteTable = _section(
      title: 'Palette: four families, one demo',
      accent: brassAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: paletteRows,
      ),
    );
  } catch (e) {
    paletteTable = _errorBlock('palette', e);
  }

  // -------------------------------------------------------------------------
  // 3. Glossary -- Frost Lattice family (cool, structural).
  // -------------------------------------------------------------------------
  final glossaryEntries = <_GlossaryEntry>[
    _GlossaryEntry(
      term: 'Flexible',
      summary: 'A widget that controls how a child of Row/Column/Flex flexes '
          'along the main axis. Carries a flex weight and a FlexFit.',
    ),
    _GlossaryEntry(
      term: 'Expanded',
      summary: 'Sugar for Flexible(fit: FlexFit.tight). The child is forced '
          'to fill its share -- no compromise, no shrinking.',
    ),
    _GlossaryEntry(
      term: 'FlexFit.loose',
      summary: 'Default for Flexible. Child may be SMALLER than the share -- '
          'useful when intrinsic size matters (icons, badges, short text).',
    ),
    _GlossaryEntry(
      term: 'FlexFit.tight',
      summary: 'Child is forced to exactly its share. Equivalent to wrapping '
          'with Expanded. Use when you want hard column rules.',
    ),
    _GlossaryEntry(
      term: 'flex (int)',
      summary: 'Relative weight versus other Flexible/Expanded siblings. '
          'A flex of 2 vs 1 means a 2:1 share of the leftover space.',
    ),
    _GlossaryEntry(
      term: 'leftover space',
      summary: 'Main-axis extent remaining after fixed-size children claim '
          'their bounds. Flexible/Expanded only divide LEFTOVER -- not total.',
    ),
    _GlossaryEntry(
      term: 'RenderFlex overflow',
      summary: 'The yellow-and-black warning Flutter draws when children of '
          'a Row/Column exceed their constraints with no Flexible to absorb.',
    ),
    _GlossaryEntry(
      term: 'intrinsic size',
      summary: 'A widget\'s natural extent absent any external constraint. '
          'FlexFit.loose lets a child stay near intrinsic.',
    ),
    _GlossaryEntry(
      term: 'unbounded constraint',
      summary: 'A constraint with infinite max extent. Putting Text inside an '
          'unbounded Row without Flexible commonly overflows.',
    ),
    _GlossaryEntry(
      term: 'main axis',
      summary: 'For Row this is horizontal; for Column it is vertical. Flex '
          'distribution always happens along the main axis.',
    ),
  ];

  final glossaryRows = <Widget>[];
  glossaryRows.add(_glossaryHeaderRow());
  for (int i = 0; i < glossaryEntries.length; i = i + 1) {
    glossaryRows.add(_glossaryRow(glossaryEntries[i], i));
  }

  Widget glossarySection;
  try {
    glossarySection = _section(
      title: 'Glossary',
      accent: frostAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: glossaryRows,
      ),
    );
  } catch (e) {
    glossarySection = _errorBlock('glossary', e);
  }

  // -------------------------------------------------------------------------
  // 4. FlexFit.loose vs FlexFit.tight comparison -- Brass Compass.
  // -------------------------------------------------------------------------
  final fitComparisons = <_FitComparison>[
    _FitComparison(
      label: 'short label, narrow Row (200px)',
      naturalWidth: 60.0,
      rowWidth: 200.0,
      flex: 1,
      note: 'loose hugs intrinsic; tight stretches to share.',
    ),
    _FitComparison(
      label: 'medium content, balanced Row (260px)',
      naturalWidth: 110.0,
      rowWidth: 260.0,
      flex: 1,
      note: 'loose still smaller than share; tight fills share.',
    ),
    _FitComparison(
      label: 'wide content vs narrow share (240px, flex=1)',
      naturalWidth: 180.0,
      rowWidth: 240.0,
      flex: 1,
      note: 'natural exceeds share -- both fits clip to share.',
    ),
    _FitComparison(
      label: 'tiny content, wide row (320px)',
      naturalWidth: 30.0,
      rowWidth: 320.0,
      flex: 2,
      note: 'gap between loose and tight is most visible here.',
    ),
    _FitComparison(
      label: 'medium content, flex=3 share',
      naturalWidth: 90.0,
      rowWidth: 300.0,
      flex: 3,
      note: 'tight=full share; loose=intrinsic, leaving filler gap.',
    ),
  ];

  final fitRows = <Widget>[];
  fitRows.add(_fitHeaderRow());
  for (int i = 0; i < fitComparisons.length; i = i + 1) {
    fitRows.add(_fitRow(fitComparisons[i], i));
  }

  Widget fitSection;
  try {
    fitSection = _section(
      title: 'FlexFit.loose vs FlexFit.tight',
      accent: brassAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _prose(
            'Both rows below carry one Flexible plus one fixed Container. '
            'In the LOOSE column the Flexible may stay small if its child has '
            'a finite preferred width. In the TIGHT column the Flexible '
            'always fills its share. Watch the trailing fixed Container: when '
            'the Flexible loosens, more space spills toward the right.',
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: fitRows,
          ),
        ],
      ),
    );
  } catch (e) {
    fitSection = _errorBlock('fit', e);
  }

  // -------------------------------------------------------------------------
  // 5. Ratio matrix -- diverse weights (1:1, 2:3, 1:4, 5:2:3, 1:1:1:1:1, etc).
  // -------------------------------------------------------------------------
  final ratioCases = <_RatioCase>[
    _RatioCase(label: '1:1', weights: [1, 1]),
    _RatioCase(label: '2:3', weights: [2, 3]),
    _RatioCase(label: '1:4', weights: [1, 4]),
    _RatioCase(label: '3:2:1', weights: [3, 2, 1]),
    _RatioCase(label: '5:2:3', weights: [5, 2, 3]),
    _RatioCase(label: '1:2:1', weights: [1, 2, 1]),
    _RatioCase(label: '4:1:1:2', weights: [4, 1, 1, 2]),
    _RatioCase(label: '1:1:1:1:1', weights: [1, 1, 1, 1, 1]),
    _RatioCase(label: '7:1', weights: [7, 1]),
    _RatioCase(label: '2:2:2:2', weights: [2, 2, 2, 2]),
  ];

  final ratioRows = <Widget>[];
  ratioRows.add(_ratioHeaderRow());
  for (int i = 0; i < ratioCases.length; i = i + 1) {
    ratioRows.add(_ratioRow(ratioCases[i], i));
  }

  Widget ratioSection;
  try {
    ratioSection = _section(
      title: 'Ratio matrix (FlexFit.tight assumed)',
      accent: verdantAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _prose(
            'Diverse weights show how leftover space splits. The bar uses '
            'tight fit so each Flexible occupies exactly its computed slice. '
            'Numerator/denominator labels show share = w / sum(w).',
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: ratioRows,
          ),
        ],
      ),
    );
  } catch (e) {
    ratioSection = _errorBlock('ratio', e);
  }

  // -------------------------------------------------------------------------
  // 6. Nested Row/Column mixing Flexible+Expanded.
  // -------------------------------------------------------------------------
  Widget nestedSection;
  try {
    nestedSection = _section(
      title: 'Nested Row/Column with mixed Flexible + Expanded',
      accent: twilightAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _prose(
            'A common layout: outer Row has a fixed sidebar, an Expanded '
            'main area, and a Flexible (loose) trailing badge. Inside the '
            'main area a Column splits a header (Flexible loose) from a body '
            '(Expanded). This mirrors the master/detail/badge pattern.',
          ),
          SizedBox(height: 10.0),
          _nestedDemo1(),
          SizedBox(height: 14.0),
          _prose(
            'Second nested example: a Row of three Flexibles where the '
            'middle one wraps a Column of two Expanded panels. The middle '
            'flex weight controls how much vertical column the inner panels '
            'see -- because horizontal share dictates the inner box width.',
          ),
          SizedBox(height: 10.0),
          _nestedDemo2(),
          SizedBox(height: 14.0),
          _prose(
            'Third nested example: alternating Flexible-loose and '
            'Expanded inside a Row. Loose children only consume their '
            'intrinsic width; their share leaks to neighboring Expanded.',
          ),
          SizedBox(height: 10.0),
          _nestedDemo3(),
        ],
      ),
    );
  } catch (e) {
    nestedSection = _errorBlock('nested', e);
  }

  // -------------------------------------------------------------------------
  // 7. Edge case: NO Flexible at all -- Twilight Quay (warning family).
  // -------------------------------------------------------------------------
  Widget edgeCaseSection;
  try {
    edgeCaseSection = _section(
      title: 'Edge case: what if no Flexible is present?',
      accent: twilightAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _prose(
            'Without any Flexible/Expanded child, a Row simply sums its '
            'children\'s natural widths. If that sum exceeds the available '
            'main-axis extent the engine paints the yellow-and-black overflow '
            'stripes. Flexible exists precisely to absorb that excess.',
          ),
          SizedBox(height: 10.0),
          _edgeCase1(),
          SizedBox(height: 12.0),
          _edgeCase2(),
          SizedBox(height: 12.0),
          _edgeCase3(),
        ],
      ),
    );
  } catch (e) {
    edgeCaseSection = _errorBlock('edge', e);
  }

  // -------------------------------------------------------------------------
  // 8. ASCII layout diagrams.
  // -------------------------------------------------------------------------
  Widget asciiSection;
  try {
    asciiSection = _section(
      title: 'ASCII layout diagrams',
      accent: frostAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _asciiBlock(
            'FlexFit.loose with intrinsic width 60 in a 200 row, flex=1:',
            '+---------------- 200 px row ----------------+\n'
                '| [60: loose]                  [140 leftover]|\n'
                '+--------------------------------------------+',
          ),
          SizedBox(height: 10.0),
          _asciiBlock(
            'FlexFit.tight with same flex=1 in a 200 row, two siblings:',
            '+---------------- 200 px row ----------------+\n'
                '| [100: flex=1 tight ][100: flex=1 tight ] |\n'
                '+--------------------------------------------+',
          ),
          SizedBox(height: 10.0),
          _asciiBlock(
            'Mixed: fixed 40 + Flexible(flex=2 tight) + Flexible(flex=1 loose) in 300:',
            '+---------------- 300 px row ----------------+\n'
                '| [40: fix][   173: flex=2 tight ][87 leftover share, child smaller]|\n'
                '+--------------------------------------------+',
          ),
          SizedBox(height: 10.0),
          _asciiBlock(
            'Ratio 5:2:3 in 250 (sum=10, shares 125/50/75):',
            '+----------------- 250 px row ----------------+\n'
                '| [125: 5/10]      [50: 2/10][75: 3/10]    |\n'
                '+---------------------------------------------+',
          ),
          SizedBox(height: 10.0),
          _asciiBlock(
            'Nested: outer Row(fixed,Expanded,Flexible), inner Column(Flexible,Expanded):',
            '+----------- outer Row 360 px ---------------+\n'
                '| [80 sidebar][  Expanded main 220       ][60]\n'
                '|              | header (loose)          |\n'
                '|              | body (Expanded fill)    |\n'
                '+--------------------------------------------+',
          ),
          SizedBox(height: 10.0),
          _asciiBlock(
            'Edge: no Flexible -- 3x80px text in a 200px row -> overflow:',
            '+-------- 200 px row --------+\n'
                '| [80][80][80]  <-- 240, 40px overflow striped\n'
                '+----------------------------+',
          ),
        ],
      ),
    );
  } catch (e) {
    asciiSection = _errorBlock('ascii', e);
  }

  // -------------------------------------------------------------------------
  // 9. Decision flowchart prose.
  // -------------------------------------------------------------------------
  final decisionSteps = <_DecisionStep>[
    _DecisionStep(
      step: 'Q1',
      question: 'Does this child have an intrinsic size you want to respect?',
      yes: 'Use Flexible (FlexFit.loose, default).',
      no: 'Move on to Q2.',
    ),
    _DecisionStep(
      step: 'Q2',
      question: 'Should the child fill its allocated share regardless?',
      yes: 'Use Expanded (or Flexible with FlexFit.tight).',
      no: 'Move on to Q3.',
    ),
    _DecisionStep(
      step: 'Q3',
      question: 'Is the child a fixed-size widget (e.g. Container 40x40)?',
      yes: 'No wrapper needed -- it occupies its declared size.',
      no: 'Move on to Q4.',
    ),
    _DecisionStep(
      step: 'Q4',
      question: 'Are you mixing Text or other unbounded widgets in a Row?',
      yes: 'Wrap Text in Flexible (loose) to avoid RenderFlex overflow.',
      no: 'Move on to Q5.',
    ),
    _DecisionStep(
      step: 'Q5',
      question: 'Do you need ratio splits (e.g. 30/70)?',
      yes: 'Use multiple Expanded with flex weights, or Flexible(tight).',
      no: 'Stick with default child sizes.',
    ),
    _DecisionStep(
      step: 'Q6',
      question: 'Is the parent Row/Column itself unbounded?',
      yes: 'Bound it first (SizedBox, Container with width, etc).',
      no: 'You are good -- Flexible/Expanded compute leftover correctly.',
    ),
  ];

  final decisionRows = <Widget>[];
  decisionRows.add(_decisionHeaderRow());
  for (int i = 0; i < decisionSteps.length; i = i + 1) {
    decisionRows.add(_decisionRow(decisionSteps[i], i));
  }

  Widget decisionSection;
  try {
    decisionSection = _section(
      title: 'Decision flowchart -- Flexible or not?',
      accent: brassAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: decisionRows,
      ),
    );
  } catch (e) {
    decisionSection = _errorBlock('decision', e);
  }

  // -------------------------------------------------------------------------
  // 10. Pitfalls panel.
  // -------------------------------------------------------------------------
  final pitfalls = <_Pitfall>[
    _Pitfall(
      symbol: '!',
      title: 'RenderFlex overflowed by N pixels',
      detail: 'A Row or Column had children whose natural sizes summed beyond '
          'the parent constraint AND none of those children were Flexible or '
          'Expanded. Wrap the offender (usually a Text or wide Container) in '
          'Flexible to absorb the excess.',
    ),
    _Pitfall(
      symbol: 'x',
      title: 'Flexible inside an unbounded parent',
      detail: 'Putting Flexible inside a Row that itself has unbounded width '
          '(common inside a SingleChildScrollView) is a logical error -- there '
          'is no leftover space to divide. The parent must be bounded first.',
    ),
    _Pitfall(
      symbol: '?',
      title: 'Flex weight without enough siblings',
      detail: 'A single Flexible(flex: 7) is functionally identical to '
          'Flexible(flex: 1) -- weights only matter when more than one '
          'flexing sibling exists. Do not over-tune solo weights.',
    ),
    _Pitfall(
      symbol: '~',
      title: 'Mixing Expanded and Flexible(loose) by accident',
      detail: 'Expanded forces tight fit; Flexible defaults to loose. Side by '
          'side they compute share correctly but render very differently. If '
          'you want consistent column rules, pick one and stick with it.',
    ),
    _Pitfall(
      symbol: '#',
      title: 'Forgetting flex defaults to 1',
      detail: 'Flexible() with no flex argument is flex=1. This is fine but '
          'silent -- mix it with Flexible(flex: 2) and you get a 1:2 split '
          'even though only one weight is visible in source.',
    ),
    _Pitfall(
      symbol: '%',
      title: 'Wrapping in Flexible to fix scrolling',
      detail: 'Flexible does NOT enable scrolling. If your content overflows '
          'AND you want scroll, use SingleChildScrollView or ListView. '
          'Flexible only redistributes; it never adds scroll.',
    ),
  ];

  final pitfallRows = <Widget>[];
  for (int i = 0; i < pitfalls.length; i = i + 1) {
    pitfallRows.add(_pitfallCard(pitfalls[i], i));
    if (i < pitfalls.length - 1) {
      pitfallRows.add(SizedBox(height: 8.0));
    }
  }

  Widget pitfallSection;
  try {
    pitfallSection = _section(
      title: 'Pitfalls panel -- the gallery of past mistakes',
      accent: twilightAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: pitfallRows,
      ),
    );
  } catch (e) {
    pitfallSection = _errorBlock('pitfalls', e);
  }

  // -------------------------------------------------------------------------
  // 11. Recipe cards.
  // -------------------------------------------------------------------------
  final recipes = <_Recipe>[
    _Recipe(
      title: 'Two-column form (label : input)',
      use: 'Flexible(flex: 1) for label + Expanded for input.',
      snippet: 'Row(children: [\n'
          '  Flexible(flex: 1, child: Text(label)),\n'
          '  SizedBox(width: 8.0),\n'
          '  Expanded(flex: 3, child: TextField(...)),\n'
          ']);',
    ),
    _Recipe(
      title: 'Header bar with optional badge',
      use: 'Expanded title + Flexible(loose) badge that may be empty.',
      snippet: 'Row(children: [\n'
          '  Expanded(child: Text(title)),\n'
          '  Flexible(child: badge ?? SizedBox.shrink()),\n'
          ']);',
    ),
    _Recipe(
      title: 'Sidebar / main / inspector',
      use: 'Two Expanded with weights 3:7, fixed sidebar Container.',
      snippet: 'Row(children: [\n'
          '  Container(width: 80.0, ...sidebar),\n'
          '  Expanded(flex: 3, child: list),\n'
          '  Expanded(flex: 7, child: detail),\n'
          ']);',
    ),
    _Recipe(
      title: 'Wrap-around chip row',
      use: 'Flexible(loose) keeps each chip at intrinsic width.',
      snippet: 'Row(children: [\n'
          '  for (final c in chips)\n'
          '    Flexible(child: ChipWidget(c)),\n'
          ']);',
    ),
    _Recipe(
      title: 'Vertical split panel',
      use: 'Column with two Expanded children at 1:1 weight.',
      snippet: 'Column(children: [\n'
          '  Expanded(child: top),\n'
          '  Divider(height: 1.0),\n'
          '  Expanded(child: bottom),\n'
          ']);',
    ),
    _Recipe(
      title: 'Status bar with elastic gap',
      use: 'Two fixed icons + Flexible Spacer-like SizedBox in middle.',
      snippet: 'Row(children: [\n'
          '  Icon(Icons.disc_full),\n'
          '  Flexible(child: SizedBox()),\n'
          '  Text(timestamp),\n'
          ']);',
    ),
    _Recipe(
      title: 'Ratio columns 30/70',
      use: 'Flexible(flex:3) + Flexible(flex:7), both tight fit.',
      snippet: 'Row(children: [\n'
          '  Flexible(flex: 3, fit: FlexFit.tight, child: a),\n'
          '  Flexible(flex: 7, fit: FlexFit.tight, child: b),\n'
          ']);',
    ),
    _Recipe(
      title: 'Wrapping long Text',
      use: 'Flexible around Text -- prevents RenderFlex overflow.',
      snippet: 'Row(children: [\n'
          '  Icon(Icons.info),\n'
          '  SizedBox(width: 6.0),\n'
          '  Flexible(child: Text(longString)),\n'
          ']);',
    ),
  ];

  final recipeRows = <Widget>[];
  for (int i = 0; i < recipes.length; i = i + 2) {
    final left = recipes[i];
    final right = (i + 1 < recipes.length) ? recipes[i + 1] : null;
    recipeRows.add(_recipePairRow(left, right));
    if (i + 2 < recipes.length) recipeRows.add(SizedBox(height: 10.0));
  }

  Widget recipeSection;
  try {
    recipeSection = _section(
      title: 'Recipe cards',
      accent: verdantAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: recipeRows,
      ),
    );
  } catch (e) {
    recipeSection = _errorBlock('recipes', e);
  }

  // -------------------------------------------------------------------------
  // 12. Before/after panel.
  // -------------------------------------------------------------------------
  Widget beforeAfterSection;
  try {
    beforeAfterSection = _section(
      title: 'Before / After: introducing Flexible',
      accent: brassAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _prose(
            'BEFORE: an icon, a long Text, and a trailing badge -- the Text '
            'wants 220px in a 240px row. AFTER: the Text is wrapped in '
            'Flexible(loose) so it shrinks (or wraps via softWrap) to fit.',
          ),
          SizedBox(height: 10.0),
          _beforeAfter(),
        ],
      ),
    );
  } catch (e) {
    beforeAfterSection = _errorBlock('beforeafter', e);
  }

  // -------------------------------------------------------------------------
  // 13. Palette swatches strip -- 24 swatches across all four families.
  // -------------------------------------------------------------------------
  final swatchList = <Color>[
    verdantLinen1,
    verdantLinen2,
    verdantLinen3,
    verdantLinen4,
    verdantLinen5,
    verdantAccent,
    brassCompass1,
    brassCompass2,
    brassCompass3,
    brassCompass4,
    brassCompass5,
    brassAccent,
    frostLattice1,
    frostLattice2,
    frostLattice3,
    frostLattice4,
    frostLattice5,
    frostAccent,
    twilightQuay1,
    twilightQuay2,
    twilightQuay3,
    twilightQuay4,
    twilightQuay5,
    twilightAccent,
  ];

  final swatchTiles = <Widget>[];
  for (int i = 0; i < swatchList.length; i = i + 1) {
    swatchTiles.add(_swatchTile(swatchList[i], i));
  }

  Widget swatchSection;
  try {
    swatchSection = _section(
      title: 'Palette swatches (all 24)',
      accent: frostAccent,
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: swatchTiles,
      ),
    );
  } catch (e) {
    swatchSection = _errorBlock('swatch', e);
  }

  // -------------------------------------------------------------------------
  // 14. Closing prose blocks.
  // -------------------------------------------------------------------------
  Widget closingProse;
  try {
    closingProse = _section(
      title: 'Closing thoughts',
      accent: verdantAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _prose(
            'Flexible is conceptually small but operationally enormous. '
            'Almost every Row or Column you write will, at some point, need '
            'one of these wrappers to keep the layout from either collapsing '
            'into intrinsic widths or overflowing out the side.'),
          SizedBox(height: 8.0),
          _prose(
            'Mental model: think of leftover space as a budget and Flexible '
            'children as departments competing for that budget. Each '
            'department\'s share is its weight divided by the sum of weights. '
            'A FlexFit.tight department spends ALL of its share. A '
            'FlexFit.loose department is frugal -- it spends only what its '
            'child intrinsically wants, returning the rest to the budget '
            '(though no other department gets to claim it -- it simply shows '
            'as empty trailing space).'),
          SizedBox(height: 8.0),
          _prose(
            'Pick Expanded when ratio is the contract; pick Flexible when '
            'intrinsic size is part of the contract. Pick neither when your '
            'children are already fixed and you trust them not to overflow. '
            'And when you see the yellow-and-black stripes -- the answer is '
            'almost always "wrap one more child in Flexible".'),
          SizedBox(height: 12.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: verdantLinen1,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: verdantLinen3, width: 1.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: verdantLinen4,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                SizedBox(width: 10.0),
                Flexible(
                  child: Text(
                    'TL;DR -- Flexible(loose) is the polite default. Expanded '
                    'is the loud default. Choose based on whether the child '
                    'has an opinion about its size, and you will rarely '
                    'see a yellow stripe again.',
                    style: TextStyle(
                      color: verdantLinen5,
                      fontSize: 13.0,
                      height: 1.5,
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
  } catch (e) {
    closingProse = _errorBlock('closing', e);
  }

  print('Flexible deep-demo: assembling final scaffold.');

  // -------------------------------------------------------------------------
  // FINAL SCAFFOLD ASSEMBLY
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: paperBg,
    appBar: AppBar(
      backgroundColor: verdantLinen5,
      elevation: 0.0,
      title: Text(
        'Flexible -- Verdant Linen showcase',
        style: TextStyle(
          color: verdantLinen1,
          fontWeight: FontWeight.w800,
          fontSize: 17.0,
          letterSpacing: 0.4,
        ),
      ),
      iconTheme: IconThemeData(color: verdantLinen1),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          heroCard,
          SizedBox(height: 18.0),
          paletteTable,
          SizedBox(height: 18.0),
          glossarySection,
          SizedBox(height: 18.0),
          fitSection,
          SizedBox(height: 18.0),
          ratioSection,
          SizedBox(height: 18.0),
          nestedSection,
          SizedBox(height: 18.0),
          edgeCaseSection,
          SizedBox(height: 18.0),
          asciiSection,
          SizedBox(height: 18.0),
          decisionSection,
          SizedBox(height: 18.0),
          pitfallSection,
          SizedBox(height: 18.0),
          recipeSection,
          SizedBox(height: 18.0),
          beforeAfterSection,
          SizedBox(height: 18.0),
          swatchSection,
          SizedBox(height: 18.0),
          closingProse,
          SizedBox(height: 24.0),
          _footer(),
          SizedBox(height: 12.0),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SUPPORT TYPES
// ===========================================================================

class _PaletteFamily {
  final String name;
  final String tagline;
  final List<Color> swatches;
  final Color accent;
  _PaletteFamily({
    required this.name,
    required this.tagline,
    required this.swatches,
    required this.accent,
  });
}

class _GlossaryEntry {
  final String term;
  final String summary;
  _GlossaryEntry({required this.term, required this.summary});
}

class _FitComparison {
  final String label;
  final double naturalWidth;
  final double rowWidth;
  final int flex;
  final String note;
  _FitComparison({
    required this.label,
    required this.naturalWidth,
    required this.rowWidth,
    required this.flex,
    required this.note,
  });
}

class _RatioCase {
  final String label;
  final List<int> weights;
  _RatioCase({required this.label, required this.weights});
}

class _DecisionStep {
  final String step;
  final String question;
  final String yes;
  final String no;
  _DecisionStep({
    required this.step,
    required this.question,
    required this.yes,
    required this.no,
  });
}

class _Pitfall {
  final String symbol;
  final String title;
  final String detail;
  _Pitfall({
    required this.symbol,
    required this.title,
    required this.detail,
  });
}

class _Recipe {
  final String title;
  final String use;
  final String snippet;
  _Recipe({
    required this.title,
    required this.use,
    required this.snippet,
  });
}

// ===========================================================================
// HELPERS
// ===========================================================================

Widget _heroChip(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _section({
  required String title,
  required Color accent,
  required Widget child,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: hairline, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: inkPrimary.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 6.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: inkPrimary,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(height: 1.0, color: hairline),
        SizedBox(height: 12.0),
        child,
      ],
    ),
  );
}

Widget _prose(String text) {
  return Text(
    text,
    style: TextStyle(
      color: inkSecondary,
      fontSize: 13.0,
      height: 1.5,
    ),
  );
}

Widget _errorBlock(String label, Object e) {
  return Container(
    padding: EdgeInsets.all(10.0),
    color: Color(0xFFFFE5E5),
    child: Text(
      'section $label failed: $e',
      style: TextStyle(color: Color(0xFF7A1F1F), fontSize: 12.0),
    ),
  );
}

// ---- palette helpers ------------------------------------------------------

Widget _paletteHeaderRow() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    color: brassCompass1,
    child: Row(
      children: [
        Expanded(flex: 3, child: _th('Family')),
        Expanded(flex: 5, child: _th('Tagline')),
        Expanded(flex: 6, child: _th('Swatches')),
      ],
    ),
  );
}

Widget _paletteFamilyRow(_PaletteFamily f, int i) {
  final striped = i % 2 == 0 ? Colors.white : Color(0xFFFAF7EE);
  final swatchTiles = <Widget>[];
  for (int j = 0; j < f.swatches.length; j = j + 1) {
    swatchTiles.add(
      Container(
        width: 22.0,
        height: 22.0,
        margin: EdgeInsets.only(right: 4.0),
        decoration: BoxDecoration(
          color: f.swatches[j],
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: hairline, width: 0.5),
        ),
      ),
    );
  }
  swatchTiles.add(
    Container(
      width: 28.0,
      height: 22.0,
      decoration: BoxDecoration(
        color: f.accent,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: inkPrimary, width: 0.8),
      ),
    ),
  );
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: striped,
      border: Border(bottom: BorderSide(color: hairline, width: 0.5)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            f.name,
            style: TextStyle(
              color: inkPrimary,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            f.tagline,
            style: TextStyle(
              color: inkSecondary,
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Wrap(children: swatchTiles),
        ),
      ],
    ),
  );
}

Widget _th(String s) {
  return Text(
    s,
    style: TextStyle(
      color: brassCompass5,
      fontSize: 11.5,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.3,
    ),
  );
}

// ---- glossary helpers -----------------------------------------------------

Widget _glossaryHeaderRow() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    color: frostLattice1,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Term',
            style: TextStyle(
              color: frostLattice5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            'Meaning',
            style: TextStyle(
              color: frostLattice5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryRow(_GlossaryEntry g, int i) {
  final striped = i % 2 == 0 ? Colors.white : Color(0xFFF6FAFE);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: striped,
      border: Border(bottom: BorderSide(color: hairline, width: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: frostLattice2,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              g.term,
              style: TextStyle(
                color: frostLattice5,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 7,
          child: Text(
            g.summary,
            style: TextStyle(
              color: inkSecondary,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---- fit comparison helpers ----------------------------------------------

Widget _fitHeaderRow() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    color: brassCompass1,
    child: Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            'Scenario',
            style: TextStyle(
              color: brassCompass5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'FlexFit.loose',
            style: TextStyle(
              color: brassCompass5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'FlexFit.tight',
            style: TextStyle(
              color: brassCompass5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fitRow(_FitComparison c, int i) {
  final striped = i % 2 == 0 ? Colors.white : Color(0xFFFAF6E8);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: striped,
      border: Border(bottom: BorderSide(color: hairline, width: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    c.label,
                    style: TextStyle(
                      color: inkPrimary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    'flex=${c.flex}, natural=${c.naturalWidth.toInt()}px',
                    style: TextStyle(
                      color: inkSecondary,
                      fontSize: 10.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: _fitMiniRow(c, FlexFit.loose),
            ),
            SizedBox(width: 4.0),
            Expanded(
              flex: 4,
              child: _fitMiniRow(c, FlexFit.tight),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          c.note,
          style: TextStyle(
            color: brassCompass4,
            fontSize: 10.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _fitMiniRow(_FitComparison c, FlexFit fit) {
  final fitColor =
      fit == FlexFit.loose ? brassCompass2 : brassCompass3;
  return Container(
    height: 30.0,
    decoration: BoxDecoration(
      color: brassCompass1,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: brassCompass3, width: 0.6),
    ),
    child: Row(
      children: [
        Flexible(
          flex: c.flex,
          fit: fit,
          child: Container(
            width: c.naturalWidth,
            height: 30.0,
            color: fitColor,
            alignment: Alignment.center,
            child: Text(
              fit == FlexFit.loose ? 'loose' : 'tight',
              style: TextStyle(
                color: brassCompass5,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Container(
          width: 16.0,
          height: 30.0,
          color: brassCompass4,
        ),
      ],
    ),
  );
}

// ---- ratio helpers --------------------------------------------------------

Widget _ratioHeaderRow() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    color: verdantLinen1,
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Ratio',
            style: TextStyle(
              color: verdantLinen5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            'Layout (FlexFit.tight)',
            style: TextStyle(
              color: verdantLinen5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Shares',
            style: TextStyle(
              color: verdantLinen5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _ratioRow(_RatioCase r, int i) {
  final striped = i % 2 == 0 ? Colors.white : Color(0xFFF6F8EE);
  int sum = 0;
  for (int j = 0; j < r.weights.length; j = j + 1) {
    sum = sum + r.weights[j];
  }
  final segs = <Widget>[];
  final palette = [
    verdantLinen2,
    verdantLinen3,
    verdantLinen4,
    verdantAccent,
    verdantLinen5,
  ];
  for (int j = 0; j < r.weights.length; j = j + 1) {
    final w = r.weights[j];
    final c = palette[j % palette.length];
    segs.add(
      Flexible(
        flex: w,
        fit: FlexFit.tight,
        child: Container(
          height: 22.0,
          color: c,
          alignment: Alignment.center,
          child: Text(
            '$w',
            style: TextStyle(
              color: w >= 3 ? verdantLinen1 : verdantLinen5,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
  final shares = <String>[];
  for (int j = 0; j < r.weights.length; j = j + 1) {
    shares.add('${r.weights[j]}/$sum');
  }
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: striped,
      border: Border(bottom: BorderSide(color: hairline, width: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: verdantLinen2,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              r.label,
              style: TextStyle(
                color: verdantLinen5,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          flex: 7,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Row(children: segs),
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          flex: 4,
          child: Text(
            shares.join('  '),
            style: TextStyle(
              color: inkSecondary,
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---- nested demos ---------------------------------------------------------

Widget _nestedDemo1() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: twilightQuay1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: twilightQuay3, width: 0.7),
    ),
    child: SizedBox(
      height: 110.0,
      child: Row(
        children: [
          Container(
            width: 60.0,
            decoration: BoxDecoration(
              color: twilightQuay4,
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignment: Alignment.center,
            child: Text(
              'side',
              style: TextStyle(
                color: twilightQuay1,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 6.0),
          Expanded(
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: twilightQuay2,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'header (Flexible loose)',
                      style: TextStyle(
                        color: twilightQuay5,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: twilightQuay3,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'body (Expanded tight)',
                      style: TextStyle(
                        color: twilightQuay1,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.0),
          Flexible(
            child: Container(
              width: 50.0,
              decoration: BoxDecoration(
                color: twilightAccent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'badge',
                style: TextStyle(
                  color: twilightQuay5,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _nestedDemo2() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: frostLattice1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: frostLattice3, width: 0.7),
    ),
    child: SizedBox(
      height: 120.0,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                color: frostLattice2,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'flex 1',
                style: TextStyle(color: frostLattice5, fontSize: 11.0),
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: frostLattice3,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'inner top',
                      style: TextStyle(
                        color: frostLattice1,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: frostLattice4,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'inner bottom',
                      style: TextStyle(
                        color: frostLattice1,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 4.0),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                color: frostAccent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'flex 1',
                style: TextStyle(
                  color: frostLattice5,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _nestedDemo3() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: verdantLinen1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: verdantLinen3, width: 0.7),
    ),
    child: SizedBox(
      height: 50.0,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              width: 30.0,
              decoration: BoxDecoration(
                color: verdantLinen3,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'L',
                style: TextStyle(
                  color: verdantLinen1,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 3.0),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: verdantLinen4,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'E2',
                style: TextStyle(
                  color: verdantLinen1,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 3.0),
          Flexible(
            flex: 1,
            child: Container(
              width: 25.0,
              decoration: BoxDecoration(
                color: verdantAccent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'L',
                style: TextStyle(
                  color: verdantLinen5,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 3.0),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: verdantLinen5,
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'E3',
                style: TextStyle(
                  color: verdantLinen1,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ---- edge case demos ------------------------------------------------------

Widget _edgeCase1() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: twilightQuay1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: twilightQuay3, width: 0.7),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Case A: three fixed Containers in a 220px row -- no Flexible.',
          style: TextStyle(
            color: twilightQuay5,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        SizedBox(
          width: 220.0,
          height: 28.0,
          child: Row(
            children: [
              Container(width: 60.0, color: twilightQuay2),
              Container(width: 60.0, color: twilightQuay3),
              Container(width: 60.0, color: twilightQuay4),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'sum=180 < 220 -- ok, 40px trailing space remains unused.',
          style: TextStyle(
            color: twilightQuay4,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _edgeCase2() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: twilightQuay1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: twilightQuay3, width: 0.7),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Case B: same row, but content adds up to 240 (overflow risk).',
          style: TextStyle(
            color: twilightQuay5,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #109, P3):
        // Row's natural width = 3 * 80 = 240 px in a SizedBox(width: 220) =>
        // exact 20 px right overflow. ClipRect was intended to suppress the
        // visual stripes but RenderFlex still asserts before paint-time.
        // Wrapping the Row in OverflowBox(maxWidth: double.infinity) gives
        // the Row unbounded horizontal constraints, so it lays out at its
        // natural 240 px without firing the overflow assertion; the outer
        // SizedBox + ClipRect still clip the painted bars to 220 px, so the
        // pedagogical "content overflows the box, the box clips it" visual
        // is preserved exactly.
        SizedBox(
          width: 220.0,
          height: 28.0,
          child: ClipRect(
            child: OverflowBox(
              alignment: Alignment.centerLeft,
              maxWidth: double.infinity,
              child: Row(
                children: [
                  Container(width: 80.0, color: twilightQuay2),
                  Container(width: 80.0, color: twilightQuay3),
                  Container(width: 80.0, color: twilightQuay4),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'sum=240 > 220 -- overflow! ClipRect hides the warning here.',
          style: TextStyle(
            color: twilightQuay4,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _edgeCase3() {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: twilightQuay1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: twilightQuay3, width: 0.7),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Case C: same content, third item wrapped in Flexible -- ok.',
          style: TextStyle(
            color: twilightQuay5,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        SizedBox(
          width: 220.0,
          height: 28.0,
          child: Row(
            children: [
              Container(width: 80.0, color: twilightQuay2),
              Container(width: 80.0, color: twilightQuay3),
              Flexible(
                child: Container(
                  width: 80.0,
                  color: twilightAccent,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'flexible third absorbs the squeeze -- shrinks to 60px share.',
          style: TextStyle(
            color: twilightQuay4,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---- ASCII helper ---------------------------------------------------------

Widget _asciiBlock(String caption, String ascii) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: frostLattice1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: frostLattice3, width: 0.7),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          caption,
          style: TextStyle(
            color: frostLattice5,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: frostLattice2, width: 0.7),
          ),
          child: Text(
            ascii,
            style: TextStyle(
              color: frostLattice5,
              fontSize: 11.0,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---- decision helpers -----------------------------------------------------

Widget _decisionHeaderRow() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    color: brassCompass1,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '#',
            style: TextStyle(
              color: brassCompass5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            'Question',
            style: TextStyle(
              color: brassCompass5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Yes',
            style: TextStyle(
              color: brassCompass5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'No',
            style: TextStyle(
              color: brassCompass5,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _decisionRow(_DecisionStep s, int i) {
  final striped = i % 2 == 0 ? Colors.white : Color(0xFFFAF6E8);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: striped,
      border: Border(bottom: BorderSide(color: hairline, width: 0.5)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            s.step,
            style: TextStyle(
              color: brassAccent,
              fontSize: 12.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            s.question,
            style: TextStyle(
              color: inkPrimary,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            s.yes,
            style: TextStyle(
              color: verdantLinen4,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            s.no,
            style: TextStyle(
              color: twilightQuay4,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---- pitfall card ---------------------------------------------------------

Widget _pitfallCard(_Pitfall p, int i) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: twilightQuay1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: twilightQuay3, width: 0.7),
      boxShadow: [
        BoxShadow(
          color: twilightQuay5.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: twilightAccent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: Text(
            p.symbol,
            style: TextStyle(
              color: twilightQuay5,
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                p.title,
                style: TextStyle(
                  color: twilightQuay5,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                p.detail,
                style: TextStyle(
                  color: twilightQuay4,
                  fontSize: 11.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---- recipe pair row ------------------------------------------------------

Widget _recipePairRow(_Recipe left, _Recipe? right) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: _recipeCard(left)),
      SizedBox(width: 10.0),
      Expanded(
        child: right != null ? _recipeCard(right) : SizedBox.shrink(),
      ),
    ],
  );
}

Widget _recipeCard(_Recipe r) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: verdantLinen1,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: verdantLinen3, width: 0.7),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          r.title,
          style: TextStyle(
            color: verdantLinen5,
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 3.0),
        Text(
          r.use,
          style: TextStyle(
            color: verdantLinen4,
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: verdantLinen2, width: 0.7),
          ),
          child: Text(
            r.snippet,
            style: TextStyle(
              color: verdantLinen5,
              fontSize: 10.5,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---- before/after ---------------------------------------------------------

Widget _beforeAfter() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: twilightQuay1,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: twilightQuay3, width: 0.7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'BEFORE -- no Flexible',
                style: TextStyle(
                  color: twilightQuay5,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8.0),
              // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #109, P3):
              // The BEFORE row's natural width = 24 + 6 + 220 + 6 + 32 = 288 px
              // in a SizedBox(width: 240) => exact 48 px right overflow. Same
              // pedagogical pattern as _edgeCase2: the ClipRect was meant to
              // hide the stripes but the assert still fires. Wrapping in
              // OverflowBox(maxWidth: double.infinity) keeps the Row's natural
              // 288 px layout (no assert) while the outer SizedBox + ClipRect
              // clip the painted output to 240 px. Visual is identical to the
              // original "icon + clipped long text + badge" demonstration.
              SizedBox(
                width: 240.0,
                height: 32.0,
                child: ClipRect(
                  child: OverflowBox(
                    alignment: Alignment.centerLeft,
                    maxWidth: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          width: 24.0,
                          color: twilightQuay3,
                          alignment: Alignment.center,
                          child: Text(
                            'i',
                            style: TextStyle(
                              color: twilightQuay1,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Container(
                          width: 220.0,
                          color: twilightQuay2,
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'long descriptive text that wants 220px',
                            style: TextStyle(
                              color: twilightQuay5,
                              fontSize: 11.0,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Container(
                          width: 32.0,
                          color: twilightAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'overflow risk -- text + badge exceed 240px.',
                style: TextStyle(
                  color: twilightQuay4,
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 10.0),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: verdantLinen1,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: verdantLinen3, width: 0.7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'AFTER -- Flexible(loose) on text',
                style: TextStyle(
                  color: verdantLinen5,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8.0),
              SizedBox(
                width: 240.0,
                height: 32.0,
                child: Row(
                  children: [
                    Container(
                      width: 24.0,
                      color: verdantLinen3,
                      alignment: Alignment.center,
                      child: Text(
                        'i',
                        style: TextStyle(
                          color: verdantLinen1,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Flexible(
                      child: Container(
                        color: verdantLinen2,
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'long descriptive text now wraps gracefully',
                          style: TextStyle(
                            color: verdantLinen5,
                            fontSize: 11.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Container(
                      width: 32.0,
                      color: verdantAccent,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'no overflow -- Flexible compresses the text region.',
                style: TextStyle(
                  color: verdantLinen4,
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---- swatch tile ----------------------------------------------------------

Widget _swatchTile(Color c, int i) {
  return Container(
    width: 56.0,
    height: 56.0,
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: hairline, width: 0.7),
      boxShadow: [
        BoxShadow(
          color: inkPrimary.withValues(alpha: 0.05),
          blurRadius: 3.0,
          offset: Offset(0.0, 1.0),
        ),
      ],
    ),
    alignment: Alignment.bottomLeft,
    padding: EdgeInsets.all(4.0),
    child: Text(
      '${i + 1}',
      style: TextStyle(
        color: _contrast(c),
        fontSize: 9.5,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

Color _contrast(Color c) {
  // Quick eyeball: dark family colors get light text.
  final r = (c.r * 255.0).round();
  final g = (c.g * 255.0).round();
  final b = (c.b * 255.0).round();
  final yiq = (r * 299 + g * 587 + b * 114) ~/ 1000;
  return yiq >= 150 ? inkPrimary : Colors.white;
}

// ---- footer ---------------------------------------------------------------

Widget _footer() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: verdantLinen5,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: verdantAccent,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.0),
        Flexible(
          child: Text(
            'Flexible deep-demo / Verdant Linen / Brass Compass / Frost '
            'Lattice / Twilight Quay -- end of file.',
            style: TextStyle(
              color: verdantLinen1,
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Opacity(
          opacity: 0.7,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: verdantAccent.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration.zero,
              child: Text(
                'v1.0',
                style: TextStyle(
                  color: verdantLinen1,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

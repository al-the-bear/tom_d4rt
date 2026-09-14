// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - AnimatedList Choreography Hall
// Theme: "AnimatedList Choreography Hall" - a curated stage for the
// AnimatedList family. We cannot drive insert/remove dynamically inside the
// bridged interpreter, so every section renders multiple AnimatedList
// instances with snapshot itemCounts. Each itemBuilder wires the provided
// animation through SizeTransition / FadeTransition; some panels also feed
// an AlwaysStoppedAnimation<double>(t) value to visualise the in-progress
// choreography frame by frame. The page reads top-to-bottom like a
// programme for a dance recital.
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ============================================================================
// CHOREOGRAPHY DATA - performer rosters, palettes, programme notes
// ============================================================================

const List<String> _palettesLabels = <String>[
  'Aurora Velvet',
  'Crimson Cabaret',
  'Verdant Promenade',
  'Cobalt Overture',
  'Amber Andante',
  'Lavender Reverie',
  'Ivory Allegro',
  'Onyx Finale',
];

const List<Map<String, dynamic>> _performers = <Map<String, dynamic>>[
  <String, dynamic>{
    'name': 'Aria',
    'role': 'Lead • Soprano arc',
    'tone': 0xFFFCE4EC,
    'accent': 0xFFC2185B,
    'symbol': '♪',
  },
  <String, dynamic>{
    'name': 'Bevan',
    'role': 'Counterpoint • Bass swell',
    'tone': 0xFFE3F2FD,
    'accent': 0xFF1565C0,
    'symbol': '♫',
  },
  <String, dynamic>{
    'name': 'Cilla',
    'role': 'Chorus • Mid harmony',
    'tone': 0xFFE8F5E9,
    'accent': 0xFF2E7D32,
    'symbol': '♬',
  },
  <String, dynamic>{
    'name': 'Dorian',
    'role': 'Solo • Alto modulation',
    'tone': 0xFFFFF3E0,
    'accent': 0xFFE65100,
    'symbol': '♩',
  },
  <String, dynamic>{
    'name': 'Elise',
    'role': 'Tempo • Percussion lead',
    'tone': 0xFFEDE7F6,
    'accent': 0xFF512DA8,
    'symbol': '♭',
  },
  <String, dynamic>{
    'name': 'Fionn',
    'role': 'Strings • Andante phrase',
    'tone': 0xFFE0F7FA,
    'accent': 0xFF006064,
    'symbol': '♯',
  },
  <String, dynamic>{
    'name': 'Greta',
    'role': 'Encore • Coda voice',
    'tone': 0xFFF3E5F5,
    'accent': 0xFF6A1B9A,
    'symbol': '♮',
  },
  <String, dynamic>{
    'name': 'Hugo',
    'role': 'Bassoon • Sustained tonic',
    'tone': 0xFFECEFF1,
    'accent': 0xFF455A64,
    'symbol': '♪',
  },
];

const List<String> _programmeActs = <String>[
  'Overture',
  'Adagio',
  'Allegro',
  'Scherzo',
  'Coda',
  'Reprise',
];

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  print('AnimatedList Choreography Hall executing');
  // Sample the pseudo-random utility just to anchor it into the call graph.
  print('Choreography seed sample: ${_pseudoRandom(42).toStringAsFixed(3)}');

  // ==========================================================================
  // SECTION 1: ANIMATEDLIST PRIMITIVES — different initialItemCount snapshots
  // ==========================================================================
  final Widget primitivesSnapshotZero = AnimatedList(
    initialItemCount: 0,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      return SizeTransition(
        sizeFactor: a,
        child: _performerTile(_performers[i % _performers.length], i),
      );
    },
  );

  final Widget primitivesSnapshotThree = AnimatedList(
    initialItemCount: 3,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      return SizeTransition(
        sizeFactor: a,
        child: _performerTile(_performers[i % _performers.length], i),
      );
    },
  );

  final Widget primitivesSnapshotFive = AnimatedList(
    initialItemCount: 5,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      return FadeTransition(
        opacity: a,
        child: _performerTile(_performers[i % _performers.length], i),
      );
    },
  );

  final Widget primitivesSnapshotEight = AnimatedList(
    initialItemCount: 8,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      return SizeTransition(
        sizeFactor: a,
        axisAlignment: -1.0,
        child: _performerTile(_performers[i % _performers.length], i),
      );
    },
  );

  // ==========================================================================
  // SECTION 2: INSERTION FRAME SNAPSHOTS — t = 0.0, 0.25, 0.5, 0.75, 1.0
  // ==========================================================================
  final Widget insertionFrameZero = _frozenAnimatedList(
    count: 4,
    t: 0.0,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget insertionFrameQuarter = _frozenAnimatedList(
    count: 4,
    t: 0.25,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget insertionFrameHalf = _frozenAnimatedList(
    count: 4,
    t: 0.5,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget insertionFrameThreeQuarter = _frozenAnimatedList(
    count: 4,
    t: 0.75,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget insertionFrameFull = _frozenAnimatedList(
    count: 4,
    t: 1.0,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  // ==========================================================================
  // SECTION 3: REMOVAL FRAME SNAPSHOTS — reversed animation curve
  // ==========================================================================
  final Widget removalFrameStart = _frozenAnimatedList(
    count: 3,
    t: 1.0,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _removedItemTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget removalFrameMid = _frozenAnimatedList(
    count: 3,
    t: 0.5,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _removedItemTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget removalFrameLate = _frozenAnimatedList(
    count: 3,
    t: 0.2,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _removedItemTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget removalFrameVanish = _frozenAnimatedList(
    count: 3,
    t: 0.0,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _removedItemTile(_performers[i % _performers.length], i),
    ),
  );

  // ==========================================================================
  // SECTION 4: ITEMBUILDER PATTERNS — varied tile compositions
  // ==========================================================================
  final Widget builderLeadingTrailing = AnimatedList(
    initialItemCount: 4,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      final Map<String, dynamic> p = _performers[i % _performers.length];
      return SizeTransition(
        sizeFactor: a,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(p['tone'] as int),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(p['accent'] as int), width: 1.0),
          ),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color(p['accent'] as int),
                radius: 14.0,
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  '${p['name']} — ${p['role']}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(p['accent'] as int),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.music_note,
                color: Color(p['accent'] as int),
                size: 16.0,
              ),
            ],
          ),
        ),
      );
    },
  );

  final Widget builderBadgeRow = AnimatedList(
    initialItemCount: 4,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      final Map<String, dynamic> p = _performers[i % _performers.length];
      return SizeTransition(
        sizeFactor: a,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(p['accent'] as int), width: 1.5),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(p['accent'] as int),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${p['symbol']}',
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${p['name']}',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Color(p['accent'] as int),
                      ),
                    ),
                    Text(
                      'Act ${_programmeActs[i % _programmeActs.length]}',
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF616161),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: Color(p['accent'] as int).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'cue ${i + 1}',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Color(p['accent'] as int),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  final Widget builderTimeline = AnimatedList(
    initialItemCount: 5,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      final Map<String, dynamic> p = _performers[i % _performers.length];
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #102, P1):
      // Row(crossAxisAlignment.stretch) inside an AnimatedList itemBuilder
      // (shrinkWrap:true + NeverScrollableScrollPhysics) drives the Row into
      // an unbounded-height constraint via AnimatedList's intrinsic sizing
      // path, which propagates into the timeline column's `Expanded` and
      // tripped the original `BoxConstraints forces an infinite height` +
      // `sliver_multi_box_adaptor … child.hasSize` + 3× null-check chain
      // (frameworkErrors=5). Wrapping the Row in IntrinsicHeight gives the
      // sliver child a finite cross-axis budget and clears all five errors.
      return FadeTransition(
        opacity: a,
        child: IntrinsicHeight(
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: 28.0,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 2.0,
                    height: 6.0,
                    color: i == 0
                        ? const Color(0x00000000)
                        : Color(p['accent'] as int),
                  ),
                  Container(
                    width: 16.0,
                    height: 16.0,
                    decoration: BoxDecoration(
                      color: Color(p['accent'] as int),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFFFFF),
                        width: 2.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 2.0,
                      color: Color(p['accent'] as int),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(p['tone'] as int),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${p['name']} • ${_programmeActs[i % _programmeActs.length]}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color(p['accent'] as int),
                      ),
                    ),
                    Text(
                      'Frame entry at cue ${i + 1}',
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF616161),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 5: SIZETRANSITION COMPOSITIONS — axis, axisAlignment variations
  // ==========================================================================
  final Widget sizeTransitionVertical = _frozenAnimatedList(
    count: 3,
    t: 0.65,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget sizeTransitionTopAligned = _frozenAnimatedList(
    count: 3,
    t: 0.65,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      axisAlignment: -1.0,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget sizeTransitionBottomAligned = _frozenAnimatedList(
    count: 3,
    t: 0.65,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      axisAlignment: 1.0,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget sizeTransitionHorizontalAxis = SizedBox(
    height: 90.0,
    child: AnimatedList(
      initialItemCount: 4,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext c, int i, Animation<double> a) {
        final Map<String, dynamic> p = _performers[i % _performers.length];
        return SizeTransition(
          sizeFactor: AlwaysStoppedAnimation<double>(0.7),
          axis: Axis.horizontal,
          child: Container(
            width: 80.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Color(p['tone'] as int),
              border: Border.all(color: Color(p['accent'] as int), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${p['symbol']}',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(p['accent'] as int),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${p['name']}',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(p['accent'] as int),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  // ==========================================================================
  // SECTION 6: FADETRANSITION COMPOSITIONS — opacity at different t values
  // ==========================================================================
  final Widget fadeTwentyPercent = _frozenAnimatedList(
    count: 3,
    t: 0.2,
    builder: (int i, Animation<double> a) => FadeTransition(
      opacity: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget fadeFortyPercent = _frozenAnimatedList(
    count: 3,
    t: 0.4,
    builder: (int i, Animation<double> a) => FadeTransition(
      opacity: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget fadeSeventyPercent = _frozenAnimatedList(
    count: 3,
    t: 0.7,
    builder: (int i, Animation<double> a) => FadeTransition(
      opacity: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  final Widget fadeFullPercent = _frozenAnimatedList(
    count: 3,
    t: 1.0,
    builder: (int i, Animation<double> a) => FadeTransition(
      opacity: a,
      child: _performerTile(_performers[i % _performers.length], i),
    ),
  );

  // ==========================================================================
  // SECTION 7: COMBINED SIZE + FADE — choreographed dual-axis transitions
  // ==========================================================================
  final Widget combinedDualEarly = _frozenAnimatedList(
    count: 4,
    t: 0.3,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: FadeTransition(
        opacity: a,
        child: _performerTile(_performers[i % _performers.length], i),
      ),
    ),
  );

  final Widget combinedDualMid = _frozenAnimatedList(
    count: 4,
    t: 0.55,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: FadeTransition(
        opacity: a,
        child: _performerTile(_performers[i % _performers.length], i),
      ),
    ),
  );

  final Widget combinedDualLate = _frozenAnimatedList(
    count: 4,
    t: 0.85,
    builder: (int i, Animation<double> a) => SizeTransition(
      sizeFactor: a,
      child: FadeTransition(
        opacity: a,
        child: _performerTile(_performers[i % _performers.length], i),
      ),
    ),
  );

  // ==========================================================================
  // SECTION 8: SLIVERANIMATEDLIST PATTERNS — animated lists inside slivers
  // ==========================================================================
  final Widget sliverAnimatedHost = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: const Color(0xFFEDE7F6),
          child: const Text(
            'SliverAnimatedList host • bounded viewport',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF512DA8),
            ),
          ),
        ),
      ),
      SliverAnimatedList(
        initialItemCount: 4,
        itemBuilder: (BuildContext c, int i, Animation<double> a) {
          final Map<String, dynamic> p = _performers[i % _performers.length];
          return SizeTransition(
            sizeFactor: a,
            child: _performerTile(p, i),
          );
        },
      ),
    ],
  );

  final Widget sliverAnimatedMixed = CustomScrollView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    slivers: <Widget>[
      SliverAnimatedList(
        initialItemCount: 3,
        itemBuilder: (BuildContext c, int i, Animation<double> a) {
          return FadeTransition(
            opacity: a,
            child: _performerTile(_performers[i % _performers.length], i),
          );
        },
      ),
      const SliverToBoxAdapter(
        child: SizedBox(height: 6.0),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext c, int i) {
            return _miniProgrammeNote(
              'Programme note ${i + 1}',
              'Coordinates the entrance of performer ${_performers[i % _performers.length]['name']}.',
              _performers[i % _performers.length]['accent'] as int,
            );
          },
          childCount: 2,
        ),
      ),
    ],
  );

  // ==========================================================================
  // SECTION 9: REORDER VISUALISATION — simulate before/during/after states
  // ==========================================================================
  final Widget reorderBefore = _frozenAnimatedList(
    count: 4,
    t: 1.0,
    builder: (int i, Animation<double> a) {
      final List<int> ordering = <int>[0, 1, 2, 3];
      final Map<String, dynamic> p =
          _performers[ordering[i] % _performers.length];
      return SizeTransition(
        sizeFactor: a,
        child: _performerTile(p, ordering[i]),
      );
    },
  );

  final Widget reorderDuring = _frozenAnimatedList(
    count: 4,
    t: 0.5,
    builder: (int i, Animation<double> a) {
      final List<int> ordering = <int>[0, 2, 1, 3];
      final Map<String, dynamic> p =
          _performers[ordering[i] % _performers.length];
      return SizeTransition(
        sizeFactor: a,
        child: _performerTile(p, ordering[i]),
      );
    },
  );

  final Widget reorderAfter = _frozenAnimatedList(
    count: 4,
    t: 1.0,
    builder: (int i, Animation<double> a) {
      final List<int> ordering = <int>[2, 0, 3, 1];
      final Map<String, dynamic> p =
          _performers[ordering[i] % _performers.length];
      return SizeTransition(
        sizeFactor: a,
        child: _performerTile(p, ordering[i]),
      );
    },
  );

  // ==========================================================================
  // SECTION 10: SEPARATOR VARIATIONS — gap, divider, dotted, gradient
  // ==========================================================================
  final Widget separatorGap = AnimatedList(
    initialItemCount: 4,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      return SizeTransition(
        sizeFactor: a,
        child: Column(
          children: <Widget>[
            _performerTile(_performers[i % _performers.length], i),
            const SizedBox(height: 8.0),
          ],
        ),
      );
    },
  );

  final Widget separatorDivider = AnimatedList(
    initialItemCount: 4,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      return SizeTransition(
        sizeFactor: a,
        child: Column(
          children: <Widget>[
            _performerTile(_performers[i % _performers.length], i),
            const Divider(
              color: Color(0xFFBDBDBD),
              height: 4.0,
              thickness: 0.6,
            ),
          ],
        ),
      );
    },
  );

  final Widget separatorAccent = AnimatedList(
    initialItemCount: 4,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      final Map<String, dynamic> p = _performers[i % _performers.length];
      return SizeTransition(
        sizeFactor: a,
        child: Column(
          children: <Widget>[
            _performerTile(p, i),
            Container(
              height: 2.0,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(p['accent'] as int).withOpacity(0.0),
                    Color(p['accent'] as int).withOpacity(0.8),
                    Color(p['accent'] as int).withOpacity(0.0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4.0),
          ],
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 11: RECIPE GALLERY — code-quote cards
  // ==========================================================================
  final Widget recipeGallery = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _recipeQuoteCard(
        title: 'Basic AnimatedList',
        accent: 0xFF1565C0,
        lines: const <String>[
          'AnimatedList(',
          '  initialItemCount: 3,',
          '  itemBuilder: (ctx, i, anim) =>',
          '    SizeTransition(',
          '      sizeFactor: anim,',
          '      child: PerformerTile(i),',
          '    ),',
          ')',
        ],
      ),
      const SizedBox(height: 8.0),
      _recipeQuoteCard(
        title: 'FadeTransition itemBuilder',
        accent: 0xFFC2185B,
        lines: const <String>[
          'AnimatedList(',
          '  initialItemCount: 5,',
          '  itemBuilder: (ctx, i, anim) =>',
          '    FadeTransition(',
          '      opacity: anim,',
          '      child: PerformerTile(i),',
          '    ),',
          ')',
        ],
      ),
      const SizedBox(height: 8.0),
      _recipeQuoteCard(
        title: 'Combined Size + Fade',
        accent: 0xFF2E7D32,
        lines: const <String>[
          'itemBuilder: (ctx, i, anim) =>',
          '  SizeTransition(',
          '    sizeFactor: anim,',
          '    child: FadeTransition(',
          '      opacity: anim,',
          '      child: PerformerTile(i),',
          '    ),',
          '  )',
        ],
      ),
      const SizedBox(height: 8.0),
      _recipeQuoteCard(
        title: 'Horizontal AnimatedList',
        accent: 0xFFE65100,
        lines: const <String>[
          'AnimatedList(',
          '  scrollDirection: Axis.horizontal,',
          '  initialItemCount: 4,',
          '  itemBuilder: (ctx, i, anim) =>',
          '    SizeTransition(',
          '      sizeFactor: anim,',
          '      axis: Axis.horizontal,',
          '      child: PerformerCard(i),',
          '    ),',
          ')',
        ],
      ),
      const SizedBox(height: 8.0),
      _recipeQuoteCard(
        title: 'SliverAnimatedList host',
        accent: 0xFF512DA8,
        lines: const <String>[
          'CustomScrollView(',
          '  slivers: [',
          '    SliverAnimatedList(',
          '      initialItemCount: 4,',
          '      itemBuilder: (ctx, i, anim) =>',
          '        SizeTransition(',
          '          sizeFactor: anim,',
          '          child: PerformerTile(i),',
          '        ),',
          '    ),',
          '  ],',
          ')',
        ],
      ),
      const SizedBox(height: 8.0),
      _recipeQuoteCard(
        title: 'removedItemBuilder pattern',
        accent: 0xFF6A1B9A,
        lines: const <String>[
          'final removedBuilder =',
          '  (item, ctx, anim) =>',
          '    SizeTransition(',
          '      sizeFactor: anim,',
          '      child: PerformerTile(item),',
          '    );',
          '// listState.removeItem(idx, removedBuilder)',
        ],
      ),
    ],
  );

  print('All AnimatedList Choreography Hall sections constructed');

  // ==========================================================================
  // FINAL ROOT — MaterialApp/Scaffold/SingleChildScrollView/Column
  // ==========================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF7F4FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _heroHeader(),
            const SizedBox(height: 16.0),
            _conceptOverview(),
            const SizedBox(height: 20.0),
            _sectionPanel(
              number: 1,
              title: 'AnimatedList Primitives',
              subtitle:
                  'Snapshot demonstrations of initialItemCount = 0, 3, 5, 8',
              bg: 0xFFFCE4EC,
              border: 0xFFF8BBD0,
              accent: 0xFFC2185B,
              demoHeight: 340.0,
              demo: _quadGrid(<Widget>[
                _miniDemoLabelled('initialItemCount: 0', primitivesSnapshotZero),
                _miniDemoLabelled('initialItemCount: 3', primitivesSnapshotThree),
                _miniDemoLabelled('initialItemCount: 5', primitivesSnapshotFive),
                _miniDemoLabelled('initialItemCount: 8', primitivesSnapshotEight),
              ]),
              recipe: const <String>[
                'AnimatedList declares animated insertion/removal semantics',
                'initialItemCount sets the starting roster size',
                'itemBuilder must use the supplied Animation<double>',
                'Use shrinkWrap + NeverScrollableScrollPhysics when nested in scroll views',
              ],
              comparison: const <List<String>>[
                <String>['Variant', 'Use case'],
                <String>['initialItemCount: 0', 'Empty list — wait for first insert'],
                <String>['initialItemCount: 3', 'Small roster snapshot'],
                <String>['initialItemCount: 5', 'Medium roster — fade entry'],
                <String>['initialItemCount: 8', 'Full programme — top-aligned grow'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 2,
              title: 'Insertion Frame Snapshots',
              subtitle:
                  'AlwaysStoppedAnimation<double>(t) captures the in-flight curve',
              bg: 0xFFE3F2FD,
              border: 0xFFBBDEFB,
              accent: 0xFF1565C0,
              demoHeight: 460.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('t = 0.00', insertionFrameZero),
                  _miniDemoLabelled('t = 0.25', insertionFrameQuarter),
                  _miniDemoLabelled('t = 0.50', insertionFrameHalf),
                  _miniDemoLabelled('t = 0.75', insertionFrameThreeQuarter),
                  _miniDemoLabelled('t = 1.00', insertionFrameFull),
                ],
              ),
              recipe: const <String>[
                'AlwaysStoppedAnimation<double>(t) snapshots a frame in time',
                'Routing it through SizeTransition lets us inspect any t∈[0,1]',
                'Equivalent to insertItem freeze-frame stills',
                'Lets bridged interpreters demo motion without a ticker',
              ],
              comparison: const <List<String>>[
                <String>['Frame', 'Effect'],
                <String>['t = 0.00', 'Item collapsed; about to grow'],
                <String>['t = 0.25', 'Quarter-grown; subtle reveal'],
                <String>['t = 0.50', 'Half-grown; midpoint of choreography'],
                <String>['t = 0.75', 'Three-quarters; near full'],
                <String>['t = 1.00', 'Fully realised; static state'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 3,
              title: 'Removal Frame Snapshots',
              subtitle:
                  'removedItemBuilder visualised by reversing the t axis',
              bg: 0xFFFFF3E0,
              border: 0xFFFFE0B2,
              accent: 0xFFE65100,
              demoHeight: 400.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('t = 1.00 (item present)', removalFrameStart),
                  _miniDemoLabelled('t = 0.50 (halfway out)', removalFrameMid),
                  _miniDemoLabelled('t = 0.20 (nearly gone)', removalFrameLate),
                  _miniDemoLabelled('t = 0.00 (vanished)', removalFrameVanish),
                ],
              ),
              recipe: const <String>[
                'removedItemBuilder receives an animation that runs 1→0',
                'Reversing AlwaysStoppedAnimation values mirrors that path',
                'SizeTransition with sizeFactor: anim is the canonical removal',
                'Use distinct styling to flag departing rows visually',
              ],
              comparison: const <List<String>>[
                <String>['Frame', 'Phase'],
                <String>['t = 1.00', 'Item still occupies full slot'],
                <String>['t = 0.50', 'Halfway collapsed; warning state'],
                <String>['t = 0.20', 'Almost gone; ghosted'],
                <String>['t = 0.00', 'Fully removed; slot empty'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 4,
              title: 'itemBuilder Patterns',
              subtitle:
                  'Three contrasting itemBuilder strategies for AnimatedList rows',
              bg: 0xFFE8F5E9,
              border: 0xFFC8E6C9,
              accent: 0xFF2E7D32,
              demoHeight: 520.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('Leading/trailing icons', builderLeadingTrailing),
                  _miniDemoLabelled('Badge row with cue tags', builderBadgeRow),
                  _miniDemoLabelled('Timeline with connector', builderTimeline),
                ],
              ),
              recipe: const <String>[
                'itemBuilder must return a widget that uses the animation',
                'Free-form composition — Row, Column, custom layouts all work',
                'Combine with Container decoration + Border for shape',
                'CircleAvatar / icons help orient the index in long lists',
              ],
              comparison: const <List<String>>[
                <String>['Pattern', 'Notes'],
                <String>['Leading + trailing', 'Card-style, two-tone'],
                <String>['Badge row', 'Compact summary with cue tag'],
                <String>['Timeline', 'Vertical connector + bubble'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 5,
              title: 'SizeTransition Compositions',
              subtitle:
                  'axis / axisAlignment / horizontal variants of SizeTransition',
              bg: 0xFFEDE7F6,
              border: 0xFFD1C4E9,
              accent: 0xFF512DA8,
              demoHeight: 440.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('vertical (default)', sizeTransitionVertical),
                  _miniDemoLabelled('axisAlignment: -1 (top)', sizeTransitionTopAligned),
                  _miniDemoLabelled('axisAlignment: +1 (bottom)', sizeTransitionBottomAligned),
                  _miniDemoLabelled('axis: horizontal', sizeTransitionHorizontalAxis),
                ],
              ),
              recipe: const <String>[
                'SizeTransition scales the cross axis based on sizeFactor',
                'axis: Axis.horizontal swaps the scaling direction',
                'axisAlignment controls anchor point (-1 top, +1 bottom)',
                'Pair with FadeTransition for combined choreography',
              ],
              comparison: const <List<String>>[
                <String>['Property', 'Effect'],
                <String>['axis: vertical', 'Grow downward from center'],
                <String>['axis: horizontal', 'Grow sideways — for h-lists'],
                <String>['axisAlignment: -1', 'Anchor top, expand downward'],
                <String>['axisAlignment: +1', 'Anchor bottom, expand upward'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 6,
              title: 'FadeTransition Compositions',
              subtitle:
                  'Opacity ramp at four discrete t values from 0.2 to 1.0',
              bg: 0xFFFCE4EC,
              border: 0xFFF8BBD0,
              accent: 0xFFAD1457,
              demoHeight: 420.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('opacity = 0.2', fadeTwentyPercent),
                  _miniDemoLabelled('opacity = 0.4', fadeFortyPercent),
                  _miniDemoLabelled('opacity = 0.7', fadeSeventyPercent),
                  _miniDemoLabelled('opacity = 1.0', fadeFullPercent),
                ],
              ),
              recipe: const <String>[
                'FadeTransition uses opacity: animation',
                'Same Animation<double> drives every fade-in tile',
                'Combine with Color.withOpacity for layered fades',
                'For text-heavy rows, opacity feels softer than scale',
              ],
              comparison: const <List<String>>[
                <String>['t value', 'Visual'],
                <String>['0.2', 'Ghosted entry — barely visible'],
                <String>['0.4', 'Early reveal — silhouette'],
                <String>['0.7', 'Strong presence'],
                <String>['1.0', 'Fully opaque finalist'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 7,
              title: 'Combined Size + Fade',
              subtitle:
                  'Layering SizeTransition over FadeTransition for dual-axis motion',
              bg: 0xFFE0F7FA,
              border: 0xFFB2EBF2,
              accent: 0xFF006064,
              demoHeight: 400.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('t = 0.30', combinedDualEarly),
                  _miniDemoLabelled('t = 0.55', combinedDualMid),
                  _miniDemoLabelled('t = 0.85', combinedDualLate),
                ],
              ),
              recipe: const <String>[
                'Wrap FadeTransition inside SizeTransition (or vice versa)',
                'Both share the same Animation<double> argument',
                'Result: simultaneous size + opacity reveal',
                'Idiomatic for Material Design enter/exit choreography',
              ],
              comparison: const <List<String>>[
                <String>['Stack order', 'Effect'],
                <String>['Size > Fade', 'Layout grows, content fades inside'],
                <String>['Fade > Size', 'Opacity envelopes the resize'],
                <String>['Single transition', 'One-axis motion'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 8,
              title: 'SliverAnimatedList Patterns',
              subtitle:
                  'AnimatedList semantics inside a CustomScrollView viewport',
              bg: 0xFFEDE7F6,
              border: 0xFFD1C4E9,
              accent: 0xFF311B92,
              demoHeight: 460.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('SliverAnimatedList host', sliverAnimatedHost),
                  _miniDemoLabelled('Mixed slivers', sliverAnimatedMixed),
                ],
              ),
              recipe: const <String>[
                'SliverAnimatedList participates in viewport scroll',
                'Inside CustomScrollView with other slivers',
                'Same itemBuilder signature as AnimatedList',
                'Use SliverToBoxAdapter to interleave non-list content',
              ],
              comparison: const <List<String>>[
                <String>['Widget', 'Role'],
                <String>['AnimatedList', 'Standalone scroll view'],
                <String>['SliverAnimatedList', 'Inside CustomScrollView'],
                <String>['SliverList', 'No animation semantics'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 9,
              title: 'Reorder Visualisation',
              subtitle:
                  'Before / during / after snapshots of a reorder operation',
              bg: 0xFFFFF8E1,
              border: 0xFFFFECB3,
              accent: 0xFFE65100,
              demoHeight: 440.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('Before (orig order)', reorderBefore),
                  _miniDemoLabelled('During swap (t=0.5)', reorderDuring),
                  _miniDemoLabelled('After (new order)', reorderAfter),
                ],
              ),
              recipe: const <String>[
                'Reordering = remove + insert under the hood',
                'Render two ordering arrays for before / after',
                'Middle frame uses t=0.5 to visualise interpolation',
                'In production, ReorderableListView wraps the choreography',
              ],
              comparison: const <List<String>>[
                <String>['Stage', 'Item order'],
                <String>['Before', '[0, 1, 2, 3]'],
                <String>['During', '[0, 2, 1, 3]'],
                <String>['After', '[2, 0, 3, 1]'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 10,
              title: 'Separator Variations',
              subtitle:
                  'AnimatedList has no built-in separator — compose in the builder',
              bg: 0xFFE0F2F1,
              border: 0xFFB2DFDB,
              accent: 0xFF00695C,
              demoHeight: 480.0,
              demo: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _miniDemoLabelled('SizedBox gap', separatorGap),
                  _miniDemoLabelled('Material Divider', separatorDivider),
                  _miniDemoLabelled('Gradient accent rule', separatorAccent),
                ],
              ),
              recipe: const <String>[
                'AnimatedList itself has no separatorBuilder',
                'Return a Column from itemBuilder with the separator below',
                'Use Divider, SizedBox, or a styled Container',
                'The animation wraps the whole Column for cohesive entry',
              ],
              comparison: const <List<String>>[
                <String>['Approach', 'Result'],
                <String>['SizedBox', 'Empty gap; cleanest'],
                <String>['Divider', 'Material 1px rule'],
                <String>['Gradient bar', 'Themed accent separator'],
              ],
            ),
            const SizedBox(height: 16.0),
            _sectionPanel(
              number: 11,
              title: 'Recipe Gallery',
              subtitle: 'Hand-curated code-quote cards for copy-paste reuse',
              bg: 0xFFFAFAFA,
              border: 0xFFE0E0E0,
              accent: 0xFF455A64,
              demoHeight: 720.0,
              demo: recipeGallery,
              recipe: const <String>[
                'Each card is a self-contained AnimatedList idiom',
                'Use them as starting points for richer choreographies',
                'Mix and match SizeTransition + FadeTransition freely',
                'Pair with SliverAnimatedList for in-viewport hosting',
              ],
              comparison: const <List<String>>[
                <String>['Recipe', 'Highlights'],
                <String>['Basic AnimatedList', 'Vertical, SizeTransition'],
                <String>['Fade itemBuilder', 'Soft opacity reveal'],
                <String>['Combined transitions', 'Dual-axis choreography'],
                <String>['Horizontal list', 'Axis.horizontal scroll'],
                <String>['SliverAnimatedList', 'Viewport-embedded'],
                <String>['removedItemBuilder', 'Exit-animation pattern'],
              ],
            ),
            const SizedBox(height: 20.0),
            _comparisonOverviewPanel(),
            const SizedBox(height: 16.0),
            _glossaryPanel(),
            const SizedBox(height: 16.0),
            _epiloguePanel(),
            const SizedBox(height: 24.0),
            const Center(
              child: Text(
                'AnimatedList Choreography Hall • Deep Demo • Flutter Widgets',
                style: TextStyle(fontSize: 11.0, color: Color(0xFF9E9E9E)),
              ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// HERO HEADER — gradient banner with chip cluster
// ============================================================================
Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF4A148C),
          Color(0xFF7B1FA2),
          Color(0xFFAB47BC),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x66000000),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(
                Icons.queue_music,
                color: Color(0xFFFFFFFF),
                size: 28.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'AnimatedList Choreography Hall',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Text(
                    'A staged tour of insertion, removal, and transition primitives',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFEDE7F6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Deep Demo: AnimatedList, SliverAnimatedList, itemBuilder, '
          'removedItemBuilder, SizeTransition, FadeTransition. Insertion and '
          'removal are visualised as static frame snapshots driven by '
          'AlwaysStoppedAnimation<double>(t).',
          style: TextStyle(
            fontSize: 12.5,
            color: Color(0xFFEDE7F6),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _heroChip('AnimatedList'),
            _heroChip('SliverAnimatedList'),
            _heroChip('itemBuilder'),
            _heroChip('removedItemBuilder'),
            _heroChip('SizeTransition'),
            _heroChip('FadeTransition'),
            _heroChip('AlwaysStoppedAnimation'),
            _heroChip('Reorder snapshots'),
            _heroChip('Separator variations'),
            _heroChip('Recipe gallery'),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            for (final String label in _palettesLabels.take(4))
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  decoration: BoxDecoration(
                    color: const Color(0x22FFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 11.0),
    ),
  );
}

// ============================================================================
// CONCEPT OVERVIEW
// ============================================================================
Widget _conceptOverview() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x11000000),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF6A1B9A),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.theater_comedy,
                color: Color(0xFFFFFFFF),
                size: 18.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Concept Overview',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'AnimatedList wraps a scroll view that animates inserts and removals '
          'via a state-bound API: AnimatedListState.insertItem / removeItem. '
          'Because the bridged D4rt interpreter cannot subclass StatefulWidget '
          'or hold an AnimatedListState reference, we visualise the surface '
          'area through STATIC SNAPSHOTS instead — different itemCounts, '
          'different t values fed through AlwaysStoppedAnimation<double>(t).',
          style: TextStyle(fontSize: 13.0, height: 1.5, color: Color(0xFF37474F)),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Key principle:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 6.0),
        const Text(
          '  AnimatedList = "what to grow / shrink"    '
          'AlwaysStoppedAnimation = "freeze the curve at t"',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Color(0xFF311B92),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFD1C4E9)),
          ),
          child: const Text(
            'Every section below renders multiple AnimatedList instances side-by-side. Insertion is shown by sweeping t from 0 to 1; removal by sweeping t from 1 to 0. Combine them mentally to picture the live choreography.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF4A148C),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION PANEL — re-used wrapper for every numbered demo
// ============================================================================
Widget _sectionPanel({
  required int number,
  required String title,
  required String subtitle,
  required int bg,
  required int border,
  required int accent,
  required Widget demo,
  required double demoHeight,
  required List<String> recipe,
  required List<List<String>> comparison,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(bg),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(border), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x11000000),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(accent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(accent),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF616161),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        // ---- LIVE DEMO BOX ----
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color(border).withOpacity(0.6)),
          ),
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: demoHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: demo,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        _recipeCard(recipe, accent),
        const SizedBox(height: 10.0),
        _comparisonTable(comparison, accent, border),
      ],
    ),
  );
}

// ============================================================================
// RECIPE CARD
// ============================================================================
Widget _recipeCard(List<String> lines, int accent) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Color(accent), size: 16.0),
            const SizedBox(width: 6.0),
            Text(
              'Recipe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Color(accent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        for (final String line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '• ',
                  style: TextStyle(color: Color(accent), fontSize: 12.0),
                ),
                Expanded(
                  child: Text(
                    line,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF424242),
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

// ============================================================================
// COMPARISON TABLE
// ============================================================================
Widget _comparisonTable(List<List<String>> rows, int accent, int border) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.compare_arrows, color: Color(accent), size: 14.0),
            const SizedBox(width: 6.0),
            Text(
              'Comparison',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                color: Color(accent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: i == 0
                  ? Color(border).withOpacity(0.18)
                  : (i.isEven
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFFF5F5F5)),
              borderRadius: BorderRadius.circular(4.0),
            ),
            margin: const EdgeInsets.only(bottom: 2.0),
            child: Row(
              children: <Widget>[
                for (int c = 0; c < rows[i].length; c++)
                  Expanded(
                    child: Text(
                      rows[i][c],
                      style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: c == 0 ? 'monospace' : null,
                        fontWeight: i == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: i == 0
                            ? Color(accent)
                            : const Color(0xFF424242),
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

// ============================================================================
// COMPARISON OVERVIEW — AnimatedList vs ListView vs ReorderableListView
// ============================================================================
Widget _comparisonOverviewPanel() {
  const List<List<String>> rows = <List<String>>[
    <String>['Capability', 'AnimatedList', 'ListView', 'ReorderableListView'],
    <String>['Insert animation', 'yes (state API)', 'no', 'partial'],
    <String>['Remove animation', 'yes (state API)', 'no', 'partial'],
    <String>['Reorder support', 'manual', 'no', 'built-in'],
    <String>['itemBuilder signature', '(ctx, i, anim)', '(ctx, i)', '(ctx, i)'],
    <String>['Sliver variant', 'SliverAnimatedList', 'SliverList', 'n/a'],
    <String>['Separator support', 'manual (in builder)', '.separated ctor', 'manual'],
    <String>['Common transition', 'SizeTransition', 'n/a', 'AnimatedSwitcher'],
    <String>['Use case', 'Add/remove rows', 'Static rows', 'Drag to reorder'],
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x11000000),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.dashboard, color: Color(0xFF311B92), size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'AnimatedList vs ListView vs ReorderableListView',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: i == 0
                  ? const Color(0xFFEDE7F6)
                  : (i.isEven ? const Color(0xFFFFFFFF) : const Color(0xFFFAFAFA)),
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFEEEEEE),
                  width: 0.6,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                for (int c = 0; c < rows[i].length; c++)
                  Expanded(
                    flex: c == 0 ? 2 : 1,
                    child: Text(
                      rows[i][c],
                      style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: c == 0 ? 'monospace' : null,
                        fontWeight: i == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: i == 0
                            ? const Color(0xFF311B92)
                            : const Color(0xFF424242),
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

// ============================================================================
// GLOSSARY PANEL
// ============================================================================
Widget _glossaryPanel() {
  final List<Map<String, String>> entries = <Map<String, String>>[
    <String, String>{
      'term': 'AnimatedList',
      'def': 'A scrolling list that animates item inserts and removals.',
    },
    <String, String>{
      'term': 'SliverAnimatedList',
      'def': 'AnimatedList variant for use inside a CustomScrollView.',
    },
    <String, String>{
      'term': 'itemBuilder',
      'def': '(BuildContext, int, Animation<double>) → Widget — builds each row.',
    },
    <String, String>{
      'term': 'removedItemBuilder',
      'def': 'Builds the row during its exit animation (state API).',
    },
    <String, String>{
      'term': 'AnimatedListState',
      'def': 'State object exposing insertItem / removeItem.',
    },
    <String, String>{
      'term': 'SizeTransition',
      'def': 'Animates the size of its child along one axis.',
    },
    <String, String>{
      'term': 'FadeTransition',
      'def': 'Animates the opacity of its child.',
    },
    <String, String>{
      'term': 'AlwaysStoppedAnimation',
      'def': 'A non-ticking Animation<T> stuck at a single value — useful for snapshots.',
    },
    <String, String>{
      'term': 'axisAlignment',
      'def': 'SizeTransition property: -1=top, 0=center, +1=bottom.',
    },
    <String, String>{
      'term': 'initialItemCount',
      'def': 'Number of items the list has when first built.',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFFEE58), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.menu_book, color: Color(0xFFF57F17), size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Choreography Glossary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF57F17),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final Map<String, String> entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 138.0,
                  child: Text(
                    entry['term'] ?? '',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entry['def'] ?? '',
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF5D4037),
                      height: 1.45,
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

// ============================================================================
// EPILOGUE PANEL — coverage manifest
// ============================================================================
Widget _epiloguePanel() {
  final List<String> achievements = <String>[
    'AnimatedList with initialItemCount snapshots (0, 3, 5, 8)',
    'Insertion frames at t = 0, 0.25, 0.5, 0.75, 1.0',
    'Removal frames at t = 1, 0.5, 0.2, 0.0',
    'itemBuilder strategies: leading/trailing, badge row, timeline',
    'SizeTransition: vertical, axisAlignment -1/+1, horizontal',
    'FadeTransition: opacity ramps at 0.2 / 0.4 / 0.7 / 1.0',
    'Combined SizeTransition + FadeTransition dual-axis demo',
    'SliverAnimatedList inside a CustomScrollView host',
    'Reorder visualisation: before / during / after orderings',
    'Separator variations: SizedBox, Divider, gradient bar',
    'Recipe gallery with six copy-paste code-quote cards',
    'AnimatedList vs ListView vs ReorderableListView comparison table',
    'Choreography glossary covering 10 key API terms',
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1B5E20), Color(0xFF2E7D32)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.verified, color: Color(0xFFFFFFFF), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Epilogue • Coverage Manifest',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Every supported AnimatedList facet has a live (bounded) demo, recipe card, and comparison panel above. Below is the coverage manifest.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFFC8E6C9), height: 1.4),
        ),
        const SizedBox(height: 12.0),
        for (final String item in achievements)
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFFA5D6A7),
                  size: 14.0,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Choreography Hall Coverage: All AnimatedList Primitives Demonstrated ✓',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// FROZEN ANIMATEDLIST HELPER — wraps AnimatedList with AlwaysStoppedAnimation
// ============================================================================
Widget _frozenAnimatedList({
  required int count,
  required double t,
  required Widget Function(int, Animation<double>) builder,
}) {
  return AnimatedList(
    initialItemCount: count,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext c, int i, Animation<double> a) {
      // Override the supplied animation with a static t value so we can
      // visualise any frame on the choreography curve. The provided
      // `a` is intentionally ignored here.
      final Animation<double> frozen = AlwaysStoppedAnimation<double>(t);
      return builder(i, frozen);
    },
  );
}

// ============================================================================
// PERFORMER TILE — the canonical row used across most sections
// ============================================================================
Widget _performerTile(Map<String, dynamic> p, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Color(p['tone'] as int),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(p['accent'] as int), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(p['accent'] as int).withOpacity(0.08),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(p['accent'] as int),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '${p['symbol']}',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${p['name']}',
                style: TextStyle(
                  color: Color(p['accent'] as int),
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              Text(
                '${p['role']}',
                style: const TextStyle(
                  fontSize: 10.5,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(p['accent'] as int).withOpacity(0.5),
              width: 0.8,
            ),
          ),
          child: Text(
            '#${index + 1}',
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Color(p['accent'] as int),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// REMOVED ITEM TILE — the row variant used by removal frame snapshots
// ============================================================================
Widget _removedItemTile(Map<String, dynamic> p, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: const Color(0xFFEF5350),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFEF5350),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Icon(
            Icons.remove_circle,
            color: Color(0xFFFFFFFF),
            size: 16.0,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${p['name']} (exiting)',
                style: const TextStyle(
                  color: Color(0xFFB71C1C),
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              const Text(
                'removedItemBuilder snapshot',
                style: TextStyle(
                  fontSize: 10.5,
                  color: Color(0xFFC62828),
                ),
              ),
            ],
          ),
        ),
        Text(
          '#${index + 1}',
          style: const TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// MINI PROGRAMME NOTE — used inside SliverAnimatedList mixed demo
// ============================================================================
Widget _miniProgrammeNote(String title, String body, int accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(accent).withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            color: Color(accent),
          ),
        ),
        Text(
          body,
          style: const TextStyle(
            fontSize: 10.5,
            color: Color(0xFF424242),
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// MINI DEMO LABEL — label + bounded demo block, used inside section panels
// ============================================================================
Widget _miniDemoLabelled(String label, Widget demo) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: Color(0xFF311B92),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          padding: const EdgeInsets.all(4.0),
          child: demo,
        ),
      ],
    ),
  );
}

// ============================================================================
// QUAD GRID — 2x2 layout used by Section 1 to show four initialItemCounts
// ============================================================================
Widget _quadGrid(List<Widget> children) {
  // Pair them into rows of two for a 2x2 layout. If the list isn't a
  // multiple of two, the final row will have a placeholder Spacer instead.
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < children.length; i += 2) {
    final Widget left = children[i];
    final Widget right =
        (i + 1 < children.length) ? children[i + 1] : const SizedBox.shrink();
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: left),
            const SizedBox(width: 8.0),
            Expanded(child: right),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: rows,
  );
}

// ============================================================================
// RECIPE QUOTE CARD — monospace code-style card used by Section 11
// ============================================================================
Widget _recipeQuoteCard({
  required String title,
  required int accent,
  required List<String> lines,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(accent), width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(accent).withOpacity(0.25),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: Color(accent),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.code, color: Color(0xFFFFFFFF), size: 14.0),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 1.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Text(
                  'dart',
                  style: TextStyle(
                    fontSize: 9.5,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final String line in lines)
                Text(
                  line,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Color(0xFFB3E5FC),
                    height: 1.35,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// UNUSED RNG UTILITY — kept for potential future stochastic palette swaps
// ============================================================================
double _pseudoRandom(int seed) {
  final math.Random rng = math.Random(seed);
  return rng.nextDouble();
}

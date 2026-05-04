// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderSliverOverlapInjector from widgets
// Deep Demo: Visual demonstration of the RenderSliverOverlapInjector render
// object, the SliverOverlapAbsorberHandle that pairs it with an
// SliverOverlapAbsorber, and the NestedScrollView coordination pattern that
// keeps a pinned SliverAppBar from bleeding into inner sliver content.
import 'package:flutter/material.dart';

// ============================================================================
// Top-level constants used to keep the long build() method readable.
// ============================================================================

const Color kIndigoDeep = Color(0xFF1A237E);
const Color kIndigoMid = Color(0xFF3949AB);
const Color kIndigoSoft = Color(0xFFE8EAF6);
const Color kAmberDeep = Color(0xFFFF8F00);
const Color kAmberMid = Color(0xFFFFB300);
const Color kAmberSoft = Color(0xFFFFF8E1);
const Color kInkDark = Color(0xFF0D1117);
const Color kInkMid = Color(0xFF161B22);
const Color kInkSoft = Color(0xFF21262D);
const Color kCodeGreen = Color(0xFF7EE787);
const Color kCodePink = Color(0xFFFF7B72);
const Color kCodeBlue = Color(0xFF79C0FF);
const Color kCodePurple = Color(0xFFD2A8FF);
const Color kCodeAmber = Color(0xFFE3B341);

dynamic build(BuildContext context) {
  print('RenderSliverOverlapInjector Deep Demo executing');

  // ==========================================================================
  // SECTION 1: Title Banner
  // ==========================================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kIndigoDeep, kIndigoMid, kAmberDeep],
        stops: [0.0, 0.6, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: kIndigoDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: kAmberDeep.withValues(alpha: 0.20),
          blurRadius: 36.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.layers_outlined,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RenderSliverOverlapInjector',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'package:flutter/rendering.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Injects the overlap recorded by a paired '
                  'RenderSliverOverlapAbsorber so an inner CustomScrollView '
                  'starts below pinned headers.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white.withValues(alpha: 0.95),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 2: Anatomy diagram of the SliverOverlapAbsorberHandle
  // ==========================================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomyDiagram = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kIndigoSoft, Colors.white, kAmberSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kIndigoMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: kIndigoMid.withValues(alpha: 0.15),
          blurRadius: 18.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionLabel('2. Anatomy', 'How the handle bridges two render trees'),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _diagramColumn(
                title: 'OUTER scroll',
                subtitle: 'CustomScrollView',
                color: kIndigoMid,
                tiles: [
                  _diagramTile('SliverOverlapAbsorber', kIndigoMid, true),
                  _diagramTile('SliverAppBar (pinned)', kIndigoDeep, false),
                  _diagramTile('SliverPersistentHeader', kIndigoMid, false),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            _handleConnector(),
            const SizedBox(width: 8.0),
            Expanded(
              child: _diagramColumn(
                title: 'INNER scroll',
                subtitle: 'CustomScrollView',
                color: kAmberDeep,
                tiles: [
                  _diagramTile('SliverOverlapInjector', kAmberDeep, true),
                  _diagramTile('SliverList items', kAmberMid, false),
                  _diagramTile('SliverFillRemaining', kAmberMid, false),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        _legendChip(
          'SliverOverlapAbsorberHandle is a Listenable owned by the '
          'NestedScrollView. The absorber WRITES the overlap into it; the '
          'injector READS the overlap out.',
          Icons.swap_horiz,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 3: NestedScrollView pairing
  // ==========================================================================
  print('=== Section 3: NestedScrollView pairing ===');

  final nestedDiagram = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colors.white, kIndigoSoft],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kIndigoMid.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: kIndigoDeep.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionLabel('3. NestedScrollView pairing', 'Outer + inner slivers'),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: kIndigoSoft,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: kIndigoMid, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: kIndigoMid,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Text(
                      'OUTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    'headerSliverBuilder',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: kIndigoDeep,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              _diagramTile('SliverOverlapAbsorber(handle:_handle)', kIndigoMid, true),
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: _diagramTile('   SliverAppBar(pinned: true)', kIndigoDeep, false),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: kAmberDeep, width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: kAmberDeep.withValues(alpha: 0.30),
                  blurRadius: 8.0,
                  offset: const Offset(0.0, 3.0),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_downward, color: kAmberDeep, size: 16.0),
                SizedBox(width: 6.0),
                Text(
                  'overlap value flows DOWN via the shared handle',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: kAmberDeep,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: kAmberSoft,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: kAmberDeep, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: kAmberDeep,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Text(
                      'INNER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    'body: Builder(builder: ... CustomScrollView)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: kAmberDeep,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              _diagramTile('SliverOverlapInjector(handle:_handle)', kAmberDeep, true),
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: _diagramTile('SliverList(children)', kAmberMid, false),
              ),
              const SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: _diagramTile('SliverFillRemaining', kAmberMid, false),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 4: Why this exists - with vs without injector
  // ==========================================================================
  print('=== Section 4: Why this exists ===');

  final whyExists = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.red.shade50,
          Colors.white,
          Colors.green.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 14.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionLabel('4. Why this exists', 'With vs without injector'),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _comparisonStack(false)),
            const SizedBox(width: 12.0),
            Expanded(child: _comparisonStack(true)),
          ],
        ),
        const SizedBox(height: 14.0),
        _legendChip(
          'Without the injector, the inner sliver list starts at offset 0 in '
          'its own viewport — the pinned SliverAppBar paints OVER its first '
          'rows. With the injector, the list starts below the absorbed '
          'overlap so item #1 stays visible.',
          Icons.lightbulb_outline,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 5: Code skeleton in dark monospace
  // ==========================================================================
  print('=== Section 5: Code skeleton ===');

  final codeSkeleton = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kInkDark, kInkMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Color(0xFFFF5F56),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Color(0xFFFFBD2E),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Color(0xFF27C93F),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16.0),
            Text(
              'nested_scroll.dart',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _codeLine([_kw('NestedScrollView'), _pn('('), _na('')]),
        _codeLine([_pn('  '), _at('headerSliverBuilder'), _pn(': ('), _va('ctx'), _pn(', '), _va('_'), _pn(') => ['), _na('')]),
        _codeLine([_pn('    '), _kw('SliverOverlapAbsorber'), _pn('('), _na('')]),
        _codeLine([_pn('      '), _at('handle'), _pn(': '), _kw('NestedScrollView'), _pn('.'), _fn('sliverOverlapAbsorberHandleFor'), _pn('('), _va('ctx'), _pn('),'), _na('')]),
        _codeLine([_pn('      '), _at('sliver'), _pn(': '), _kw('SliverAppBar'), _pn('('), _at('pinned'), _pn(': '), _kw('true'), _pn(', /* ... */),'), _na('')]),
        _codeLine([_pn('    ),'), _na('')]),
        _codeLine([_pn('  ],'), _na('')]),
        _codeLine([_pn('  '), _at('body'), _pn(': '), _kw('Builder'), _pn('('), _na('')]),
        _codeLine([_pn('    '), _at('builder'), _pn(': ('), _va('ctx'), _pn(') => '), _kw('CustomScrollView'), _pn('('), _na('')]),
        _codeLine([_pn('      '), _at('slivers'), _pn(': ['), _na('')]),
        _codeLine([_pn('        '), _kw('SliverOverlapInjector'), _pn('('), _na('')]),
        _codeLine([_pn('          '), _at('handle'), _pn(': '), _kw('NestedScrollView'), _pn('.'), _fn('sliverOverlapAbsorberHandleFor'), _pn('('), _va('ctx'), _pn('),'), _na('')]),
        _codeLine([_pn('        ),'), _na('')]),
        _codeLine([_pn('        '), _kw('SliverList'), _pn('('), _at('delegate'), _pn(': '), _kw('SliverChildBuilderDelegate'), _pn('(...)),'), _na('')]),
        _codeLine([_pn('      ],'), _na('')]),
        _codeLine([_pn('    ),'), _na('')]),
        _codeLine([_pn('  ),'), _na('')]),
        _codeLine([_pn(');'), _na('')]),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 6: SliverConstraints overlap flow
  // ==========================================================================
  print('=== Section 6: SliverConstraints flow ===');

  final constraintsFlow = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionLabel(
          '6. SliverConstraints flow',
          'Where overlap travels in performLayout()',
        ),
        const SizedBox(height: 16.0),
        _flowRow(
          step: '1',
          title: 'Absorber.performLayout()',
          detail:
              'Lays out its child sliver, captures childLayoutGeometry.layoutExtent '
              'minus paintExtent, stores it in handle._setExtents().',
          color: kIndigoMid,
        ),
        _flowArrow(),
        _flowRow(
          step: '2',
          title: 'Handle notifies listeners',
          detail:
              'SliverOverlapAbsorberHandle is a ChangeNotifier; the inner '
              'render-object subscribes via attach()/detach().',
          color: kIndigoDeep,
        ),
        _flowArrow(),
        _flowRow(
          step: '3',
          title: 'Injector.performLayout()',
          detail:
              'Reads handle.layoutExtent, sets its own SliverGeometry with '
              'paintExtent and layoutExtent matching the absorbed value.',
          color: kAmberMid,
        ),
        _flowArrow(),
        _flowRow(
          step: '4',
          title: 'Inner viewport offsets following slivers',
          detail:
              'Subsequent slivers (SliverList, SliverFillRemaining) receive '
              'a precedingScrollExtent that already accounts for the headers.',
          color: kAmberDeep,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 7: Real-world TabBarView mock
  // ==========================================================================
  print('=== Section 7: Real-world TabBarView mock ===');

  final tabBarMock = Container(
    height: 360.0,
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 22.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: kIndigoDeep.withValues(alpha: 0.10),
          blurRadius: 8.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          // Background sheet
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade100, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Mock content rows (representing inner sliver list under injector)
          Positioned(
            top: 132.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Column(
              children: [
                for (int i = 0; i < 5; i++)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigo.shade50,
                            Colors.amber.shade50,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.indigo.shade100,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12.0),
                          Container(
                            width: 28.0,
                            height: 28.0,
                            decoration: BoxDecoration(
                              color: i.isEven
                                  ? kIndigoMid
                                  : kAmberDeep,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            'Inner SliverList row #${i + 1}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: kInkDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Pinned SliverAppBar (outer, absorbed)
          Container(
            height: 88.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [kIndigoDeep, kIndigoMid],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.20),
                  blurRadius: 8.0,
                  offset: const Offset(0.0, 3.0),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.menu, color: Colors.white),
                SizedBox(width: 12.0),
                Text(
                  'Project · TabBarView demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 12.0),
                Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),
          // TabBar (also pinned, sits in the absorber zone)
          Positioned(
            top: 88.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 44.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: kAmberDeep,
                    width: 3.0,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _tabPill('OVERVIEW', true),
                  _tabPill('FILES', false),
                  _tabPill('ACTIVITY', false),
                ],
              ),
            ),
          ),
          // Annotation: injector zone marker
          Positioned(
            top: 132.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 18.0,
              decoration: BoxDecoration(
                color: kAmberDeep.withValues(alpha: 0.85),
              ),
              alignment: Alignment.center,
              child: const Text(
                '↑ SliverOverlapInjector reserves this 132px overlap ↑',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 8: Lifecycle steps
  // ==========================================================================
  print('=== Section 8: Lifecycle ===');

  final lifecycleCard = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionLabel(
          '8. Lifecycle',
          'Handle creation → attach → layout → paint',
        ),
        const SizedBox(height: 14.0),
        _lifecycleStep(
          1,
          'Handle creation',
          'NestedScrollView creates one SliverOverlapAbsorberHandle in '
              'createState(); the value persists for the widget lifetime.',
          Colors.teal,
        ),
        _lifecycleStep(
          2,
          'Attach phase',
          'When the injector’s render object adopts a parent, attach() '
              'subscribes to the handle as a listener; detach() reverses it.',
          Colors.cyan,
        ),
        _lifecycleStep(
          3,
          'Layout phase',
          'During the outer scroll layout the absorber writes the overlap; '
              'during the inner scroll layout the injector reads it back and '
              'reports SliverGeometry(paintExtent: overlap).',
          Colors.lightBlue,
        ),
        _lifecycleStep(
          4,
          'Paint phase',
          'The injector paints nothing; it merely reserves layout space. '
              'Subsequent slivers paint as if the headers were inside their '
              'viewport.',
          Colors.indigo,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 9: Comparison vs simpler approaches
  // ==========================================================================
  print('=== Section 9: Comparison table ===');

  final comparisonTable = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionLabel(
          '9. Comparison',
          'Injector vs simpler layout approaches',
        ),
        const SizedBox(height: 12.0),
        _tableHeaderRow(),
        _tableRow(
          'Flat Column of slivers',
          'No nesting; fine until you need pull-to-refresh per page.',
          'No coordinated header collapse; each sliver fights for scroll.',
          Colors.red,
        ),
        _tableRow(
          'Manual Padding(top: kHeaderHeight)',
          'Quick hack; works for a constant-height header.',
          'Breaks on resize/orientation; no flex/snap; double-counts safe area.',
          Colors.orange,
        ),
        _tableRow(
          'Single CustomScrollView',
          'Simplest; all slivers scroll together.',
          'Cannot have independent inner pages (TabBarView with own scroll).',
          Colors.amber,
        ),
        _tableRow(
          'NestedScrollView + Injector',
          'Precise overlap math; supports pinned/snap/floating headers.',
          'Requires sharing handle through Builder context.',
          Colors.green,
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 10: Footgun cards
  // ==========================================================================
  print('=== Section 10: Footguns ===');

  final footgunCards = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _sectionLabel('10. Footguns', 'Five things that go wrong'),
      const SizedBox(height: 12.0),
      _footgun(
        '1. Sharing the handle by value',
        'A SliverOverlapAbsorberHandle is identity-based. Pass the SAME '
            'instance — never a copy or a new instance per build. Use '
            'NestedScrollView.sliverOverlapAbsorberHandleFor(context).',
        Icons.fingerprint,
        Colors.red,
      ),
      _footgun(
        '2. Forgetting the inner Builder',
        'sliverOverlapAbsorberHandleFor(context) walks UP from the given '
            'context. Without a Builder inside the body, you get the OUTER '
            'context and an assertion fires.',
        Icons.account_tree_outlined,
        Colors.deepOrange,
      ),
      _footgun(
        '3. Reusing one handle for two pairs',
        'Each absorber/injector pair owns one handle. Two absorbers writing '
            'to the same handle race; two injectors reading it both shift, '
            'doubling the offset.',
        Icons.compare_arrows,
        Colors.orange,
      ),
      _footgun(
        '4. Missing the injector entirely',
        'Without the injector, the inner viewport ignores the absorbed '
            'overlap, the first list item hides under the SliverAppBar, and '
            'scroll math goes off by exactly the header height.',
        Icons.warning_amber_outlined,
        Colors.amber,
      ),
      _footgun(
        '5. Treating the handle as cheap',
        'The handle is a Listenable. Every layout pulse may notify; injectors '
            'mark themselves needsLayout. Avoid creating extra handles or '
            'wrapping it in additional ChangeNotifiers.',
        Icons.bolt_outlined,
        Colors.purple,
      ),
    ],
  );

  // ==========================================================================
  // SECTION 11: Recap card
  // ==========================================================================
  print('=== Section 11: Recap ===');

  final recapCard = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [kIndigoDeep, kIndigoMid, kAmberDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: kIndigoDeep.withValues(alpha: 0.40),
          blurRadius: 22.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: kAmberDeep.withValues(alpha: 0.20),
          blurRadius: 30.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(
                Icons.bookmark_added_outlined,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'Recap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _recapBullet(
          'Injector mirrors the overlap recorded by the absorber.',
        ),
        _recapBullet(
          'Same SliverOverlapAbsorberHandle MUST be shared by reference.',
        ),
        _recapBullet(
          'Use NestedScrollView.sliverOverlapAbsorberHandleFor(context) '
          'inside a Builder under the body.',
        ),
        _recapBullet(
          'Place the SliverOverlapInjector as the FIRST sliver of the inner '
          'CustomScrollView.',
        ),
        _recapBullet(
          'Reserve only — it paints nothing; following slivers do the actual '
          'drawing.',
        ),
      ],
    ),
  );

  // ==========================================================================
  // Real Sliver demo (SliverOverlapInjector inside a real CustomScrollView).
  // We construct a tiny SliverOverlapAbsorberHandle and drop the real
  // SliverOverlapInjector widget in there — it is allowed at the top level.
  // ==========================================================================
  print('=== Live SliverOverlapInjector instance ===');

  final liveHandle = SliverOverlapAbsorberHandle();
  print('Live SliverOverlapAbsorberHandle: $liveHandle');

  final liveInjectorBox = Container(
    height: 220.0,
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kIndigoMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: kIndigoMid.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: CustomScrollView(
        slivers: [
          SliverOverlapInjector(handle: liveHandle),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: kIndigoSoft,
              child: const Text(
                'This CustomScrollView has a real SliverOverlapInjector at '
                'the top, fed by a standalone SliverOverlapAbsorberHandle. '
                'No overlap is ever written, so the injector reserves 0 '
                'pixels — the demo merely proves the widget mounts.',
                style: TextStyle(fontSize: 13.0, color: kInkDark),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext c, int i) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: i.isEven ? Colors.white : kAmberSoft,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Text(
                  'Item ${i + 1} below the injector',
                  style: const TextStyle(fontSize: 13.0, color: kInkDark),
                ),
              ),
              childCount: 8,
            ),
          ),
        ],
      ),
    ),
  );

  print('RenderSliverOverlapInjector Deep Demo completed successfully');

  // ==========================================================================
  // Final layout: Scaffold → SingleChildScrollView → Column
  // ==========================================================================
  return Scaffold(
    backgroundColor: const Color(0xFFF7F8FB),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          const SizedBox(height: 24.0),
          anatomyDiagram,
          const SizedBox(height: 24.0),
          nestedDiagram,
          const SizedBox(height: 24.0),
          whyExists,
          const SizedBox(height: 24.0),
          codeSkeleton,
          const SizedBox(height: 24.0),
          constraintsFlow,
          const SizedBox(height: 24.0),
          _sectionLabel(
            '7. Real-world TabBarView mock',
            'How the injector reserves the pinned area',
          ),
          const SizedBox(height: 12.0),
          tabBarMock,
          const SizedBox(height: 24.0),
          lifecycleCard,
          const SizedBox(height: 24.0),
          comparisonTable,
          const SizedBox(height: 24.0),
          footgunCards,
          const SizedBox(height: 24.0),
          _sectionLabel(
            'Live instance',
            'A real SliverOverlapInjector in a CustomScrollView',
          ),
          const SizedBox(height: 12.0),
          liveInjectorBox,
          const SizedBox(height: 24.0),
          recapCard,
          const SizedBox(height: 16.0),
        ],
      ),
    ),
  );
}

// ============================================================================
// Helpers (top-level)
// ============================================================================

Widget _sectionLabel(String title, String subtitle) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 4.0,
        height: 36.0,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [kIndigoDeep, kAmberDeep],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      const SizedBox(width: 10.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: kInkDark,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _diagramColumn({
  required String title,
  required String subtitle,
  required Color color,
  required List<Widget> tiles,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 10.0),
        for (final t in tiles) ...[t, const SizedBox(height: 6.0)],
      ],
    ),
  );
}

Widget _diagramTile(String label, Color color, bool highlighted) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: highlighted
            ? [color, color.withValues(alpha: 0.7)]
            : [
                color.withValues(alpha: 0.20),
                color.withValues(alpha: 0.10),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(
        color: color,
        width: highlighted ? 2.0 : 1.0,
      ),
    ),
    child: Row(
      children: [
        Icon(
          highlighted ? Icons.star : Icons.crop_square,
          size: 14.0,
          color: highlighted ? Colors.white : color,
        ),
        const SizedBox(width: 6.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
              color: highlighted ? Colors.white : color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _handleConnector() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(height: 30.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [kIndigoMid, kAmberDeep],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: kIndigoMid.withValues(alpha: 0.40),
              blurRadius: 6.0,
              offset: const Offset(0.0, 3.0),
            ),
          ],
        ),
        child: const Column(
          children: [
            Icon(Icons.link, color: Colors.white, size: 16.0),
            SizedBox(height: 4.0),
            RotatedBox(
              quarterTurns: 1,
              child: Text(
                'HANDLE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 9.0,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _legendChip(String text, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kAmberDeep.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: kAmberDeep, size: 18.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.0,
              color: kInkDark,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonStack(bool withInjector) {
  final Color accent = withInjector ? Colors.green.shade700 : Colors.red.shade700;
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            withInjector ? 'WITH injector' : 'WITHOUT injector',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        // Header bar
        Container(
          height: 26.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [kIndigoDeep, kIndigoMid],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.centerLeft,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              'SliverAppBar (pinned)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        // Stack: with injector shows reserved zone; without shows overlap
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                if (withInjector)
                  Container(
                    height: 16.0,
                    decoration: BoxDecoration(
                      color: kAmberDeep.withValues(alpha: 0.35),
                      border: Border.all(color: kAmberDeep, width: 1.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'INJECTOR (reserves)',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: kInkDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                for (int i = 0; i < 4; i++)
                  Container(
                    height: 18.0,
                    margin: const EdgeInsets.symmetric(vertical: 2.0),
                    decoration: BoxDecoration(
                      color: i == 0 && !withInjector
                          ? Colors.red.shade100
                          : kIndigoSoft,
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(
                        color: i == 0 && !withInjector
                            ? Colors.red
                            : Colors.indigo.shade200,
                        width: 1.0,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        'Row #${i + 1}',
                        style: const TextStyle(
                          fontSize: 9.0,
                          color: kInkDark,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Without injector: header bleeds over Row #1
            if (!withInjector)
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: kIndigoDeep.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '⚠ header bleeds over Row #1',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
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

Widget _flowRow({
  required String step,
  required String title,
  required String detail,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.0),
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                detail,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: kInkDark,
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

Widget _flowArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Center(
      child: Icon(Icons.arrow_downward, color: kIndigoMid, size: 22.0),
    ),
  );
}

Widget _tabPill(String label, bool active) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: active ? kAmberDeep : Colors.transparent,
            width: 3.0,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          color: active ? kInkDark : Colors.grey.shade600,
          letterSpacing: 0.5,
        ),
      ),
    ),
  );
}

Widget _lifecycleStep(int n, String title, String body, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            '#$n',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: kInkDark,
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

Widget _tableHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: kIndigoSoft,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: const [
        Expanded(
          flex: 3,
          child: Text(
            'Approach',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: kIndigoDeep,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Pros',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: kIndigoDeep,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Cons',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: kIndigoDeep,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tableRow(String approach, String pros, String cons, Color tone) {
  return Container(
    margin: const EdgeInsets.only(top: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: tone.withValues(alpha: 0.30), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            approach,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: tone,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            pros,
            style: const TextStyle(fontSize: 10.5, color: kInkDark),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            cons,
            style: const TextStyle(fontSize: 10.5, color: kInkDark),
          ),
        ),
      ],
    ),
  );
}

Widget _footgun(String title, String body, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.02),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.50), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.white, size: 20.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: kInkDark,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recapBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.6),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Code-skeleton helpers: build a syntax-highlighted line out of token spans.
// ----------------------------------------------------------------------------

Widget _codeLine(List<TextSpan> spans) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.0,
          color: Colors.white,
          height: 1.45,
        ),
        children: spans,
      ),
    ),
  );
}

TextSpan _kw(String s) =>
    TextSpan(text: s, style: const TextStyle(color: kCodePink, fontWeight: FontWeight.w600));
TextSpan _at(String s) =>
    TextSpan(text: s, style: const TextStyle(color: kCodeAmber));
TextSpan _va(String s) =>
    TextSpan(text: s, style: const TextStyle(color: kCodeBlue));
TextSpan _fn(String s) =>
    TextSpan(text: s, style: const TextStyle(color: kCodePurple, fontStyle: FontStyle.italic));
TextSpan _pn(String s) =>
    TextSpan(text: s, style: const TextStyle(color: Color(0xFFC9D1D9)));
TextSpan _na(String s) =>
    TextSpan(text: s, style: const TextStyle(color: kCodeGreen));

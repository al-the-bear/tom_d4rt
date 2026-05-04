// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests AggregatedTimings from package:flutter/foundation.dart
// Deep Demo: Visual exploration of AggregatedTimings, AggregatedTimedBlock,
// frame budgets, performance buckets, and timing aggregation visualization.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AggregatedTimings Deep Demo executing');

  // ============================================================
  // Data preparation: synthesize AggregatedTimedBlock samples
  // and a real AggregatedTimings instance (with empty timedBlocks
  // due to bridge cast quirk; computed buckets are illustrated).
  // ============================================================
  print('=== Preparing aggregated timing data ===');

  final emptyTimings = AggregatedTimings(<TimedBlock>[]);
  print('Empty AggregatedTimings created');
  print('Empty timedBlocks count: ${emptyTimings.timedBlocks.length}');
  print('Empty aggregatedBlocks count: ${emptyTimings.aggregatedBlocks.length}');

  // Standalone AggregatedTimedBlock objects illustrating typical
  // build/layout/paint/raster performance categories.
  final blocks = <AggregatedTimedBlock>[
    AggregatedTimedBlock(name: 'build', duration: 2400.0, count: 3),
    AggregatedTimedBlock(name: 'layout', duration: 1800.0, count: 2),
    AggregatedTimedBlock(name: 'paint', duration: 1200.0, count: 4),
    AggregatedTimedBlock(name: 'compositing', duration: 900.0, count: 2),
    AggregatedTimedBlock(name: 'rasterize', duration: 3600.0, count: 1),
    AggregatedTimedBlock(name: 'gestureDispatch', duration: 200.0, count: 5),
    AggregatedTimedBlock(name: 'semantics', duration: 450.0, count: 1),
  ];

  for (final b in blocks) {
    print('Block ${b.name}: duration=${b.duration}us count=${b.count}');
  }

  // Synthetic timings list to derive min/max/average illustration.
  final samplesPerBlock = <String, List<double>>{
    'build': <double>[700.0, 820.0, 880.0],
    'layout': <double>[850.0, 950.0],
    'paint': <double>[280.0, 300.0, 310.0, 310.0],
    'compositing': <double>[420.0, 480.0],
    'rasterize': <double>[3600.0],
    'gestureDispatch': <double>[35.0, 40.0, 42.0, 41.0, 42.0],
    'semantics': <double>[450.0],
  };

  final perBlockStats = <_BlockStat>[];
  for (final entry in samplesPerBlock.entries) {
    final samples = entry.value;
    var minV = samples.first;
    var maxV = samples.first;
    var total = 0.0;
    for (final s in samples) {
      if (s < minV) minV = s;
      if (s > maxV) maxV = s;
      total += s;
    }
    final avg = total / samples.length;
    perBlockStats.add(
      _BlockStat(
        name: entry.key,
        count: samples.length,
        total: total,
        min: minV,
        max: maxV,
        average: avg,
      ),
    );
    print(
      'Stats ${entry.key}: count=${samples.length} total=$total '
      'min=$minV max=$maxV avg=${avg.toStringAsFixed(2)}',
    );
  }

  // ============================================================
  // SECTION 1: Hero header with introduction
  // ============================================================
  print('=== Section 1: Hero header ===');
  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade800, Colors.purple.shade600, Colors.pink.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 20.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.amber.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.timeline,
                size: 40.0,
                color: Colors.indigo.shade800,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AggregatedTimings',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Aggregates TimedBlock data into per-name summaries with '
          'duration totals and counts. Use FlutterTimeline.debugCollect '
          'to gather frame timings, then construct AggregatedTimings to '
          'reason about hotspots.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white,
            height: 1.45,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildHeroChip('@immutable', Icons.lock_outline),
            _buildHeroChip('final class', Icons.architecture),
            _buildHeroChip('lazy compute', Icons.flash_on),
            _buildHeroChip('per-name stats', Icons.dashboard),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: AggregatedTimedBlock anatomy
  // ============================================================
  print('=== Section 2: AggregatedTimedBlock anatomy ===');
  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.cyan.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.15),
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
            Icon(Icons.tune, color: Colors.blue.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'AggregatedTimedBlock anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildAnatomyField(
                'name',
                'String',
                'Readable label that uniquely identifies the timed code path.',
                Colors.indigo,
                Icons.label_important_outline,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildAnatomyField(
                'duration',
                'double',
                'Sum of TimedBlock durations (microseconds).',
                Colors.teal,
                Icons.timer,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _buildAnatomyField(
                'count',
                'int',
                'Number of TimedBlock samples merged.',
                Colors.deepOrange,
                Icons.format_list_numbered,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Sample blocks card grid
  // ============================================================
  print('=== Section 3: Sample blocks ===');
  final blockCards = <Widget>[];
  for (final b in blocks) {
    final color = _colorForBlock(b.name);
    blockCards.add(
      Container(
        width: 200.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.30),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_iconForBlock(b.name), color: color, size: 20.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    b.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildKvRow('duration', '${b.duration.toStringAsFixed(0)} us', color),
            SizedBox(height: 4.0),
            _buildKvRow('count', '${b.count}', color),
            SizedBox(height: 4.0),
            _buildKvRow(
              'avg/sample',
              '${(b.duration / b.count).toStringAsFixed(1)} us',
              color,
            ),
            SizedBox(height: 10.0),
            Container(
              height: 6.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (b.duration / 4000.0).clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withValues(alpha: 0.8), color],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Timing distribution bar chart (totals)
  // ============================================================
  print('=== Section 4: Timing distribution chart ===');
  final maxDuration = blocks
      .map((b) => b.duration)
      .fold<double>(0.0, (a, b) => a > b ? a : b);

  final chartBars = <Widget>[];
  for (final b in blocks) {
    final color = _colorForBlock(b.name);
    final fraction = (b.duration / maxDuration).clamp(0.0, 1.0);
    chartBars.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            SizedBox(
              width: 110.0,
              child: Text(
                b.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: fraction,
                    child: Container(
                      height: 24.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withValues(alpha: 0.7),
                            color,
                            color.withValues(alpha: 0.85),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.35),
                            blurRadius: 6.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${b.duration.toStringAsFixed(0)} us',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            SizedBox(
              width: 50.0,
              child: Text(
                'x${b.count}',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final distributionChart = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
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
            Icon(Icons.bar_chart, color: Colors.deepPurple, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Total duration per name (us)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...chartBars,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Frame budget thermometer (16.6 ms ~ 60 fps)
  // ============================================================
  print('=== Section 5: Frame budget thermometer ===');
  // Sum of all durations in microseconds.
  var totalUs = 0.0;
  for (final b in blocks) {
    totalUs += b.duration;
  }
  final totalMs = totalUs / 1000.0;
  const frameBudgetMs60 = 16.667;
  const frameBudgetMs120 = 8.333;
  final frame60Frac = (totalMs / frameBudgetMs60).clamp(0.0, 1.5);
  final frame120Frac = (totalMs / frameBudgetMs120).clamp(0.0, 1.5);

  final thermometer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50, Colors.yellow.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.15),
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
            Icon(Icons.speed, color: Colors.deepOrange, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Frame budget thermometer',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Total accumulated time: ${totalMs.toStringAsFixed(2)} ms '
          '(${totalUs.toStringAsFixed(0)} us)',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 14.0),
        _buildBudgetBar(
          '60 fps budget',
          frameBudgetMs60,
          totalMs,
          frame60Frac,
          Colors.green,
          Colors.red,
        ),
        SizedBox(height: 12.0),
        _buildBudgetBar(
          '120 fps budget',
          frameBudgetMs120,
          totalMs,
          frame120Frac,
          Colors.teal,
          Colors.deepOrange,
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _buildBudgetTag(
              frame60Frac <= 1.0 ? 'within 60fps' : 'over 60fps',
              frame60Frac <= 1.0 ? Colors.green : Colors.red,
              frame60Frac <= 1.0 ? Icons.check_circle : Icons.warning_amber,
            ),
            SizedBox(width: 8.0),
            _buildBudgetTag(
              frame120Frac <= 1.0 ? 'within 120fps' : 'over 120fps',
              frame120Frac <= 1.0 ? Colors.teal : Colors.deepOrange,
              frame120Frac <= 1.0 ? Icons.check_circle : Icons.warning_amber,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Per-block min / max / average / count table
  // ============================================================
  print('=== Section 6: Stats table ===');
  final statsRows = <Widget>[];
  statsRows.add(
    Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade100, Colors.indigo.shade50],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          _buildHeaderCell('name', 110.0),
          _buildHeaderCell('count', 60.0),
          _buildHeaderCell('total', 80.0),
          _buildHeaderCell('min', 70.0),
          _buildHeaderCell('max', 70.0),
          _buildHeaderCell('avg', 70.0),
        ],
      ),
    ),
  );

  for (var i = 0; i < perBlockStats.length; i++) {
    final s = perBlockStats[i];
    final color = _colorForBlock(s.name);
    final striped = i.isEven ? Colors.white : Colors.grey.shade50;
    statsRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: striped,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 110.0,
              child: Row(
                children: [
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      s.name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: Colors.grey.shade900,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            _buildDataCell('${s.count}', 60.0, Colors.grey.shade800),
            _buildDataCell('${s.total.toStringAsFixed(0)}', 80.0, color),
            _buildDataCell('${s.min.toStringAsFixed(0)}', 70.0, Colors.green.shade700),
            _buildDataCell('${s.max.toStringAsFixed(0)}', 70.0, Colors.red.shade700),
            _buildDataCell(
              s.average.toStringAsFixed(1),
              70.0,
              Colors.deepPurple.shade700,
            ),
          ],
        ),
      ),
    );
  }

  final statsTable = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(children: statsRows),
  );

  // ============================================================
  // SECTION 7: Min / Max / Average visualization per block
  // ============================================================
  print('=== Section 7: Min/Max/Avg viz ===');
  final mmaCards = <Widget>[];
  for (final s in perBlockStats) {
    final color = _colorForBlock(s.name);
    mmaCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_iconForBlock(s.name), color: color, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  s.name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '(${s.count} samples)',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildRangeBar(s.min, s.max, s.average, color),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatChip('min', '${s.min.toStringAsFixed(0)} us', Colors.green),
                _buildStatChip('avg', '${s.average.toStringAsFixed(1)} us', Colors.deepPurple),
                _buildStatChip('max', '${s.max.toStringAsFixed(0)} us', Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: getAggregated() - missing block fallback demo
  // ============================================================
  print('=== Section 8: getAggregated fallback ===');
  // Real call against the empty AggregatedTimings - returns block with 0/0.
  final missing = emptyTimings.getAggregated('nonExistentBlock');
  print(
    'getAggregated("nonExistentBlock") -> name=${missing.name} '
    'duration=${missing.duration} count=${missing.count}',
  );

  final fallbackPanel = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.green.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.shield_moon, color: Colors.teal.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'getAggregated() graceful fallback',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Calling getAggregated(name) on a name that has no recorded '
          'TimedBlock samples returns an AggregatedTimedBlock with '
          'duration 0 and count 0 instead of throwing.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.teal.shade900,
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _buildFallbackChip(
                'name',
                missing.name,
                Colors.teal,
                Icons.label_outline,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildFallbackChip(
                'duration',
                missing.duration.toStringAsFixed(1),
                Colors.green,
                Icons.timer,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildFallbackChip(
                'count',
                '${missing.count}',
                Colors.deepOrange,
                Icons.format_list_numbered,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Performance hotspot heatmap (matrix)
  // ============================================================
  print('=== Section 9: Heatmap ===');
  // 3 phases x N blocks, normalized intensity per cell.
  const phases = <String>['warmup', 'steady', 'teardown'];
  // Synthetic intensities scaled by block duration.
  final heatRows = <Widget>[];
  heatRows.add(
    Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 110.0),
          for (final p in phases)
            Expanded(
              child: Center(
                child: Text(
                  p,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
  for (var i = 0; i < blocks.length; i++) {
    final b = blocks[i];
    final color = _colorForBlock(b.name);
    final base = (b.duration / maxDuration).clamp(0.0, 1.0);
    final phaseIntensities = <double>[
      (base * 0.5).clamp(0.0, 1.0),
      base,
      (base * 0.7).clamp(0.0, 1.0),
    ];
    heatRows.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: [
            SizedBox(
              width: 110.0,
              child: Text(
                b.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            for (var j = 0; j < phases.length; j++)
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  height: 28.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.15 + 0.5 * phaseIntensities[j]),
                        color.withValues(alpha: 0.35 + 0.5 * phaseIntensities[j]),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: color.withValues(alpha: 0.5),
                      width: 0.8,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      phaseIntensities[j].toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  final heatmap = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: Colors.purple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Hotspot heatmap (per phase)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ...heatRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Aggregation pipeline diagram
  // ============================================================
  print('=== Section 10: Pipeline diagram ===');
  final pipeline = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade100, width: 1.5),
    ),
    child: Column(
      children: [
        Text(
          'Aggregation Pipeline',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPipelineNode(
              'TimedBlock',
              'name + start + end',
              Icons.fiber_manual_record,
              Colors.blue,
            ),
            _buildPipelineArrow(),
            _buildPipelineNode(
              'List<TimedBlock>',
              'collected via\nFlutterTimeline',
              Icons.list_alt,
              Colors.indigo,
            ),
            _buildPipelineArrow(),
            _buildPipelineNode(
              'AggregatedTimings',
              'wraps the list',
              Icons.merge_type,
              Colors.deepPurple,
            ),
            _buildPipelineArrow(),
            _buildPipelineNode(
              'AggregatedTimedBlock',
              'name / duration / count',
              Icons.assessment,
              Colors.purple,
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'aggregatedBlocks is computed lazily on first read; '
            'subsequent accesses return the cached list.',
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.deepPurple.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Code usage examples
  // ============================================================
  print('=== Section 11: Code examples ===');
  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
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
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage examples',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          '// 1. Collect timed blocks via FlutterTimeline\n'
          'FlutterTimeline.startSync("build");\n'
          'doExpensiveBuildWork();\n'
          'FlutterTimeline.finishSync();\n'
          '\n'
          'final blocks = FlutterTimeline.debugCollect();',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 2. Aggregate per name\n'
          'final timings = AggregatedTimings(blocks.timedBlocks);\n'
          'for (final agg in timings.aggregatedBlocks) {\n'
          '  print("\${agg.name}: \${agg.duration}us x\${agg.count}");\n'
          '}',
          Colors.lightBlueAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildCodeBlock(
          '// 3. Look up a specific block (graceful fallback)\n'
          'final buildAgg = timings.getAggregated("build");\n'
          'if (buildAgg.count == 0) {\n'
          '  // No build measurements in this window\n'
          '} else {\n'
          '  final avgUs = buildAgg.duration / buildAgg.count;\n'
          '}',
          Colors.amberAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Summary footer with totals
  // ============================================================
  print('=== Section 12: Summary footer ===');
  var totalBlocks = 0;
  for (final b in blocks) {
    totalBlocks += b.count;
  }

  final summaryFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade400, Colors.deepPurple.shade400, Colors.pink.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Aggregation summary',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSummaryStat('${blocks.length}', 'unique names', Icons.label),
            _buildSummaryStat('$totalBlocks', 'total samples', Icons.tag),
            _buildSummaryStat(
              '${totalUs.toStringAsFixed(0)}',
              'total us',
              Icons.hourglass_bottom,
            ),
            _buildSummaryStat(
              totalMs.toStringAsFixed(2),
              'total ms',
              Icons.timer,
            ),
          ],
        ),
      ],
    ),
  );

  print('AggregatedTimings Deep Demo completed successfully');

  // ============================================================
  // Final layout assembly
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              hero,
              SizedBox(height: 24.0),
              _sectionLabel('1. AggregatedTimedBlock Anatomy', Icons.architecture),
              anatomy,
              SizedBox(height: 24.0),
              _sectionLabel('2. Sample blocks', Icons.dashboard_customize),
              Wrap(alignment: WrapAlignment.center, children: blockCards),
              SizedBox(height: 24.0),
              _sectionLabel('3. Total duration distribution', Icons.bar_chart),
              distributionChart,
              SizedBox(height: 24.0),
              _sectionLabel('4. Frame budget thermometer', Icons.speed),
              thermometer,
              SizedBox(height: 24.0),
              _sectionLabel('5. Per-block summary table', Icons.table_chart),
              statsTable,
              SizedBox(height: 24.0),
              _sectionLabel('6. Min / Max / Average per block', Icons.stacked_bar_chart),
              ...mmaCards,
              SizedBox(height: 24.0),
              _sectionLabel('7. getAggregated() fallback', Icons.shield_moon),
              fallbackPanel,
              SizedBox(height: 24.0),
              _sectionLabel('8. Hotspot heatmap', Icons.grid_view),
              heatmap,
              SizedBox(height: 24.0),
              _sectionLabel('9. Aggregation pipeline', Icons.account_tree),
              pipeline,
              SizedBox(height: 24.0),
              _sectionLabel('10. Code examples', Icons.code),
              codeBlock,
              SizedBox(height: 24.0),
              _sectionLabel('11. Aggregation summary', Icons.summarize),
              summaryFooter,
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// Lightweight value object holding derived stats per block name.
// ============================================================
class _BlockStat {
  _BlockStat({
    required this.name,
    required this.count,
    required this.total,
    required this.min,
    required this.max,
    required this.average,
  });

  final String name;
  final int count;
  final double total;
  final double min;
  final double max;
  final double average;
}

// Returns a stable color for a given block name.
Color _colorForBlock(String name) {
  switch (name) {
    case 'build':
      return Colors.indigo;
    case 'layout':
      return Colors.teal;
    case 'paint':
      return Colors.deepPurple;
    case 'compositing':
      return Colors.orange;
    case 'rasterize':
      return Colors.red;
    case 'gestureDispatch':
      return Colors.green;
    case 'semantics':
      return Colors.blueGrey;
    default:
      return Colors.grey;
  }
}

// Returns a representative icon for a given block name.
IconData _iconForBlock(String name) {
  switch (name) {
    case 'build':
      return Icons.build_circle;
    case 'layout':
      return Icons.dashboard;
    case 'paint':
      return Icons.brush;
    case 'compositing':
      return Icons.layers;
    case 'rasterize':
      return Icons.grain;
    case 'gestureDispatch':
      return Icons.touch_app;
    case 'semantics':
      return Icons.accessibility_new;
    default:
      return Icons.timer;
  }
}

// Section header pill.
Widget _sectionLabel(String text, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withValues(alpha: 0.25),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

// Hero chip used in the header banner.
Widget _buildHeroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 13.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// Anatomy field card (name / duration / count).
Widget _buildAnatomyField(
  String fieldName,
  String type,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              fieldName,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade800,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// Key/value row used inside the block cards.
Widget _buildKvRow(String key, String value, Color color) {
  return Row(
    children: [
      Text(
        '$key:',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: Colors.grey.shade700,
        ),
      ),
      SizedBox(width: 6.0),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

// Frame budget bar (60fps / 120fps) - shows budget as background and
// total time as a coloured fill that turns red if over the budget.
Widget _buildBudgetBar(
  String label,
  double budgetMs,
  double actualMs,
  double frac,
  Color okColor,
  Color overColor,
) {
  final isOver = actualMs > budgetMs;
  final fillColor = isOver ? overColor : okColor;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(width: 6.0),
          Text(
            '(${budgetMs.toStringAsFixed(2)} ms)',
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.grey.shade600,
            ),
          ),
          Spacer(),
          Text(
            '${(frac * 100).toStringAsFixed(0)}%',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: fillColor,
            ),
          ),
        ],
      ),
      SizedBox(height: 4.0),
      Stack(
        children: [
          Container(
            height: 18.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          FractionallySizedBox(
            widthFactor: frac.clamp(0.0, 1.0),
            child: Container(
              height: 18.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    fillColor.withValues(alpha: 0.7),
                    fillColor,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: fillColor.withValues(alpha: 0.35),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
            ),
          ),
          if (frac > 1.0)
            Positioned(
              right: 4.0,
              top: 0.0,
              bottom: 0.0,
              child: Center(
                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    ],
  );
}

// Tag widget for the budget panel summary.
Widget _buildBudgetTag(String label, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Header cell for tables.
Widget _buildHeaderCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

// Generic data cell for tables.
Widget _buildDataCell(String text, double width, Color color) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Range bar showing min, average, max along a 0..maxRange line.
Widget _buildRangeBar(double min, double max, double avg, Color color) {
  final maxRange = max <= 0.0 ? 1.0 : max;
  final minFrac = (min / maxRange).clamp(0.0, 1.0);
  final avgFrac = (avg / maxRange).clamp(0.0, 1.0);
  return SizedBox(
    height: 32.0,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        return Stack(
          children: [
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 13.0,
              child: Container(
                height: 6.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.15),
                      color.withValues(alpha: 0.5),
                      color.withValues(alpha: 0.15),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
            Positioned(
              left: (w * minFrac) - 6.0,
              top: 4.0,
              child: Container(
                width: 12.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.4),
                      blurRadius: 3.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: (w * avgFrac) - 6.0,
              top: 4.0,
              child: Container(
                width: 12.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
            Positioned(
              right: -6.0,
              top: 4.0,
              child: Container(
                width: 12.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

// Small statistic chip used by min/max/avg cards.
Widget _buildStatChip(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade700,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Fallback chip used by the getAggregated section.
Widget _buildFallbackChip(
  String label,
  String value,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey.shade600,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Pipeline node and arrow for the aggregation flow diagram.
Widget _buildPipelineNode(
  String title,
  String subtitle,
  IconData icon,
  Color color,
) {
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.35),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(height: 4.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 3.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.0,
            color: Colors.grey.shade700,
            height: 1.25,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipelineArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(
      Icons.arrow_forward,
      color: Colors.deepPurple.shade400,
      size: 22.0,
    ),
  );
}

// Code block widget.
Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.05),
        width: 1.0,
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.5,
      ),
    ),
  );
}

// Summary stat used inside the footer banner.
Widget _buildSummaryStat(String value, String label, IconData icon) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.35),
            width: 1.0,
          ),
        ),
        child: Icon(icon, color: Colors.white, size: 18.0),
      ),
      SizedBox(height: 6.0),
      Text(
        value,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.white70,
        ),
      ),
    ],
  );
}

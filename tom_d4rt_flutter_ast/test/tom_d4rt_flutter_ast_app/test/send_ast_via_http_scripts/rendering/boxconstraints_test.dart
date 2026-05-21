// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BoxConstraints from rendering
// Deep Demo: Visual exploration of BoxConstraints constructors, getters and methods.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxConstraints Deep Demo executing');

  // ============================================================
  // SECTION 1: Constructor Gallery
  // ============================================================
  print('=== Section 1: Constructor Gallery ===');

  final defaultConstraints = BoxConstraints();
  final fullConstraints = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 30.0,
    maxHeight: 150.0,
  );
  final tightConstraints = BoxConstraints.tight(const Size(200.0, 100.0));
  final tightForWidthConstraints = BoxConstraints.tightFor(width: 120.0);
  final tightForHeightConstraints = BoxConstraints.tightFor(height: 80.0);
  final tightForBothConstraints = BoxConstraints.tightFor(
    width: 140.0,
    height: 90.0,
  );
  final tightForFiniteConstraints = BoxConstraints.tightForFinite(
    width: 110.0,
    height: 70.0,
  );
  final looseConstraints = BoxConstraints.loose(const Size(180.0, 120.0));
  final expandAllConstraints = BoxConstraints.expand();
  final expandWidthConstraints = BoxConstraints.expand(width: 220.0);
  final expandHeightConstraints = BoxConstraints.expand(height: 140.0);

  print('default: $defaultConstraints');
  print('full: $fullConstraints');
  print('tight(200,100): $tightConstraints');
  print('tightFor(w:120): $tightForWidthConstraints');
  print('tightFor(h:80): $tightForHeightConstraints');
  print('tightFor(both): $tightForBothConstraints');
  print('tightForFinite(110,70): $tightForFiniteConstraints');
  print('loose(180,120): $looseConstraints');
  print('expand(): $expandAllConstraints');
  print('expand(w:220): $expandWidthConstraints');
  print('expand(h:140): $expandHeightConstraints');

  final ctorEntries = <Map<String, dynamic>>[
    {
      'title': 'BoxConstraints()',
      'subtitle': 'Default — unbounded',
      'minW': defaultConstraints.minWidth,
      'maxW': defaultConstraints.maxWidth,
      'minH': defaultConstraints.minHeight,
      'maxH': defaultConstraints.maxHeight,
      'icon': Icons.crop_free,
      'color': Colors.blueGrey,
    },
    {
      'title': 'BoxConstraints(min/max...)',
      'subtitle': '50..200 x 30..150',
      'minW': fullConstraints.minWidth,
      'maxW': fullConstraints.maxWidth,
      'minH': fullConstraints.minHeight,
      'maxH': fullConstraints.maxHeight,
      'icon': Icons.aspect_ratio,
      'color': Colors.blue,
    },
    {
      'title': 'BoxConstraints.tight(Size)',
      'subtitle': 'tight(200, 100)',
      'minW': tightConstraints.minWidth,
      'maxW': tightConstraints.maxWidth,
      'minH': tightConstraints.minHeight,
      'maxH': tightConstraints.maxHeight,
      'icon': Icons.lock,
      'color': Colors.indigo,
    },
    {
      'title': 'BoxConstraints.tightFor(w)',
      'subtitle': 'tightFor(width: 120)',
      'minW': tightForWidthConstraints.minWidth,
      'maxW': tightForWidthConstraints.maxWidth,
      'minH': tightForWidthConstraints.minHeight,
      'maxH': tightForWidthConstraints.maxHeight,
      'icon': Icons.swap_horiz,
      'color': Colors.deepPurple,
    },
    {
      'title': 'BoxConstraints.tightFor(h)',
      'subtitle': 'tightFor(height: 80)',
      'minW': tightForHeightConstraints.minWidth,
      'maxW': tightForHeightConstraints.maxWidth,
      'minH': tightForHeightConstraints.minHeight,
      'maxH': tightForHeightConstraints.maxHeight,
      'icon': Icons.swap_vert,
      'color': Colors.purple,
    },
    {
      'title': 'BoxConstraints.tightFor(w,h)',
      'subtitle': 'tightFor(140, 90)',
      'minW': tightForBothConstraints.minWidth,
      'maxW': tightForBothConstraints.maxWidth,
      'minH': tightForBothConstraints.minHeight,
      'maxH': tightForBothConstraints.maxHeight,
      'icon': Icons.fullscreen_exit,
      'color': Colors.pink,
    },
    {
      'title': 'BoxConstraints.tightForFinite',
      'subtitle': 'tightForFinite(110, 70)',
      'minW': tightForFiniteConstraints.minWidth,
      'maxW': tightForFiniteConstraints.maxWidth,
      'minH': tightForFiniteConstraints.minHeight,
      'maxH': tightForFiniteConstraints.maxHeight,
      'icon': Icons.crop_din,
      'color': Colors.red,
    },
    {
      'title': 'BoxConstraints.loose(Size)',
      'subtitle': 'loose(180, 120)',
      'minW': looseConstraints.minWidth,
      'maxW': looseConstraints.maxWidth,
      'minH': looseConstraints.minHeight,
      'maxH': looseConstraints.maxHeight,
      'icon': Icons.lock_open,
      'color': Colors.orange,
    },
    {
      'title': 'BoxConstraints.expand()',
      'subtitle': 'expand() — infinite x infinite',
      'minW': expandAllConstraints.minWidth,
      'maxW': expandAllConstraints.maxWidth,
      'minH': expandAllConstraints.minHeight,
      'maxH': expandAllConstraints.maxHeight,
      'icon': Icons.zoom_out_map,
      'color': Colors.teal,
    },
    {
      'title': 'BoxConstraints.expand(w)',
      'subtitle': 'expand(width: 220)',
      'minW': expandWidthConstraints.minWidth,
      'maxW': expandWidthConstraints.maxWidth,
      'minH': expandWidthConstraints.minHeight,
      'maxH': expandWidthConstraints.maxHeight,
      'icon': Icons.unfold_more,
      'color': Colors.green,
    },
    {
      'title': 'BoxConstraints.expand(h)',
      'subtitle': 'expand(height: 140)',
      'minW': expandHeightConstraints.minWidth,
      'maxW': expandHeightConstraints.maxWidth,
      'minH': expandHeightConstraints.minHeight,
      'maxH': expandHeightConstraints.maxHeight,
      'icon': Icons.unfold_less,
      'color': Colors.lightGreen,
    },
  ];

  final ctorCards = <Widget>[];
  for (final entry in ctorEntries) {
    final color = entry['color'] as Color;
    ctorCards.add(
      Container(
        width: 220.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.08), color.withValues(alpha: 0.20)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.55), width: 1.6),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(entry['icon'] as IconData, color: color, size: 20.0),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    entry['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color.withValues(alpha: 0.95),
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              entry['subtitle'] as String,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8.0),
            _buildMiniValueRow('minW', _fmt(entry['minW'] as double), color),
            _buildMiniValueRow('maxW', _fmt(entry['maxW'] as double), color),
            _buildMiniValueRow('minH', _fmt(entry['minH'] as double), color),
            _buildMiniValueRow('maxH', _fmt(entry['maxH'] as double), color),
          ],
        ),
      ),
    );
  }
  print('Created ${ctorCards.length} constructor cards');

  // ============================================================
  // SECTION 2: Boolean Property Inspector
  // ============================================================
  print('=== Section 2: Boolean Property Inspector ===');

  final propSamples = <Map<String, dynamic>>[
    {
      'name': 'tight(200x100)',
      'c': tightConstraints,
      'color': Colors.indigo,
    },
    {
      'name': 'loose(180x120)',
      'c': looseConstraints,
      'color': Colors.orange,
    },
    {
      'name': 'expand()',
      'c': expandAllConstraints,
      'color': Colors.teal,
    },
    {
      'name': 'default()',
      'c': defaultConstraints,
      'color': Colors.blueGrey,
    },
    {
      'name': 'full(50..200, 30..150)',
      'c': fullConstraints,
      'color': Colors.blue,
    },
  ];

  for (final s in propSamples) {
    final c = s['c'] as BoxConstraints;
    print(
      '${s['name']}: tight=${c.isTight} norm=${c.isNormalized} '
      'boundedW=${c.hasBoundedWidth} boundedH=${c.hasBoundedHeight} '
      'infW=${c.hasInfiniteWidth} infH=${c.hasInfiniteHeight} '
      'tightW=${c.hasTightWidth} tightH=${c.hasTightHeight} '
      'biggest=${c.biggest} smallest=${c.smallest}',
    );
  }

  final propertyTable = <Widget>[];
  propertyTable.add(_buildPropTableHeader());
  for (final s in propSamples) {
    final c = s['c'] as BoxConstraints;
    propertyTable.add(
      _buildPropTableRow(
        s['name'] as String,
        s['color'] as Color,
        <bool>[
          c.isTight,
          c.isNormalized,
          c.hasBoundedWidth,
          c.hasBoundedHeight,
          c.hasInfiniteWidth,
          c.hasInfiniteHeight,
          c.hasTightWidth,
          c.hasTightHeight,
        ],
      ),
    );
  }
  print('Created property inspector table with ${propertyTable.length} rows');

  // ============================================================
  // SECTION 3: constrain / constrainWidth / constrainHeight / aspect
  // ============================================================
  print('=== Section 3: Constrain Operations ===');

  final constrainBase = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 150.0,
    minHeight: 30.0,
    maxHeight: 100.0,
  );

  final constrainCases = <Map<String, dynamic>>[
    {
      'input': const Size(10.0, 10.0),
      'tag': 'too small',
      'color': Colors.red,
      'icon': Icons.arrow_upward,
    },
    {
      'input': const Size(100.0, 60.0),
      'tag': 'in range',
      'color': Colors.green,
      'icon': Icons.check_circle,
    },
    {
      'input': const Size(300.0, 200.0),
      'tag': 'too large',
      'color': Colors.deepOrange,
      'icon': Icons.arrow_downward,
    },
    {
      'input': const Size(80.0, 200.0),
      'tag': 'mixed',
      'color': Colors.purple,
      'icon': Icons.swap_calls,
    },
  ];

  final constrainWidgets = <Widget>[];
  for (final caseEntry in constrainCases) {
    final input = caseEntry['input'] as Size;
    final color = caseEntry['color'] as Color;
    final result = constrainBase.constrain(input);
    final widthClamped = constrainBase.constrainWidth(input.width);
    final heightClamped = constrainBase.constrainHeight(input.height);
    final aspect = constrainBase.constrainSizeAndAttemptToPreserveAspectRatio(
      input,
    );

    print(
      'constrain(${input.width}x${input.height}) -> ${result.width}x${result.height} '
      '(W=$widthClamped, H=$heightClamped, aspect=${aspect.width}x${aspect.height})',
    );

    constrainWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(caseEntry['icon'] as IconData, color: color, size: 20.0),
                const SizedBox(width: 8.0),
                Text(
                  'Input ${input.width.toInt()} x ${input.height.toInt()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color.withValues(alpha: 0.95),
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    caseEntry['tag'] as String,
                    style: TextStyle(fontSize: 10.0, color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: _buildKVChip(
                    'constrain',
                    '${result.width.toInt()} x ${result.height.toInt()}',
                    color,
                  ),
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: _buildKVChip(
                    'constrainWidth',
                    widthClamped.toInt().toString(),
                    color,
                  ),
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: _buildKVChip(
                    'constrainHeight',
                    heightClamped.toInt().toString(),
                    color,
                  ),
                ),
                const SizedBox(width: 6.0),
                Expanded(
                  child: _buildKVChip(
                    'aspect',
                    '${aspect.width.toStringAsFixed(1)} x ${aspect.height.toStringAsFixed(1)}',
                    color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                _buildConstrainBox(
                  input,
                  Colors.grey.shade400,
                  'in',
                  Colors.black,
                ),
                const SizedBox(width: 8.0),
                Icon(Icons.arrow_forward, color: color, size: 24.0),
                const SizedBox(width: 8.0),
                _buildConstrainBox(result, color, 'out', Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${constrainWidgets.length} constrain widgets');

  // ============================================================
  // SECTION 4: enforce / tighten / loosen / deflate / widen / normalize / flipped
  // ============================================================
  print('=== Section 4: Transform Operations ===');

  final transformBase = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 100.0,
    minHeight: 30.0,
    maxHeight: 80.0,
  );
  final enforceCap = BoxConstraints(
    minWidth: 0.0,
    maxWidth: 80.0,
    minHeight: 0.0,
    maxHeight: 60.0,
  );

  final enforced = transformBase.enforce(enforceCap);
  final tightened = looseConstraints.tighten(width: 100.0, height: 80.0);
  final loosened = tightConstraints.loosen();
  final deflated = fullConstraints.deflate(const EdgeInsets.all(10.0));
  final widened = transformBase.copyWith(minWidth: 80.0, maxWidth: 140.0);
  final heightened = transformBase.heightenSafe(120.0);
  final normalized = BoxConstraints(minWidth: 120.0, maxWidth: 50.0).normalize();
  final flipped = transformBase.flipped;

  print('enforce: $enforced');
  print('tighten: $tightened');
  print('loosen: $loosened');
  print('deflate(10): $deflated');
  print('copyWith(minW:80, maxW:140): $widened');
  print('heightenSafe(120): $heightened');
  print('normalize: $normalized');
  print('flipped: $flipped');

  final transforms = <Map<String, dynamic>>[
    {
      'op': 'enforce(0..80, 0..60)',
      'before': transformBase,
      'after': enforced,
      'icon': Icons.gavel,
      'color': Colors.indigo,
    },
    {
      'op': 'tighten(w:100, h:80)',
      'before': looseConstraints,
      'after': tightened,
      'icon': Icons.compress,
      'color': Colors.deepPurple,
    },
    {
      'op': 'loosen()',
      'before': tightConstraints,
      'after': loosened,
      'icon': Icons.expand,
      'color': Colors.orange,
    },
    {
      'op': 'deflate(EdgeInsets.all(10))',
      'before': fullConstraints,
      'after': deflated,
      'icon': Icons.padding,
      'color': Colors.teal,
    },
    {
      'op': 'copyWith(minW:80, maxW:140)',
      'before': transformBase,
      'after': widened,
      'icon': Icons.swap_horiz,
      'color': Colors.blue,
    },
    {
      'op': 'normalize(min>max)',
      'before': BoxConstraints(minWidth: 120.0, maxWidth: 50.0),
      'after': normalized,
      'icon': Icons.sort_by_alpha,
      'color': Colors.green,
    },
    {
      'op': 'flipped',
      'before': transformBase,
      'after': flipped,
      'icon': Icons.flip,
      'color': Colors.pink,
    },
  ];

  final transformWidgets = <Widget>[];
  for (final t in transforms) {
    final color = t['color'] as Color;
    final before = t['before'] as BoxConstraints;
    final after = t['after'] as BoxConstraints;
    transformWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.05), color.withValues(alpha: 0.12)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(t['icon'] as IconData, color: color, size: 22.0),
                const SizedBox(width: 8.0),
                Text(
                  t['op'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildConstraintsCard('before', before, Colors.grey),
                ),
                Icon(Icons.arrow_forward, color: color),
                Expanded(
                  child: _buildConstraintsCard('after', after, color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${transformWidgets.length} transform widgets');

  // ============================================================
  // SECTION 5: ConstrainedBox / UnconstrainedBox / SizedBox visuals
  // ============================================================
  print('=== Section 5: Visual Constraint Examples ===');

  final visualSamples = <Widget>[
    Container(
      width: 220.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          Text(
            'ConstrainedBox(tight 100x80)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 8.0),
          ConstrainedBox(
            constraints: BoxConstraints.tight(const Size(100.0, 80.0)),
            child: Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                '100 x 80',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      width: 220.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        children: [
          Text(
            'ConstrainedBox(loose 150x100)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 8.0),
          ConstrainedBox(
            constraints: BoxConstraints.loose(const Size(150.0, 100.0)),
            child: Container(
              width: 60.0,
              height: 40.0,
              color: Colors.orange,
              alignment: Alignment.center,
              child: const Text(
                '60 x 40',
                style: TextStyle(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      width: 220.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          Text(
            'Min/Max box (80..160, 40..80)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 8.0),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 80.0,
              maxWidth: 160.0,
              minHeight: 40.0,
              maxHeight: 80.0,
            ),
            child: Container(
              color: Colors.green,
              alignment: Alignment.center,
              child: const Text(
                '80..160 x 40..80',
                style: TextStyle(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      width: 220.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        children: [
          Text(
            'tightFor(width: 140)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 8.0),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 140.0),
            child: Container(
              height: 60.0,
              color: Colors.purple,
              alignment: Alignment.center,
              child: const Text(
                'w fixed=140',
                style: TextStyle(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      width: 220.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        children: [
          Text(
            'SizedBox(120, 60)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: 120.0,
            height: 60.0,
            child: Container(
              color: Colors.teal,
              alignment: Alignment.center,
              child: const Text(
                'SizedBox',
                style: TextStyle(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      width: 220.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          Text(
            'UnconstrainedBox(child 90x50)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: 180.0,
            height: 60.0,
            child: UnconstrainedBox(
              child: Container(
                width: 90.0,
                height: 50.0,
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text(
                  'free',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ];
  print('Created ${visualSamples.length} visual constraint examples');

  // ============================================================
  // SECTION 6: Lerp Progression
  // ============================================================
  print('=== Section 6: Lerp Progression ===');

  final lerpStart = const BoxConstraints(
    minWidth: 0.0,
    maxWidth: 100.0,
    minHeight: 0.0,
    maxHeight: 100.0,
  );
  final lerpEnd = const BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 50.0,
    maxHeight: 200.0,
  );

  final lerpSteps = <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
  final lerpWidgets = <Widget>[];
  for (final t in lerpSteps) {
    final l = BoxConstraints.lerp(lerpStart, lerpEnd, t)!;
    print('lerp(t=$t): minW=${l.minWidth}, maxW=${l.maxWidth}, '
        'minH=${l.minHeight}, maxH=${l.maxHeight}');
    final barWidth = (l.maxWidth - l.minWidth) / 200.0 * 160.0;
    final color = Color.lerp(Colors.blue, Colors.pink, t)!;

    lerpWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 50.0,
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              alignment: Alignment.center,
              child: Text(
                't=${t.toStringAsFixed(1)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
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
                    'W ${l.minWidth.toInt()}..${l.maxWidth.toInt()}  '
                    'H ${l.minHeight.toInt()}..${l.maxHeight.toInt()}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 10.0,
                    width: barWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.5),
                          color,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${lerpWidgets.length} lerp widgets');

  // ============================================================
  // SECTION 7: Code panels
  // ============================================================
  print('=== Section 7: Code Panels ===');

  final tightConstrainWidthResult = BoxConstraints.tight(
    const Size(200.0, 100.0),
  ).constrainWidth(50.0);
  final tightConstrainHeightResult = BoxConstraints.tight(
    const Size(200.0, 100.0),
  ).constrainHeight(50.0);
  final looseConstrainResult = BoxConstraints.loose(
    const Size(200.0, 100.0),
  ).constrain(const Size(300.0, 80.0));
  final equalityCheck = const BoxConstraints(minWidth: 50.0, maxWidth: 100.0) ==
      const BoxConstraints(minWidth: 50.0, maxWidth: 100.0);
  final hashCheck = const BoxConstraints(minWidth: 50.0, maxWidth: 100.0)
          .hashCode ==
      const BoxConstraints(minWidth: 50.0, maxWidth: 100.0).hashCode;

  print('tight(200,100).constrainWidth(50)=$tightConstrainWidthResult');
  print('tight(200,100).constrainHeight(50)=$tightConstrainHeightResult');
  print('loose(200,100).constrain(300,80)=$looseConstrainResult');
  print('equality=$equalityCheck hash=$hashCheck');

  final codePanel = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              'BoxConstraints in Code',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _buildCodeChunk(
          'Constructors',
          '// Tight to a Size\n'
              'final c1 = BoxConstraints.tight(Size(200, 100));\n'
              '\n'
              '// Tight for a width only\n'
              'final c2 = BoxConstraints.tightFor(width: 120);\n'
              '\n'
              '// Loose — child can be 0..200 x 0..100\n'
              'final c3 = BoxConstraints.loose(Size(200, 100));\n'
              '\n'
              '// Expand to fill\n'
              'final c4 = BoxConstraints.expand(width: 220);',
          Colors.greenAccent.shade100,
        ),
        const SizedBox(height: 10.0),
        _buildCodeChunk(
          'Computed values',
          'tight(200,100).constrainWidth(50)  -> '
              '${tightConstrainWidthResult.toInt()}\n'
              'tight(200,100).constrainHeight(50) -> '
              '${tightConstrainHeightResult.toInt()}\n'
              'loose(200,100).constrain(300,80)   -> '
              '${looseConstrainResult.width.toInt()} x '
              '${looseConstrainResult.height.toInt()}',
          Colors.amberAccent.shade100,
        ),
        const SizedBox(height: 10.0),
        _buildCodeChunk(
          'Transforms',
          'BoxConstraints(50..200, 30..150)\n'
              '  .deflate(EdgeInsets.all(10)) ->\n'
              '  minW=${deflated.minWidth.toInt()}, maxW=${deflated.maxWidth.toInt()}\n'
              '  minH=${deflated.minHeight.toInt()}, maxH=${deflated.maxHeight.toInt()}\n'
              '\n'
              'tight(200,100).loosen() ->\n'
              '  ${loosened.minWidth.toInt()}..${loosened.maxWidth.toInt()} x '
              '${loosened.minHeight.toInt()}..${loosened.maxHeight.toInt()}\n'
              '\n'
              'BoxConstraints(120>50).normalize() ->\n'
              '  minW=${normalized.minWidth.toInt()}, '
              'maxW=${normalized.maxWidth.toInt()}',
          Colors.lightBlueAccent.shade100,
        ),
        const SizedBox(height: 10.0),
        _buildCodeChunk(
          'Equality / Hash',
          'BoxConstraints(50..100) == BoxConstraints(50..100)  -> '
              '$equalityCheck\n'
              'BoxConstraints(50..100).hashCode == ...                -> '
              '$hashCheck',
          Colors.pinkAccent.shade100,
        ),
      ],
    ),
  );
  print('Created code panel');

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        const SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.lock,
          'tight() vs loose()',
          'tight forces a single size; loose lets the child be smaller.',
          Colors.indigo,
        ),
        const SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.zoom_out_map,
          'expand()',
          'Forces infinite bounds unless width/height is supplied.',
          Colors.teal,
        ),
        const SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.gavel,
          'enforce()',
          'Clamps the constraints into another set of bounds.',
          Colors.deepPurple,
        ),
        const SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.compress,
          'tighten() / loosen()',
          'tighten narrows ranges; loosen drops minimums to zero.',
          Colors.orange,
        ),
        const SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.padding,
          'deflate()',
          'Shrinks constraints by an EdgeInsets — useful for padding.',
          Colors.green,
        ),
        const SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.sort_by_alpha,
          'normalize() / flipped',
          'Fixes min>max ordering; swaps width and height axes.',
          Colors.pink,
        ),
        const SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.linear_scale,
          'lerp()',
          'Smooth interpolation between two BoxConstraints values.',
          Colors.blue,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('BoxConstraints Deep Demo completed successfully');

  // ============================================================
  // Return final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF00838F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.4),
                    blurRadius: 12.0,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: const [
                  Icon(
                    Icons.aspect_ratio,
                    size: 56.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'BoxConstraints',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Constructors, getters, methods & lerp — deep visual demo',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // 1. Constructor gallery
            const _SectionHeader('1. Constructor Gallery'),
            const SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: ctorCards),
            const SizedBox(height: 32.0),

            // 2. Boolean property inspector
            const _SectionHeader('2. Boolean Property Inspector'),
            const SizedBox(height: 12.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(children: propertyTable),
            ),
            const SizedBox(height: 32.0),

            // 3. Constrain operations
            const _SectionHeader('3. constrain / constrainWidth / Height / aspect'),
            const SizedBox(height: 12.0),
            ...constrainWidgets,
            const SizedBox(height: 32.0),

            // 4. Transform operations
            const _SectionHeader('4. enforce / tighten / loosen / deflate / widen / normalize / flipped'),
            const SizedBox(height: 12.0),
            ...transformWidgets,
            const SizedBox(height: 32.0),

            // 5. Visual constraint examples
            const _SectionHeader('5. ConstrainedBox / UnconstrainedBox / SizedBox'),
            const SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: visualSamples),
            const SizedBox(height: 32.0),

            // 6. Lerp progression
            const _SectionHeader('6. Lerp Progression'),
            const SizedBox(height: 12.0),
            ...lerpWidgets,
            const SizedBox(height: 32.0),

            // 7. Code panels
            const _SectionHeader('7. Code Panels'),
            codePanel,
            const SizedBox(height: 32.0),

            // 8. Summary
            const _SectionHeader('8. Summary'),
            summaryPanel,
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    ),
  );
}

String _fmt(double v) {
  if (v.isInfinite) {
    return v.isNegative ? '-∞' : '∞';
  }
  if (v == v.roundToDouble()) {
    return v.toInt().toString();
  }
  return v.toStringAsFixed(2);
}

Widget _buildMiniValueRow(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      children: [
        SizedBox(
          width: 44.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: color.withValues(alpha: 0.25)),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropTableHeader() {
  final headers = [
    'Constraints',
    'isTight',
    'isNorm',
    'bndW',
    'bndH',
    'infW',
    'infH',
    'tW',
    'tH',
  ];
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: headers
          .map<Widget>(
            (h) => Expanded(
              flex: h == 'Constraints' ? 3 : 1,
              child: Text(
                h,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}

Widget _buildPropTableRow(String name, Color color, List<bool> values) {
  Widget boolCell(bool v) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: v
              ? Colors.green.withValues(alpha: 0.15)
              : Colors.red.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Icon(
          v ? Icons.check : Icons.close,
          size: 14.0,
          color: v ? Colors.green.shade700 : Colors.red.shade400,
        ),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Container(
                width: 6.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: color.withValues(alpha: 0.95),
                  ),
                ),
              ),
            ],
          ),
        ),
        for (final v in values) boolCell(v),
      ],
    ),
  );
}

Widget _buildKVChip(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.35)),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9.0,
            color: color.withValues(alpha: 0.85),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildConstrainBox(Size s, Color color, String label, Color textColor) {
  // Visual scaled box capped at 80x60 to fit row.
  final w = s.width.clamp(20.0, 160.0).toDouble();
  final h = s.height.clamp(14.0, 80.0).toDouble();
  return Container(
    width: w,
    height: h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.95), width: 1.0),
    ),
    child: Text(
      '$label\n${s.width.toInt()}x${s.height.toInt()}',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10.0, color: textColor),
    ),
  );
}

Widget _buildConstraintsCard(String title, BoxConstraints c, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 6.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'W ${_fmt(c.minWidth)}..${_fmt(c.maxWidth)}',
          style: const TextStyle(fontFamily: 'monospace', fontSize: 11.0),
        ),
        Text(
          'H ${_fmt(c.minHeight)}..${_fmt(c.maxHeight)}',
          style: const TextStyle(fontFamily: 'monospace', fontSize: 11.0),
        ),
      ],
    ),
  );
}

Widget _buildCodeChunk(String title, String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// $title',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: textColor,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(color: Colors.indigo.shade400, width: 4.0),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.indigo.shade900,
        ),
      ),
    );
  }
}

extension _BoxConstraintsHeightenSafe on BoxConstraints {
  // Convenience used in the demo — keeps the API surface broader without
  // touching framework BoxConstraints. Mirrors `widen` but for the height axis
  // by enforcing a tight height while preserving width range.
  BoxConstraints heightenSafe(double height) {
    return BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: height,
      maxHeight: height,
    );
  }
}

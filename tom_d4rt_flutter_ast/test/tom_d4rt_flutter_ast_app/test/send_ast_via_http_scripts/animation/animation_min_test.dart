// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: Animation.min operator showcase.
//
// Theme: "Algebraic Slate" — a cool slate-and-cobalt palette layered over
// carmine accents to dramatize the algebra of Animation.min(other).
//
// Animation.min(other) is the operator on the Animation<double> family
// that yields a new Animation<double> whose value at any moment is the
// pointwise minimum of the receiver and the argument animation. In this
// hand-authored snapshot demo we only use AlwaysStoppedAnimation<double>
// instances — they never tick, never spawn a controller, but they expose
// the same .min(...) algebra and let us paint the math without engaging
// any timer infrastructure. Every visual is built from Container strips,
// Rows, Columns, and Text — no painters, no tickers, no futures.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationMin deep visual demo executing');

  // ============================================================
  // Palette: "Algebraic Slate"
  // ============================================================
  // The hero hue is a cool cobalt-slate; carmine ribbons highlight
  // the "min" winners and lemon-glass plates accent equality cases.
  final Color slateInk = Color(0xFF12182A);
  final Color slatePanel = Color(0xFF1B2440);
  final Color slatePanelAlt = Color(0xFF243056);
  final Color cobaltLine = Color(0xFF3F6BD9);
  final Color cobaltGlow = Color(0xFF6E96F2);
  final Color carmineMin = Color(0xFFD43A5C);
  final Color carmineMinSoft = Color(0xFFE56C84);
  final Color lemonEqual = Color(0xFFE8C547);
  final Color frostText = Color(0xFFEAF1FF);
  final Color frostMuted = Color(0xFFA8B5D6);
  final Color edgeOutline = Color(0xFF34406B);
  final Color edgeOutlineWarm = Color(0xFF7A3245);
  final Color paperBackdrop = Color(0xFF0A0F1E);
  final Color codeBackdrop = Color(0xFF0E1426);
  final Color graphAxis = Color(0xFF566799);

  print('Palette assembled: 12 hues for Algebraic Slate.');

  // ============================================================
  // Snapshot animation pairs.
  // We never call AnimationController, never await Futures, we just
  // pin two AlwaysStoppedAnimation<double> values and ask them their
  // pointwise minimum through AnimationMin<double>.
  // ============================================================
  final List<List<double>> pairs = <List<double>>[
    <double>[0.20, 0.80],
    <double>[0.50, 0.50],
    <double>[0.00, 1.00],
    <double>[0.30, 0.70],
    <double>[0.10, 0.90],
    <double>[0.65, 0.35],
    <double>[0.45, 0.55],
    <double>[0.85, 0.15],
    <double>[0.05, 0.05],
    <double>[0.95, 0.95],
    <double>[0.25, 0.25],
    <double>[0.75, 0.25],
  ];

  // Compute the "min" via AnimationMin so we exercise the operator,
  // not just dart's math. Wrap in try/catch in case the bridge ever
  // throws on weird value pairs.
  final List<double> minResults = <double>[];
  for (int i = 0; i < pairs.length; i++) {
    final double a = pairs[i][0];
    final double b = pairs[i][1];
    double result;
    try {
      final AlwaysStoppedAnimation<double> first =
          AlwaysStoppedAnimation<double>(a);
      final AlwaysStoppedAnimation<double> second =
          AlwaysStoppedAnimation<double>(b);
      final AnimationMin<double> m = AnimationMin<double>(first, second);
      result = m.value;
    } catch (e) {
      print('AnimationMin failed on pair ($a, $b): $e');
      result = a < b ? a : b;
    }
    minResults.add(result);
    print('  min($a, $b) = $result');
  }

  // Edge probe: negative inputs and the zero/one boundary.
  final List<List<double>> edgeProbes = <List<double>>[
    <double>[-0.50, 0.50],
    <double>[-0.10, -0.90],
    <double>[0.00, -0.00],
    <double>[1.00, 1.00],
    <double>[0.99, 1.01],
  ];
  final List<double> edgeMin = <double>[];
  for (int i = 0; i < edgeProbes.length; i++) {
    final double a = edgeProbes[i][0];
    final double b = edgeProbes[i][1];
    try {
      final AnimationMin<double> m = AnimationMin<double>(
        AlwaysStoppedAnimation<double>(a),
        AlwaysStoppedAnimation<double>(b),
      );
      edgeMin.add(m.value);
    } catch (e) {
      print('Edge probe error: $e');
      edgeMin.add(a < b ? a : b);
    }
  }

  // The hero curve is the pointwise min of two pre-baked sequences:
  //   curveA(i) starts low and ramps;
  //   curveB(i) starts high and dips.
  // The hero graph highlights where each branch wins.
  final List<double> curveA = <double>[
    0.05, 0.10, 0.20, 0.32, 0.45, 0.55, 0.62, 0.70, 0.78, 0.84,
    0.88, 0.91, 0.93, 0.95, 0.96, 0.97, 0.98, 0.98, 0.99, 0.99,
  ];
  final List<double> curveB = <double>[
    0.95, 0.92, 0.88, 0.82, 0.74, 0.65, 0.55, 0.45, 0.36, 0.28,
    0.22, 0.18, 0.15, 0.13, 0.12, 0.11, 0.10, 0.10, 0.10, 0.10,
  ];
  final List<double> curveMin = <double>[];
  final List<int> curveWinner = <int>[]; // 0 = A wins, 1 = B wins, 2 = tie
  for (int i = 0; i < curveA.length; i++) {
    try {
      final AnimationMin<double> m = AnimationMin<double>(
        AlwaysStoppedAnimation<double>(curveA[i]),
        AlwaysStoppedAnimation<double>(curveB[i]),
      );
      curveMin.add(m.value);
    } catch (e) {
      curveMin.add(curveA[i] < curveB[i] ? curveA[i] : curveB[i]);
    }
    if ((curveA[i] - curveB[i]).abs() < 0.0005) {
      curveWinner.add(2);
    } else if (curveA[i] < curveB[i]) {
      curveWinner.add(0);
    } else {
      curveWinner.add(1);
    }
  }

  // ============================================================
  // Hero card: "min(curveA, curveB)" graph drawn from Container strips.
  // ============================================================
  final double graphHeight = 160.0;
  final double stripWidth = 14.0;
  final double stripGap = 4.0;
  final List<Widget> heroStrips = <Widget>[];
  for (int i = 0; i < curveA.length; i++) {
    final double a = curveA[i];
    final double b = curveB[i];
    final double m = curveMin[i];
    final int winner = curveWinner[i];
    final Color winnerHue = winner == 0
        ? cobaltLine
        : (winner == 1 ? carmineMin : lemonEqual);
    heroStrips.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: stripGap / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Ghost of the losing curve
            Container(
              width: stripWidth,
              height: graphHeight * (a > b ? a : b),
              color: winnerHue.withValues(alpha: 0.18),
            ),
            // Solid min winner
            Container(
              width: stripWidth,
              height: graphHeight * m,
              color: winnerHue,
            ),
            SizedBox(height: 4.0),
            Text(
              i.toString(),
              style: TextStyle(
                color: frostMuted,
                fontSize: 9.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget heroGraph = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Hero curve: pointwise min of two snapshot animations',
          style: TextStyle(
            color: frostText,
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Cobalt strip = curve A wins. Carmine strip = curve B wins. '
          'Lemon strip = the two curves tie within 0.0005.',
          style: TextStyle(color: frostMuted, fontSize: 12.0),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: heroStrips,
        ),
        SizedBox(height: 12.0),
        Container(height: 1.0, color: graphAxis),
        SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              color: cobaltLine,
            ),
            SizedBox(width: 6.0),
            Text(
              'A',
              style: TextStyle(color: frostText, fontSize: 12.0),
            ),
            SizedBox(width: 18.0),
            Container(
              width: 10.0,
              height: 10.0,
              color: carmineMin,
            ),
            SizedBox(width: 6.0),
            Text(
              'B',
              style: TextStyle(color: frostText, fontSize: 12.0),
            ),
            SizedBox(width: 18.0),
            Container(
              width: 10.0,
              height: 10.0,
              color: lemonEqual,
            ),
            SizedBox(width: 6.0),
            Text(
              'Tie',
              style: TextStyle(color: frostText, fontSize: 12.0),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // Palette table (12 swatches with name + hex + role).
  // ============================================================
  final List<List<String>> paletteRows = <List<String>>[
    <String>['Slate Ink',        '#12182A', 'page void'],
    <String>['Slate Panel',      '#1B2440', 'card body'],
    <String>['Slate Panel Alt',  '#243056', 'alt row'],
    <String>['Cobalt Line',      '#3F6BD9', 'curve A'],
    <String>['Cobalt Glow',      '#6E96F2', 'highlights'],
    <String>['Carmine Min',      '#D43A5C', 'curve B / min winner'],
    <String>['Carmine Min Soft', '#E56C84', 'min ghost'],
    <String>['Lemon Equal',      '#E8C547', 'tie marker'],
    <String>['Frost Text',       '#EAF1FF', 'primary type'],
    <String>['Frost Muted',      '#A8B5D6', 'secondary type'],
    <String>['Edge Outline',     '#34406B', 'card border'],
    <String>['Edge Outline Warm','#7A3245', 'pitfall border'],
  ];
  final List<Color> paletteHues = <Color>[
    slateInk,
    slatePanel,
    slatePanelAlt,
    cobaltLine,
    cobaltGlow,
    carmineMin,
    carmineMinSoft,
    lemonEqual,
    frostText,
    frostMuted,
    edgeOutline,
    edgeOutlineWarm,
  ];
  final List<Widget> paletteTableRows = <Widget>[];
  paletteTableRows.add(
    Row(
      children: <Widget>[
        SizedBox(width: 36.0),
        SizedBox(
          width: 150.0,
          child: Text(
            'Name',
            style: TextStyle(color: frostText, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Text(
            'Hex',
            style: TextStyle(color: frostText, fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(
          child: Text(
            'Role',
            style: TextStyle(color: frostText, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
  paletteTableRows.add(SizedBox(height: 6.0));
  for (int i = 0; i < paletteRows.length; i++) {
    paletteTableRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        padding: EdgeInsets.all(6.0),
        color: i.isEven
            ? slatePanel.withValues(alpha: 0.6)
            : slatePanelAlt.withValues(alpha: 0.6),
        child: Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 18.0,
              color: paletteHues[i],
            ),
            SizedBox(width: 8.0),
            SizedBox(
              width: 150.0,
              child: Text(
                paletteRows[i][0],
                style: TextStyle(color: frostText, fontSize: 12.0),
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                paletteRows[i][1],
                style: TextStyle(
                  color: frostMuted,
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                paletteRows[i][2],
                style: TextStyle(color: frostMuted, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget paletteCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Palette: Algebraic Slate',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: paletteTableRows,
        ),
      ],
    ),
  );

  // ============================================================
  // API surface table.
  // Members of the Animation algebra family that interact with .min.
  // ============================================================
  final List<List<String>> apiRows = <List<String>>[
    <String>[
      'Animation.min(other)',
      'Animation<T>',
      'Pointwise minimum of two animations.',
    ],
    <String>[
      'Animation.max(other)',
      'Animation<T>',
      'Pointwise maximum of two animations.',
    ],
    <String>[
      'Animation.drive(animatable)',
      'Animation<U>',
      'Chain through an Animatable<U>.',
    ],
    <String>[
      'Animation.value',
      'T',
      'Current scalar at the snapshot moment.',
    ],
    <String>[
      'Animation.status',
      'AnimationStatus',
      'Lifecycle state (always dismissed for snapshots).',
    ],
    <String>[
      'AnimationMin<T>',
      'CompoundAnimation',
      'Concrete compound that powers .min.',
    ],
    <String>[
      'AnimationMax<T>',
      'CompoundAnimation',
      'Concrete compound that powers .max.',
    ],
    <String>[
      'AlwaysStoppedAnimation<T>',
      'Animation<T>',
      'Pinned snapshot value, no controller needed.',
    ],
    <String>[
      'CurvedAnimation',
      'Animation<double>',
      'Maps a parent through a Curve.',
    ],
    <String>[
      'Tween<T>.animate(parent)',
      'Animation<T>',
      'Wraps a parent in a tween range.',
    ],
    <String>[
      'ReverseAnimation',
      'Animation<double>',
      'Inverts a parent (1.0 - value).',
    ],
    <String>[
      'TrainHoppingAnimation',
      'Animation<double>',
      'Switches sources when they cross.',
    ],
    <String>[
      'ProxyAnimation',
      'Animation<double>',
      'Indirection layer over another animation.',
    ],
    <String>[
      'CompoundAnimation',
      'abstract',
      'Base class for min/max-style compounds.',
    ],
  ];
  final List<Widget> apiTableChildren = <Widget>[];
  apiTableChildren.add(
    Container(
      padding: EdgeInsets.all(8.0),
      color: slatePanelAlt,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 220.0,
            child: Text(
              'Member',
              style: TextStyle(
                color: frostText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 160.0,
            child: Text(
              'Returns',
              style: TextStyle(
                color: frostText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Notes',
              style: TextStyle(
                color: frostText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < apiRows.length; i++) {
    apiTableChildren.add(
      Container(
        padding: EdgeInsets.all(8.0),
        color: i.isEven
            ? slatePanel
            : slatePanelAlt.withValues(alpha: 0.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 220.0,
              child: Text(
                apiRows[i][0],
                style: TextStyle(
                  color: cobaltGlow,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 160.0,
              child: Text(
                apiRows[i][1],
                style: TextStyle(
                  color: frostText,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                apiRows[i][2],
                style: TextStyle(color: frostMuted, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget apiCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Animation algebra: API surface around .min',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Members in the Animation family that interlock with the min '
          'operator. Together they form a small, total algebra over '
          'snapshotable curves.',
          style: TextStyle(color: frostMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: apiTableChildren,
        ),
      ],
    ),
  );

  // ============================================================
  // Value-pair gallery: each pair shown as a triptych — A | B | min.
  // ============================================================
  final List<Widget> galleryTiles = <Widget>[];
  for (int i = 0; i < pairs.length; i++) {
    final double a = pairs[i][0];
    final double b = pairs[i][1];
    final double m = minResults[i];
    final bool aWins = a < b;
    final bool tied = (a - b).abs() < 0.0005;
    galleryTiles.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: i.isEven ? slatePanel : slatePanelAlt,
          border: Border.all(color: edgeOutline, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 110.0,
              child: Text(
                'min($a, $b)',
                style: TextStyle(
                  color: frostText,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            // Bar A
            Container(
              width: 100.0 * a,
              height: 14.0,
              color: aWins
                  ? cobaltLine
                  : (tied ? lemonEqual : cobaltLine.withValues(alpha: 0.35)),
            ),
            SizedBox(width: 6.0),
            SizedBox(
              width: 36.0,
              child: Text(
                a.toStringAsFixed(2),
                style: TextStyle(color: frostMuted, fontSize: 11.0),
              ),
            ),
            // Bar B
            Container(
              width: 100.0 * b,
              height: 14.0,
              color: aWins
                  ? carmineMin.withValues(alpha: 0.35)
                  : (tied ? lemonEqual : carmineMin),
            ),
            SizedBox(width: 6.0),
            SizedBox(
              width: 36.0,
              child: Text(
                b.toStringAsFixed(2),
                style: TextStyle(color: frostMuted, fontSize: 11.0),
              ),
            ),
            // min winner
            Container(
              width: 12.0,
              height: 14.0,
              color: tied
                  ? lemonEqual
                  : (aWins ? cobaltLine : carmineMin),
            ),
            SizedBox(width: 6.0),
            Text(
              '= ${m.toStringAsFixed(2)}',
              style: TextStyle(
                color: frostText,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget galleryCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel.withValues(alpha: 0.85),
      border: Border.all(color: edgeOutline, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Value-pair gallery (12 cases)',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each row sketches A as a cobalt bar, B as a carmine bar, and '
          'the resulting Animation.min as the tiny winner-tile. When A '
          'and B tie within 0.0005 the lemon hue calls it out.',
          style: TextStyle(color: frostMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: galleryTiles,
        ),
      ],
    ),
  );

  // ============================================================
  // ASCII diagram of min(a,b) over time.
  // We render a plain Text monospace block with line graphs.
  // ============================================================
  const String asciiGraph = ''
      'value                                                                     \n'
      ' 1.0 |####B##B##B                                                          \n'
      ' 0.9 |        ##B##B                                                       \n'
      ' 0.8 |             ##B                                                     \n'
      ' 0.7 |     A          ##B                                                  \n'
      ' 0.6 |        A          ##B##                                             \n'
      ' 0.5 |           A           ##B                                           \n'
      ' 0.4 |              A           ##B##B                                     \n'
      ' 0.3 |     ::::::::::A:::::::::::    B##B##                                \n'
      ' 0.2 |               * A                  B##B                             \n'
      ' 0.1 |                  *  A                  B##B##B                      \n'
      ' 0.0 +------------------------------------------------------> t            \n'
      '       0   1   2   3   4   5   6   7   8   9  10  11  12  13               \n'
      '                                                                          \n'
      'Legend: A = curve A samples, B = curve B samples, * = min(A,B)             \n'
      '         The min curve always hugs whichever line is currently lower.      \n'
      '                                                                          \n'
      '                                                                          \n'
      'Second view, single-axis:                                                  \n'
      '                                                                          \n'
      '   t:  0   1   2   3   4   5   6   7   8   9                              \n'
      '   A:  .   .   ..  .:  .#  ##  #*  ## :*  :#                              \n'
      '   B:  ##  #*  *.  *.  :.  :.  ..  ..  .   .                              \n'
      ' min:  .   .   .   .   :.  :.  ..  ..  .   .                              \n'
      '       ^^^                  ^^^^^^^^^^^^^^^^^^^                            \n'
      '        B wins              A wins (lower)                                 \n'
      '';
  final Widget asciiCard = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: codeBackdrop,
      border: Border.all(color: edgeOutline, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'ASCII line-graph: min(a, b) sweeping along time',
          style: TextStyle(
            color: frostText,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          asciiGraph,
          style: TextStyle(
            color: cobaltGlow,
            fontFamily: 'monospace',
            fontSize: 11.0,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Prose on Animation algebra.
  // ============================================================
  const String prose1 =
      'Animation<T> is more than a single ticking number — it is a node in a '
      'small algebra. The .drive(animatable) operator chains a curve into a '
      'tween, .min(other) takes the lower of two parallel runners, .max(other) '
      'takes the higher, and ReverseAnimation flips a parent. Each operator '
      'returns another Animation<T>, so they compose without limit. In a snapshot '
      'demo we never actually tick the clock, but the algebra is identical: '
      'replace any AnimationController with an AlwaysStoppedAnimation and the '
      'min, max, drive operators still resolve to consistent values.';
  const String prose2 =
      'The intuition for .min is "the slower of two animations always wins". '
      'If you have a fade that wants to reach 1.0 and a clamp that caps at 0.6, '
      'feeding both into AnimationMin yields a fade that asymptotes at 0.6. '
      'This is invaluable when one branch must dominate another on the way down: '
      'a pinned ceiling, a safety governor, an opacity cap.';
  const String prose3 =
      'Note that AnimationMin is *not* a Boolean AND. It is the pointwise '
      'numeric minimum. If A=0.9 and B=0.4, the result is 0.4, not 0.36 (their '
      'product) and not 1.0 (their disjunction). For a probabilistic AND you '
      'want multiplication. For a crossfade you want a Tween. For a hard ceiling, '
      'you want this.';
  final Widget proseCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'On Animation algebra',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          prose1,
          style: TextStyle(
            color: frostText,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          prose2,
          style: TextStyle(
            color: frostText,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          prose3,
          style: TextStyle(
            color: carmineMinSoft,
            fontSize: 13.0,
            height: 1.45,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Scenario panels.
  // ============================================================
  final List<List<String>> scenarios = <List<String>>[
    <String>[
      'Clamping a fade-in',
      'Use min(fadeAnim, AlwaysStoppedAnimation<double>(0.6)) to cap a fade '
          'at 60% — the fade still grows naturally up to 0.6 and then sits.',
      '0.6 ceiling',
    ],
    <String>[
      'Multi-stage transition',
      'Compose three sub-fades and feed each into the next via .min so that '
          'no later stage can ever appear stronger than the slowest one.',
      'serial governor',
    ],
    <String>[
      'Capped opacity governor',
      'A theme-level "max brightness" knob can be pinned in via min. The '
          'animation never fights the clamp — the clamp is just another '
          'Animation handed in to .min.',
      'theme knob',
    ],
    <String>[
      'Loading shimmer cap',
      'When a shimmer reaches its peak we never want it brighter than the '
          'background; min(shimmer, bgCap) keeps it tasteful.',
      'visual taste',
    ],
    <String>[
      'Disabled-state dim',
      'Pin a 0.4 disabled cap and feed every interactive animation through '
          'min(anim, dimCap). The dim is a property of the tree, the anims '
          'are properties of the widget, and min stitches the two.',
      'tree-wide dim',
    ],
    <String>[
      'Onboarding gating',
      'Each onboarding card has its own intro animation, but until the user '
          'taps "next" we expose only min(intro, gate). Once gate flips to 1.0 '
          'the intro plays freely.',
      'gate latch',
    ],
  ];
  final List<Widget> scenarioWidgets = <Widget>[];
  for (int i = 0; i < scenarios.length; i++) {
    scenarioWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: slatePanelAlt,
          border: Border.all(color: cobaltLine, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  color: cobaltGlow,
                ),
                SizedBox(width: 8.0),
                Text(
                  scenarios[i][0],
                  style: TextStyle(
                    color: frostText,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  color: carmineMin.withValues(alpha: 0.25),
                  child: Text(
                    scenarios[i][2],
                    style: TextStyle(
                      color: carmineMinSoft,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              scenarios[i][1],
              style: TextStyle(
                color: frostMuted,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget scenariosCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Scenarios — when to reach for Animation.min',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: scenarioWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // Pitfalls.
  // ============================================================
  final List<List<String>> pitfalls = <List<String>>[
    <String>[
      'min as Boolean AND',
      'min(0.9, 0.4) is 0.4, not 0.36. If you actually want a probability-like '
          'AND you must multiply.',
    ],
    <String>[
      'min vs CurvedAnimation',
      'min picks between two values; CurvedAnimation reshapes one value '
          'through a curve. They are not interchangeable.',
    ],
    <String>[
      'min cannot raise a floor',
      'min only ever lowers. If you want to enforce a minimum-of value as a '
          'floor, that is the .max operator, not .min.',
    ],
    <String>[
      'snapshot vs ticking',
      'AnimationMin will gladly accept two AlwaysStoppedAnimation values, '
          'but its real strength is across two ticking parents — keep the '
          'algebra in mind even when prototyping with snapshots.',
    ],
    <String>[
      'status semantics',
      'AnimationMin\'s status is the parent\'s; do not assume "completed" '
          'means the result is at 1.0. It only means a parent reported done.',
    ],
    <String>[
      'numeric noise',
      'When two parents are nearly equal, floating-point noise can flip which '
          'one wins each tick. For visual stability prefer a deliberate margin '
          'or a carefully chosen tween.',
    ],
  ];
  final List<Widget> pitfallWidgets = <Widget>[];
  for (int i = 0; i < pitfalls.length; i++) {
    pitfallWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: paperBackdrop,
          border: Border.all(color: edgeOutlineWarm, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 22.0,
                  height: 22.0,
                  color: carmineMin,
                  alignment: Alignment.center,
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: frostText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    pitfalls[i][0],
                    style: TextStyle(
                      color: carmineMinSoft,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              pitfalls[i][1],
              style: TextStyle(
                color: frostMuted,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget pitfallsCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutlineWarm, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Pitfalls',
          style: TextStyle(
            color: carmineMinSoft,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: pitfallWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // Glossary.
  // ============================================================
  final List<List<String>> glossary = <List<String>>[
    <String>[
      'Animation<T>',
      'A node carrying a value of type T plus a status, observable by '
          'listeners.',
    ],
    <String>[
      'AnimationMin<T>',
      'CompoundAnimation that returns the min of its first and next parents.',
    ],
    <String>[
      'AnimationMax<T>',
      'CompoundAnimation that returns the max of its first and next parents.',
    ],
    <String>[
      'AlwaysStoppedAnimation<T>',
      'A pinned snapshot animation; never ticks, but participates in algebra.',
    ],
    <String>[
      'AnimationController',
      'A Ticker-driven Animation<double> — not used in this demo.',
    ],
    <String>[
      'Animatable<T>',
      'A static map that turns 0..1 into a T; used by .drive.',
    ],
    <String>[
      'Tween<T>',
      'An Animatable<T> that linearly interpolates between begin and end.',
    ],
    <String>[
      'CurvedAnimation',
      'Wraps a parent and applies a Curve before exposing its value.',
    ],
    <String>[
      'CompoundAnimation',
      'Abstract base class composing two parents; AnimationMin extends it.',
    ],
    <String>[
      'pointwise',
      'Adjective: applied at each instant independently.',
    ],
    <String>[
      'governor',
      'A clamp-like animation that keeps another animation in a band.',
    ],
    <String>[
      'snapshot',
      'A frozen value; used here to stand in for a real ticking animation.',
    ],
  ];
  final List<Widget> glossaryRows = <Widget>[];
  for (int i = 0; i < glossary.length; i++) {
    glossaryRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        color: i.isEven ? slatePanelAlt : slatePanel,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: Text(
                glossary[i][0],
                style: TextStyle(
                  color: cobaltGlow,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                glossary[i][1],
                style: TextStyle(color: frostText, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget glossaryCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Glossary',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: glossaryRows,
        ),
      ],
    ),
  );

  // ============================================================
  // Palette swatches strip.
  // ============================================================
  final List<Widget> swatchTiles = <Widget>[];
  for (int i = 0; i < paletteHues.length; i++) {
    swatchTiles.add(
      Container(
        margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
        width: 64.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 64.0,
              height: 28.0,
              color: paletteHues[i],
            ),
            SizedBox(height: 3.0),
            Text(
              paletteRows[i][0],
              style: TextStyle(
                color: frostMuted,
                fontSize: 9.0,
              ),
            ),
            Text(
              paletteRows[i][1],
              style: TextStyle(
                color: frostMuted,
                fontSize: 9.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget swatchCard = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Swatches',
          style: TextStyle(
            color: frostText,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          children: swatchTiles,
        ),
      ],
    ),
  );

  // ============================================================
  // Comparison: Animation.min vs math.min vs CurvedAnimation.
  // ============================================================
  final List<List<String>> comparisonRows = <List<String>>[
    <String>[
      'Animation.min(other)',
      'Animation<T>',
      'Pointwise lower of two parents — yields a *new* Animation that ticks '
          'as both parents tick.',
    ],
    <String>[
      'math.min(a, b)',
      'num',
      'Pure scalar math. No Animation, no listeners, no status.',
    ],
    <String>[
      'CurvedAnimation(curve: ...)',
      'Animation<double>',
      'Reshapes a single parent through a non-linear curve. Has nothing to '
          'do with comparing two parents.',
    ],
    <String>[
      'Tween<T>(begin, end)',
      'Animatable<T>',
      'Maps 0..1 to a value range; combined via .animate(parent).',
    ],
    <String>[
      'Animation.drive(animatable)',
      'Animation<U>',
      'Composes a parent through an animatable to produce a new typed '
          'animation.',
    ],
    <String>[
      'AnimationMean',
      'Animation<double>',
      'Like AnimationMin, but takes the average of two parents — useful for '
          'soft blending.',
    ],
  ];
  final List<Widget> comparisonChildren = <Widget>[];
  comparisonChildren.add(
    Container(
      padding: EdgeInsets.all(8.0),
      color: slatePanelAlt,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 220.0,
            child: Text(
              'Operator',
              style: TextStyle(
                color: frostText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 160.0,
            child: Text(
              'Returns',
              style: TextStyle(
                color: frostText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'When',
              style: TextStyle(
                color: frostText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < comparisonRows.length; i++) {
    comparisonChildren.add(
      Container(
        padding: EdgeInsets.all(8.0),
        color: i.isEven
            ? slatePanel
            : slatePanelAlt.withValues(alpha: 0.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 220.0,
              child: Text(
                comparisonRows[i][0],
                style: TextStyle(
                  color: cobaltGlow,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 160.0,
              child: Text(
                comparisonRows[i][1],
                style: TextStyle(
                  color: frostText,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                comparisonRows[i][2],
                style: TextStyle(color: frostMuted, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget comparisonCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Comparison: Animation.min vs math.min vs CurvedAnimation',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'These look related but live in different layers of the framework. '
          'Knowing which to reach for is half the work.',
          style: TextStyle(color: frostMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: comparisonChildren,
        ),
      ],
    ),
  );

  // ============================================================
  // Decision flowchart.
  // ============================================================
  const String flowchart = ''
      'Q1. Do you have TWO animations that should "fight" for visibility?\n'
      '     YES -> go to Q2.\n'
      '     NO  -> reach for CurvedAnimation or Tween, not min.\n'
      '\n'
      'Q2. Should the LOWER of the two win at every tick?\n'
      '     YES -> Animation.min(other). DONE.\n'
      '     NO  -> if HIGHER wins, use Animation.max(other).\n'
      '            if AVERAGE wins, use AnimationMean.\n'
      '\n'
      'Q3. Are both inputs ticking, or are some snapshots?\n'
      '     ALL TICKING -> .min composes them as live parents.\n'
      '     SOME SNAPSHOT -> use AlwaysStoppedAnimation<T>(value) and feed in.\n'
      '\n'
      'Q4. Do you need to TYPE-MAP the result?\n'
      '     YES -> apply .drive(animatable) AFTER .min, not inside it.\n'
      '     NO  -> stop here.\n'
      '\n'
      'Q5. Are you trying to enforce a CEILING, FLOOR, or AVERAGE?\n'
      '     CEILING -> .min with a constant snapshot equal to the cap.\n'
      '     FLOOR   -> .max with a constant snapshot equal to the floor.\n'
      '     AVERAGE -> AnimationMean.\n'
      '';
  final Widget flowchartCard = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: codeBackdrop,
      border: Border.all(color: edgeOutline, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Decision flowchart: when to use Animation.min',
          style: TextStyle(
            color: frostText,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          flowchart,
          style: TextStyle(
            color: cobaltGlow,
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Code snippets.
  // ============================================================
  const String snippet1 = ''
      '// Snapshot pair — safest for d4rt scripts.\n'
      'final a = AlwaysStoppedAnimation<double>(0.30);\n'
      'final b = AlwaysStoppedAnimation<double>(0.70);\n'
      'final m = AnimationMin<double>(a, b); // m.value == 0.30\n'
      '';
  const String snippet2 = ''
      '// Capping a fade-in at 60%.\n'
      'final fade = controller.drive(\n'
      '  CurveTween(curve: Curves.easeOut),\n'
      ');\n'
      'final cap = AlwaysStoppedAnimation<double>(0.60);\n'
      'final capped = AnimationMin<double>(fade, cap);\n'
      '// `capped` rises with the fade until it bumps the 0.60 ceiling.\n'
      '';
  const String snippet3 = ''
      '// Multi-stage governor: each stage cannot outshine the slowest.\n'
      'final stage1 = controllerA.view;\n'
      'final stage2 = AnimationMin<double>(stage1, controllerB.view);\n'
      'final stage3 = AnimationMin<double>(stage2, controllerC.view);\n'
      '// stage3 is the pointwise min of all three.\n'
      '';
  const String snippet4 = ''
      '// Snapshot probe with try/catch — defensive script style.\n'
      'double safeMin(double x, double y) {\n'
      '  try {\n'
      '    final m = AnimationMin<double>(\n'
      '      AlwaysStoppedAnimation<double>(x),\n'
      '      AlwaysStoppedAnimation<double>(y),\n'
      '    );\n'
      '    return m.value;\n'
      '  } catch (e) {\n'
      '    return x < y ? x : y;\n'
      '  }\n'
      '}\n'
      '';
  const String snippet5 = ''
      '// Comparison with math.min — note the type difference.\n'
      'final scalar = math.min(0.3, 0.7); // a `num`, not animated.\n'
      'final animated = AnimationMin<double>(\n'
      '  AlwaysStoppedAnimation<double>(0.3),\n'
      '  AlwaysStoppedAnimation<double>(0.7),\n'
      ').value; // a `double`, sourced from an Animation node.\n'
      '';

  final List<List<String>> snippets = <List<String>>[
    <String>['Pair-snapshot baseline', snippet1],
    <String>['Capped fade-in', snippet2],
    <String>['Multi-stage governor', snippet3],
    <String>['Defensive snapshot probe', snippet4],
    <String>['math.min vs Animation.min', snippet5],
  ];
  final List<Widget> snippetWidgets = <Widget>[];
  for (int i = 0; i < snippets.length; i++) {
    snippetWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: codeBackdrop,
          border: Border.all(color: edgeOutline, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 6.0),
              color: slatePanelAlt,
              width: double.infinity,
              child: Text(
                snippets[i][0],
                style: TextStyle(
                  color: frostText,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                snippets[i][1],
                style: TextStyle(
                  color: cobaltGlow,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget snippetsCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Code snippets',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: snippetWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // Edge probe summary card.
  // ============================================================
  final List<Widget> edgeWidgets = <Widget>[];
  for (int i = 0; i < edgeProbes.length; i++) {
    final double a = edgeProbes[i][0];
    final double b = edgeProbes[i][1];
    edgeWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
        color: i.isEven ? slatePanel : slatePanelAlt,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: Text(
                'min(${a.toStringAsFixed(2)}, ${b.toStringAsFixed(2)})',
                style: TextStyle(
                  color: cobaltGlow,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            Text(
              '= ${edgeMin[i].toStringAsFixed(2)}',
              style: TextStyle(
                color: frostText,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget edgeCard = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: slatePanel,
      border: Border.all(color: edgeOutline, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Edge probes (negatives, equalities, near-ties)',
          style: TextStyle(
            color: frostText,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: edgeWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // Header card.
  // ============================================================
  final Widget headerCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: slatePanelAlt,
      border: Border.all(color: cobaltLine, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Animation.min — Algebraic Slate edition',
          style: TextStyle(
            color: frostText,
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A deep, hand-painted snapshot tour of the .min operator over '
          'AlwaysStoppedAnimation<double> values, drawn entirely from '
          'Container strips, Rows, and Columns. No tickers, no controllers, '
          'no futures — just algebra and pixels.',
          style: TextStyle(
            color: frostMuted,
            fontSize: 13.5,
            height: 1.45,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Container(
              width: 14.0,
              height: 14.0,
              color: cobaltGlow,
            ),
            SizedBox(width: 8.0),
            Text(
              'Cobalt = curve A',
              style: TextStyle(color: frostText, fontSize: 12.0),
            ),
            SizedBox(width: 24.0),
            Container(
              width: 14.0,
              height: 14.0,
              color: carmineMin,
            ),
            SizedBox(width: 8.0),
            Text(
              'Carmine = curve B / min winner',
              style: TextStyle(color: frostText, fontSize: 12.0),
            ),
            SizedBox(width: 24.0),
            Container(
              width: 14.0,
              height: 14.0,
              color: lemonEqual,
            ),
            SizedBox(width: 8.0),
            Text(
              'Lemon = tie',
              style: TextStyle(color: frostText, fontSize: 12.0),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // Footer summary card.
  // ============================================================
  final Widget footerCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slatePanelAlt,
      border: Border.all(color: edgeOutline, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Recap',
          style: TextStyle(
            color: frostText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Animation.min(other) is the pointwise lower of two animations — '
          'a precise tool for capping, governing, and gating motion. It is '
          'distinct from math.min (a scalar), CurvedAnimation (a reshaper), '
          'and Tween (a ranger). Demo built from snapshots only, the algebra '
          'still holds.',
          style: TextStyle(
            color: frostText,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Pairs sampled: ${pairs.length}    edge probes: '
          '${edgeProbes.length}    hero curve points: ${curveA.length}',
          style: TextStyle(
            color: frostMuted,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );

  print('AnimationMin deep visual demo build complete.');

  return Scaffold(
    backgroundColor: slateInk,
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            headerCard,
            SizedBox(height: 16.0),
            heroGraph,
            SizedBox(height: 16.0),
            paletteCard,
            SizedBox(height: 16.0),
            apiCard,
            SizedBox(height: 16.0),
            galleryCard,
            SizedBox(height: 16.0),
            asciiCard,
            SizedBox(height: 16.0),
            proseCard,
            SizedBox(height: 16.0),
            scenariosCard,
            SizedBox(height: 16.0),
            pitfallsCard,
            SizedBox(height: 16.0),
            glossaryCard,
            SizedBox(height: 16.0),
            swatchCard,
            SizedBox(height: 16.0),
            comparisonCard,
            SizedBox(height: 16.0),
            flowchartCard,
            SizedBox(height: 16.0),
            snippetsCard,
            SizedBox(height: 16.0),
            edgeCard,
            SizedBox(height: 16.0),
            footerCard,
          ],
        ),
      ),
    ),
  );
}

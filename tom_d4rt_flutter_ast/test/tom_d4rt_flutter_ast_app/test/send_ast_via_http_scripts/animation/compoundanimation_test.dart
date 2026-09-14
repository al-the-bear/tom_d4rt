// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CompoundAnimation and its concrete subclasses
// Deep Demo: Visual demonstration of compound animation composition

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CompoundAnimation Deep Demo executing');

  // ============================================================
  // SECTION 1: CompoundAnimation Concept Overview
  // ============================================================
  print('=== Section 1: CompoundAnimation Concept Overview ===');

  final conceptCards = <Widget>[];

  // Concept Card 1: What is a CompoundAnimation
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.account_tree, size: 48.0, color: Colors.indigo),
          SizedBox(height: 10.0),
          Text(
            'CompoundAnimation',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Abstract base that combines\ntwo Animation<double> sources\ninto a single derived value.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept Card 2: first + next inputs
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _miniBadge('first', Colors.teal),
              Icon(Icons.add, size: 24.0, color: Colors.teal.shade400),
              _miniBadge('next', Colors.cyan),
            ],
          ),
          SizedBox(height: 10.0),
          Icon(Icons.arrow_downward, size: 24.0, color: Colors.teal.shade400),
          SizedBox(height: 6.0),
          _miniBadge('value', Colors.indigo),
          SizedBox(height: 8.0),
          Text(
            'Two parent animations feed\nthe compound; subclasses\noverride the combining rule.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.teal.shade800),
          ),
        ],
      ),
    ),
  );

  // Concept Card 3: Subclass map
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
      ),
      child: Column(
        children: [
          Icon(Icons.category, size: 40.0, color: Colors.orange.shade700),
          SizedBox(height: 10.0),
          Text(
            'Concrete Subclasses',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          _subclassRow('AnimationMin', 'min(a, b)', Colors.blue),
          SizedBox(height: 4.0),
          _subclassRow('AnimationMax', 'max(a, b)', Colors.red),
          SizedBox(height: 4.0),
          _subclassRow('AnimationMean', '(a + b) / 2', Colors.green),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Input Gallery — paired (a, b) values driving the demo
  // ============================================================
  print('=== Section 2: Input Gallery ===');

  final inputPairs = <Map<String, double>>[
    {'a': 0.10, 'b': 0.90},
    {'a': 0.30, 'b': 0.70},
    {'a': 0.50, 'b': 0.50},
    {'a': 0.20, 'b': 0.80},
    {'a': 0.85, 'b': 0.15},
    {'a': 0.65, 'b': 0.35},
  ];

  final inputWidgets = <Widget>[];
  for (int i = 0; i < inputPairs.length; i++) {
    final pair = inputPairs[i];
    final a = pair['a']!;
    final b = pair['b']!;
    print('Input pair $i: a=$a, b=$b');

    inputWidgets.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Pair #${i + 1}',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade900,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _verticalBar('a', a, Colors.teal),
                _verticalBar('b', b, Colors.cyan),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'a=${a.toStringAsFixed(2)}  b=${b.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${inputWidgets.length} input pair widgets');

  // ============================================================
  // SECTION 3: AnimationMin Results Gallery
  // ============================================================
  print('=== Section 3: AnimationMin Results ===');

  final minCards = <Widget>[];
  for (int i = 0; i < inputPairs.length; i++) {
    final pair = inputPairs[i];
    final a = pair['a']!;
    final b = pair['b']!;
    final first = AlwaysStoppedAnimation<double>(a);
    final next = AlwaysStoppedAnimation<double>(b);
    final minAnim = AnimationMin<double>(first, next);
    final result = minAnim.value;
    print('AnimationMin($a, $b) = ${result.toStringAsFixed(3)}');

    minCards.add(
      _compoundResultCard(
        index: i + 1,
        title: 'AnimationMin',
        formula: 'min(a, b)',
        a: a,
        b: b,
        result: result,
        accent: Colors.blue,
      ),
    );
  }
  print('Created ${minCards.length} AnimationMin result cards');

  // ============================================================
  // SECTION 4: AnimationMax Results Gallery
  // ============================================================
  print('=== Section 4: AnimationMax Results ===');

  final maxCards = <Widget>[];
  for (int i = 0; i < inputPairs.length; i++) {
    final pair = inputPairs[i];
    final a = pair['a']!;
    final b = pair['b']!;
    final first = AlwaysStoppedAnimation<double>(a);
    final next = AlwaysStoppedAnimation<double>(b);
    final maxAnim = AnimationMax<double>(first, next);
    final result = maxAnim.value;
    print('AnimationMax($a, $b) = ${result.toStringAsFixed(3)}');

    maxCards.add(
      _compoundResultCard(
        index: i + 1,
        title: 'AnimationMax',
        formula: 'max(a, b)',
        a: a,
        b: b,
        result: result,
        accent: Colors.red,
      ),
    );
  }
  print('Created ${maxCards.length} AnimationMax result cards');

  // ============================================================
  // SECTION 5: AnimationMean Results Gallery
  // ============================================================
  print('=== Section 5: AnimationMean Results ===');

  final meanCards = <Widget>[];
  for (int i = 0; i < inputPairs.length; i++) {
    final pair = inputPairs[i];
    final a = pair['a']!;
    final b = pair['b']!;
    final first = AlwaysStoppedAnimation<double>(a);
    final next = AlwaysStoppedAnimation<double>(b);
    final meanAnim = AnimationMean(left: first, right: next);
    final result = meanAnim.value;
    print('AnimationMean($a, $b) = ${result.toStringAsFixed(3)}');

    meanCards.add(
      _compoundResultCard(
        index: i + 1,
        title: 'AnimationMean',
        formula: '(a + b) / 2',
        a: a,
        b: b,
        result: result,
        accent: Colors.green,
      ),
    );
  }
  print('Created ${meanCards.length} AnimationMean result cards');

  // ============================================================
  // SECTION 6: ProxyAnimation — parent redirection pattern
  // ============================================================
  print('=== Section 6: ProxyAnimation — Parent Redirection ===');

  final parentA = AlwaysStoppedAnimation<double>(0.25);
  final parentB = AlwaysStoppedAnimation<double>(0.80);

  final proxyEmpty = ProxyAnimation();
  print('ProxyAnimation() empty: value=${proxyEmpty.value}, '
      'status=${proxyEmpty.status}');

  final proxyToA = ProxyAnimation(parentA);
  print('ProxyAnimation -> parentA(0.25): value=${proxyToA.value}');

  final proxyToB = ProxyAnimation(parentB);
  print('ProxyAnimation -> parentB(0.80): value=${proxyToB.value}');

  // Reassign parent on the same proxy
  final proxyDynamic = ProxyAnimation(parentA);
  print('proxyDynamic initially -> parentA: ${proxyDynamic.value}');
  proxyDynamic.parent = parentB;
  print('proxyDynamic after reassignment -> parentB: ${proxyDynamic.value}');

  final proxyStages = <Map<String, dynamic>>[
    {
      'label': 'No parent',
      'value': proxyEmpty.value,
      'note': 'Defaults to 0.0',
      'color': Colors.grey,
      'icon': Icons.link_off,
    },
    {
      'label': 'parent = A',
      'value': proxyToA.value,
      'note': 'Mirrors parentA = 0.25',
      'color': Colors.teal,
      'icon': Icons.link,
    },
    {
      'label': 'parent = B',
      'value': proxyToB.value,
      'note': 'Mirrors parentB = 0.80',
      'color': Colors.deepPurple,
      'icon': Icons.link,
    },
    {
      'label': 'Reassign A -> B',
      'value': proxyDynamic.value,
      'note': 'Same proxy, parent swapped',
      'color': Colors.orange,
      'icon': Icons.swap_horiz,
    },
  ];

  final proxyWidgets = <Widget>[];
  for (int i = 0; i < proxyStages.length; i++) {
    final s = proxyStages[i];
    final color = s['color'] as Color;
    proxyWidgets.add(
      Container(
        width: 200.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: color.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(s['icon'] as IconData, color: color, size: 18.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    s['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _horizontalValueBar(
              s['value'] as double,
              color,
            ),
            SizedBox(height: 6.0),
            Text(
              'value = ${(s['value'] as double).toStringAsFixed(3)}',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              s['note'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${proxyWidgets.length} proxy stage widgets');

  // ============================================================
  // SECTION 7: TrainHoppingAnimation Concept Diagram
  // ============================================================
  print('=== Section 7: TrainHoppingAnimation Concept ===');

  final trainScenarios = <Map<String, dynamic>>[
    {
      'label': 'Train A leads',
      'first': 0.30,
      'next': 0.60,
      'note': 'value tracks first until next overtakes',
    },
    {
      'label': 'Train B leads',
      'first': 0.75,
      'next': 0.20,
      'note': 'first is already ahead of next',
    },
    {
      'label': 'Single train',
      'first': 0.50,
      'next': null,
      'note': 'No next: behaves like the first parent',
    },
  ];

  final trainWidgets = <Widget>[];
  for (int i = 0; i < trainScenarios.length; i++) {
    final s = trainScenarios[i];
    final firstVal = s['first'] as double;
    final nextVal = s['next'] as double?;
    final trainFirst = AlwaysStoppedAnimation<double>(firstVal);
    final trainNext =
        nextVal == null ? null : AlwaysStoppedAnimation<double>(nextVal);
    final hop = TrainHoppingAnimation(trainFirst, trainNext);
    final result = hop.value;
    print('TrainHoppingAnimation(first=$firstVal, next=$nextVal) = '
        '${result.toStringAsFixed(3)}');

    trainWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.train, color: Colors.deepPurple, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  'Scenario ${i + 1}: ${s['label']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _trackRow(
              'first',
              firstVal,
              Colors.deepPurple,
              icon: Icons.train,
            ),
            SizedBox(height: 6.0),
            _trackRow(
              'next',
              nextVal,
              Colors.purple,
              icon: Icons.directions_railway,
            ),
            SizedBox(height: 6.0),
            _trackRow(
              'hop value',
              result,
              Colors.indigo,
              icon: Icons.compare_arrows,
              highlight: true,
            ),
            SizedBox(height: 8.0),
            Text(
              s['note'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.deepPurple.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${trainWidgets.length} train hopping widgets');

  // ============================================================
  // SECTION 8: Code Example Panels
  // ============================================================
  print('=== Section 8: Code Example Panels ===');

  final codePanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.lightBlueAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Patterns',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          title: 'Define a custom CompoundAnimation',
          code: '// Subclass CompoundAnimation<double> and combine\n'
              '// the two parent animations however you like.\n'
              'class WeightedBlend extends CompoundAnimation<double> {\n'
              '  WeightedBlend(this.weight, Animation<double> a,\n'
              '                Animation<double> b)\n'
              '      : super(first: a, next: b);\n'
              '  final double weight;\n'
              '  @override\n'
              '  double get value =>\n'
              '      first.value * weight + next.value * (1.0 - weight);\n'
              '}',
          color: Colors.greenAccent,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          title: 'AnimationMin / AnimationMax',
          code: '// Built-in subclasses provided by Flutter.\n'
              'final a = AlwaysStoppedAnimation<double>(0.30);\n'
              'final b = AlwaysStoppedAnimation<double>(0.70);\n'
              '\n'
              'final lower = AnimationMin<double>(a, b);  // 0.30\n'
              'final upper = AnimationMax<double>(a, b);  // 0.70',
          color: Colors.amberAccent,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          title: 'AnimationMean — public CompoundAnimation',
          code: '// AnimationMean exposes named left/right parameters.\n'
              'final blend = AnimationMean(\n'
              '  left:  AlwaysStoppedAnimation<double>(0.20),\n'
              '  right: AlwaysStoppedAnimation<double>(0.80),\n'
              ');\n'
              'print(blend.value);  // 0.50',
          color: Colors.pinkAccent,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          title: 'ProxyAnimation — redirectable parent',
          code: '// ProxyAnimation lets you swap the parent at runtime.\n'
              'final proxy = ProxyAnimation(parentA);\n'
              'print(proxy.value);  // mirrors parentA\n'
              'proxy.parent = parentB;\n'
              'print(proxy.value);  // now mirrors parentB',
          color: Colors.cyanAccent,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          title: 'TrainHoppingAnimation — hop on overtake',
          code: '// Tracks `first` until `next` overtakes; then hops.\n'
              'final hop = TrainHoppingAnimation(\n'
              '  AlwaysStoppedAnimation<double>(0.30),\n'
              '  AlwaysStoppedAnimation<double>(0.60),\n'
              ');\n'
              'print(hop.value);',
          color: Colors.orangeAccent,
        ),
      ],
    ),
  );
  print('Created code panel');

  // ============================================================
  // SECTION 9: Summary Takeaways
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
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
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.account_tree,
          'Two parents, one value',
          'CompoundAnimation reduces `first` and `next` to a single derived value.',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.south,
          'AnimationMin / AnimationMax',
          'Lower or upper envelope of two parents; common for clamp-like effects.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.equalizer,
          'AnimationMean',
          'Arithmetic mean of the two parents — a clean public CompoundAnimation.',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.swap_horiz,
          'ProxyAnimation',
          'Single forwarder whose parent can be swapped without breaking listeners.',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.train,
          'TrainHoppingAnimation',
          'Follows the first parent until the second overtakes — then hops.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.lock,
          'Works with AlwaysStoppedAnimation',
          'No Ticker required: feed constant parents and read `.value` directly.',
          Colors.orange,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('CompoundAnimation Deep Demo completed successfully');

  // ============================================================
  // Final return — one SingleChildScrollView
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.account_tree, size: 60.0, color: Colors.white),
              SizedBox(height: 10.0),
              Text(
                'CompoundAnimation',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Min · Max · Mean · Proxy · TrainHopping',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.0),

        // Section 1: Concept cards
        _sectionTitle('1. CompoundAnimation Concept'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 32.0),

        // Section 2: Input gallery
        _sectionTitle('2. Input Pairs Driving the Demo'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: inputWidgets),
        SizedBox(height: 32.0),

        // Section 3: AnimationMin gallery
        _sectionTitle('3. AnimationMin — min(a, b)'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: minCards),
        SizedBox(height: 32.0),

        // Section 4: AnimationMax gallery
        _sectionTitle('4. AnimationMax — max(a, b)'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: maxCards),
        SizedBox(height: 32.0),

        // Section 5: AnimationMean gallery
        _sectionTitle('5. AnimationMean — (a + b) / 2'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: meanCards),
        SizedBox(height: 32.0),

        // Section 6: ProxyAnimation
        _sectionTitle('6. ProxyAnimation — Parent Redirection'),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: proxyWidgets),
        SizedBox(height: 32.0),

        // Section 7: TrainHopping
        _sectionTitle('7. TrainHoppingAnimation'),
        SizedBox(height: 12.0),
        Column(children: trainWidgets),
        SizedBox(height: 32.0),

        // Section 8: Code
        _sectionTitle('8. Code Examples'),
        codePanel,
        SizedBox(height: 32.0),

        // Section 9: Summary
        _sectionTitle('9. Summary'),
        summaryPanel,
        SizedBox(height: 16.0),
      ],
    ),
  );
}

// ============================================================
// Helper Widgets (file scope)
// ============================================================

Widget _sectionTitle(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Colors.indigo, width: 5.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _miniBadge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

Widget _subclassRow(String name, String formula, Color color) {
  return Row(
    children: [
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 6.0),
      Expanded(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: color,
          ),
        ),
      ),
      Text(
        formula,
        style: TextStyle(
          fontSize: 11.0,
          fontFamily: 'monospace',
          color: Colors.grey.shade800,
        ),
      ),
    ],
  );
}

Widget _verticalBar(String label, double value, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 22.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 22.0,
            height: 70.0 * value,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.6),
                  color,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}

Widget _compoundResultCard({
  required int index,
  required String title,
  required String formula,
  required double a,
  required double b,
  required double result,
  required Color accent,
}) {
  return Container(
    width: 180.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.4),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '#$index',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
            ),
            Text(
              formula,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _verticalBar('a', a, Colors.teal),
            _verticalBar('b', b, Colors.cyan),
            _verticalBar('=', result, accent),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'value = ${result.toStringAsFixed(3)}',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _horizontalValueBar(double value, Color color) {
  return Container(
    height: 14.0,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(7.0),
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: value.clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.6), color],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
    ),
  );
}

Widget _trackRow(
  String label,
  double? value,
  Color color, {
  required IconData icon,
  bool highlight = false,
}) {
  return Row(
    children: [
      SizedBox(
        width: 80.0,
        child: Row(
          children: [
            Icon(icon, size: 16.0, color: color),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: value == null
            ? Container(
                height: 14.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Center(
                  child: Text(
                    'null',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
            : Container(
                height: 14.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(7.0),
                  border: highlight
                      ? Border.all(color: color, width: 1.0)
                      : null,
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: value.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withValues(alpha: 0.5), color],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                ),
              ),
      ),
      SizedBox(width: 8.0),
      SizedBox(
        width: 50.0,
        child: Text(
          value == null ? '—' : value.toStringAsFixed(3),
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Widget _codeBlock({
  required String title,
  required String code,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.chevron_right, color: color, size: 18.0),
            SizedBox(width: 4.0),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
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
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
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

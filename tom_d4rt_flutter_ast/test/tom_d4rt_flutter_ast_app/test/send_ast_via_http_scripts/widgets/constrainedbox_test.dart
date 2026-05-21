// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ConstrainedBox and BoxConstraints factories from widgets
// Deep Demo: Visual demonstration of ConstrainedBox sizing, BoxConstraints factories,
// nested constraint resolution, and real-world layout patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ConstrainedBox Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept Overview — What ConstrainedBox Does
  // ============================================================
  print('=== Section 1: ConstrainedBox Concept Overview ===');

  final conceptCards = <Widget>[];

  // Card 1: The basic idea
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.crop_free, size: 48.0, color: Colors.indigo),
          SizedBox(height: 12.0),
          Text(
            'ConstrainedBox',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Imposes additional size\nconstraints on its child',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.indigo.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  // Card 2: Min vs Max visualization
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.expand_less, size: 32.0, color: Colors.teal),
                  Text(
                    'MIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              Text('+', style: TextStyle(color: Colors.grey, fontSize: 24.0)),
              Column(
                children: [
                  Icon(Icons.expand_more, size: 32.0, color: Colors.green),
                  Text(
                    'MAX',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Pushes children up to MIN\nClamps children down to MAX',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  // Card 3: Parent interaction
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.account_tree, size: 48.0, color: Colors.orange),
          SizedBox(height: 12.0),
          Text(
            'Constraints Merge',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Combined with parent\nconstraints, not replaced',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Parameter Gallery — min/max width/height matrix
  // ============================================================
  print('=== Section 2: BoxConstraints Parameter Gallery ===');

  final paramRows = <Widget>[];

  // Helper to build a parameter row visualization
  Widget paramRow(
    String label,
    String value,
    String effect,
    Color color,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: color, size: 22.0),
          ),
          SizedBox(width: 12.0),
          SizedBox(
            width: 120.0,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          SizedBox(
            width: 70.0,
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              effect,
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  // Build a sampler that creates an actual ConstrainedBox with that param
  final cb1 = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 100.0),
    child: Container(
      height: 24.0,
      color: Colors.blue.shade300,
      child: Center(
        child: Text('minW=100', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  final cb2 = ConstrainedBox(
    constraints: BoxConstraints(minHeight: 40.0),
    child: Container(
      width: 80.0,
      color: Colors.green.shade400,
      child: Center(
        child: Text('minH=40', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  final cb3 = ConstrainedBox(
    constraints: BoxConstraints(maxWidth: 80.0),
    child: Container(
      height: 24.0,
      width: 300.0,
      color: Colors.purple.shade300,
      child: Center(
        child: Text('clipped', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  final cb4 = ConstrainedBox(
    constraints: BoxConstraints(maxHeight: 20.0),
    child: Container(
      width: 120.0,
      height: 200.0,
      color: Colors.red.shade400,
      child: Center(
        child: Text('clipped', style: TextStyle(color: Colors.white)),
      ),
    ),
  );

  paramRows.add(paramRow('minWidth',  '100.0', 'Pushes child width to at least 100',  Colors.blue,   Icons.swap_horiz));
  paramRows.add(paramRow('minHeight', '40.0',  'Pushes child height to at least 40',  Colors.green,  Icons.swap_vert));
  paramRows.add(paramRow('maxWidth',  '80.0',  'Clamps child width to at most 80',    Colors.purple, Icons.compress));
  paramRows.add(paramRow('maxHeight', '20.0',  'Clamps child height to at most 20',   Colors.red,    Icons.height));
  print('Created ${paramRows.length} parameter rows');

  final paramGallery = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.grid_view, color: Colors.grey.shade700),
              SizedBox(width: 8.0),
              Text(
                'BoxConstraints parameters',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        ...paramRows,
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Live samples (each row is a real ConstrainedBox):',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade600,
              fontSize: 12.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cb1,
              SizedBox(height: 6.0),
              cb2,
              SizedBox(height: 6.0),
              cb3,
              SizedBox(height: 6.0),
              cb4,
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: tight / loose / expand factory showcase
  // ============================================================
  print('=== Section 3: BoxConstraints factory showcase ===');

  final factoryShowcase = <Widget>[];

  // tight()
  final tightBox = ConstrainedBox(
    constraints: BoxConstraints.tight(Size(140.0, 60.0)),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepOrange.shade400, Colors.deepOrange.shade700],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          'tight 140x60',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  // loose()
  final looseBox = ConstrainedBox(
    constraints: BoxConstraints.loose(Size(200.0, 80.0)),
    child: Container(
      width: 120.0,
      height: 40.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.lightBlue.shade400, Colors.lightBlue.shade700],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          'loose <=200x80',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  // expand()
  final expandBox = SizedBox(
    height: 40.0,
    child: ConstrainedBox(
      constraints: BoxConstraints.expand(height: 40.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade400, Colors.purple.shade700],
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'expand height=40',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );

  // tightFor()
  final tightForBox = ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: 180.0),
    child: Container(
      height: 32.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade400, Colors.teal.shade700],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          'tightFor width=180',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  // tightForFinite()
  final tightForFiniteBox = ConstrainedBox(
    constraints: BoxConstraints.tightForFinite(width: 160.0, height: 30.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade400, Colors.pink.shade700],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          'tightForFinite',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  Widget factoryCard({
    required String name,
    required String signature,
    required String description,
    required Color color,
    required IconData icon,
    required Widget sample,
  }) {
    return Container(
      width: 320.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
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
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22.0),
              ),
              SizedBox(width: 10.0),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              signature,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.cyan.shade200,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 10.0),
          sample,
        ],
      ),
    );
  }

  factoryShowcase.add(factoryCard(
    name: 'BoxConstraints.tight',
    signature: 'BoxConstraints.tight(Size(140, 60))',
    description: 'Both min and max equal the given size — forces an exact size.',
    color: Colors.deepOrange,
    icon: Icons.lock,
    sample: tightBox,
  ));
  factoryShowcase.add(factoryCard(
    name: 'BoxConstraints.loose',
    signature: 'BoxConstraints.loose(Size(200, 80))',
    description: 'Max equals the size, min is zero — child may be smaller.',
    color: Colors.lightBlue,
    icon: Icons.lock_open,
    sample: looseBox,
  ));
  factoryShowcase.add(factoryCard(
    name: 'BoxConstraints.expand',
    signature: 'BoxConstraints.expand(height: 40)',
    description: 'Tight in both axes — fills parent unless an axis is given.',
    color: Colors.purple,
    icon: Icons.open_in_full,
    sample: expandBox,
  ));
  factoryShowcase.add(factoryCard(
    name: 'BoxConstraints.tightFor',
    signature: 'BoxConstraints.tightFor(width: 180)',
    description: 'Tight on the given axis; the other axis is unconstrained.',
    color: Colors.teal,
    icon: Icons.compare_arrows,
    sample: tightForBox,
  ));
  factoryShowcase.add(factoryCard(
    name: 'BoxConstraints.tightForFinite',
    signature: 'BoxConstraints.tightForFinite(width: 160, height: 30)',
    description: 'Like tightFor but rejects infinite values, useful in scrollables.',
    color: Colors.pink,
    icon: Icons.straighten,
    sample: tightForFiniteBox,
  ));
  print('Created ${factoryShowcase.length} factory cards');

  // ============================================================
  // SECTION 4: Before/After — child size with and without constraints
  // ============================================================
  print('=== Section 4: Before/After comparison gallery ===');

  Widget beforeAfter({
    required String title,
    required Widget before,
    required Widget after,
    required String afterLabel,
    required Color accent,
  }) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.compare, color: accent, size: 18.0),
              SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: accent),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'BEFORE',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    before,
                  ],
                ),
              ),
              SizedBox(width: 12.0),
              Icon(Icons.arrow_forward, color: accent),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        afterLabel,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    after,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final beforeAfterWidgets = <Widget>[];

  beforeAfterWidgets.add(beforeAfter(
    title: 'Force a minimum width',
    before: Container(
      color: Colors.blueGrey.shade200,
      height: 28.0,
      child: Text('  hi  '),
    ),
    after: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 120.0),
      child: Container(
        color: Colors.blue.shade400,
        height: 28.0,
        child: Center(
          child: Text('  hi  ', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    afterLabel: 'minWidth=120',
    accent: Colors.blue,
  ));

  beforeAfterWidgets.add(beforeAfter(
    title: 'Cap an oversized child',
    before: Container(
      color: Colors.red.shade200,
      height: 24.0,
      width: 240.0,
      child: Text('  too wide  '),
    ),
    after: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 100.0),
      child: Container(
        color: Colors.red.shade400,
        height: 24.0,
        width: 240.0,
        child: Center(
          child: Text('  capped  ', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    afterLabel: 'maxWidth=100',
    accent: Colors.red,
  ));

  beforeAfterWidgets.add(beforeAfter(
    title: 'Force an exact size',
    before: Container(
      color: Colors.green.shade200,
      child: Text('flexible'),
    ),
    after: ConstrainedBox(
      constraints: BoxConstraints.tight(Size(120.0, 32.0)),
      child: Container(
        color: Colors.green.shade500,
        child: Center(
          child: Text('exact 120x32', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    afterLabel: 'tight 120x32',
    accent: Colors.green,
  ));

  beforeAfterWidgets.add(beforeAfter(
    title: 'Bound a stretchy container',
    before: Container(
      color: Colors.orange.shade200,
      height: 26.0,
      width: 300.0,
      child: Text('  stretchy  '),
    ),
    after: ConstrainedBox(
      constraints: BoxConstraints.loose(Size(150.0, 40.0)),
      child: Container(
        color: Colors.orange.shade400,
        width: 300.0,
        height: 26.0,
        child: Center(
          child: Text('  bounded  ', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    afterLabel: 'loose 150x40',
    accent: Colors.orange,
  ));
  print('Created ${beforeAfterWidgets.length} before/after panels');

  // ============================================================
  // SECTION 5: Nested ConstrainedBox — constraint resolution timeline
  // ============================================================
  print('=== Section 5: Nested constraint resolution timeline ===');

  final timelineSteps = [
    {
      'step': '1. Parent offers constraints',
      'desc': 'Outer parent gives 0..400 width to its child',
      'icon': Icons.input,
      'color': Colors.indigo,
    },
    {
      'step': '2. Outer ConstrainedBox',
      'desc': 'Adds maxWidth=250 — merged result: 0..250',
      'icon': Icons.layers,
      'color': Colors.blue,
    },
    {
      'step': '3. Inner ConstrainedBox',
      'desc': 'Adds minWidth=180 — merged result: 180..250',
      'icon': Icons.layers_outlined,
      'color': Colors.teal,
    },
    {
      'step': '4. Child resolves',
      'desc': 'Child must size somewhere in 180..250',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
  ];

  final timelineWidgets = <Widget>[];
  for (int i = 0; i < timelineSteps.length; i++) {
    final step = timelineSteps[i];
    final color = step['color'] as Color;
    final isLast = i == timelineSteps.length - 1;

    timelineWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 40.0,
                  color: color.withValues(alpha: 0.5),
                ),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.35),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['step'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build the live nested example
  final nestedExample = ConstrainedBox(
    constraints: BoxConstraints(maxWidth: 250.0),
    child: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 180.0),
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade400, Colors.teal.shade400],
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'resolved: 180..250',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
  print('Created ${timelineWidgets.length} timeline steps');

  // ============================================================
  // SECTION 6: Real-world layout patterns
  // ============================================================
  print('=== Section 6: Real-world layout patterns ===');

  final patternWidgets = <Widget>[];

  // Pattern 1: Chat bubble with max width
  patternWidgets.add(
    Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.chat_bubble, size: 18.0, color: Colors.blue),
              SizedBox(width: 6.0),
              Text(
                'Pattern: chat bubble with maxWidth',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 220.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Hello! This is a long chat message that would otherwise stretch to fill the parent. The ConstrainedBox caps it at 220 logical pixels so the bubble wraps neatly.',
                  style: TextStyle(color: Colors.blue.shade900),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Pattern 2: Image thumbnail with minimum size
  patternWidgets.add(
    Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.image, size: 18.0, color: Colors.green),
              SizedBox(width: 6.0),
              Text(
                'Pattern: avatar with minimum hit area',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 48.0, minHeight: 48.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              SizedBox(width: 12.0),
              Text(
                'minWidth/Height keeps the\ntappable target at least 48 px.',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // Pattern 3: Toolbar with bounded height
  patternWidgets.add(
    Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.dashboard, size: 18.0, color: Colors.deepPurple),
              SizedBox(width: 6.0),
              Text(
                'Pattern: bounded toolbar height',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 44.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade400, Colors.purple.shade400],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: null,
                  ),
                  Expanded(
                    child: Text(
                      'Toolbar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    onPressed: null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Pattern 4: Tight square badge
  patternWidgets.add(
    Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.badge, size: 18.0, color: Colors.amber.shade800),
              SizedBox(width: 6.0),
              Text(
                'Pattern: badge with tight square',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tight(Size(32.0, 32.0)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber.shade600,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      '9',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              ConstrainedBox(
                constraints: BoxConstraints.tight(Size(48.0, 48.0)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      '99',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.0),
              Text(
                'Same shape, different size,\nboth via BoxConstraints.tight.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // Pattern 5: List item with min height
  patternWidgets.add(
    Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list, size: 18.0, color: Colors.teal),
              SizedBox(width: 6.0),
              Text(
                'Pattern: list items with minHeight',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 48.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.task_alt, color: Colors.teal),
                  SizedBox(width: 8.0),
                  Text('Short item — still 48 px tall'),
                ],
              ),
            ),
          ),
          SizedBox(height: 6.0),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 48.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.task_alt, color: Colors.teal),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Longer item with lots of text that wraps to a couple of lines but still respects the same minimum.',
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
  print('Created ${patternWidgets.length} real-world patterns');

  // ============================================================
  // SECTION 7: Code panel — usage patterns in dark style
  // ============================================================
  print('=== Section 7: Dark code panel ===');

  final codePanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'ConstrainedBox usage patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// 1) Cap a child\'s maximum width\n'
            'ConstrainedBox(\n'
            '  constraints: BoxConstraints(maxWidth: 220.0),\n'
            '  child: Text(longMessage),\n'
            ')\n'
            '\n'
            '// 2) Force a tappable minimum\n'
            'ConstrainedBox(\n'
            '  constraints: BoxConstraints(\n'
            '    minWidth: 48.0,\n'
            '    minHeight: 48.0,\n'
            '  ),\n'
            '  child: IconButton(...),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// 3) Factory shortcuts\n'
            'BoxConstraints.tight(Size(120, 32));\n'
            'BoxConstraints.loose(Size(200, 80));\n'
            'BoxConstraints.expand(height: 40);\n'
            'BoxConstraints.tightFor(width: 180);\n'
            'BoxConstraints.tightForFinite(width: 160, height: 30);',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// 4) Nested constraints merge — never replace\n'
            'ConstrainedBox(\n'
            '  constraints: BoxConstraints(maxWidth: 250),\n'
            '  child: ConstrainedBox(\n'
            '    constraints: BoxConstraints(minWidth: 180),\n'
            '    child: child,\n'
            '  ),\n'
            ')\n'
            '// effective: minWidth=180, maxWidth=250',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade300,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary — key takeaways
  // ============================================================
  print('=== Section 8: Summary panel ===');

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
          Icons.crop_free,
          'Adds, never replaces',
          'ConstrainedBox is merged with parent constraints.',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.lock,
          'Tight = exact',
          'BoxConstraints.tight forces a specific size on the child.',
          Colors.deepOrange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.lock_open,
          'Loose = up to',
          'BoxConstraints.loose lets the child be smaller than the cap.',
          Colors.lightBlue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.open_in_full,
          'Expand fills',
          'BoxConstraints.expand is tight in both axes by default.',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.compare_arrows,
          'tightFor per axis',
          'tightFor pins one axis and leaves the other free.',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.straighten,
          'tightForFinite is safe',
          'Use it when the surrounding box may pass infinity (scrollables).',
          Colors.pink,
        ),
      ],
    ),
  );

  print('ConstrainedBox Deep Demo completed successfully');

  // ============================================================
  // Final composition
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
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.crop_free, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ConstrainedBox',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Sizing constraints, factories, nesting, real-world patterns',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        Text(
          '1. What ConstrainedBox Does',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: conceptCards,
        ),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. Parameter Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        paramGallery,
        SizedBox(height: 32.0),

        // Section 3
        Text(
          '3. BoxConstraints Factories',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: factoryShowcase,
        ),
        SizedBox(height: 32.0),

        // Section 4
        Text(
          '4. Before / After Comparisons',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...beforeAfterWidgets,
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. Nested ConstrainedBox Timeline',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: timelineWidgets),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live nested resolution:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
                SizedBox(height: 8.0),
                nestedExample,
              ],
            ),
          ),
        ),
        SizedBox(height: 32.0),

        // Section 6
        Text(
          '6. Real-World Patterns',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...patternWidgets,
        SizedBox(height: 32.0),

        // Section 7
        Text(
          '7. Code Patterns',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codePanel,
        SizedBox(height: 32.0),

        // Section 8
        Text(
          '8. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// Helper: small summary item used in the closing panel.
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

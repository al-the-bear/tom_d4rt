// D4rt test script: Tests CircularProgressIndicator, LinearProgressIndicator, RefreshIndicator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Progress Indicator widgets test executing');

  // ========== CIRCULARPROGRESSINDICATOR ==========
  print('--- CircularProgressIndicator Tests ---');

  // Test basic indeterminate CircularProgressIndicator
  final basicCircular = CircularProgressIndicator();
  print('Basic CircularProgressIndicator (indeterminate) created');

  // Test CircularProgressIndicator with value
  final valueCircular = CircularProgressIndicator(value: 0.6);
  print('CircularProgressIndicator with value=0.6 created');

  // Test CircularProgressIndicator with value 0
  final zeroCircular = CircularProgressIndicator(value: 0.0);
  print('CircularProgressIndicator with value=0 created');

  // Test CircularProgressIndicator with value 1
  final fullCircular = CircularProgressIndicator(value: 1.0);
  print('CircularProgressIndicator with value=1 created');

  // Test CircularProgressIndicator with color
  final coloredCircular = CircularProgressIndicator(color: Colors.purple);
  print('CircularProgressIndicator with color created');

  // Test CircularProgressIndicator with backgroundColor
  final bgCircular = CircularProgressIndicator(
    value: 0.5,
    backgroundColor: Colors.grey.shade300,
  );
  print('CircularProgressIndicator with backgroundColor created');

  // Test CircularProgressIndicator with strokeWidth
  final thickCircular = CircularProgressIndicator(strokeWidth: 8.0);
  print('CircularProgressIndicator with strokeWidth=8 created');

  // Test thin CircularProgressIndicator
  final thinCircular = CircularProgressIndicator(strokeWidth: 2.0);
  print('CircularProgressIndicator with strokeWidth=2 created');

  // Test CircularProgressIndicator with valueColor
  final animatedColorCircular = CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
  );
  print('CircularProgressIndicator with valueColor created');

  // Test CircularProgressIndicator with strokeCap
  final roundedCircular = CircularProgressIndicator(
    value: 0.7,
    strokeCap: StrokeCap.round,
    strokeWidth: 8.0,
  );
  print('CircularProgressIndicator with strokeCap=round created');

  // Test CircularProgressIndicator with semanticsLabel
  final labeledCircular = CircularProgressIndicator(
    value: 0.4,
    semanticsLabel: '40% complete',
    semanticsValue: '40%',
  );
  print('CircularProgressIndicator with semanticsLabel created');

  // Test CircularProgressIndicator.adaptive
  final adaptiveCircular = CircularProgressIndicator.adaptive();
  print('CircularProgressIndicator.adaptive created');

  // ========== LINEARPROGRESSINDICATOR ==========
  print('--- LinearProgressIndicator Tests ---');

  // Test basic indeterminate LinearProgressIndicator
  final basicLinear = LinearProgressIndicator();
  print('Basic LinearProgressIndicator (indeterminate) created');

  // Test LinearProgressIndicator with value
  final valueLinear = LinearProgressIndicator(value: 0.5);
  print('LinearProgressIndicator with value=0.5 created');

  // Test LinearProgressIndicator with value 0
  final zeroLinear = LinearProgressIndicator(value: 0.0);
  print('LinearProgressIndicator with value=0 created');

  // Test LinearProgressIndicator with value 1
  final fullLinear = LinearProgressIndicator(value: 1.0);
  print('LinearProgressIndicator with value=1 created');

  // Test LinearProgressIndicator with color
  final coloredLinear = LinearProgressIndicator(color: Colors.green);
  print('LinearProgressIndicator with color created');

  // Test LinearProgressIndicator with backgroundColor
  final bgLinear = LinearProgressIndicator(
    value: 0.7,
    backgroundColor: Colors.grey.shade200,
  );
  print('LinearProgressIndicator with backgroundColor created');

  // Test LinearProgressIndicator with valueColor
  final animatedColorLinear = LinearProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
  );
  print('LinearProgressIndicator with valueColor created');

  // Test LinearProgressIndicator with minHeight
  final tallLinear = LinearProgressIndicator(minHeight: 10.0, value: 0.6);
  print('LinearProgressIndicator with minHeight=10 created');

  // Test thin LinearProgressIndicator
  final thinLinear = LinearProgressIndicator(minHeight: 2.0, value: 0.8);
  print('LinearProgressIndicator with minHeight=2 created');

  // Test LinearProgressIndicator with borderRadius
  final roundedLinear = LinearProgressIndicator(
    value: 0.5,
    minHeight: 8.0,
    borderRadius: BorderRadius.circular(4.0),
  );
  print('LinearProgressIndicator with borderRadius created');

  // Test LinearProgressIndicator with semanticsLabel
  final labeledLinear = LinearProgressIndicator(
    value: 0.3,
    semanticsLabel: '30% complete',
    semanticsValue: '30%',
  );
  print('LinearProgressIndicator with semanticsLabel created');

  // ========== REFRESHINDICATOR ==========
  print('--- RefreshIndicator Tests ---');

  // Test basic RefreshIndicator
  final basicRefresh = RefreshIndicator(
    onRefresh: () async {
      print('Refreshing...');
      await Future.delayed(Duration(seconds: 1));
      print('Refresh complete');
    },
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    ),
  );
  print('Basic RefreshIndicator created');

  // Test RefreshIndicator with color
  final coloredRefresh = RefreshIndicator(
    color: Colors.purple,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(
      children: [
        ListTile(title: Text('Pull to refresh')),
        ListTile(title: Text('Colored indicator')),
      ],
    ),
  );
  print('RefreshIndicator with color created');

  // Test RefreshIndicator with backgroundColor
  final bgRefresh = RefreshIndicator(
    backgroundColor: Colors.blue.shade100,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(
      children: [
        ListTile(title: Text('Pull to refresh')),
        ListTile(title: Text('Background colored')),
      ],
    ),
  );
  print('RefreshIndicator with backgroundColor created');

  // Test RefreshIndicator with displacement
  final displacedRefresh = RefreshIndicator(
    displacement: 60.0,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Large displacement'))]),
  );
  print('RefreshIndicator with displacement created');

  // Test RefreshIndicator with edgeOffset
  final offsetRefresh = RefreshIndicator(
    edgeOffset: 100.0,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Edge offset'))]),
  );
  print('RefreshIndicator with edgeOffset created');

  // Test RefreshIndicator with strokeWidth
  final strokeRefresh = RefreshIndicator(
    strokeWidth: 4.0,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Thick stroke'))]),
  );
  print('RefreshIndicator with strokeWidth created');

  // Test RefreshIndicator with triggerMode
  final triggerRefresh = RefreshIndicator(
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Trigger anywhere'))]),
  );
  print('RefreshIndicator with triggerMode created');

  // Test RefreshIndicator.adaptive
  final adaptiveRefresh = RefreshIndicator.adaptive(
    onRefresh: () async {
      await Future.delayed(Duration(seconds: 1));
    },
    child: ListView(children: [ListTile(title: Text('Adaptive indicator'))]),
  );
  print('RefreshIndicator.adaptive created');

  print('Progress Indicator widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Indicators Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'CircularProgressIndicator:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: basicCircular),
                SizedBox(height: 4),
                Text('Indeterminate', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: valueCircular),
                SizedBox(height: 4),
                Text('60%', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: coloredCircular),
                SizedBox(height: 4),
                Text('Colored', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: thickCircular),
                SizedBox(height: 4),
                Text('Thick', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: roundedCircular),
                SizedBox(height: 4),
                Text('Rounded Cap', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: bgCircular),
                SizedBox(height: 4),
                Text('With BG', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                SizedBox(width: 40, height: 40, child: adaptiveCircular),
                SizedBox(height: 4),
                Text('Adaptive', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'LinearProgressIndicator:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),

        Text('Indeterminate:', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        basicLinear,
        SizedBox(height: 12.0),

        Text('50% complete:', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        valueLinear,
        SizedBox(height: 12.0),

        Text('Colored (green):', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        coloredLinear,
        SizedBox(height: 12.0),

        Text('With background:', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        bgLinear,
        SizedBox(height: 12.0),

        Text('Tall (10px):', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        tallLinear,
        SizedBox(height: 12.0),

        Text('Thin (2px):', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        thinLinear,
        SizedBox(height: 12.0),

        Text('Rounded corners:', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        roundedLinear,

        SizedBox(height: 24.0),
        Text(
          'RefreshIndicator:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '(Pull down to refresh in actual app)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: basicRefresh,
        ),
      ],
    ),
  );
}

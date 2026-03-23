// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverList, SliverGrid, SliverToBoxAdapter, SliverPadding from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverList test executing');

  // Test SliverList with SliverChildListDelegate
  final sliverListWidget = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverList(
        delegate: SliverChildListDelegate([
          Container(
            height: 50.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'SliverList item 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.lightBlue,
            child: Center(
              child: Text(
                'SliverList item 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'SliverList item 3',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.lightBlue,
            child: Center(
              child: Text(
                'SliverList item 4',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    ],
  );
  print('SliverList with SliverChildListDelegate created');

  // Test SliverList with SliverChildBuilderDelegate
  final sliverListBuilder = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          print('SliverChildBuilderDelegate building index $index');
          return Container(
            height: 40.0,
            color: index % 2 == 0 ? Colors.green : Colors.lightGreen,
            child: Center(
              child: Text(
                'Builder item $index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }, childCount: 5),
      ),
    ],
  );
  print('SliverList with SliverChildBuilderDelegate created');

  // Test SliverGrid with SliverGridDelegateWithFixedCrossAxisCount
  final sliverGridFixed = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildListDelegate([
          Container(
            color: Colors.red,
            child: Center(
              child: Text('1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.orange,
            child: Center(
              child: Text('2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Center(
              child: Text('3', style: TextStyle(color: Colors.black)),
            ),
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text('4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('5', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.purple,
            child: Center(
              child: Text('6', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    ],
  );
  print('SliverGrid with fixedCrossAxisCount=3 created');

  // Test SliverGrid with SliverGridDelegateWithMaxCrossAxisExtent
  final sliverGridExtent = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 1.5,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text('$index', style: TextStyle(color: Colors.white)),
            ),
          );
        }, childCount: 8),
      ),
    ],
  );
  print('SliverGrid with maxCrossAxisExtent=100 created');

  // Test SliverToBoxAdapter
  final sliverToBoxWidget = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 60.0,
          color: Colors.teal,
          child: Center(
            child: Text(
              'SliverToBoxAdapter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Card in SliverToBoxAdapter'),
            ),
          ),
        ),
      ),
    ],
  );
  print('SliverToBoxAdapter widgets created');

  // Test SliverPadding
  final sliverPaddingWidget = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverPadding(
        padding: EdgeInsets.all(16.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: 40.0,
              color: Colors.indigo,
              child: Center(
                child: Text(
                  'Padded item 1',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              height: 40.0,
              color: Colors.indigo,
              child: Center(
                child: Text(
                  'Padded item 2',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    ],
  );
  print('SliverPadding with SliverList created');

  // Test SliverPadding with symmetric padding
  final sliverPaddingSymmetric = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 50.0,
            color: Colors.brown,
            child: Center(
              child: Text(
                'Symmetric padding',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ],
  );
  print('SliverPadding with symmetric padding created');

  // Test combined slivers
  final combinedSlivers = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 40.0,
          color: Colors.grey,
          child: Center(
            child: Text(
              'Header',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 2.0,
          ),
          delegate: SliverChildListDelegate([
            Container(
              color: Colors.cyan,
              child: Center(child: Text('A')),
            ),
            Container(
              color: Colors.amber,
              child: Center(child: Text('B')),
            ),
            Container(
              color: Colors.cyan,
              child: Center(child: Text('C')),
            ),
            Container(
              color: Colors.amber,
              child: Center(child: Text('D')),
            ),
          ]),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 40.0,
          color: Colors.grey,
          child: Center(
            child: Text(
              'Footer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
  print('Combined slivers created');

  print('SliverList test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'SliverList / SliverGrid Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'SliverList (ListDelegate):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 220.0, child: sliverListWidget),
        SizedBox(height: 16.0),
        Text(
          'SliverList (BuilderDelegate):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 220.0, child: sliverListBuilder),
        SizedBox(height: 16.0),
        Text(
          'SliverGrid (fixedCrossAxisCount):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 250.0, child: sliverGridFixed),
        SizedBox(height: 16.0),
        Text(
          'SliverGrid (maxCrossAxisExtent):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 200.0, child: sliverGridExtent),
        SizedBox(height: 16.0),
        Text(
          'SliverToBoxAdapter:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 150.0, child: sliverToBoxWidget),
        SizedBox(height: 16.0),
        Text('SliverPadding:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 130.0, child: sliverPaddingWidget),
        SizedBox(height: 16.0),
        Text(
          'SliverPadding symmetric:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 80.0, child: sliverPaddingSymmetric),
        SizedBox(height: 16.0),
        Text('Combined:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: combinedSlivers),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SliverList uses delegate for children'),
        Text('• SliverGrid uses gridDelegate + delegate'),
        Text('• SliverToBoxAdapter wraps regular widgets'),
        Text('• SliverPadding adds padding around slivers'),
        Text('• SliverChildBuilderDelegate for lazy building'),
      ],
    ),
  );
}

// D4rt test script: Tests CustomScrollView from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CustomScrollView test executing');

  // Test CustomScrollView with SliverToBoxAdapter children
  final basicScrollView = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 80.0,
          color: Colors.blue,
          child: Center(
            child: Text('Sliver 1', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 80.0,
          color: Colors.green,
          child: Center(
            child: Text('Sliver 2', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 80.0,
          color: Colors.orange,
          child: Center(
            child: Text('Sliver 3', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with SliverToBoxAdapter children created');

  // Test CustomScrollView with SliverAppBar
  final withAppBar = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverAppBar(
        title: Text('Sliver AppBar'),
        backgroundColor: Colors.purple,
        expandedHeight: 100.0,
        floating: true,
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 60.0,
          color: Colors.purple,
          child: Center(
            child: Text(
              'Content below AppBar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with SliverAppBar created');

  // Test CustomScrollView with SliverPadding
  final withPadding = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverPadding(
        padding: EdgeInsets.all(16.0),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 60.0,
            color: Colors.teal,
            child: Center(
              child: Text(
                'Padded sliver',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with SliverPadding created');

  // Test CustomScrollView with SliverList
  final withSliverList = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverList(
        delegate: SliverChildListDelegate([
          Container(
            height: 50.0,
            color: Colors.red,
            child: Center(
              child: Text('List item 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.pink,
            child: Center(
              child: Text('List item 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.red,
            child: Center(
              child: Text('List item 3', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    ],
  );
  print('CustomScrollView with SliverList created');

  // Test CustomScrollView with mixed slivers
  final mixedSlivers = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.indigo,
          child: Center(
            child: Text('Header', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Card 1'),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Card 2'),
              ),
            ),
          ]),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.indigo,
          child: Center(
            child: Text('Footer', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with mixed slivers created');

  // Test CustomScrollView with scrollDirection horizontal
  final horizontalScroll = SizedBox(
    height: 80.0,
    child: CustomScrollView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            width: 100.0,
            color: Colors.cyan,
            child: Center(
              child: Text('H1', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: 100.0,
            color: Colors.amber,
            child: Center(
              child: Text('H2', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: 100.0,
            color: Colors.cyan,
            child: Center(
              child: Text('H3', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    ),
  );
  print('CustomScrollView with horizontal scrollDirection created');

  // Test CustomScrollView with reverse
  final reverseScroll = CustomScrollView(
    shrinkWrap: true,
    reverse: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.brown,
          child: Center(
            child: Text(
              'First (at bottom)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.grey,
          child: Center(
            child: Text(
              'Second (above)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with reverse=true created');

  print('CustomScrollView test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'CustomScrollView Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Basic with SliverToBoxAdapter:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 300.0, child: basicScrollView),
        SizedBox(height: 16.0),
        Text(
          'With SliverAppBar:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 200.0, child: withAppBar),
        SizedBox(height: 16.0),
        Text(
          'With SliverPadding:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 120.0, child: withPadding),
        SizedBox(height: 16.0),
        Text('With SliverList:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: withSliverList),
        SizedBox(height: 16.0),
        Text('Mixed slivers:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: mixedSlivers),
        SizedBox(height: 16.0),
        Text(
          'Horizontal scroll:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        horizontalScroll,
        SizedBox(height: 16.0),
        Text('Reverse:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 120.0, child: reverseScroll),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• CustomScrollView combines multiple slivers'),
        Text('• SliverToBoxAdapter wraps regular widgets'),
        Text('• SliverPadding adds padding around slivers'),
        Text('• scrollDirection supports horizontal scrolling'),
        Text('• reverse flips the scroll direction'),
      ],
    ),
  );
}

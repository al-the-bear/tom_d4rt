// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AnimatedList from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedList test executing');

  // Test AnimatedList with initialItemCount
  final listBasic = AnimatedList(
    initialItemCount: 3,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text('Item $index')),
      );
    },
  );
  print('AnimatedList with initialItemCount=3 created');

  // Test AnimatedList with initialItemCount=0
  final listEmpty = AnimatedList(
    initialItemCount: 0,
    itemBuilder: (context, index, animation) {
      return FadeTransition(
        opacity: animation,
        child: ListTile(title: Text('Item $index')),
      );
    },
  );
  print('AnimatedList with initialItemCount=0 created');

  // Test AnimatedList with initialItemCount=5
  final listFive = AnimatedList(
    initialItemCount: 5,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          child: ListTile(
            leading: Icon(Icons.star),
            title: Text('Star item $index'),
          ),
        ),
      );
    },
  );
  print('AnimatedList with initialItemCount=5 created');

  // Test AnimatedList with horizontal scrollDirection
  final listHorizontal = SizedBox(
    height: 80.0,
    child: AnimatedList(
      scrollDirection: Axis.horizontal,
      initialItemCount: 4,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          child: Container(
            width: 80.0,
            margin: EdgeInsets.all(4.0),
            color: Colors.blue,
            child: Center(
              child: Text('H$index', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    ),
  );
  print('AnimatedList with scrollDirection=horizontal created');

  // Test AnimatedList with physics NeverScrollableScrollPhysics
  final listNeverScroll = AnimatedList(
    initialItemCount: 3,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(
          title: Text('No-scroll item $index'),
          subtitle: Text('NeverScrollableScrollPhysics'),
        ),
      );
    },
  );
  print('AnimatedList with NeverScrollableScrollPhysics created');

  // Test AnimatedList with BouncingScrollPhysics
  final listBouncing = AnimatedList(
    initialItemCount: 4,
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          color: Colors.green,
          child: Center(
            child: Text('Bounce $index', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    },
  );
  print('AnimatedList with BouncingScrollPhysics created');

  // Test AnimatedList with reverse
  final listReverse = AnimatedList(
    initialItemCount: 3,
    reverse: true,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text('Reverse item $index')),
      );
    },
  );
  print('AnimatedList with reverse=true created');

  // Test AnimatedList with padding
  final listPadded = AnimatedList(
    initialItemCount: 3,
    padding: EdgeInsets.all(16.0),
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('$index')),
            title: Text('Padded item $index'),
          ),
        ),
      );
    },
  );
  print('AnimatedList with padding created');

  // Test AnimatedList with shrinkWrap
  final listShrinkWrap = AnimatedList(
    initialItemCount: 2,
    shrinkWrap: true,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          height: 40.0,
          margin: EdgeInsets.all(2.0),
          color: Colors.orange,
          child: Center(
            child: Text('Shrink $index', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    },
  );
  print('AnimatedList with shrinkWrap=true created');

  print('All AnimatedList tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== AnimatedList Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic (3 items):', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: listBasic),
        SizedBox(height: 8.0),
        Text('Empty (0 items):', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 60.0, child: listEmpty),
        SizedBox(height: 8.0),
        Text(
          'Five items with cards:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 300.0, child: listFive),
        SizedBox(height: 8.0),
        Text('Horizontal:', style: TextStyle(fontWeight: FontWeight.bold)),
        listHorizontal,
        SizedBox(height: 8.0),
        Text('NeverScrollable:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: listNeverScroll),
        SizedBox(height: 8.0),
        Text(
          'Bouncing physics:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 220.0, child: listBouncing),
        SizedBox(height: 8.0),
        Text('Reverse:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: listReverse),
        SizedBox(height: 8.0),
        Text('Padded:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 220.0, child: listPadded),
        SizedBox(height: 8.0),
        Text('ShrinkWrap:', style: TextStyle(fontWeight: FontWeight.bold)),
        listShrinkWrap,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• AnimatedList animates item insertion/removal'),
        Text('• initialItemCount sets starting number of items'),
        Text('• itemBuilder receives animation for transitions'),
        Text('• scrollDirection supports horizontal lists'),
        Text('• physics controls scroll behavior'),
        Text('• Use SizeTransition/FadeTransition with the animation param'),
      ],
    ),
  );
}

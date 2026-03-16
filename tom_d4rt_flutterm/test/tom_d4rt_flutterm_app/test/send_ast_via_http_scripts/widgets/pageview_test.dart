// D4rt test script: Tests PageView widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageView test executing');

  // Test basic PageView
  final basicPageView = PageView(
    children: [
      Container(
        color: Colors.red,
        child: Center(
          child: Text(
            'Page 1',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
      Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'Page 2',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
      Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            'Page 3',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      ),
    ],
  );
  print('Basic PageView with 3 children created');

  // Test PageView with controller
  final controller = PageController(initialPage: 1, viewportFraction: 0.9);
  print('PageController created: initialPage=1, viewportFraction=0.9');

  final withController = PageView(
    controller: controller,
    children: [
      Container(
        color: Colors.orange,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
      ),
      Container(
        color: Colors.purple,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
      ),
      Container(
        color: Colors.teal,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
      ),
    ],
  );
  print('PageView with controller created');

  // Test PageView.builder
  final pageViewBuilder = PageView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            'Page $index',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
      );
    },
  );
  print('PageView.builder with 10 items created');

  // Test PageView.custom
  final pageViewCustom = PageView.custom(
    childrenDelegate: SliverChildBuilderDelegate((context, index) {
      return Container(
        color: Colors.accents[index % Colors.accents.length],
        child: Center(child: Text('Custom $index')),
      );
    }, childCount: 5),
  );
  print('PageView.custom with SliverChildBuilderDelegate created');

  // Test PageView with scrollDirection
  final horizontalPageView = PageView(
    scrollDirection: Axis.horizontal,
    children: [
      Container(
        color: Colors.red.shade200,
        child: Center(child: Text('Horizontal 1')),
      ),
      Container(
        color: Colors.red.shade300,
        child: Center(child: Text('Horizontal 2')),
      ),
      Container(
        color: Colors.red.shade400,
        child: Center(child: Text('Horizontal 3')),
      ),
    ],
  );
  print('PageView with scrollDirection=Axis.horizontal created');

  final verticalPageView = PageView(
    scrollDirection: Axis.vertical,
    children: [
      Container(
        color: Colors.blue.shade200,
        child: Center(child: Text('Vertical 1')),
      ),
      Container(
        color: Colors.blue.shade300,
        child: Center(child: Text('Vertical 2')),
      ),
      Container(
        color: Colors.blue.shade400,
        child: Center(child: Text('Vertical 3')),
      ),
    ],
  );
  print('PageView with scrollDirection=Axis.vertical created');

  // Test PageView with physics
  final bouncingPhysics = PageView(
    physics: BouncingScrollPhysics(),
    children: [
      Container(
        color: Colors.amber.shade200,
        child: Center(child: Text('Bouncing 1')),
      ),
      Container(
        color: Colors.amber.shade300,
        child: Center(child: Text('Bouncing 2')),
      ),
    ],
  );
  print('PageView with BouncingScrollPhysics created');

  final clampingPhysics = PageView(
    physics: ClampingScrollPhysics(),
    children: [
      Container(
        color: Colors.green.shade200,
        child: Center(child: Text('Clamping 1')),
      ),
      Container(
        color: Colors.green.shade300,
        child: Center(child: Text('Clamping 2')),
      ),
    ],
  );
  print('PageView with ClampingScrollPhysics created');

  final neverScroll = PageView(
    physics: NeverScrollableScrollPhysics(),
    children: [
      Container(
        color: Colors.grey.shade300,
        child: Center(child: Text('Never Scroll')),
      ),
    ],
  );
  print('PageView with NeverScrollableScrollPhysics created');

  // Test PageView with onPageChanged
  final withCallback = PageView(
    onPageChanged: (int page) {
      print('PageView page changed to: $page');
    },
    children: [
      Container(
        color: Colors.cyan.shade200,
        child: Center(child: Text('Callback 1')),
      ),
      Container(
        color: Colors.cyan.shade300,
        child: Center(child: Text('Callback 2')),
      ),
      Container(
        color: Colors.cyan.shade400,
        child: Center(child: Text('Callback 3')),
      ),
    ],
  );
  print('PageView with onPageChanged callback created');

  // Test PageView with reverse
  final reversePageView = PageView(
    reverse: true,
    children: [
      Container(
        color: Colors.pink.shade200,
        child: Center(child: Text('Reverse 1')),
      ),
      Container(
        color: Colors.pink.shade300,
        child: Center(child: Text('Reverse 2')),
      ),
      Container(
        color: Colors.pink.shade400,
        child: Center(child: Text('Reverse 3')),
      ),
    ],
  );
  print('PageView with reverse=true created');

  // Test PageView with pageSnapping
  final noSnapping = PageView(
    pageSnapping: false,
    children: [
      Container(
        color: Colors.lime.shade200,
        child: Center(child: Text('No Snap 1')),
      ),
      Container(
        color: Colors.lime.shade300,
        child: Center(child: Text('No Snap 2')),
      ),
    ],
  );
  print('PageView with pageSnapping=false created');

  // Test PageController methods
  print('PageController.jumpToPage(2) - instant jump');
  print('PageController.animateToPage(2) - animated scroll');
  print('PageController.nextPage() - go to next');
  print('PageController.previousPage() - go to previous');

  // Test PageController with keepPage
  final keepPageController = PageController(initialPage: 0, keepPage: true);
  print('PageController with keepPage=true created');

  // Test padEnds
  final padEndsPageView = PageView(
    controller: PageController(viewportFraction: 0.8),
    padEnds: true,
    children: [
      Container(
        color: Colors.indigo.shade200,
        child: Center(child: Text('Pad 1')),
      ),
      Container(
        color: Colors.indigo.shade300,
        child: Center(child: Text('Pad 2')),
      ),
      Container(
        color: Colors.indigo.shade400,
        child: Center(child: Text('Pad 3')),
      ),
    ],
  );
  print('PageView with padEnds=true created');

  // Test allowImplicitScrolling
  final implicitScroll = PageView(
    allowImplicitScrolling: true,
    children: [
      Container(
        color: Colors.brown.shade200,
        child: Center(child: Text('Implicit 1')),
      ),
      Container(
        color: Colors.brown.shade300,
        child: Center(child: Text('Implicit 2')),
      ),
    ],
  );
  print('PageView with allowImplicitScrolling=true created');

  print('PageView test completed');

  return Column(
    children: [
      Expanded(flex: 3, child: basicPageView),
      Expanded(flex: 2, child: withController),
      Expanded(flex: 2, child: pageViewBuilder),
    ],
  );
}

// ignore_for_file: avoid_print
// D4rt test script: Tests LayoutBuilder, OrientationBuilder, CustomMultiChildLayout,
// MultiChildLayoutDelegate, CustomSingleChildLayout, SingleChildLayoutDelegate,
// SizedOverflowBox, OverflowBox
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Layout builder advanced test executing');

  // ========== LayoutBuilder ==========
  print('--- LayoutBuilder Tests ---');
  final layoutBuilder = LayoutBuilder(
    builder: (context, constraints) {
      print('  LayoutBuilder constraints: $constraints');
      print('    maxWidth: ${constraints.maxWidth}');
      print('    maxHeight: ${constraints.maxHeight}');
      print('    minWidth: ${constraints.minWidth}');
      print('    minHeight: ${constraints.minHeight}');
      print('    hasBoundedWidth: ${constraints.hasBoundedWidth}');
      print('    hasBoundedHeight: ${constraints.hasBoundedHeight}');
      print('    hasInfiniteWidth: ${constraints.hasInfiniteWidth}');
      print('    hasInfiniteHeight: ${constraints.hasInfiniteHeight}');

      if (constraints.maxWidth > 600) {
        return Row(
          children: [
            Expanded(child: Container(color: Colors.blue, height: 100)),
            Expanded(child: Container(color: Colors.red, height: 100)),
          ],
        );
      }
      return Column(
        children: [
          Container(color: Colors.blue, height: 50),
          Container(color: Colors.red, height: 50),
        ],
      );
    },
  );
  print('LayoutBuilder created');

  // ========== OrientationBuilder ==========
  print('--- OrientationBuilder Tests ---');
  final orientationBuilder = OrientationBuilder(
    builder: (context, orientation) {
      print('  Orientation: $orientation');
      if (orientation == Orientation.landscape) {
        return Row(
          children: [
            Expanded(child: Container(color: Colors.green, height: 80)),
            Expanded(child: Container(color: Colors.yellow, height: 80)),
          ],
        );
      }
      return Column(
        children: [
          Container(color: Colors.green, height: 40, width: double.infinity),
          Container(color: Colors.yellow, height: 40, width: double.infinity),
        ],
      );
    },
  );
  print('OrientationBuilder created');

  // ========== CustomMultiChildLayout ==========
  print('--- CustomMultiChildLayout Tests ---');
  final multiChildLayout = CustomMultiChildLayout(
    delegate: TestMultiChildLayoutDelegate(),
    children: [
      LayoutId(
        id: 'header',
        child: Container(color: Colors.blue, child: Text('Header')),
      ),
      LayoutId(
        id: 'body',
        child: Container(color: Colors.green, child: Text('Body')),
      ),
      LayoutId(
        id: 'footer',
        child: Container(color: Colors.red, child: Text('Footer')),
      ),
    ],
  );
  print('CustomMultiChildLayout created');

  // ========== CustomSingleChildLayout ==========
  print('--- CustomSingleChildLayout Tests ---');
  final singleChildLayout = CustomSingleChildLayout(
    delegate: TestSingleChildLayoutDelegate(),
    child: Container(
      width: 100,
      height: 100,
      color: Colors.purple,
      child: Center(child: Text('Single')),
    ),
  );
  print('CustomSingleChildLayout created');

  // ========== OverflowBox ==========
  print('--- OverflowBox Tests ---');
  final overflowBox = OverflowBox(
    alignment: Alignment.center,
    minWidth: 0,
    maxWidth: 300,
    minHeight: 0,
    maxHeight: 300,
    child: Container(
      width: 200,
      height: 200,
      color: Colors.teal,
      child: Center(child: Text('Overflow')),
    ),
  );
  print('OverflowBox created');

  // ========== SizedOverflowBox ==========
  print('--- SizedOverflowBox Tests ---');
  final sizedOverflowBox = SizedOverflowBox(
    size: Size(100, 100),
    alignment: Alignment.topLeft,
    child: Container(
      width: 150,
      height: 150,
      color: Colors.amber,
      child: Center(child: Text('SizedOverflow')),
    ),
  );
  print('SizedOverflowBox created');

  // ========== BoxConstraints advanced ==========
  print('--- BoxConstraints Tests ---');
  final c1 = BoxConstraints(
    minWidth: 0,
    maxWidth: 300,
    minHeight: 0,
    maxHeight: 500,
  );
  print('BoxConstraints: $c1');
  final c2 = BoxConstraints.tight(Size(100, 200));
  print('BoxConstraints.tight: $c2');
  final c3 = BoxConstraints.loose(Size(300, 400));
  print('BoxConstraints.loose: $c3');
  final c4 = BoxConstraints.expand(width: 200, height: 300);
  print('BoxConstraints.expand: $c4');
  final c5 = BoxConstraints.tightFor(width: 100);
  print('BoxConstraints.tightFor: $c5');
  print('  c1.isTight: ${c1.isTight}');
  print('  c1.isNormalized: ${c1.isNormalized}');
  print('  c1.biggest: ${c1.biggest}');
  print('  c1.smallest: ${c1.smallest}');
  final c6 = c1.enforce(BoxConstraints(maxWidth: 200));
  print('  enforce: $c6');
  final c7 = c1.deflate(EdgeInsets.all(10));
  print('  deflate: $c7');

  print('All layout builder advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 200, child: layoutBuilder),
            SizedBox(height: 200, child: orientationBuilder),
            SizedBox(height: 200, child: multiChildLayout),
            singleChildLayout,
            overflowBox,
            sizedOverflowBox,
          ],
        ),
      ),
    ),
  );
}

class TestMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final headerSize = layoutChild(
      'header',
      BoxConstraints.tightFor(width: size.width, height: 50),
    );
    positionChild('header', Offset.zero);

    final footerSize = layoutChild(
      'footer',
      BoxConstraints.tightFor(width: size.width, height: 50),
    );
    positionChild('footer', Offset(0, size.height - footerSize.height));

    layoutChild(
      'body',
      BoxConstraints.tightFor(
        width: size.width,
        height: size.height - headerSize.height - footerSize.height,
      ),
    );
    positionChild('body', Offset(0, headerSize.height));
  }

  @override
  bool shouldRelayout(TestMultiChildLayoutDelegate oldDelegate) => false;
}

class TestSingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(
      (size.width - childSize.width) / 2,
      (size.height - childSize.height) / 2,
    );
  }

  @override
  bool shouldRelayout(TestSingleChildLayoutDelegate oldDelegate) => false;
}

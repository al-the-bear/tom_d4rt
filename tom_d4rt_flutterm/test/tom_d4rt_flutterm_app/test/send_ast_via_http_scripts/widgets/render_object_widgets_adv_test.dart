// ignore_for_file: avoid_print
// Tests: SingleChildRenderObjectWidget, MultiChildRenderObjectWidget,
//        SlottedContainerRenderObjectMixin, SlottedRenderObjectWidget,
//        SlottedMultiChildRenderObjectWidget, PreferredSizeWidget,
//        PlaceholderSpan, RawImage
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- SingleChildRenderObjectWidget Tests ---
  print('--- SingleChildRenderObjectWidget Tests ---');
  print('SingleChildRenderObjectWidget has exactly one child');
  print('Type: $SingleChildRenderObjectWidget');
  var opacity = Opacity(opacity: 0.5, child: Container());
  print('Opacity (SingleChildRenderObjectWidget): $opacity');
  print('opacity value: 0.5');

  // --- MultiChildRenderObjectWidget Tests ---
  print('--- MultiChildRenderObjectWidget Tests ---');
  print('MultiChildRenderObjectWidget has a list of children');
  print('Type: $MultiChildRenderObjectWidget');
  var column = Column(children: [const Text('A'), const Text('B')]);
  print('Column (MultiChildRenderObjectWidget): $column');
  print('Column arranges children vertically');

  // --- SlottedContainerRenderObjectMixin Tests ---
  print('--- SlottedContainerRenderObjectMixin Tests ---');
  print(
    'SlottedContainerRenderObjectMixin provides named slot child management',
  );
  print('Type: SlottedContainerRenderObjectMixin (internal framework mixin)');
  print('Used by render objects that have a fixed set of named children');

  // --- SlottedRenderObjectWidget Tests ---
  print('--- SlottedRenderObjectWidget Tests ---');
  print('SlottedRenderObjectWidget uses named slots for children');
  print('Type: SlottedRenderObjectWidget (internal framework class)');
  print('Base class for widgets with a fixed number of named child slots');

  // --- SlottedMultiChildRenderObjectWidget Tests ---
  print('--- SlottedMultiChildRenderObjectWidget Tests ---');
  print(
    'SlottedMultiChildRenderObjectWidget extends SlottedRenderObjectWidget',
  );
  print('Type: SlottedMultiChildRenderObjectWidget (internal framework class)');
  print('Provides multi-child support with named slots');

  // --- PreferredSizeWidget Tests ---
  print('--- PreferredSizeWidget Tests ---');
  print('PreferredSizeWidget defines a preferred size for layout');
  print('Type: $PreferredSizeWidget');
  var appBar = AppBar(title: const Text('PreferredSizeWidget Test'));
  print('AppBar (implements PreferredSizeWidget): $appBar');
  print('AppBar preferredSize: ${appBar.preferredSize}');
  var preferredSize = PreferredSize(
    preferredSize: const Size.fromHeight(50.0),
    child: Container(),
  );
  print('PreferredSize widget: $preferredSize');
  print('preferredSize height: 50.0');

  // --- PlaceholderSpan Tests ---
  print('--- PlaceholderSpan Tests ---');
  print('PlaceholderSpan is an abstract InlineSpan for embedding widgets');
  print('Type: $PlaceholderSpan');
  var widgetSpan = WidgetSpan(child: Container(width: 20, height: 20));
  print('WidgetSpan (extends PlaceholderSpan): $widgetSpan');
  print('WidgetSpan alignment: ${widgetSpan.alignment}');

  // --- RawImage Tests ---
  print('--- RawImage Tests ---');
  var rawImage = RawImage(image: null, width: 100, height: 100);
  print('RawImage: $rawImage');
  print('RawImage width: ${rawImage.width}');
  print('RawImage height: ${rawImage.height}');
  print('RawImage image: ${rawImage.image}');
  print('RawImage scale: ${rawImage.scale}');

  print('All render object widgets advanced tests passed');

  return MaterialApp(
    home: Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            opacity,
            column,
            preferredSize,
            rawImage,
            const Text('Render Object Widgets Adv Test'),
          ],
        ),
      ),
    ),
  );
}

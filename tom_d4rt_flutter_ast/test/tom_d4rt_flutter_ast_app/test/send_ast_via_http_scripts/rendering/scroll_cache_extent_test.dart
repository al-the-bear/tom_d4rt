// ignore_for_file: avoid_print, unnecessary_type_check
// D4rt test script: ScrollCacheExtent (rendering, Flutter 3.47).
//
// ScrollCacheExtent says how far beyond the viewport a scroll view lays out
// children: a number of pixels or a fraction of the viewport. The script
// creates both, reads `style` and `value`, and passes each to a ListView.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget extentList(String title, ScrollCacheExtent extent) {
  return Expanded(
    child: Column(
      children: [
        Text('$title: ${extent.style.name} ${extent.value}'),
        Expanded(
          child: ListView.builder(
            scrollCacheExtent: extent,
            itemCount: 40,
            itemBuilder: (context, index) =>
                ListTile(dense: true, title: Text('$title item $index')),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== ScrollCacheExtent ===');
  const pixels = ScrollCacheExtent.pixels(250.0);
  const viewport = ScrollCacheExtent.viewport(0.5);
  print('pixels: style=${pixels.style}, value=${pixels.value}');
  print('viewport: style=${viewport.style}, value=${viewport.value}');
  print('pixels is ScrollCacheExtent: ${pixels is ScrollCacheExtent}');
  print('styles differ: ${pixels.style != viewport.style}');
  print('CacheExtentStyle values: ${CacheExtentStyle.values}');

  return SizedBox(
    height: 500,
    child: Row(
      children: [
        extentList('pixels', pixels),
        extentList('viewport', viewport),
      ],
    ),
  );
}

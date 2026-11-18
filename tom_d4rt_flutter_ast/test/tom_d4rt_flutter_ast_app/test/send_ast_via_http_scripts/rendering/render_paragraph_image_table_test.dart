// ignore_for_file: avoid_print
// D4rt test script: RenderParagraph, RenderImage, RenderTable
// (rendering, addtests1).
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

RenderBox _box(double w, double h) => RenderConstrainedBox(
  additionalConstraints: BoxConstraints.tightFor(width: w, height: h),
);

dynamic build(BuildContext context) {
  print('=== RenderParagraph ===');
  final paragraph = RenderParagraph(
    const TextSpan(text: 'hello world', style: TextStyle(fontSize: 10)),
    textDirection: TextDirection.ltr,
  );
  print('paragraph text: ${paragraph.text.toPlainText()}');
  print('paragraph has width: ${paragraph.getMaxIntrinsicWidth(1000) > 0}');
  paragraph.maxLines = 1;
  print('paragraph maxLines: ${paragraph.maxLines}');

  print('=== RenderImage ===');
  final image = RenderImage(width: 64, height: 32, fit: BoxFit.cover);
  print('image size: ${image.width} x ${image.height} ${image.fit}');
  print('image has image: ${image.image != null}');
  final dry = image.getDryLayout(
    const BoxConstraints(maxWidth: 300, maxHeight: 300),
  );
  print('image dry size: ${dry.width} x ${dry.height}');

  print('=== RenderTable ===');
  final table = RenderTable(
    textDirection: TextDirection.ltr,
    children: [
      [_box(10, 10), _box(20, 10)],
      [_box(10, 15), _box(20, 15)],
    ],
  );
  print('table: ${table.rows} rows, ${table.columns} columns');
  table.defaultColumnWidth = const FixedColumnWidth(30);
  print('table min width: ${table.getMinIntrinsicWidth(100)}');
  return const Center(child: Text('paragraph / image / table'));
}

// ignore_for_file: avoid_print, unnecessary_type_check
// D4rt test script: ShapedInputBorder (material, Flutter 3.47).
//
// ShapedInputBorder draws an InputDecorator's outline in any ShapeBorder. The
// script builds it with a stadium and a beveled shape, reads `isOutline`,
// `gapPadding`, `borderSide` and `shape`, uses `copyWith`, and decorates
// three text fields with it.
import 'package:flutter/material.dart';

Widget field(String label, InputBorder border) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: TextField(
      decoration: InputDecoration(labelText: label, border: border),
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== ShapedInputBorder ===');
  const stadium = ShapedInputBorder(shape: StadiumBorder());
  final beveled = ShapedInputBorder(
    borderSide: const BorderSide(color: Colors.indigo, width: 2),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
    gapPadding: 6,
  );
  print('stadium isOutline: ${stadium.isOutline}');
  print('stadium gapPadding: ${stadium.gapPadding}');
  print('stadium shape: ${stadium.shape.runtimeType}');
  print('beveled borderSide width: ${beveled.borderSide.width}');
  print('beveled gapPadding: ${beveled.gapPadding}');
  final thicker = beveled.copyWith(
    borderSide: const BorderSide(color: Colors.teal, width: 3),
  );
  print('copyWith width: ${thicker.borderSide.width}');
  print('copyWith keeps gapPadding: ${thicker.gapPadding}');
  final reshaped = stadium.copyWith(shape: const CircleBorder());
  print('copyWith shape: ${reshaped.shape.runtimeType}');
  print('is InputBorder: ${stadium is InputBorder}');

  return SingleChildScrollView(
    child: Column(
      children: [
        field('Stadium', stadium),
        field('Beveled', beveled),
        field('Beveled, copyWith', thicker),
      ],
    ),
  );
}

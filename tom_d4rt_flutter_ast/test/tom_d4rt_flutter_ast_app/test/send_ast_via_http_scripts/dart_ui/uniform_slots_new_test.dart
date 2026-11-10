// ignore_for_file: avoid_print, unnecessary_nullable_for_final_variable_declarations
// D4rt test script: UniformType, UniformArray, UniformMat2Slot and
// UniformMat3Slot (dart:ui, Flutter 3.47).
//
// These classes are handed out by a FragmentShader for the uniforms of a
// compiled shader (`shader.getUniformMat2('u_m')`, ...); none has a public
// constructor, and the companion app bundles no shader asset. The script
// therefore uses them as types: in parameter and variable annotations, in
// generic type arguments and in `is` checks, which resolves each name
// through the bridges without a shader instance.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

String describeMat2(ui.UniformMat2Slot? slot) =>
    slot == null ? 'no mat2 slot' : 'mat2 slot';

String describeMat3(ui.UniformMat3Slot? slot) =>
    slot == null ? 'no mat3 slot' : 'mat3 slot';

String describeArray(ui.UniformArray<ui.UniformType>? array) =>
    array == null ? 'no uniform array' : 'array of ${array.length}';

dynamic build(BuildContext context) {
  print('=== Uniform types ===');
  ui.UniformMat2Slot? mat2;
  ui.UniformMat3Slot? mat3;
  ui.UniformArray<ui.UniformType>? array;
  final Object? notAUniform = 'u_color';
  print(describeMat2(mat2));
  print(describeMat3(mat3));
  print(describeArray(array));
  print('string is UniformType: ${notAUniform is ui.UniformType}');
  print('string is UniformMat2Slot: ${notAUniform is ui.UniformMat2Slot}');
  print('null is UniformArray: ${array is ui.UniformArray}');
  final slots = <ui.UniformType>[];
  print('empty List<UniformType>: ${slots.length}');

  const lines = [
    'UniformType - sealed base of every uniform handle',
    'UniformMat2Slot.set(4 floats) - a mat2 uniform',
    'UniformMat3Slot.set(9 floats) - a mat3 uniform',
    'UniformArray<T>[i], length - an array uniform',
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          'Shader uniform handles',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      for (final line in lines)
        ListTile(
          dense: true,
          leading: const Icon(Icons.grid_on),
          title: Text(line),
        ),
      Text(
        '${describeMat2(mat2)}, ${describeMat3(mat3)}, ${describeArray(array)}',
      ),
    ],
  );
}

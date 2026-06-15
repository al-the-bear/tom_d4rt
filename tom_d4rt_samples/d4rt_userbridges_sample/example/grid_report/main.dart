// grid_report — composite and generic index operators via user bridges.
//
// `grid[[r, c]]` passes a List<int> index, and `box[i]` is a generic container;
// both are shapes the generator can't bridge, so GridUserBridge and
// BoxUserBridge supply the operators. The plain members (`sum`, `fill`, `size`,
// `isEmpty`) come from the generator.

import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';

void main(List<String> args) {
  // ── Grid: composite [row, col] index operators ──────────────────
  final grid = Grid(3, 3);
  for (var r = 0; r < 3; r++) {
    for (var c = 0; c < 3; c++) {
      grid[[r, c]] = r * 3 + c; // user-bridged operator[]=
    }
  }

  print('Grid rows:');
  for (var r = 0; r < 3; r++) {
    final row = <num>[];
    for (var c = 0; c < 3; c++) {
      row.add(grid[[r, c]]); // user-bridged operator[]
    }
    print('  $row');
  }
  print('Grid sum (generated getter): ${grid.sum}');

  grid.fill(1); // generated method
  print('After fill(1), sum: ${grid.sum}');

  // ── Box<T>: generic index operators ─────────────────────────────
  final box = Box(3);
  print('');
  print('Box size (generated): ${box.size}, isEmpty (generated): ${box.isEmpty}');
  box[0] = 'first'; // user-bridged generic operator[]=
  box[2] = 'third';
  print('box[0] = ${box[0]}, box[1] = ${box[1]}, box[2] = ${box[2]}');
  print('isEmpty after writes: ${box.isEmpty}');
}

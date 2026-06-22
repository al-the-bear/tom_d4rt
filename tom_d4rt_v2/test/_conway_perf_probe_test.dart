// Diagnostic probe (not a behavioural assertion): reproduces the
// Conway's-Life R-pentomino slowdown reported in the flutter sample
// app, headless, straight through the tom_d4rt interpreter.
//
// Hypothesis: the interpreter's native Set<Cell>/Map<Cell,int> do not
// bucket on the interpreted `hashCode`, so `contains`/`[]` degrade to a
// linear scan -> O(live^2) per generation. If so, micros-per-live-cell
// grows roughly linearly with population instead of staying flat.
//
// The script times each generation with DateTime micros and returns a
// list of [gen, alive, micros]; the test prints per-10-gen rows and the
// micros/alive trend so we can read the scaling off the output.
import 'package:tom_d4rt_v2/d4rt.dart';
import 'package:test/test.dart';

void main() {
  test('conway R-pentomino per-generation timing (diagnostic)', () {
    final d4rt = D4rt();
    D4rtDiag.reset();
    final result = d4rt.execute(source: r'''
      const int kBoardW = 60;
      const int kBoardH = 40;

      class Cell {
        final int x;
        final int y;
        const Cell(this.x, this.y);
        @override
        bool operator ==(Object other) =>
            other is Cell && other.x == x && other.y == y;
        @override
        int get hashCode => x * 1000003 + y;
      }

      Set<Cell> stepLife(Set<Cell> live) {
        final neighbourCounts = <Cell, int>{};
        for (final cell in live) {
          for (var dy = -1; dy <= 1; dy++) {
            for (var dx = -1; dx <= 1; dx++) {
              if (dx == 0 && dy == 0) continue;
              final nx = cell.x + dx;
              final ny = cell.y + dy;
              if (nx < 0 || nx >= kBoardW) continue;
              if (ny < 0 || ny >= kBoardH) continue;
              final n = Cell(nx, ny);
              final prev = neighbourCounts[n] ?? 0;
              neighbourCounts[n] = prev + 1;
            }
          }
        }
        final next = <Cell>{};
        for (final cell in live) {
          final c = neighbourCounts[cell] ?? 0;
          if (c == 2 || c == 3) next.add(cell);
        }
        for (final entry in neighbourCounts.entries) {
          if (entry.value == 3 && !live.contains(entry.key)) {
            next.add(entry.key);
          }
        }
        return next;
      }

      List<List<int>> main() {
        // R-pentomino at board centre.
        final ax = kBoardW ~/ 2;
        final ay = kBoardH ~/ 2;
        var live = <Cell>{};
        final offs = <List<int>>[
          [0, -1], [1, -1],
          [-1, 0], [0, 0],
          [0, 1],
        ];
        for (final o in offs) {
          live.add(Cell(ax + o[0], ay + o[1]));
        }

        final rows = <List<int>>[];
        for (var gen = 1; gen <= 220; gen++) {
          final t0 = DateTime.now().microsecondsSinceEpoch;
          live = stepLife(live);
          final t1 = DateTime.now().microsecondsSinceEpoch;
          rows.add([gen, live.length, t1 - t0]);
        }
        return rows;
      }
    ''');

    final rows = (result as List).cast<List>();
    final gens = rows.length;
    var totalAlive = 0;
    for (final r in rows) {
      totalAlive += r[1] as int;
    }
    // ignore: avoid_print
    print('=== allocation totals over $gens generations ===');
    // ignore: avoid_print
    print('total cell-steps (sum alive)   : $totalAlive');
    // ignore: avoid_print
    print('Environment allocs             : ${D4rtDiag.envAllocs}'
        '  (~${(D4rtDiag.envAllocs / gens).round()}/gen)');
    // ignore: avoid_print
    print('closure (InterpretedFunction)  : ${D4rtDiag.closureAllocs}'
        '  (~${(D4rtDiag.closureAllocs / gens).round()}/gen)');
    // ignore: avoid_print
    print('InterpretedInstance (Cell)     : ${D4rtDiag.instanceAllocs}'
        '  (~${(D4rtDiag.instanceAllocs / gens).round()}/gen)');
    // ignore: avoid_print
    print('BridgedInstance                : ${D4rtDiag.bridgedAllocs}'
        '  (~${(D4rtDiag.bridgedAllocs / gens).round()}/gen)');
    // ignore: avoid_print
    print('gen   alive   micros   micros/alive');
    for (final r in rows) {
      final gen = r[0] as int;
      if (gen % 10 != 0) continue;
      final alive = r[1] as int;
      final micros = r[2] as int;
      final perCell = alive == 0 ? 0 : micros / alive;
      // ignore: avoid_print
      print('${gen.toString().padLeft(3)}  '
          '${alive.toString().padLeft(5)}  '
          '${micros.toString().padLeft(7)}  '
          '${perCell.toStringAsFixed(1)}');
    }
    expect(rows, isNotEmpty);
  });
}

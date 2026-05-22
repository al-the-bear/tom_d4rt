import 'dart:math';

/// Direction encoded as: 0=up, 1=right, 2=down, 3=left.
const int dirUp = 0;
const int dirRight = 1;
const int dirDown = 2;
const int dirLeft = 3;

const List<List<int>> _deltas = [
  [0, -1], // up
  [1, 0], // right
  [0, 1], // down
  [-1, 0], // left
];

int turnLeft(int d) => (d + 3) % 4;
int turnRight(int d) => (d + 1) % 4;

List<int> stepOf(int d) => _deltas[d];

enum CellOwner { empty, player, ai }

enum GameStatus { playing, playerWin, aiWin, draw }

class Bike {
  int x;
  int y;
  int dir;
  // queued direction from input — applied at next tick.
  int? pendingDir;

  Bike({required this.x, required this.y, required this.dir});

  void queueTurnLeft() {
    final base = pendingDir ?? dir;
    pendingDir = turnLeft(base);
  }

  void queueTurnRight() {
    final base = pendingDir ?? dir;
    pendingDir = turnRight(base);
  }

  void applyPending() {
    if (pendingDir != null) {
      dir = pendingDir!;
      pendingDir = null;
    }
  }
}

class TronEngine {
  final int cols;
  final int rows;
  final Random _rng;

  late List<List<CellOwner>> grid;
  late Bike player;
  late Bike ai;

  /// Trail cells as encoded ints (x * rows + y). Includes the head.
  /// Used by the painter so we don't have to scan the full grid.
  final List<int> playerTrail = [];
  final List<int> aiTrail = [];

  GameStatus status = GameStatus.playing;
  int tick = 0;

  TronEngine({this.cols = 40, this.rows = 28, int? seed})
      : _rng = Random(seed) {
    reset();
  }

  void reset() {
    grid = List.generate(
        cols, (_) => List<CellOwner>.filled(rows, CellOwner.empty));
    final py = rows ~/ 2;
    final ay = rows ~/ 2;
    player = Bike(x: 4, y: py, dir: dirRight);
    ai = Bike(x: cols - 5, y: ay, dir: dirLeft);
    grid[player.x][player.y] = CellOwner.player;
    grid[ai.x][ai.y] = CellOwner.ai;
    playerTrail.clear();
    aiTrail.clear();
    playerTrail.add(_encode(player.x, player.y));
    aiTrail.add(_encode(ai.x, ai.y));
    status = GameStatus.playing;
    tick = 0;
  }

  int _encode(int x, int y) => x * rows + y;

  bool _inBounds(int x, int y) => x >= 0 && x < cols && y >= 0 && y < rows;

  bool _isFree(int x, int y) =>
      _inBounds(x, y) && grid[x][y] == CellOwner.empty;

  /// One simulation tick. Returns updated [status].
  GameStatus step() {
    if (status != GameStatus.playing) return status;
    tick++;

    _decideAi();

    player.applyPending();
    ai.applyPending();

    final pd = stepOf(player.dir);
    final ad = stepOf(ai.dir);
    final pnx = player.x + pd[0];
    final pny = player.y + pd[1];
    final anx = ai.x + ad[0];
    final any = ai.y + ad[1];

    final playerCrash = !_isFree(pnx, pny);
    final aiCrash = !_isFree(anx, any);
    final headOn = pnx == anx && pny == any;

    if (headOn || (playerCrash && aiCrash)) {
      status = GameStatus.draw;
      return status;
    }
    if (playerCrash) {
      status = GameStatus.aiWin;
      _moveBike(ai, anx, any, CellOwner.ai, aiTrail);
      return status;
    }
    if (aiCrash) {
      status = GameStatus.playerWin;
      _moveBike(player, pnx, pny, CellOwner.player, playerTrail);
      return status;
    }

    _moveBike(player, pnx, pny, CellOwner.player, playerTrail);
    _moveBike(ai, anx, any, CellOwner.ai, aiTrail);
    return status;
  }

  void _moveBike(
      Bike b, int nx, int ny, CellOwner owner, List<int> trail) {
    b.x = nx;
    b.y = ny;
    grid[b.x][b.y] = owner;
    trail.add(_encode(b.x, b.y));
  }

  // === AI ===

  void _decideAi() {
    // Original tuning. An earlier "friendlier" pass (flood-fill horizon
    // 8, jitter 0..3, bias 1) was meant to compensate for the AI
    // winning before the player could react, but the responsiveness
    // problem was actually input starvation — once that was fixed
    // via the 250 ms tick + edge-detected polling, the AI was just
    // visibly dumb (encircling itself because 8 cells of lookahead
    // wasn't enough to see most self-traps). Restored: 20-cell
    // flood-fill horizon, straight-bias +2 so it doesn't dither, and
    // a small 0..1 jitter so it still occasionally takes the less-
    // optimal turn the player can exploit.
    final candidates = <int>[ai.dir, turnLeft(ai.dir), turnRight(ai.dir)];
    int best = ai.dir;
    int bestScore = -1;
    for (final d in candidates) {
      final s = stepOf(d);
      final nx = ai.x + s[0];
      final ny = ai.y + s[1];
      if (!_isFree(nx, ny)) continue;
      var score = _floodScore(nx, ny, 20);
      if (d == ai.dir) score += 2; // prefer straight
      score += _rng.nextInt(2);
      if (score > bestScore) {
        bestScore = score;
        best = d;
      }
    }
    if (best != ai.dir) {
      ai.pendingDir = best;
    }
  }

  int _floodScore(int sx, int sy, int limit) {
    if (!_isFree(sx, sy)) return 0;
    final visited = <int>{};
    final stack = <int>[_encode(sx, sy)];
    visited.add(stack.first);
    var count = 0;
    while (stack.isNotEmpty && count < limit) {
      final cur = stack.removeLast();
      final cx = cur ~/ rows;
      final cy = cur % rows;
      count++;
      for (final d in _deltas) {
        final nx = cx + d[0];
        final ny = cy + d[1];
        if (!_isFree(nx, ny)) continue;
        final key = _encode(nx, ny);
        if (visited.contains(key)) continue;
        visited.add(key);
        stack.add(key);
      }
    }
    return count;
  }

  // Helpers for the painter to decode trail entries.
  int xOf(int encoded) => encoded ~/ rows;
  int yOf(int encoded) => encoded % rows;
}

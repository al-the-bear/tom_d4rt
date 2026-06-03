// Plain-data record of one captured lap.

class Lap {
  /// 1-based lap number (1, 2, 3, …) for display.
  final int index;

  /// Total elapsed time at the moment the lap was captured, in ms.
  final int totalMs;

  /// Elapsed time *since the previous lap* (or since start for lap 1),
  /// in ms.
  final int splitMs;

  const Lap({
    required this.index,
    required this.totalMs,
    required this.splitMs,
  });
}

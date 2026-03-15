import 'package:flutter/material.dart';

/// Demonstrates AnimationMean - combines two animations, outputting their average.
dynamic build(BuildContext context) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(seconds: 3),
    builder: (context, t, _) {
      final a = Curves.easeIn.transform(t);
      final b = Curves.easeOut.transform(t);
      final mean = (a + b) / 2;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('AnimationMean Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          // Formula visualization
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('( ', style: TextStyle(fontSize: 20)),
                _Val(a, Colors.blue),
                const Text(' + ', style: TextStyle(fontSize: 16)),
                _Val(b, Colors.orange),
                const Text(' ) / 2 = ', style: TextStyle(fontSize: 16)),
                _Val(mean, Colors.purple),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Bar chart
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _AnimBar('A', a, Colors.blue),
              const SizedBox(width: 16),
              _AnimBar('B', b, Colors.orange),
              const SizedBox(width: 16),
              _AnimBar('Mean', mean, Colors.purple),
            ],
          ),
        ],
      );
    },
  );
}

class _Val extends StatelessWidget {
  final double v;
  final Color c;
  const _Val(this.v, this.c);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: c.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
    child: Text('${(v * 100).toInt()}', style: TextStyle(fontWeight: FontWeight.bold, color: c)),
  );
}

class _AnimBar extends StatelessWidget {
  final String l;
  final double v;
  final Color c;
  const _AnimBar(this.l, this.v, this.c);
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 30, height: 60 * v, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(4))),
      const SizedBox(height: 4),
      Text(l, style: TextStyle(fontSize: 10, color: c)),
    ],
  );
}

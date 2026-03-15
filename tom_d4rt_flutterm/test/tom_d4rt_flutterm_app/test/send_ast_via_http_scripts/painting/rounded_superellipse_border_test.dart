import 'package:flutter/material.dart';

Widget _sample(String label, RoundedSuperellipseBorder border, Color fill) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 90,
        height: 70,
        decoration: ShapeDecoration(shape: border, color: fill),
      ),
      const SizedBox(height: 6),
      Text(label),
    ],
  );
}

dynamic build(BuildContext context) {
  const base = RoundedSuperellipseBorder();
  const thick = RoundedSuperellipseBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    side: BorderSide(color: Colors.indigo, width: 3),
  );
  final scaled = thick.scale(0.6) as RoundedSuperellipseBorder;

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RoundedSuperellipseBorder Visual Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _sample('Base', base, Colors.amber.shade200),
            _sample('Thick', thick, Colors.lightBlue.shade100),
            _sample('Scaled', scaled, Colors.green.shade100),
          ],
        ),
        const SizedBox(height: 10),
        Text('Base side width: ${base.side.width}'),
        Text('Thick side width: ${thick.side.width}'),
        Text('Scaled side width: ${scaled.side.width}'),
      ],
    ),
  );
}

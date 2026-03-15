import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final items = List.generate(8, (index) => index);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimatedGridState concept demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SizedBox(
        width: 300,
        height: 180,
        child: GridView.count(
          crossAxisCount: 4,
          children: [
            for (final item in items)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.all(4),
                color: Colors.primaries[item % Colors.primaries.length].shade300,
                alignment: Alignment.center,
                child: Text('$item'),
              ),
          ],
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';

/// Deep visual demo for Colors class.
/// Shows Material color palette.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Colors')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Material Color Swatches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Swatch('Red', Colors.red),
        _Swatch('Pink', Colors.pink),
        _Swatch('Purple', Colors.purple),
        _Swatch('Deep Purple', Colors.deepPurple),
        _Swatch('Indigo', Colors.indigo),
        _Swatch('Blue', Colors.blue),
        _Swatch('Cyan', Colors.cyan),
        _Swatch('Teal', Colors.teal),
        _Swatch('Green', Colors.green),
        _Swatch('Lime', Colors.lime),
        _Swatch('Yellow', Colors.yellow),
        _Swatch('Amber', Colors.amber),
        _Swatch('Orange', Colors.orange),
        _Swatch('Deep Orange', Colors.deepOrange),
        _Swatch('Brown', Colors.brown),
        _Swatch('Grey', Colors.grey),
        _Swatch('Blue Grey', Colors.blueGrey),
      ],
    ),
  );
}

class _Swatch extends StatelessWidget {
  final String name;
  final MaterialColor color;
  const _Swatch(this.name, this.color);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(width: 100, child: Text(name, style: const TextStyle(fontSize: 12))),
        for (final shade in [100, 300, 500, 700, 900])
          Expanded(
            child: Container(
              height: 32,
              color: color[shade],
              alignment: Alignment.center,
              child: Text(shade.toString(), style: TextStyle(color: shade < 500 ? Colors.black : Colors.white, fontSize: 10)),
            ),
          ),
      ],
    ),
  );
}

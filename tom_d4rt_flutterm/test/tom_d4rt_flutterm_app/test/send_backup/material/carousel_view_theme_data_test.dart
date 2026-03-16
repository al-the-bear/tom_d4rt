import 'package:flutter/material.dart';

/// Deep visual demo for CarouselViewThemeData.
/// Shows carousel theme customization.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CarouselViewThemeData')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Carousel Theme Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Prop('backgroundColor', 'Background color'),
        _Prop('elevation', 'Shadow elevation'),
        _Prop('shape', 'Item shape'),
        _Prop('overlayColor', 'Tap overlay color'),
        const SizedBox(height: 24),
        const Text('Themed Carousel:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: CarouselView(
            itemExtent: 200,
            backgroundColor: Colors.deepPurple.shade100,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  color: Colors.deepPurple.shade300,
                  alignment: Alignment.center,
                  child: Text('Item ' + (i + 1).toString(), style: const TextStyle(color: Colors.white, fontSize: 18)),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Prop extends StatelessWidget {
  final String name, desc;
  const _Prop(this.name, this.desc);
  @override
  Widget build(BuildContext context) => ListTile(title: Text(name), subtitle: Text(desc), dense: true);
}

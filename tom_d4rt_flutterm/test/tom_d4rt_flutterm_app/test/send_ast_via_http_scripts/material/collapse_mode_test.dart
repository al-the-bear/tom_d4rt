import 'package:flutter/material.dart';

/// Deep visual demo for CollapseMode.
/// Shows SliverAppBar collapse behavior modes.
dynamic build(BuildContext context) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('CollapseMode'),
            background: Container(color: Colors.blue.shade300),
            collapseMode: CollapseMode.parallax,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CollapseMode Enum', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  _ModeItem('parallax', 'Background scrolls slower than foreground', '(default)'),
                  _ModeItem('pin', 'Background stays fixed until collapsed', ''),
                  _ModeItem('none', 'Background scrolls with content', ''),
                  SizedBox(height: 16),
                  Text('Scroll to see parallax effect', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            for (int i = 0; i < 20; i++)
              ListTile(title: Text('Item ' + (i + 1).toString())),
          ]),
        ),
      ],
    ),
  );
}

class _ModeItem extends StatelessWidget {
  final String name, desc, note;
  const _ModeItem(this.name, this.desc, this.note);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
          child: Text(name, style: const TextStyle(fontFamily: 'monospace')),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(desc)),
        if (note.isNotEmpty) Text(note, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    ),
  );
}

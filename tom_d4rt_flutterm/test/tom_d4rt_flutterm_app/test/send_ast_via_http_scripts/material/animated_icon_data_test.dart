import 'package:flutter/material.dart';

/// Deep visual demo for AnimatedIconData.
/// Shows data that defines animated icon shapes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AnimatedIconData')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Available Animated Icons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _IconDemo('menu → arrow', AnimatedIcons.menu_arrow, Colors.blue),
        _IconDemo('play → pause', AnimatedIcons.play_pause, Colors.green),
        _IconDemo('close → menu', AnimatedIcons.close_menu, Colors.orange),
        _IconDemo('home → menu', AnimatedIcons.home_menu, Colors.purple),
        _IconDemo('list → view', AnimatedIcons.list_view, Colors.teal),
        _IconDemo('add → event', AnimatedIcons.add_event, Colors.red),
        _IconDemo('search → ellipsis', AnimatedIcons.search_ellipsis, Colors.indigo),
        const SizedBox(height: 16),
        const Text('AnimatedIconData defines SVG paths for icon transitions',
          style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    ),
  );
}

class _IconDemo extends StatefulWidget {
  final String name;
  final AnimatedIconData icon;
  final Color color;
  const _IconDemo(this.name, this.icon, this.color);
  @override
  State<_IconDemo> createState() => _IconDemoState();
}

class _IconDemoState extends State<_IconDemo> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() { super.initState(); _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500)); }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => ListTile(
    leading: AnimatedIcon(icon: widget.icon, progress: _ctrl, color: widget.color, size: 32),
    title: Text(widget.name),
    trailing: IconButton(icon: const Icon(Icons.play_arrow), onPressed: () {
      if (_ctrl.isCompleted) _ctrl.reverse(); else _ctrl.forward();
    }),
  );
}

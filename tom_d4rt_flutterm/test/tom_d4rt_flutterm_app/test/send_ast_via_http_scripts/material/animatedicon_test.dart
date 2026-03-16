import 'package:flutter/material.dart';

/// Deep visual demo for AnimatedIcon.
/// Shows morphing icon animations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AnimatedIcon')),
    body: Center(child: _AnimatedIconDemo()),
  );
}

class _AnimatedIconDemo extends StatefulWidget {
  @override
  State<_AnimatedIconDemo> createState() => _AnimatedIconDemoState();
}

class _AnimatedIconDemoState extends State<_AnimatedIconDemo> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Tap the icon to animate', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {
            if (_ctrl.isCompleted) _ctrl.reverse(); else _ctrl.forward();
          },
          child: Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.blue.withAlpha(100), blurRadius: 12)],
            ),
            alignment: Alignment.center,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _ctrl,
              size: 56,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) => Text(
            'Progress: \${(_ctrl.value * 100).toInt()}%',
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Menu ↔ Close', style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}

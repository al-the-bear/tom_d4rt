import 'package:flutter/material.dart';

/// Deep visual demo for AnimatedTheme.
/// Shows smooth theme transitions.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AnimatedTheme')),
    body: Center(child: _ThemeDemo()),
  );
}

class _ThemeDemo extends StatefulWidget {
  @override
  State<_ThemeDemo> createState() => _ThemeDemoState();
}

class _ThemeDemoState extends State<_ThemeDemo> {
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      duration: const Duration(milliseconds: 500),
      child: Builder(builder: (ctx) => Container(
        width: 300,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(ctx).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(ctx).dividerColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.palette, size: 48, color: Theme.of(ctx).primaryColor),
            const SizedBox(height: 16),
            Text('AnimatedTheme Demo', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Smooth 500ms transition', style: Theme.of(ctx).textTheme.bodySmall),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _isDark = !_isDark),
              child: Text(_isDark ? 'Go Light' : 'Go Dark'),
            ),
          ],
        ),
      )),
    );
  }
}

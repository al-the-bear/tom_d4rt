import 'package:flutter/material.dart';

/// Deep visual demo for BottomNavigationBarTheme.
/// Shows bottom nav bar inherited theme widget.
dynamic build(BuildContext context) {
  return BottomNavigationBarTheme(
    data: BottomNavigationBarThemeData(
      backgroundColor: Colors.indigo,
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
    ),
    child: _ThemedNavDemo(),
  );
}

class _ThemedNavDemo extends StatefulWidget {
  @override
  State<_ThemedNavDemo> createState() => _ThemedNavDemoState();
}

class _ThemedNavDemoState extends State<_ThemedNavDemo> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomNavigationBarTheme')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.palette, size: 64, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text('Theme applied via BottomNavigationBarTheme widget'),
            const SizedBox(height: 8),
            Text('Current index: ' + _index.toString()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

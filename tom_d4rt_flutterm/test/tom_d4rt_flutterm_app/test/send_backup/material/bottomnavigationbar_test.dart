import 'package:flutter/material.dart';

/// Deep visual demo for BottomNavigationBar.
/// Shows complete bottom navigation implementation.
dynamic build(BuildContext context) {
  return _BottomNavDemo();
}

class _BottomNavDemo extends StatefulWidget {
  @override
  State<_BottomNavDemo> createState() => _BottomNavDemoState();
}

class _BottomNavDemoState extends State<_BottomNavDemo> {
  int _index = 0;
  final _titles = ['Home', 'Favorites', 'Search', 'Profile'];
  final _icons = [Icons.home, Icons.favorite, Icons.search, Icons.person];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_index])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_icons[_index], size: 80, color: Colors.blue),
            const SizedBox(height: 16),
            Text(_titles[_index], style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: [
          for (int i = 0; i < 4; i++)
            BottomNavigationBarItem(icon: Icon(_icons[i]), label: _titles[i]),
        ],
      ),
    );
  }
}

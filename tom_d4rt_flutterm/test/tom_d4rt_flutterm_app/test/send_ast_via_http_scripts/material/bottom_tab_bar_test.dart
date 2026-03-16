import 'package:flutter/material.dart';

/// Deep visual demo for BottomNavigationBar.
/// Shows bottom tab navigation pattern.
dynamic build(BuildContext context) {
  return _BottomTabDemo();
}

class _BottomTabDemo extends StatefulWidget {
  @override
  State<_BottomTabDemo> createState() => _BottomTabDemoState();
}

class _BottomTabDemoState extends State<_BottomTabDemo> {
  int _index = 0;
  final _pages = [
    const Center(child: Text('Home', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Search', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomNavigationBar')),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

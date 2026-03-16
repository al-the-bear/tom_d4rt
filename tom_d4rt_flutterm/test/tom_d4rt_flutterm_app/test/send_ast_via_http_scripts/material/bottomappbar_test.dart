import 'package:flutter/material.dart';

/// Deep visual demo for BottomAppBar.
/// Shows bottom app bar with FAB notch.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BottomAppBar')),
    body: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dock, size: 64, color: Colors.blue),
          SizedBox(height: 16),
          Text('BottomAppBar with FAB notch'),
          SizedBox(height: 8),
          Text('Use CircularNotchedRectangle shape', style: TextStyle(color: Colors.grey)),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () {}),
          const SizedBox(width: 48),
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
        ],
      ),
    ),
  );
}

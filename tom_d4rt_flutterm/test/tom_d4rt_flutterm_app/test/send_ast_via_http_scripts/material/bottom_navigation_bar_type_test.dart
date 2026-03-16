import 'package:flutter/material.dart';

/// Deep visual demo for BottomNavigationBarType.
/// Shows fixed vs shifting navigation types.
dynamic build(BuildContext context) {
  return _TypeDemo();
}

class _TypeDemo extends StatefulWidget {
  @override
  State<_TypeDemo> createState() => _TypeDemoState();
}

class _TypeDemoState extends State<_TypeDemo> {
  int _index = 0;
  bool _isFixed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BottomNavigationBarType')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isFixed ? 'FIXED' : 'SHIFTING', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(_isFixed ? 'All labels always visible' : 'Only selected label visible'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => setState(() => _isFixed = !_isFixed),
              child: Text('Switch to ' + (_isFixed ? 'Shifting' : 'Fixed')),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: _isFixed ? BottomNavigationBarType.fixed : BottomNavigationBarType.shifting,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

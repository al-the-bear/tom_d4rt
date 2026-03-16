import 'package:flutter/material.dart';

/// Deep visual demo for BottomSheet.
/// Shows bottom sheet variations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BottomSheet')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_upward),
            label: const Text('Modal Bottom Sheet'),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => Container(
                height: 250,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 24),
                    const Text('Modal Bottom Sheet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    const Text('Tap outside or swipe down to dismiss'),
                    const SizedBox(height: 24),
                    ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.drag_handle),
            label: const Text('Draggable Sheet'),
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => DraggableScrollableSheet(
                initialChildSize: 0.5,
                maxChildSize: 0.9,
                minChildSize: 0.25,
                expand: false,
                builder: (_, ctrl) => ListView.builder(
                  controller: ctrl,
                  itemCount: 25,
                  itemBuilder: (_, i) => ListTile(title: Text('Item ' + (i + 1).toString())),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

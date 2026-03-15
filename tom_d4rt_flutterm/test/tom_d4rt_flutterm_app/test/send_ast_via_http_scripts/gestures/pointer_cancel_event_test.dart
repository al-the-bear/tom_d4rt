import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerCancelEvent.
/// Shows when a pointer interaction is cancelled.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerCancelEvent')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pointer Cancel Event',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red)),
            child: Row(children: [
              const Icon(Icons.cancel, size: 48, color: Colors.red),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Interaction Cancelled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    const Text('System interrupted the gesture', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          const Text('Common Cancel Causes:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _CancelReason(reason: 'System gesture (swipe to home)'),
          _CancelReason(reason: 'Another window captured focus'),
          _CancelReason(reason: 'Widget was disposed'),
          _CancelReason(reason: 'Too many simultaneous touches'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(children: [
              Icon(Icons.warning, color: Colors.amber),
              SizedBox(width: 8),
              Expanded(child: Text('Always handle cancellation to properly clean up gesture state.')),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _CancelReason extends StatelessWidget {
  final String reason;
  const _CancelReason({required this.reason});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        const Icon(Icons.close, color: Colors.red, size: 16),
        const SizedBox(width: 8),
        Text(reason, style: const TextStyle(fontSize: 13)),
      ]),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ChannelBuffers - platform message buffering.
/// Demonstrates how messages are buffered before handler registration.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ChannelBuffers Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ChannelBuffers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Buffers platform channel messages until handlers are registered', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildFlowDiagram(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('• resize(channel, size) - Set buffer size'),
                Text('• allowOverflow(channel, bool) - Allow overflow'),
                Text('• push(channel, data, callback) - Queue message'),
                Text('• setListener(channel, handler) - Register handler'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFlowDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        _buildStep('1', 'Platform sends message', Icons.phone_android, Colors.green),
        _buildArrow(),
        _buildStep('2', 'Message stored in buffer', Icons.storage, Colors.orange),
        _buildArrow(),
        _buildStep('3', 'Handler registered', Icons.settings, Colors.blue),
        _buildArrow(),
        _buildStep('4', 'Buffered messages delivered', Icons.send, Colors.purple),
      ],
    ),
  );
}

Widget _buildStep(String num, String label, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(child: Text(num, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      const SizedBox(width: 12),
      Icon(icon, color: color),
      const SizedBox(width: 8),
      Text(label),
    ],
  );
}

Widget _buildArrow() {
  return Container(
    margin: const EdgeInsets.only(left: 15),
    height: 20,
    width: 2,
    color: Colors.grey.shade400,
  );
}

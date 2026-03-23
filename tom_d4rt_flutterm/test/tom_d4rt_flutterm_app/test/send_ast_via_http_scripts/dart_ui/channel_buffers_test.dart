// ignore_for_file: avoid_print
// D4rt test script: Tests ChannelBuffers from dart:ui
// ChannelBuffers manages message queuing for platform channels
// Used internally by Flutter's platform channel system
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ChannelBuffers Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Static Constants
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Creating ChannelBuffers Instance
  // ═══════════════════════════════════════════════════════════════════════════
  final buffers = ui.ChannelBuffers();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: resize() Method
  // ═══════════════════════════════════════════════════════════════════════════
  buffers.resize('test_channel', 100);
  buffers.resize('navigation_channel', 50);
  buffers.resize('event_channel', 1000);

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: allowOverflow() Method
  // ═══════════════════════════════════════════════════════════════════════════
  buffers.allowOverflow('test_channel', true);
  buffers.allowOverflow('test_channel', false);

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Buffer Lifecycle
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Platform Channel Integration
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Control Channel
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Memory Considerations
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Common Channel Names
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Configuring Buffers for Plugins
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Debugging Channel Issues
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Testing with ChannelBuffers
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Production Recommendations
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════

  // Return visual UI
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.cyan.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.storage, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ChannelBuffers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Platform Channel Message Queue',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // Constants display
        Text(
          'Static Constants',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ConstantCard(
                name: 'kDefaultBufferSize',
                value: '${ui.ChannelBuffers.kDefaultBufferSize}',
                description: 'Default messages per channel',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _ConstantCard(
                name: 'kControlChannelName',
                value: '"${ui.ChannelBuffers.kControlChannelName}"',
                description: 'Control channel for runtime config',
                color: Colors.purple,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),

        // Methods display
        Text(
          'Methods',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MethodCard(
                icon: Icons.photo_size_select_small,
                name: 'resize',
                signature: '(String name, int size)',
                description: 'Set buffer capacity for a channel',
                color: Colors.green,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MethodCard(
                icon: Icons.waves,
                name: 'allowOverflow',
                signature: '(String name, bool allowed)',
                description: 'Control behavior when buffer full',
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),

        // Message flow diagram
        Text(
          'Message Flow',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _FlowBox(label: 'Native', color: Colors.grey),
                  Icon(Icons.arrow_forward, color: Colors.grey),
                  _FlowBox(
                    label: 'ChannelBuffers',
                    color: Colors.cyan,
                    isHighlight: true,
                  ),
                  Icon(Icons.arrow_forward, color: Colors.grey),
                  _FlowBox(label: 'Handler', color: Colors.green),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Messages queue in ChannelBuffers until handler is registered',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.cyan.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Prevents message loss during startup • Per-channel configuration • Part of PlatformDispatcher',
                  style: TextStyle(fontSize: 12, color: Colors.cyan.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget for constant cards
class _ConstantCard extends StatelessWidget {
  final String name;
  final String value;
  final String description;
  final MaterialColor color;

  const _ConstantCard({
    required this.name,
    required this.value,
    required this.description,
    required this.color, // MaterialColor for shade access
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: color.shade700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 10, color: color.shade600),
          ),
        ],
      ),
    );
  }
}

// Helper widget for method cards
class _MethodCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String signature;
  final String description;
  final MaterialColor color;

  const _MethodCard({
    required this.icon,
    required this.name,
    required this.signature,
    required this.description,
    required this.color, // MaterialColor for shade access
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade300),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 24),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            signature,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: color.shade500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 10, color: color.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Helper widget for flow diagram boxes
class _FlowBox extends StatelessWidget {
  final String label;
  final MaterialColor color;
  final bool isHighlight;

  const _FlowBox({
    required this.label,
    required this.color, // MaterialColor for shade access
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlight ? color.shade200 : color.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.shade400, width: isHighlight ? 2 : 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
          color: color.shade700,
        ),
      ),
    );
  }
}

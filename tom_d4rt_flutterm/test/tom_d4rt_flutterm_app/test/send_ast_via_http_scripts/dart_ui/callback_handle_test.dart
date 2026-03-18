// D4rt test script: Tests CallbackHandle from dart:ui
// CallbackHandle enables passing Dart callbacks to native code/isolates
// Used for background processing, plugins, and platform channel callbacks
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // Demo variables for visual display
  final h1 = ui.CallbackHandle.fromRawHandle(12345);
  final h2 = ui.CallbackHandle.fromRawHandle(12345);
  final h3 = ui.CallbackHandle.fromRawHandle(67890);

  // Return visual UI
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
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
            color: Colors.deepPurple.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.sync_alt, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CallbackHandle',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Native-to-Dart Callback Registration',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // Methods display
        Text(
          'API Surface',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MethodCard(
                name: 'fromRawHandle',
                signature: 'factory (int raw)',
                description: 'Create from integer',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _MethodCard(
                name: 'toRawHandle',
                signature: 'int ()',
                description: 'Get integer value',
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 24),

        // Demo output
        Text(
          'Live Demo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CodeLine('final h1 = CallbackHandle.fromRawHandle(12345);'),
              _CodeLine('final h2 = CallbackHandle.fromRawHandle(12345);'),
              _CodeLine('final h3 = CallbackHandle.fromRawHandle(67890);'),
              SizedBox(height: 8),
              _ResultLine('h1.toRawHandle(): ${h1.toRawHandle()}'),
              _ResultLine('h1 == h2: ${h1 == h2}'),
              _ResultLine('h1 == h3: ${h1 == h3}'),
              _ResultLine(
                'h1.hashCode == h2.hashCode: ${h1.hashCode == h2.hashCode}',
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // Requirements
        Text(
          'Requirements for Callbacks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _RequirementCard(
                icon: Icons.check_circle,
                title: 'Top-level/Static',
                description: 'Functions must be top-level or static methods',
                isPositive: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _RequirementCard(
                icon: Icons.code,
                title: '@pragma',
                description: '@pragma("vm:entry-point") for release builds',
                isPositive: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _RequirementCard(
                icon: Icons.cancel,
                title: 'No Closures',
                description: 'Instance methods and closures not supported',
                isPositive: false,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.deepPurple.shade600,
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Used by plugins like workmanager, firebase_messaging • Essential for background processing • Works with PluginUtilities',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget for method cards
class _MethodCard extends StatelessWidget {
  final String name;
  final String signature;
  final String description;
  final MaterialColor color;

  const _MethodCard({
    required this.name,
    required this.signature,
    required this.description,
    required this.color,
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
              color: color.shade700,
            ),
          ),
          Text(
            signature,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: color.shade500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 11, color: color.shade600),
          ),
        ],
      ),
    );
  }
}

// Helper widget for code lines
class _CodeLine extends StatelessWidget {
  final String code;
  const _CodeLine(this.code);

  @override
  Widget build(BuildContext context) {
    return Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Colors.lightBlue.shade300,
      ),
    );
  }
}

// Helper widget for result lines
class _ResultLine extends StatelessWidget {
  final String result;
  const _ResultLine(this.result);

  @override
  Widget build(BuildContext context) {
    return Text(
      '// $result',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Colors.green.shade400,
      ),
    );
  }
}

// Helper widget for requirement cards
class _RequirementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isPositive;

  const _RequirementCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? Colors.green : Colors.red;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 20),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 9, color: color.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

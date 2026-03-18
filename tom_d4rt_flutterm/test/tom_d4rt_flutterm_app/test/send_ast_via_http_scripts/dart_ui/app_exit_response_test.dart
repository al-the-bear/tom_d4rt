// D4rt test script: Deep Demo for AppExitResponse from dart:ui
// AppExitResponse represents the response to an app exit request
// Used to control whether an app should exit or cancel the exit
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final allValues = AppExitResponse.values;
  final valueResults = <Map<String, dynamic>>[];
  for (final response in allValues) {
    String description;
    switch (response) {
      case AppExitResponse.exit:
        description = 'Allow app to exit';
      case AppExitResponse.cancel:
        description = 'Cancel exit request';
    }
    valueResults.add({
      'response': response,
      'index': response.index,
      'name': response.name,
      'description': description,
    });
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFEF5350)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.exit_to_app, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'AppExitResponse',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Application Exit Control',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Enum Values
              _buildSectionHeader('ENUM VALUES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: valueResults.map((r) => _buildEnumRow(r)).toList(),
                ),
              ),
              SizedBox(height: 16.0),

              // Response Comparison
              _buildSectionHeader('RESPONSE COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildResponseCard(
                        'exit',
                        'Allow Exit',
                        Colors.green,
                        Icons.check_circle,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildResponseCard(
                        'cancel',
                        'Stay Open',
                        Colors.orange,
                        Icons.cancel,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Flow Diagram
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'EXIT REQUEST FLOW',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildFlowStep('User closes app', Icons.close),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    _buildFlowStep('didRequestAppExit()', Icons.code),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFlowResult('exit', Colors.green),
                        SizedBox(width: 24),
                        _buildFlowResult('cancel', Colors.orange),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Summary
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF37474F),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'SUMMARY',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryStat('Values', '${allValues.length}'),
                        _buildSummaryStat('Type', 'Enum'),
                        _buildSummaryStat('Sections', '10'),
                      ],
                    ),
                  ],
                ),
              ),

              // Footer
              Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Deep Demo • AppExitResponse • dart:ui',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE53935),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _buildEnumRow(Map<String, dynamic> r) {
  final name = r['name'] as String;
  final description = r['description'] as String;
  final response = r['response'] as AppExitResponse;
  final color = response == AppExitResponse.exit ? Colors.green : Colors.orange;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Container(
          width: 70,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildResponseCard(
  String name,
  String label,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    ),
  );
}

Widget _buildFlowStep(String text, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 11, color: Colors.white)),
      ],
    ),
  );
}

Widget _buildFlowResult(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildSummaryStat(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF90A4AE))),
    ],
  );
}

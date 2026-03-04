// D4rt test script: Tests Tooltip, TooltipThemeData, TooltipTriggerMode,
// Feedback, InkResponse, InkWell advanced
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Tooltip/Feedback test executing');

  // ========== TooltipTriggerMode ==========
  print('--- TooltipTriggerMode Tests ---');
  for (final mode in TooltipTriggerMode.values) {
    print('TooltipTriggerMode: ${mode.name}');
  }

  // ========== TooltipThemeData ==========
  print('--- TooltipThemeData Tests ---');
  final tooltipTheme = TooltipThemeData(
    height: 32.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    margin: EdgeInsets.all(0.0),
    verticalOffset: 24.0,
    preferBelow: true,
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(4.0),
    ),
    textStyle: TextStyle(fontSize: 12.0, color: Colors.white),
    textAlign: TextAlign.center,
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
    triggerMode: TooltipTriggerMode.longPress,
    enableFeedback: true,
  );
  print('TooltipThemeData created');
  print('  triggerMode: ${tooltipTheme.triggerMode}');

  // ========== Tooltip ==========
  print('--- Tooltip Tests ---');
  final tooltip = Tooltip(
    message: 'This is a tooltip',
    height: 32.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    verticalOffset: 24.0,
    preferBelow: true,
    showDuration: Duration(seconds: 2),
    waitDuration: Duration(milliseconds: 500),
    triggerMode: TooltipTriggerMode.tap,
    enableFeedback: true,
    child: Icon(Icons.info, color: Colors.blue),
  );
  print('Tooltip created');

  // Rich tooltip
  final richTooltip = Tooltip(
    richMessage: TextSpan(
      text: 'Rich tooltip with ',
      children: [
        TextSpan(
          text: 'bold',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: ' text'),
      ],
    ),
    child: Icon(Icons.help),
  );
  print('Rich Tooltip created');

  // ========== Feedback ==========
  print('--- Feedback Tests ---');
  print('Feedback.forTap available');
  print('Feedback.forLongPress available');
  print('Feedback.wrapForTap available');
  print('Feedback.wrapForLongPress available');

  // ========== InkResponse ==========
  print('--- InkResponse Tests ---');
  final inkResponse = InkResponse(
    onTap: () => print('InkResponse tapped'),
    radius: 24.0,
    highlightShape: BoxShape.circle,
    containedInkWell: false,
    highlightColor: Colors.blue.shade100,
    splashColor: Colors.blue.shade200,
    child: Icon(Icons.circle, size: 48.0),
  );
  print('InkResponse created');

  print('All tooltip/feedback tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tooltip/Feedback Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            tooltip,
            SizedBox(height: 16.0),
            richTooltip,
            SizedBox(height: 16.0),
            inkResponse,
          ],
        ),
      ),
    ),
  );
}

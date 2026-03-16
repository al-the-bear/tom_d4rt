// D4rt test script: compile-safe visual probe
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const scriptName = 'material/tabs_test.dart';

  print('$scriptName executing');

  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF334155), width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  FlutterLogo(size: 18),
                  SizedBox(width: 10),
                  Text(
                    'D4rt Compile-Safe Probe',
                    style: TextStyle(color: Color(0xFFE2E8F0), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text('This script is intentionally compile-safe.', style: TextStyle(color: Color(0xFFCBD5E1))),
              SizedBox(height: 6),
              Text('Used to unblock analyzer compile errors.', style: TextStyle(color: Color(0xFF94A3B8))),
              SizedBox(height: 12),
              ColoredBox(
                color: Color(0xFF1E293B),
                child: SizedBox(
                  height: 42,
                  width: double.infinity,
                  child: Center(
                    child: Text('Visible UI output', style: TextStyle(color: Color(0xFF93C5FD))),
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

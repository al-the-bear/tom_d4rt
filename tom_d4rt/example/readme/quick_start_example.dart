// Example: Quick Start
// From: README.md - Quick Start
//
// Minimal example demonstrating basic D4rt usage.

import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Execute a script with a main function
  d4rt.execute(
    source: '''
      void main() {
        print("Hello from D4rt!");
      }
    ''',
  );
}

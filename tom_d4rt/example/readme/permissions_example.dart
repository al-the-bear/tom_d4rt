// Example: Security and Permissions
// From: README.md - Security and Permissions
//
// Demonstrates the permission system for sandboxed execution.

import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Grant filesystem access
  d4rt.grant(FilesystemPermission.any);

  // Grant network access to specific host
  d4rt.grant(NetworkPermission.connectTo('api.example.com'));

  // Grant process execution
  d4rt.grant(ProcessRunPermission.any);

  // Check what permissions are granted
  print('Filesystem access: ${d4rt.hasPermission(FilesystemPermission.any)}');
  print('Network access: ${d4rt.hasPermission(NetworkPermission.any)}');
  print('Process execution: ${d4rt.hasPermission(ProcessRunPermission.any)}');

  // Execute a script that uses permissions
  d4rt.execute(
    source: '''
      void main() {
        print("Running with permissions granted");
      }
    ''',
  );
}

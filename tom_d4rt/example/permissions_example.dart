// Example: Security and Permissions
// From: doc/d4rt_user_guide.md - Security and Permissions
//
// D4rt is a sandboxed environment. Scripts cannot access the filesystem,
// network, or other system resources without explicit permission grants.

import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // By default, scripts run in a sandbox with no external access
  print('=== Permission System ===');

  // Grant filesystem access
  d4rt.grant(FilesystemPermission.any); // All operations
  // Or more restricted:
  // d4rt.grant(FilesystemPermission.read); // Read only
  // d4rt.grant(FilesystemPermission.write('/tmp')); // Write to specific path

  // Grant network access
  d4rt.grant(NetworkPermission.any); // All hosts
  // Or more restricted:
  // d4rt.grant(NetworkPermission.connect('api.example.com')); // Specific host

  // Grant process execution
  d4rt.grant(ProcessRunPermission.any);

  // Grant isolate operations
  d4rt.grant(IsolatePermission.any);

  // Check permissions
  if (d4rt.hasPermission(FilesystemPermission.any)) {
    print('Filesystem access: granted');
  }

  if (d4rt.hasPermission(NetworkPermission.any)) {
    print('Network access: granted');
  }

  // Revoke permissions
  d4rt.revoke(NetworkPermission.any);

  if (!d4rt.hasPermission(NetworkPermission.any)) {
    print('Network access: revoked');
  }

  // Now scripts can use dart:io for file operations
  print('\n=== Using dart:io ===');
  d4rt.execute(
    source: '''
      import 'dart:io';
      
      void main() {
        // With FilesystemPermission.any, scripts can access the filesystem
        print('Current directory would be: ' + Directory.current.path);
      }
    ''',
  );
}

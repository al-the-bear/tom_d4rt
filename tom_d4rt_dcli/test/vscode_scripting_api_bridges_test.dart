// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// VS Code Scripting API Bridges Tests
///
/// Integration tests for bridged VS Code scripting API classes.
/// These tests require a running VS Code instance with the Tom CLI Integration
/// extension active. Tests will skip gracefully if the bridge is not available.
library;

import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
// Import VS Code scripting API and its bridge directly
import 'package:tom_d4rt_dcli/src/bridges/tom_vscode_scripting_api_bridges.b.dart';
import 'package:tom_d4rt_dcli/src/bridges/cli_api_bridges.b.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';
import 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart';

// =============================================================================
// Test Infrastructure
// =============================================================================

/// Output capture for testing.
class OutputCapture {
  final List<String> stdout = [];
  String get stdoutText => stdout.join();
  void clear() => stdout.clear();
}

/// Run with output capture.
Future<T> withCapture<T>(OutputCapture capture, Future<T> Function() fn) async {
  return runZoned(
    fn,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        capture.stdout.add('$line\n');
      },
    ),
  );
}

/// Check if VS Code bridge is available
Future<bool> isVSCodeBridgeAvailable() async {
  return VSCodeBridgeClient.isAvailable();
}

/// Helper to create a test controller with VS Code bridge initialized.
class VSCodeTestContext {
  late D4rt d4rt;
  late CliState state;
  late D4rtCliController controller;
  late Directory tempDir;
  late VSCodeBridgeClient bridgeClient;
  late VSCode vscode;
  final OutputCapture output = OutputCapture();
  bool _bridgeAvailable = false;

  bool get bridgeAvailable => _bridgeAvailable;

  Future<bool> setUp() async {
    tempDir = Directory.systemTemp.createTempSync('vscode_api_test_');
    d4rt = D4rt();
    d4rt.grant(FilesystemPermission.any);
    d4rt.grant(NetworkPermission.any);
    d4rt.grant(ProcessRunPermission.any);
    
    // Register individual bridges (avoiding dcli bridges which have issues)
    CliApiBridge.registerBridges(d4rt, 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart');
    TomVscodeScriptingApiBridge.registerBridges(d4rt, 'package:tom_vscode_scripting_api/script_globals.dart');

    state = CliState(
      dataDirectory: tempDir.path,
      initialDirectory: tempDir.path,
    );

    controller = D4rtCliController(
      d4rt: d4rt,
      state: state,
      toolName: 'VSCodeTest',
    );

    // Try to connect to VS Code bridge
    bridgeClient = VSCodeBridgeClient();
    _bridgeAvailable = await bridgeClient.connect();
    
    if (_bridgeAvailable) {
      final adapter = VSCodeBridgeAdapter(bridgeClient);
      VSCode.initialize(adapter);
      vscode = VSCode.instance;
    }

    return _bridgeAvailable;
  }

  Future<void> tearDown() async {
    if (_bridgeAvailable) {
      await bridgeClient.disconnect();
    }
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  /// Execute code with VS Code scripting imports and capture output.
  Future<ExecuteResult> exec(String code) async {
    output.clear();
    return withCapture(output, () => controller.execute('''
import 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart';

$code
'''));
  }
}

void main() {
  group('VS Code Scripting API - Bridge Availability', () {
    test('VSCodeBridgeClient.isAvailable returns bool', () async {
      final available = await VSCodeBridgeClient.isAvailable();
      expect(available, isA<bool>());
      print('VS Code bridge available: $available');
    });

    test('VSCodeBridgeClient can connect when available', () async {
      final client = VSCodeBridgeClient();
      final connected = await client.connect();
      
      if (connected) {
        expect(client.isConnected, true);
        await client.disconnect();
        expect(client.isConnected, false);
      } else {
        print('Skipping: VS Code bridge not available');
      }
    });
  });

  group('VS Code Scripting API - VSCode Class', () {
    late VSCodeTestContext ctx;
    
    setUp(() async {
      ctx = VSCodeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('VSCode.isInitialized returns correct state', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }
      
      expect(VSCode.isInitialized, true);
    });

    test('VSCode.getVersion returns version string', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      final version = await ctx.vscode.getVersion();
      expect(version, isA<String>());
      expect(version, isNotEmpty);
      print('VS Code version: $version');
    });

    test('VSCode.getEnv returns environment info', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      final env = await ctx.vscode.getEnv();
      expect(env, isA<Map<String, dynamic>>());
      expect(env.containsKey('appName'), true);
      print('VS Code app name: ${env['appName']}');
    });
  });

  group('VS Code Scripting API - VSCodeWorkspace', () {
    late VSCodeTestContext ctx;
    
    setUp(() async {
      ctx = VSCodeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('getWorkspaceFolders returns list', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      final folders = await ctx.vscode.workspace.getWorkspaceFolders();
      expect(folders, isA<List<WorkspaceFolder>>());
      
      if (folders.isNotEmpty) {
        print('Workspace folders:');
        for (final folder in folders) {
          print('  - ${folder.name}: ${folder.uri.fsPath}');
        }
      }
    });

    test('getConfiguration returns configuration', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      final config = await ctx.vscode.workspace.getConfiguration('editor');
      expect(config, isA<Map<String, dynamic>>());
      print('Editor config keys: ${config.keys.take(5).toList()}');
    });
  });

  group('VS Code Scripting API - VSCodeWindow', () {
    late VSCodeTestContext ctx;
    
    setUp(() async {
      ctx = VSCodeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('showInformationMessage displays message', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      // This will show a message in VS Code - no return value expected
      final result = await ctx.vscode.window.showInformationMessage(
        'Hello from D4rt Bridge Test!',
      );
      
      // showInformationMessage returns null immediately (doesn't wait for user action)
      expect(result, isNull);
    });

    test('getActiveTextEditor returns editor info', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      final editor = await ctx.vscode.window.getActiveTextEditor();
      
      if (editor != null) {
        print('Active editor: ${editor.document.fileName}');
        expect(editor.document.fileName, isNotEmpty);
      } else {
        print('No active text editor');
      }
    });
  });

  group('VS Code Scripting API - VSCodeCommands', () {
    late VSCodeTestContext ctx;
    
    setUp(() async {
      ctx = VSCodeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('getCommands returns list of commands', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      final commands = await ctx.vscode.commands.getCommands();
      expect(commands, isA<List<String>>());
      expect(commands, isNotEmpty);
      print('Total commands: ${commands.length}');
      print('Sample commands: ${commands.take(5).toList()}');
    });

    test('executeCommand can run basic command', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      // Execute a safe command that doesn't require user interaction
      final result = await ctx.vscode.commands.executeCommand(
        'workbench.action.focusActiveEditorGroup',
      );
      // This command doesn't return a value, just succeeds
      expect(result, anything);
    });
  });

  group('VS Code Scripting API - VSCodeExtensions', () {
    late VSCodeTestContext ctx;
    
    setUp(() async {
      ctx = VSCodeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('getAll returns list of extensions', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      final extensions = await ctx.vscode.extensions.getAll();
      expect(extensions, isA<List<Extension>>());
      expect(extensions, isNotEmpty);
      print('Total extensions: ${extensions.length}');
      
      // Find Tom CLI Integration extension
      final tomExt = extensions.where((e) => e.id.contains('tom')).toList();
      if (tomExt.isNotEmpty) {
        print('Tom extensions: ${tomExt.map((e) => e.id).toList()}');
      }
    });

    test('getExtension returns specific extension', () async {
      if (!ctx.bridgeAvailable) {
        print('Skipping: VS Code bridge not available');
        return;
      }

      // Try to get a common extension
      final ext = await ctx.vscode.extensions.getExtension('vscode.git');
      
      if (ext != null) {
        print('Found extension: ${ext.id}');
        expect(ext.id, 'vscode.git');
      } else {
        print('Git extension not found');
      }
    });
  });

  // NOTE: D4rt Script Execution tests are skipped because they require the full
  // TomD4rtDcliBridge.register() which includes dcli bridges. The dcli bridges
  // currently have errors due to dcli package API changes.
  // Once dcli bridges are fixed, these tests should be enabled.
  group('VS Code Scripting API - D4rt Script Execution', () {
    test('can access VSCode class from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('can access VSCodeBridgeClient from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('can create VSCodeUri from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('can create WorkspaceFolder from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('can create Position and Range from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('can create Selection from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('can create QuickPickItem from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('can create InputBoxOptions from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('can create MessageOptions from script', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');
  });

  group('VS Code Scripting API - Live Bridge Commands', () {
    test('script can get VS Code version through bridge', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('script can get workspace folders through bridge', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');

    test('script can get active editor through bridge', () async {
      // Test body placeholder - see skip reason
    }, skip: 'Requires full bridge registration including dcli');
  });
}

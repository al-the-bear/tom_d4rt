/// Example demonstrating basic usage of the VS Code Scripting API.
///
/// This example shows how to initialize the API and use the main
/// namespaces (window, workspace, commands) through script globals.
///
/// Note: This requires a running VS Code instance with the Tom VS Code
/// Bridge extension active.
library;

import 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart';

void main() async {
  // Connect to VS Code via the socket bridge
  final client = VSCodeBridgeClient();
  await client.connect();

  final adapter = VSCodeBridgeAdapter(client);
  VSCode.initialize(adapter);

  // Access the VS Code API through the singleton
  final vscode = VSCode.instance;

  // Show a welcome message
  await vscode.window.showInformationMessage('Hello from Dart!');

  // Get workspace folders
  final folders = await vscode.workspace.getWorkspaceFolders();
  for (final folder in folders) {
    print('Workspace folder: ${folder.name} -> ${folder.uri}');
  }

  // Execute a VS Code command
  await vscode.commands.executeCommand('workbench.action.files.save');

  // Get VS Code version
  final version = await vscode.getVersion();
  print('VS Code version: $version');

  // Cleanup
  await client.disconnect();
}

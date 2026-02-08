# tom_vscode_scripting_api

Dart abstractions for VS Code extension APIs, providing a bridge-agnostic interface for VS Code scripting.

## Overview

This package provides a complete Dart API surface for interacting with VS Code extensions. It defines abstract adapter interfaces and concrete socket-based bridge implementations, allowing Dart scripts to control VS Code windows, workspaces, commands, extensions, language models, and chat participants.

## Features

- **Window API** — Show messages, quick picks, input boxes, manage editors and terminals, display progress indicators.
- **Workspace API** — Access workspace folders, read/write files, manage configuration, create file watchers.
- **Commands API** — Execute and register VS Code commands.
- **Extensions API** — Query and activate VS Code extensions.
- **Language Model API** — Access AI models (e.g., GitHub Copilot) for chat completions and tool calls.
- **Chat API** — Create chat participants, handle chat requests, stream responses.
- **Bridge Client** — JSON-RPC 2.0 socket-based communication with the VS Code extension host.
- **Script Globals** — Convenient top-level accessors (`vscode`, `window`, `workspace`, `commands`, `extensions`, `lm`, `chat`).

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  tom_vscode_scripting_api: ^1.0.0
```

## Usage

### Using Script Globals

The simplest way to use the API is through the global accessors:

```dart
import 'package:tom_vscode_scripting_api/script_globals.dart';

void main() async {
  // Initialize with a bridge adapter
  VSCode.initialize(adapter);

  // Show a message
  await window.showInformationMessage('Hello from Dart!');

  // Execute a command
  await commands.executeCommand('workbench.action.files.save');

  // Read workspace folders
  final folders = await workspace.getWorkspaceFolders();
  print('Workspace folders: ${folders.map((f) => f.name).join(', ')}');
}
```

### Using the Bridge Client

Connect to VS Code through the socket bridge:

```dart
import 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart';

void main() async {
  // Create and connect the bridge client
  final client = VSCodeBridgeClient();
  await client.connect();

  // Create the adapter and initialize
  final adapter = VSCodeBridgeAdapter(client);
  VSCode.initialize(adapter);

  // Use the API
  final version = await vscode.getVersion();
  print('VS Code version: $version');

  // Cleanup
  await client.disconnect();
}
```

### Window Operations

```dart
// Information, warning, and error messages
await window.showInformationMessage('Info');
await window.showWarningMessage('Warning');
await window.showErrorMessage('Error');

// Quick pick
final choice = await window.showQuickPick(
  ['Option A', 'Option B', 'Option C'],
  placeHolder: 'Choose an option',
);

// Input box
final input = await window.showInputBox(prompt: 'Enter a value');

// Open a file in the editor
await window.showTextDocument('/path/to/file.dart');
```

### Language Model

```dart
// Select available models
final models = await lm.selectChatModels(vendor: 'copilot');
if (models.isNotEmpty) {
  final model = models.first;
  final response = await model.sendRequest([
    LanguageModelChatMessage.user('Explain this code'),
  ]);
  print(response);
}
```

## Architecture

The package is structured around three layers:

1. **Adapter interface** (`VSCodeAdapter`) — Abstract request/response contract.
2. **Bridge implementation** (`VSCodeBridgeAdapter`, `VSCodeBridgeClient`) — Socket-based JSON-RPC 2.0 communication with the VS Code extension host.
3. **API namespaces** (`VSCodeWindow`, `VSCodeWorkspace`, etc.) — High-level typed APIs built on the adapter.

## License

MIT — see [LICENSE](LICENSE) for details.

/// Script Globals for VS Code Scripting API
///
/// This file provides global variable declarations for scripts.
/// Import this file to get convenient access to VS Code API globals.
///
/// ## Usage
///
/// ```dart
/// import 'package:tom_vscode_scripting_api/script_globals.dart';
///
/// void main() {
///   // Now vscode, window, etc. are available
///   vscode.window.showInformationMessage('Hello!');
/// }
/// ```
///
/// ## Available Globals
///
/// - `vscode` - Main VS Code API entry point ([VSCode])
/// - `window` - VS Code window API ([VSCodeWindow])
/// - `workspace` - VS Code workspace API ([VSCodeWorkspace])
/// - `commands` - VS Code commands API ([VSCodeCommands])
/// - `extensions` - VS Code extensions API ([VSCodeExtensions])
/// - `lm` - VS Code language model API ([VSCodeLanguageModel])
/// - `chat` - VS Code chat API ([VSCodeChat])
///
/// ## Note
///
/// These globals require VSCode.initialize() to be called first.
library;

import 'src/vscode.dart';
import 'src/vscode_window.dart';
import 'src/vscode_workspace.dart';
import 'src/vscode_commands.dart';
import 'src/vscode_extensions.dart';
import 'src/vscode_lm.dart';
import 'src/vscode_chat.dart';

// Re-export the main package for convenience
export 'tom_vscode_scripting_api.dart';

/// Main VS Code API entry point.
///
/// Provides access to all VS Code namespaces:
/// - `vscode.window` - Window operations (messages, editors, terminals)
/// - `vscode.workspace` - Workspace operations (files, folders, config)
/// - `vscode.commands` - Command execution
/// - `vscode.extensions` - Extension management
/// - `vscode.lm` - Language model API
/// - `vscode.chat` - Chat participant API
///
/// Example:
/// ```dart
/// final version = await vscode.getVersion();
/// await vscode.window.showInformationMessage('VS Code $version');
/// ```
VSCode get vscode => VSCode.instance;

/// VS Code window API.
///
/// Provides window-related operations:
/// - Show messages (information, warning, error)
/// - Quick pick dialogs
/// - Input boxes
/// - Text editors
/// - Terminals
/// - Progress indicators
///
/// Example:
/// ```dart
/// await window.showInformationMessage('Hello!');
/// final choice = await window.showQuickPick(['Option 1', 'Option 2']);
/// ```
VSCodeWindow get window => VSCode.instance.window;

/// VS Code workspace API.
///
/// Provides workspace-related operations:
/// - Workspace folders
/// - File operations (find, read, write)
/// - Configuration
/// - File system watchers
///
/// Example:
/// ```dart
/// final folders = await workspace.getWorkspaceFolders();
/// final config = await workspace.getConfiguration('editor');
/// ```
VSCodeWorkspace get workspace => VSCode.instance.workspace;

/// VS Code commands API.
///
/// Provides command-related operations:
/// - Execute commands
/// - Register commands
/// - Get command list
///
/// Example:
/// ```dart
/// await commands.executeCommand('workbench.action.files.save');
/// ```
VSCodeCommands get commands => VSCode.instance.commands;

/// VS Code extensions API.
///
/// Provides extension-related operations:
/// - Get extension info
/// - Activate extensions
/// - Extension exports
///
/// Example:
/// ```dart
/// final ext = await extensions.getExtension('ms-python.python');
/// ```
VSCodeExtensions get extensions => VSCode.instance.extensions;

/// VS Code language model API.
///
/// Provides access to language models like GitHub Copilot:
/// - Select chat models
/// - Send requests
/// - Register tools
///
/// Example:
/// ```dart
/// final models = await lm.selectChatModels(vendor: 'copilot');
/// ```
VSCodeLanguageModel get lm => VSCode.instance.lm;

/// VS Code chat API.
///
/// Provides chat participant operations:
/// - Create chat participants
/// - Handle chat requests
/// - Respond with markdown/code
///
/// Example:
/// ```dart
/// final participant = await chat.createChatParticipant('myext.helper', handler: myHandler);
/// ```
VSCodeChat get chat => VSCode.instance.chat;

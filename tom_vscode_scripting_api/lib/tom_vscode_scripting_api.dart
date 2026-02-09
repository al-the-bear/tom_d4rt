/// VS Code Scripting API
/// 
/// Provides Dart abstractions for VS Code extension APIs.
/// This package allows you to interact with VS Code through a bridge adapter.
library;

// Core adapter interface
export 'src/vscode_adapter.dart';

// Bridge client for socket-based communication
export 'src/vscode_bridge_client.dart';

// Bridge adapter implementation
export 'src/vscode_bridge_adapter.dart';

// Main VS Code API
export 'src/vscode.dart';

// API namespaces
export 'src/vscode_commands.dart';
export 'src/vscode_extensions.dart';
export 'src/vscode_lm.dart';
export 'src/vscode_window.dart';
export 'src/vscode_workspace.dart';
export 'src/vscode_chat.dart';
export 'src/vscode_helper.dart';

// Types
export 'src/vscode_types.dart';

// AI APIs (local LLM prompt processing & bot conversation)
export 'src/ai_prompt_api.dart';
export 'src/ai_conversation_api.dart';

// Script globals (vscode, window, workspace, commands, extensions, lm, chat)
export 'script_globals.dart';

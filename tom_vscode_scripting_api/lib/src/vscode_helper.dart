/// VS Code Helper
/// 
/// Static helper class for common VS Code API operations.
/// Provides simplified access to VS Code functionality for scripts.
library;

import 'dart:async';
import 'vscode.dart';
import 'vscode_adapter.dart';
import 'vscode_lm.dart';
import 'vscode_types.dart';

/// Logging control for VsCodeHelper
class HelperLogging {
  static bool debugLogging = false;
}

/// Helper class for VS Code API operations in scripts
/// 
/// All methods are static and require VSCode instance initialization.
/// 
/// Example usage:
/// ```dart
/// void main() {
///   // Initialize with adapter
///   VsCodeHelper.initialize(adapter);
///   
///   // Use helper methods
///   VsCodeHelper.showInfo('Hello from script!');
/// }
/// ```
class VsCodeHelper {
  /// Private constructor to prevent instantiation
  VsCodeHelper._();

  /// Get the current VSCode API instance
  /// This is automatically set when a script executes via the bridge
  static VSCode getVSCode() {
    return VSCode.instance;
  }

  /// Set the VSCode instance (called by bridge)
  static void setVSCode(VSCode vscode) {
    // VSCode uses singleton pattern, nothing to do here
    // The instance is set via VSCode.initialize()
  }

  /// Initialize VsCodeHelper with adapter
  /// This creates the VSCode instance and stores it for use
  static void initialize(VSCodeAdapter adapter) {
    VSCode.initialize(adapter);
  }

  /// Get the VS Code window identifier (sessionId_machineId)
  /// 
  /// This unique ID identifies the current VS Code window/session and can be
  /// used for session-specific file naming (e.g., chat answer files).
  static Future<String> getWindowId({int timeoutSeconds = 30}) async {
    final vscode = getVSCode();
    final result = await vscode.adapter.sendRequest('executeScriptVce', {
      'script': '''
        return context.vscode.env.sessionId + '_' + context.vscode.env.machineId;
      ''',
      'params': {},
    }, scriptName: 'getWindowId', timeout: Duration(seconds: timeoutSeconds));
    
    // Extract result from wrapper pattern {success: true, result: ...}
    if (result.containsKey('result')) {
      return result['result']?.toString() ?? '';
    }
    return result.toString();
  }

  /// Generate a timestamp-based unique ID
  /// 
  /// Format: YYYYMMDD_HHMMSS (e.g., 20250114_153042)
  /// Useful for generating unique file names, request IDs, etc.
  static String generateTimestampId() {
    final now = DateTime.now();
    final year = now.year.toString();
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    return '$year$month${day}_$hour$minute$second';
  }

  /// Generate a short timestamp ID for internal use
  /// 
  /// Format: yymmdd-hhmmss (e.g., 260201-143042)
  /// Used as default requestId for askCopilotChat.
  static String _generateShortTimestampId() {
    final now = DateTime.now();
    final year = (now.year % 100).toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    return '$year$month$day-$hour$minute$second';
  }

  // ============================================================================
  // Convenience Functions - Direct access to common operations
  // ============================================================================

  /// Show information message
  static Future<String?> showInfo(String message, {List<String>? choices, int timeoutSeconds = 300}) async {
    final vscode = getVSCode();
    return await vscode.window.showInformationMessage(
      message,
      items: choices,
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Show warning message
  static Future<String?> showWarning(String message, {List<String>? choices, int timeoutSeconds = 300}) async {
    final vscode = getVSCode();
    return await vscode.window.showWarningMessage(
      message,
      items: choices,
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Show error message
  static Future<String?> showError(String message, {List<String>? choices, int timeoutSeconds = 300}) async {
    final vscode = getVSCode();
    return await vscode.window.showErrorMessage(
      message,
      items: choices,
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Show quick pick dialog
  static Future<String?> quickPick(
    List<String> items, {
    String? placeholder,
    bool canPickMany = false,
    int timeoutSeconds = 1800,
    String? fallbackValueOnTimeout,
    bool failOnTimeout = false,
  }) async {
    final vscode = getVSCode();
    return await vscode.window.showQuickPick(
      items,
      placeHolder: placeholder,
      canPickMany: canPickMany,
      timeoutSeconds: timeoutSeconds,
      fallbackValueOnTimeout: fallbackValueOnTimeout,
      failOnTimeout: failOnTimeout,
    );
  }

  /// Show input box
  static Future<String?> inputBox({
    String? prompt,
    String? placeholder,
    String? defaultValue,
    bool password = false,
    int timeoutSeconds = 1800,
    String? fallbackValueOnTimeout,
    bool failOnTimeout = false,
  }) async {
    final vscode = getVSCode();
    return await vscode.window.showInputBox(
      prompt: prompt,
      placeHolder: placeholder,
      value: defaultValue,
      password: password,
      timeoutSeconds: timeoutSeconds,
      fallbackValueOnTimeout: fallbackValueOnTimeout,
      failOnTimeout: failOnTimeout,
    );
  }

  /// Get workspace root path
  static Future<String?> getWorkspaceRoot({int timeoutSeconds = 30}) async {
    final vscode = getVSCode();
    final folders = await vscode.workspace.getWorkspaceFolders(
      timeoutSeconds: timeoutSeconds,
    );
    return folders.isNotEmpty ? folders.first.uri.fsPath : null;
  }

  /// Get workspace folders
  static Future<List<dynamic>?> getWorkspaceFolders({int timeoutSeconds = 30}) async {
    final vscode = getVSCode();
    return await vscode.workspace.getWorkspaceFolders(
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Get active text editor
  static Future<dynamic> getActiveTextEditor({int timeoutSeconds = 30}) async {
    final vscode = getVSCode();
    final editor = await vscode.window.getActiveTextEditor();
    return editor; // now a Map<String, dynamic> from the bridge
  }

  /// Find files in workspace
  static Future<List<String>> findFiles({
    required String include,
    String? exclude,
    int? maxResults,
    int timeoutSeconds = 60,
  }) async {
    final vscode = getVSCode();
    return await vscode.workspace.findFilePaths(
      include: include,
      exclude: exclude,
      maxResults: maxResults,
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Read file content
  static Future<String> readFile(String path, {int timeoutSeconds = 60}) async {
    final vscode = getVSCode();
    return await vscode.workspace.readFile(path);
  }

  /// Write file content
  static Future<bool> writeFile(String path, String content, {int timeoutSeconds = 60}) async {
    final vscode = getVSCode();
    return await vscode.workspace.writeFile(path, content);
  }

  /// Create a new file with content (alias for writeFile)
  static Future<bool> createFile(
    String path, {
    String content = '',
    int timeoutSeconds = 60,
  }) async {
    return await writeFile(path, content, timeoutSeconds: timeoutSeconds);
  }

  /// Delete file
  static Future<bool> deleteFile(String path, {int timeoutSeconds = 60}) async {
    final vscode = getVSCode();
    return await vscode.workspace.deleteFile(path);
  }

  /// Check if file exists
  static Future<bool> fileExists(String path, {int timeoutSeconds = 30}) async {
    final vscode = getVSCode();
    return await vscode.workspace.fileExists(path);
  }

  /// Execute VS Code command
  static Future<dynamic> executeCommand(String command, {List<dynamic>? args, int timeoutSeconds = 120}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      command,
      args: args,
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Set status bar message
  static Future<void> setStatus(String message, {int? timeout, int timeoutSeconds = 120}) async {
    final vscode = getVSCode();
    await vscode.window.setStatusBarMessage(
      message,
      timeout: timeout,
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Create and show output channel
  static Future<String> createOutput(String name, {String? initialContent, int timeoutSeconds = 60}) async {
    final vscode = getVSCode();
    final channel = await vscode.window.createOutputChannel(
      name,
      timeoutSeconds: timeoutSeconds,
    );
    if (initialContent != null) {
      await vscode.window.appendToOutputChannel(
        channel,
        initialContent,
        timeoutSeconds: timeoutSeconds,
      );
    }
    await vscode.window.showOutputChannel(
      channel,
      timeoutSeconds: timeoutSeconds,
    );
    return channel;
  }

  /// Append to output channel
  static Future<void> appendOutput(String channel, String text, {int timeoutSeconds = 60}) async {
    final vscode = getVSCode();
    await vscode.window.appendToOutputChannel(
      channel,
      text,
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Copy to clipboard
  static Future<void> copyToClipboard(String text, {int timeoutSeconds = 10}) async {
    final vscode = getVSCode();
    await vscode.copyToClipboard(text, timeoutSeconds: timeoutSeconds);
  }

  /// Read from clipboard
  static Future<String> readClipboard({int timeoutSeconds = 10}) async {
    final vscode = getVSCode();
    return await vscode.readFromClipboard(timeoutSeconds: timeoutSeconds);
  }

  /// Open file in editor
  static Future<void> openFile(String path, {int timeoutSeconds = 600}) async {
    final vscode = getVSCode();
    await vscode.window.showTextDocument(path, timeoutSeconds: timeoutSeconds);
  }

  /// Get configuration value
  static Future<dynamic> getConfig(String section, {String? key, int timeoutSeconds = 60}) async {
    final vscode = getVSCode();
    final config = await vscode.workspace.getConfiguration(
      section,
      timeoutSeconds: timeoutSeconds,
    );
    return key != null ? config[key] : config;
  }

  /// Set configuration value
  static Future<bool> setConfig(
    String section,
    String key,
    dynamic value, {
    bool global = true,
    int timeoutSeconds = 60,
  }) async {
    final vscode = getVSCode();
    return await vscode.workspace.updateConfiguration(
      section,
      key,
      value,
      global: global,
      timeoutSeconds: timeoutSeconds,
    );
  }

  // ==========================================================================
  // Dart/Flutter Development Helpers
  // ==========================================================================

  /// Run `dart pub get` in the workspace
  static Future<bool> runPubGet({String? workingDirectory, int timeoutSeconds = 300}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'dart.pub.get',
      args: workingDirectory != null ? [workingDirectory] : null,
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Run `dart pub upgrade` in the workspace
  static Future<bool> runPubUpgrade({String? workingDirectory, int timeoutSeconds = 300}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'dart.pub.upgrade',
      args: workingDirectory != null ? [workingDirectory] : null,
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Add a dependency to pubspec.yaml
  static Future<bool> addDependency(String name, {String? version, int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'dart.addDependency',
      args: [name, ?version],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Get diagnostics (errors/warnings) for a file
  static Future<List<Map<String, dynamic>>> getDiagnostics(String uri, {int timeoutSeconds = 120}) async {
    final vscode = getVSCode();
    final result = await vscode.commands.executeCommand(
      'vscode.executeDiagnosticProvider',
      args: [uri],
      timeoutSeconds: timeoutSeconds,
    );
    return result is List ? result.cast<Map<String, dynamic>>() : [];
  }

  /// Format a Dart document
  static Future<bool> formatDocument(String uri, {int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'editor.action.formatDocument',
      args: [uri],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Organize imports in a Dart file
  static Future<bool> organizeImports(String uri, {int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'editor.action.organizeImports',
      args: [uri],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Trigger Flutter hot reload
  static Future<bool> hotReload({int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'flutter.hotReload',
      args: null,
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Trigger Flutter hot restart
  static Future<bool> hotRestart({int timeoutSeconds = 240}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'flutter.hotRestart',
      args: null,
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Get list of Flutter devices
  static Future<List<Map<String, dynamic>>> getFlutterDevices({int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    final result = await vscode.commands.executeCommand(
      'flutter.selectDevice',
      args: null,
      timeoutSeconds: timeoutSeconds,
    );
    return result is List ? result.cast<Map<String, dynamic>>() : [];
  }

  /// Run Flutter app on specified device
  static Future<bool> runFlutterApp({String? deviceId, int timeoutSeconds = 420}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'flutter.run',
      args: deviceId != null ? [deviceId] : null,
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  // ==========================================================================
  // GitHub Copilot Integration Helpers
  // ==========================================================================

  /// Ask GitHub Copilot a question (D4rt-safe version)
  /// 
  /// This method performs the entire LM request in JavaScript to avoid
  /// D4rt deserialization issues with `List<LanguageModelChat>`.
  static Future<String> askCopilot(String prompt, {String? context, int timeoutSeconds = 300}) async {
    final vscode = getVSCode();
    
    // Build the full prompt with context
    final fullPrompt = context != null 
        ? 'Context: $context\n\n$prompt'
        : prompt;
    
    // Execute everything in JavaScript to avoid D4rt list deserialization issues
    final result = await vscode.adapter.sendRequest('executeScriptVce', {
      'script': '''
        // Try to get models - first without filter, then with vendor filter
        let models = await context.vscode.lm.selectChatModels({});
        if (models.length === 0) {
          models = await context.vscode.lm.selectChatModels({vendor: 'copilot'});
        }
        if (models.length === 0) {
          throw new Error('No language models available');
        }
        
        // Log available models for debugging
        console.log('Available models:', models.map(m => m.id + ' (' + m.vendor + '/' + m.family + ')').join(', '));
        
        const messages = [
          context.vscode.LanguageModelChatMessage.User(params.prompt)
        ];
        
        // Try each model until one works
        let lastError = null;
        for (const model of models) {
          try {
            console.log('Trying model:', model.id);
            const response = await model.sendRequest(messages, {});
            let text = '';
            for await (const part of response.stream) {
              if (part && part.value) text += part.value;
            }
            return text;
          } catch (e) {
            console.log('Model failed:', model.id, e.message);
            lastError = e;
          }
        }
        throw lastError || new Error('All models failed');
      ''',
      'params': {'prompt': fullPrompt},
    }, scriptName: 'askCopilot', timeout: Duration(seconds: timeoutSeconds));
    
    // Result is always Map - extract the result
    if (result.containsKey('result')) {
      return result['result']?.toString() ?? '';
    } else if (result.containsKey('value')) {
      return result['value']?.toString() ?? '';
    } else if (result.containsKey('text')) {
      return result['text']?.toString() ?? '';
    }
    // Return JSON string of the map as fallback
    return result.toString();
  }

  /// Ask Copilot Chat a question and wait for the response
  /// 
  /// This method sends the prompt to the Copilot Chat UI (visible to user)
  /// and polls for the response. The model is asked to write its response
  /// to `data[generatedMarkdown]` and any comments to `data[comments]`.
  /// 
  /// Benefits over direct LM API:
  /// - User can see and control the chat
  /// - Chat has access to workspace tools (@workspace, file reading, etc.)
  /// - User can manually select the model
  /// 
  /// [prompt] - The question or instruction to send (if customResponseInstructions is true, 
  ///            prompt should already contain complete instructions for how to respond)
  /// [requestId] - Unique identifier for this request (used in answer file).
  ///               If not provided, defaults to timestamp format: yymmdd-hhmmss
  /// [pollIntervalSeconds] - How often to check for response (default: 10)
  /// [timeoutSeconds] - Maximum wait time (default: 7200 = 2 hours)
  /// [customResponseInstructions] - If true, prompt already contains response instructions,
  ///                                 don't add default suffix (default: false)
  /// 
  /// Returns a Map with 'generatedMarkdown' and optionally 'comments' keys
  static Future<Map<String, String>> askCopilotChat(
    String prompt, {
    String? requestId,
    int pollIntervalSeconds = 10,
    int timeoutSeconds = 7200,
    bool customResponseInstructions = false,
  }) async {
    final vscode = getVSCode();
    
    // Generate requestId from timestamp if not provided
    final effectiveRequestId = requestId ?? _generateShortTimestampId();
    
    // Get windowId for file naming
    final windowId = await getWindowId();
    
    // Use absolute path in ~/.tom/copilot-chat-answers/ for reliability
    // This avoids workspace folder detection issues
    final answerFileName = '${windowId}_answer.json';
    
    // Build the suffix that instructs the model to write to the answer file
    // Skip if caller provided custom response instructions
    final suffix = customResponseInstructions ? '' : '''

---
IMPORTANT: When you have completed your response, write your answer to the file:
~/.tom/copilot-chat-answers/$answerFileName

The file must be valid JSON with this structure:
{
  "requestId": "$effectiveRequestId",
  "generatedMarkdown": "<your response as a JSON-escaped string>",
  "comments": "<optional comments>"
}

Request ID: $effectiveRequestId
''';

    final fullPrompt = '$prompt$suffix';
    
    // Delete existing answer file before sending (to ensure we detect a fresh file)
    await vscode.adapter.sendRequest('executeScriptVce', {
      'script': '''
        const fs = context.require('fs');
        const path = context.require('path');
        const os = context.require('os');
        
        const homeDir = os.homedir();
        const answerFolder = path.join(homeDir, '.tom', 'copilot-chat-answers');
        const filePath = path.join(answerFolder, params.answerFileName);
        
        // Create folder if it doesn't exist
        if (!fs.existsSync(answerFolder)) {
          fs.mkdirSync(answerFolder, { recursive: true });
        }
        
        // Delete existing file if present
        if (fs.existsSync(filePath)) {
          fs.unlinkSync(filePath);
          return { deleted: true, path: filePath };
        }
        return { deleted: false, path: filePath };
      ''',
      'params': {'answerFileName': answerFileName},
    }, scriptName: 'askCopilotChat.deleteOldAnswer', timeout: Duration(seconds: 30));
    
    // Send to Copilot Chat
    await vscode.adapter.sendRequest('executeScriptVce', {
      'script': '''
        await context.vscode.commands.executeCommand('workbench.action.chat.open', {
          query: params.prompt
        });
        return 'sent';
      ''',
      'params': {'prompt': fullPrompt},
    }, scriptName: 'askCopilotChat.send', timeout: Duration(seconds: 120));
    
    if (HelperLogging.debugLogging) print('[COPSND] Sent to Copilot Chat, waiting for response...');
    
    // Poll for response
    final startTime = DateTime.now();
    final timeout = Duration(seconds: timeoutSeconds);
    final pollInterval = Duration(seconds: pollIntervalSeconds);
    
    while (DateTime.now().difference(startTime) < timeout) {
      // Wait before polling
      await Future.delayed(pollInterval);
      
      // Check for response in ~/.tom/copilot-chat-answers/ using Node.js fs
      final result = await vscode.adapter.sendRequest('executeScriptVce', {
        'script': '''
          const fs = context.require('fs');
          const path = context.require('path');
          const os = context.require('os');
          
          const homeDir = os.homedir();
          const answerFolder = path.join(homeDir, '.tom', 'copilot-chat-answers');
          const filePath = path.join(answerFolder, params.answerFileName);
          
          try {
            // Check if file exists using Node.js fs
            if (!fs.existsSync(filePath)) {
              return { found: false, reason: 'no answer file', path: filePath };
            }
            
            // File exists - wait 500ms to ensure it's fully written
            await new Promise(resolve => setTimeout(resolve, 500));
            
            // Read the file using Node.js fs
            const content = fs.readFileSync(filePath, 'utf8');
            
            if (!content.trim()) {
              return { found: false, reason: 'empty file' };
            }
            
            // Parse as JSON
            let parsed;
            try {
              parsed = JSON.parse(content);
            } catch (e) {
              return { found: false, reason: 'invalid JSON: ' + e.message };
            }
            
            if (parsed.requestId !== params.requestId) {
              return { found: false, reason: 'request id mismatch', expected: params.requestId, got: parsed.requestId };
            }
            
            if (parsed.generatedMarkdown) {
              return { 
                found: true, 
                generatedMarkdown: parsed.generatedMarkdown,
                comments: parsed.comments || ''
              };
            }
            
            return { found: false, reason: 'generatedMarkdown not found' };
          } catch (e) {
            return { found: false, reason: 'error: ' + e.message };
          }
        ''',
        'params': {
          'requestId': effectiveRequestId,
          'answerFileName': answerFileName,
        },
      }, scriptName: 'askCopilotChat.poll', timeout: Duration(seconds: 120));
      
      // The result is wrapped: {success: true, result: {found: true, ...}}
      // Extract the inner result - result is always Map<String, dynamic>
      final innerResult = result['result'];
      
      if (innerResult is Map && innerResult['found'] == true) {
        if (HelperLogging.debugLogging) print('[COPRCV] Response received from Copilot Chat');
        return {
          'generatedMarkdown': innerResult['generatedMarkdown']?.toString() ?? '',
          'comments': innerResult['comments']?.toString() ?? '',
        };
      }
    }
    
    throw Exception('Timeout waiting for Copilot Chat response after $timeoutSeconds seconds');
  }

  /// Ask a specific language model a question by model ID
  /// 
  /// Use this when you need to specify a particular model rather than
  /// using the default first available Copilot model.
  /// 
  /// If modelId is 'auto' or empty, uses the first available model.
  static Future<String> askModel(
    String modelId,
    String prompt, {
    String? context,
    String vendor = 'copilot',
    int timeoutSeconds = 300,
  }) async {
    final vscode = getVSCode();
    
    // Get all models for the vendor
    final allModels = await vscode.lm.selectChatModels(
      vendor: vendor,
      timeoutSeconds: timeoutSeconds,
    );
    
    if (allModels.isEmpty) {
      throw Exception('No models available for vendor "$vendor"');
    }
    
    // If auto or empty, use first available model
    if (modelId == 'auto' || modelId.isEmpty) {
      final messages = <LanguageModelChatMessage>[
        if (context != null) LanguageModelChatMessage.user('Context: $context'),
        LanguageModelChatMessage.user(prompt),
      ];
      final response = await allModels.first.sendRequest(
        vscode.adapter,
        messages,
        timeoutSeconds: timeoutSeconds,
      );
      return response.text;
    }
    
    // Find the model with matching ID using index-based loop (D4rt compatible)
    LanguageModelChat? model;
    var i = 0;
    while (i < allModels.length) {
      if (allModels[i].id == modelId) {
        model = allModels[i];
        break;
      }
      i = i + 1;
    }
    
    if (model == null) {
      // Build available list with index-based loop
      final availableIds = <String>[];
      i = 0;
      while (i < allModels.length) {
        availableIds.add(allModels[i].id);
        i = i + 1;
      }
      throw Exception('Model "$modelId" not available. Available: ${availableIds.join(', ')}');
    }

    final messages = <LanguageModelChatMessage>[
      if (context != null) LanguageModelChatMessage.user('Context: $context'),
      LanguageModelChatMessage.user(prompt),
    ];

    final response = await model.sendRequest(
      vscode.adapter,
      messages,
      timeoutSeconds: timeoutSeconds,
    );
    return response.text;
  }

  /// Get code suggestion from Copilot
  static Future<String> getCopilotSuggestion(String code, String instruction, {int timeoutSeconds = 300}) async {
    final prompt = '''
Given the following code:

```
$code
```

$instruction

Please provide the modified code.
''';
    return await askCopilot(prompt, timeoutSeconds: timeoutSeconds);
  }

  /// Get code explanation from Copilot
  static Future<String> explainCode(String code, {int timeoutSeconds = 300}) async {
    final prompt = '''
Please explain the following code in detail:

```
$code
```
''';
    return await askCopilot(prompt, timeoutSeconds: timeoutSeconds);
  }

  /// Get code review from Copilot
  static Future<String> reviewCode(String code, {int timeoutSeconds = 300}) async {
    final prompt = '''
Please review the following code and provide suggestions for improvement:

```
$code
```

Focus on:
- Code quality
- Performance
- Best practices
- Potential bugs
''';
    return await askCopilot(prompt, timeoutSeconds: timeoutSeconds);
  }

  /// Generate tests for code using Copilot
  static Future<String> generateTests(String code, {int timeoutSeconds = 300}) async {
    final prompt = '''
Please generate comprehensive unit tests for the following code:

```
$code
```

Use appropriate testing framework and cover edge cases.
''';
    return await askCopilot(prompt, timeoutSeconds: timeoutSeconds);
  }

  /// Get fix suggestions from Copilot
  static Future<String> fixCode(String code, String error, {int timeoutSeconds = 300}) async {
    final prompt = '''
The following code has an error:

```
$code
```

Error: $error

Please provide a fixed version of the code.
''';
    return await askCopilot(prompt, timeoutSeconds: timeoutSeconds);
  }

  /// Select a specific Copilot model
  static Future<LanguageModelChat?> selectCopilotModel({
    String? family,
    String? vendor,
    String? id,
    int timeoutSeconds = 120,
  }) async {
    final vscode = getVSCode();
    final models = await vscode.lm.selectChatModels(
      family: family,
      vendor: vendor ?? 'copilot',
      id: id,
      timeoutSeconds: timeoutSeconds,
    );
    return models.isNotEmpty ? models.first : null;
  }

  /// Get list of available Copilot models
  static Future<List<LanguageModelChat>> getCopilotModels({int timeoutSeconds = 120}) async {
    final vscode = getVSCode();
    return await vscode.lm.selectChatModels(
      vendor: 'copilot',
      timeoutSeconds: timeoutSeconds,
    );
  }

  // ==========================================================================
  // Advanced Editor Helpers
  // ==========================================================================

  /// Replace text in a document
  static Future<bool> replaceText(
    String uri,
    int startLine,
    int startChar,
    int endLine,
    int endChar,
    String text,
    {int timeoutSeconds = 180}
  ) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'vscode.executeDocumentEdit',
      args: [
        uri,
        {
          'range': {
            'start': {'line': startLine, 'character': startChar},
            'end': {'line': endLine, 'character': endChar},
          },
          'newText': text,
        }
      ],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Insert a code snippet
  static Future<bool> insertSnippet(
    String uri,
    int line,
    int character,
    String snippet,
    {int timeoutSeconds = 180}
  ) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'editor.action.insertSnippet',
      args: [
        {
          'uri': uri,
          'position': {'line': line, 'character': character},
          'snippet': snippet,
        }
      ],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Apply workspace edit
  static Future<bool> applyWorkspaceEdit(List<Map<String, dynamic>> edits, {int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'vscode.workspace.applyEdit',
      args: [edits],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Get current selection
  static Future<Selection?> getSelection({int timeoutSeconds = 60}) async {
    final vscode = getVSCode();
    final editor = await vscode.window.getActiveTextEditor();
    final selection = editor?.selection;
    return selection;
  }

  /// Set selection in active editor
  static Future<bool> setSelection(
    int startLine,
    int startChar,
    int endLine,
    int endChar,
    {int timeoutSeconds = 120}
  ) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'editor.action.select',
      args: [
        {
          'start': {'line': startLine, 'character': startChar},
          'end': {'line': endLine, 'character': endChar},
        }
      ],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Get cursor position
  static Future<Position?> getCursorPosition({int timeoutSeconds = 60}) async {
    final vscode = getVSCode();
    final editor = await vscode.window.getActiveTextEditor();
    final selection = editor?.selection;
    final active = selection?.active;
    return active;
  }

  // ==========================================================================
  // Workspace & Project Helpers
  // ==========================================================================

  /// Get project files matching pattern with smart filtering
  static Future<List<String>> getProjectFiles(String pattern, {bool excludeTests = true, int timeoutSeconds = 120}) async {
    final exclude = excludeTests
        ? '**/test/**,**/tests/**,**/.dart_tool/**,**/build/**'
        : '**/.dart_tool/**,**/build/**';
    return await findFiles(
      include: pattern,
      exclude: exclude,
      timeoutSeconds: timeoutSeconds,
    );
  }

  /// Find git repository root
  static Future<String?> getGitRoot({int timeoutSeconds = 120}) async {
    final vscode = getVSCode();
    final result = await vscode.commands.executeCommand(
      'git.getRepositoryRoot',
      args: null,
      timeoutSeconds: timeoutSeconds,
    );
    return result as String?;
  }

  /// Detect project type (Flutter, Dart, etc.)
  static Future<String> getProjectType({int timeoutSeconds = 120}) async {
    final root = await getWorkspaceRoot(timeoutSeconds: timeoutSeconds);
    if (root == null) return 'unknown';

    // Check for pubspec.yaml
    final pubspecPath = '$root/pubspec.yaml';
    if (await fileExists(pubspecPath, timeoutSeconds: timeoutSeconds)) {
      final content = await readFile(pubspecPath, timeoutSeconds: timeoutSeconds);
      if (content.contains('flutter:')) {
        return 'flutter';
      }
      return 'dart';
    }

    // Check for other project types
    if (await fileExists('$root/package.json', timeoutSeconds: timeoutSeconds)) return 'node';
    if (await fileExists('$root/pom.xml', timeoutSeconds: timeoutSeconds)) return 'java';
    if (await fileExists('$root/Cargo.toml', timeoutSeconds: timeoutSeconds)) return 'rust';

    return 'unknown';
  }

  /// Search in workspace
  static Future<List<Map<String, dynamic>>> searchInWorkspace(
    String query, {
    String? includePattern,
    String? excludePattern,
    bool isRegex = false,
    int? maxResults,
    int timeoutSeconds = 180,
  }) async {
    final vscode = getVSCode();
    final result = await vscode.commands.executeCommand(
      'workbench.action.findInFiles',
      args: [
        {
          'query': query,
          'include': ?includePattern,
          'exclude': ?excludePattern,
          'isRegex': isRegex,
          'maxResults': ?maxResults,
        }
      ],
      timeoutSeconds: timeoutSeconds,
    );
    return result is List ? result.cast<Map<String, dynamic>>() : [];
  }

  /// Replace in workspace
  static Future<bool> replaceInWorkspace(
    String query,
    String replacement, {
    String? includePattern,
    String? excludePattern,
    bool isRegex = false,
    int timeoutSeconds = 180,
  }) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'workbench.action.replaceInFiles',
      args: [
        {
          'query': query,
          'replace': replacement,
          'include': ?includePattern,
          'exclude': ?excludePattern,
          'isRegex': isRegex,
        }
      ],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  // ==========================================================================
  // Testing & Debugging Helpers
  // ==========================================================================

  /// Run tests in specified file or workspace
  static Future<Map<String, dynamic>> runTests({String? uri, int timeoutSeconds = 420}) async {
    final vscode = getVSCode();
    final result = await vscode.commands.executeCommand(
      'dart.runAllTests',
      args: uri != null ? [uri] : null,
      timeoutSeconds: timeoutSeconds,
    );
    return result is Map<String, dynamic> ? result : {};
  }

  /// Run tests with coverage
  static Future<Map<String, dynamic>> runTestsWithCoverage({String? uri, int timeoutSeconds = 600}) async {
    final vscode = getVSCode();
    final result = await vscode.commands.executeCommand(
      'dart.runAllTestsWithCoverage',
      args: uri != null ? [uri] : null,
      timeoutSeconds: timeoutSeconds,
    );
    return result is Map<String, dynamic> ? result : {};
  }

  /// Get test results
  static Future<List<Map<String, dynamic>>> getTestResults({int timeoutSeconds = 240}) async {
    final vscode = getVSCode();
    final result = await vscode.commands.executeCommand(
      'testing.getResults',
      args: null,
      timeoutSeconds: timeoutSeconds,
    );
    return result is List ? result.cast<Map<String, dynamic>>() : [];
  }

  /// Start debugging with configuration
  static Future<bool> startDebugging({Map<String, dynamic>? config, int timeoutSeconds = 300}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'workbench.action.debug.start',
      args: config != null ? [config] : null,
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Stop current debugging session
  static Future<bool> stopDebugging({int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'workbench.action.debug.stop',
      args: null,
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Set breakpoint at line
  static Future<bool> setBreakpoint(String uri, int line, {int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'editor.debug.action.toggleBreakpoint',
      args: [
        {'uri': uri, 'line': line}
      ],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Remove breakpoint at line
  static Future<bool> removeBreakpoint(String uri, int line, {int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    return await vscode.commands.executeCommand(
      'editor.debug.action.removeBreakpoint',
      args: [
        {'uri': uri, 'line': line}
      ],
      timeoutSeconds: timeoutSeconds,
    ) != null;
  }

  /// Get all breakpoints
  static Future<List<Map<String, dynamic>>> getBreakpoints({int timeoutSeconds = 180}) async {
    final vscode = getVSCode();
    final result = await vscode.commands.executeCommand(
      'debug.getBreakpoints',
      args: null,
      timeoutSeconds: timeoutSeconds,
    );
    return result is List ? result.cast<Map<String, dynamic>>() : [];
  }
}

// ============================================================================
// Helper Classes for Building Complex Workflows
// ============================================================================

/// Progress indicator helper
/// 
/// Named VsProgress to avoid conflict with dcli's Progress class.
class VsProgress {
  final String channelName;
  final VSCode _vscode;

  VsProgress._(this._vscode, this.channelName);

  /// Create a progress indicator
  static Future<VsProgress> create(String name) async {
    final vscode = VsCodeHelper.getVSCode();
    await vscode.window.createOutputChannel(name);
    await vscode.window.showOutputChannel(name);
    return VsProgress._(vscode, name);
  }

  /// Report progress
  Future<void> report(String message) async {
    await _vscode.window.appendToOutputChannel(channelName, '$message\n');
  }

  /// Complete progress
  Future<void> complete() async {
    await _vscode.window.appendToOutputChannel(
      channelName,
      '\n=== Complete ===\n',
    );
  }

  /// Report error
  Future<void> error(String message) async {
    await _vscode.window.appendToOutputChannel(
      channelName,
      'ERROR: $message\n',
    );
  }
}

/// File batch processor
class FileBatch {
  final List<String> files;
  final VSCode _vscode;

  FileBatch._(this._vscode, this.files);

  /// Create file batch from pattern
  static Future<FileBatch> fromPattern({
    required String include,
    String? exclude,
    int? maxResults,
  }) async {
    final vscode = VsCodeHelper.getVSCode();
    final files = await vscode.workspace.findFilePaths(
      include: include,
      exclude: exclude,
      maxResults: maxResults,
    );
    return FileBatch._(vscode, files);
  }

  /// Process each file
  Future<List<T>> process<T>(
    Future<T> Function(String path, String content) processor,
  ) async {
    final results = <T>[];
    for (final file in files) {
      final content = await _vscode.workspace.readFile(file);
      final result = await processor(file, content);
      results.add(result);
    }
    return results;
  }

  /// Filter files
  Future<FileBatch> filter(bool Function(String path) predicate) async {
    final filtered = files.where(predicate).toList();
    return FileBatch._(_vscode, filtered);
  }

  /// Get file count
  int get count => files.length;
}

/// AI Conversation API — Bot Conversation (Local-Copilot / Self-Talk)
///
/// Provides Dart access to the DartScript VS Code extension's bot
/// conversation feature, which orchestrates multi-turn conversations
/// between a local Ollama model and GitHub Copilot (or between two
/// local model personas in self-talk mode).
///
/// The API uses the `botConversation.*Vce` bridge methods.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart';
///
/// void main() async {
///   // Start a conversation
///   final result = await AiConversationApi.start(
///     goal: 'Refactor the auth module for better testability',
///   );
///   print('Completed in ${result.turns} turns');
///
///   // Or do a quick single-turn round-trip
///   final single = await AiConversationApi.singleTurn(
///     prompt: 'Explain how the auth middleware works',
///   );
///   print(single.localModelOutput);
/// }
/// ```
library;

import 'vscode.dart';
import 'vscode_adapter.dart';
import 'ai_prompt_api.dart'; // Re-use AiTokenStats

// ============================================================================
// Enums
// ============================================================================

/// Conversation mode — who talks to whom.
enum ConversationMode {
  /// Local Ollama model orchestrates prompts for GitHub Copilot.
  ollamaCopilot('ollama-copilot'),

  /// Two local Ollama model personas talk to each other.
  ollamaOllama('ollama-ollama');

  final String value;
  const ConversationMode(this.value);

  static ConversationMode fromString(String s) {
    return switch (s) {
      'ollama-ollama' => ConversationMode.ollamaOllama,
      _ => ConversationMode.ollamaCopilot,
    };
  }

  @override
  String toString() => value;
}

/// History mode — how much conversation history is passed to the local model.
enum HistoryMode {
  /// Full history of all exchanges.
  full('full'),

  /// Only the last exchange.
  last('last'),

  /// Summarized history.
  summary('summary'),

  /// Trimmed history plus summary of older exchanges.
  trimAndSummary('trim_and_summary');

  final String value;
  const HistoryMode(this.value);

  static HistoryMode fromString(String s) {
    return switch (s) {
      'full' => HistoryMode.full,
      'last' => HistoryMode.last,
      'summary' => HistoryMode.summary,
      _ => HistoryMode.trimAndSummary,
    };
  }

  @override
  String toString() => value;
}

// ============================================================================
// Return Types
// ============================================================================

/// Response from Copilot in a bot conversation exchange.
class CopilotResponse {
  /// Request ID used to correlate prompt/response.
  final String requestId;

  /// Main response content (markdown).
  final String generatedMarkdown;

  /// Optional comments from Copilot.
  final String? comments;

  /// Files Copilot referenced while forming the response.
  final List<String> references;

  /// Files explicitly requested by the prompt.
  final List<String> requestedAttachments;

  CopilotResponse({
    required this.requestId,
    required this.generatedMarkdown,
    this.comments,
    this.references = const [],
    this.requestedAttachments = const [],
  });

  factory CopilotResponse.fromJson(Map<String, dynamic> json) {
    return CopilotResponse(
      requestId: json['requestId'] as String? ?? '',
      generatedMarkdown: json['generatedMarkdown'] as String? ?? '',
      comments: json['comments'] as String?,
      references: (json['references'] as List?)?.cast<String>() ?? [],
      requestedAttachments:
          (json['requestedAttachments'] as List?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'requestId': requestId,
        'generatedMarkdown': generatedMarkdown,
        'comments': ?comments,
        'references': references,
        'requestedAttachments': requestedAttachments,
      };

  @override
  String toString() =>
      'CopilotResponse(requestId: $requestId, '
      '${generatedMarkdown.length} chars)';
}

/// A single exchange (turn) in a bot conversation.
class ConversationExchange {
  /// Turn number (1-based).
  final int turn;

  /// When this exchange happened.
  final DateTime timestamp;

  /// The prompt sent to Copilot (or Person A's output in self-talk mode).
  final String promptToCopilot;

  /// Copilot's response (or Person B's output in self-talk mode).
  final CopilotResponse copilotResponse;

  /// Token stats from the local model for this turn.
  final AiTokenStats? localModelStats;

  ConversationExchange({
    required this.turn,
    required this.timestamp,
    required this.promptToCopilot,
    required this.copilotResponse,
    this.localModelStats,
  });

  factory ConversationExchange.fromJson(Map<String, dynamic> json) {
    return ConversationExchange(
      turn: json['turn'] as int? ?? 0,
      timestamp: json['timestamp'] is String
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
      promptToCopilot: json['promptToCopilot'] as String? ?? '',
      copilotResponse: json['copilotResponse'] is Map<String, dynamic>
          ? CopilotResponse.fromJson(
              json['copilotResponse'] as Map<String, dynamic>)
          : CopilotResponse(requestId: '', generatedMarkdown: ''),
      localModelStats: json['localModelStats'] is Map<String, dynamic>
          ? AiTokenStats.fromJson(
              json['localModelStats'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'turn': turn,
        'timestamp': timestamp.toIso8601String(),
        'promptToCopilot': promptToCopilot,
        'copilotResponse': copilotResponse.toJson(),
        'localModelStats': ?localModelStats?.toJson(),
      };

  @override
  String toString() =>
      'ConversationExchange(turn: $turn, '
      'prompt: ${promptToCopilot.length} chars, '
      'response: ${copilotResponse.generatedMarkdown.length} chars)';
}

/// Result of starting a bot conversation via [AiConversationApi.start].
class ConversationResult {
  /// Unique conversation ID.
  final String conversationId;

  /// Number of turns completed.
  final int turns;

  /// Whether the goal was reached.
  final bool goalReached;

  /// Path to the conversation log file.
  final String logFilePath;

  /// All exchanges in the conversation.
  final List<ConversationExchange> exchanges;

  ConversationResult({
    required this.conversationId,
    required this.turns,
    required this.goalReached,
    required this.logFilePath,
    required this.exchanges,
  });

  factory ConversationResult.fromJson(Map<String, dynamic> json) {
    return ConversationResult(
      conversationId: json['conversationId'] as String? ?? '',
      turns: json['turns'] as int? ?? 0,
      goalReached: json['goalReached'] as bool? ?? false,
      logFilePath: json['logFilePath'] as String? ?? '',
      exchanges: (json['exchanges'] as List?)
              ?.map((e) =>
                  ConversationExchange.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  String toString() =>
      'ConversationResult(id: $conversationId, turns: $turns, '
      'goalReached: $goalReached)';
}

/// Current status of a bot conversation.
class ConversationStatus {
  /// Whether a conversation is currently active.
  final bool active;

  /// Whether the conversation is halted (paused).
  final bool halted;

  /// Conversation ID (null if no conversation).
  final String? conversationId;

  /// The user's goal description.
  final String? goal;

  /// Profile key being used.
  final String? profileKey;

  /// Conversation mode.
  final ConversationMode? conversationMode;

  /// Number of turns completed so far.
  final int turnsCompleted;

  /// Maximum turns configured.
  final int maxTurns;

  /// Number of pending additional user inputs.
  final int pendingUserInput;

  ConversationStatus({
    required this.active,
    this.halted = false,
    this.conversationId,
    this.goal,
    this.profileKey,
    this.conversationMode,
    this.turnsCompleted = 0,
    this.maxTurns = 0,
    this.pendingUserInput = 0,
  });

  factory ConversationStatus.fromJson(Map<String, dynamic> json) {
    return ConversationStatus(
      active: json['active'] as bool? ?? false,
      halted: json['halted'] as bool? ?? false,
      conversationId: json['conversationId'] as String?,
      goal: json['goal'] as String?,
      profileKey: json['profileKey'] as String?,
      conversationMode: json['conversationMode'] is String
          ? ConversationMode.fromString(json['conversationMode'] as String)
          : null,
      turnsCompleted: json['turnsCompleted'] as int? ?? 0,
      maxTurns: json['maxTurns'] as int? ?? 0,
      pendingUserInput: json['pendingUserInput'] as int? ?? 0,
    );
  }

  @override
  String toString() {
    if (!active) return 'ConversationStatus(inactive)';
    final state = halted ? 'halted' : 'running';
    return 'ConversationStatus($state, turn $turnsCompleted/$maxTurns, '
        'goal: ${goal?.substring(0, goal!.length.clamp(0, 60))})';
  }
}

/// A named bot conversation profile.
class ConversationProfile {
  /// Profile key identifier.
  final String key;

  /// Human-readable label.
  final String label;

  /// Max turns override (null → inherit).
  final int? maxTurns;

  /// Temperature override (null → inherit).
  final double? temperature;

  /// Model config key override (null → default).
  final String? modelConfig;

  /// History mode override (null → inherit).
  final HistoryMode? historyMode;

  /// Goal-reached marker override (null → inherit).
  final String? goalReachedMarker;

  ConversationProfile({
    required this.key,
    required this.label,
    this.maxTurns,
    this.temperature,
    this.modelConfig,
    this.historyMode,
    this.goalReachedMarker,
  });

  factory ConversationProfile.fromJson(Map<String, dynamic> json) {
    return ConversationProfile(
      key: json['key'] as String? ?? '',
      label: json['label'] as String? ?? '',
      maxTurns: json['maxTurns'] as int?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      modelConfig: json['modelConfig'] as String?,
      historyMode: json['historyMode'] is String
          ? HistoryMode.fromString(json['historyMode'] as String)
          : null,
      goalReachedMarker: json['goalReachedMarker'] as String?,
    );
  }

  @override
  String toString() => 'ConversationProfile(key: $key, label: $label)';
}

/// Bot conversation configuration (resolved from send_to_chat.json).
class ConversationConfig {
  final int maxTurns;
  final double temperature;
  final HistoryMode historyMode;
  final int maxHistoryTokens;
  final String? modelConfig;
  final bool pauseBetweenTurns;
  final bool pauseBeforeFirst;
  final bool logConversation;
  final bool stripThinkingTags;
  final String? copilotModel;
  final String conversationLogPath;
  final String goalReachedMarker;
  final List<String> profileKeys;

  ConversationConfig({
    required this.maxTurns,
    required this.temperature,
    required this.historyMode,
    required this.maxHistoryTokens,
    this.modelConfig,
    required this.pauseBetweenTurns,
    required this.pauseBeforeFirst,
    required this.logConversation,
    required this.stripThinkingTags,
    this.copilotModel,
    required this.conversationLogPath,
    required this.goalReachedMarker,
    required this.profileKeys,
  });

  factory ConversationConfig.fromJson(Map<String, dynamic> json) {
    return ConversationConfig(
      maxTurns: json['maxTurns'] as int? ?? 10,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.5,
      historyMode: json['historyMode'] is String
          ? HistoryMode.fromString(json['historyMode'] as String)
          : HistoryMode.trimAndSummary,
      maxHistoryTokens: json['maxHistoryTokens'] as int? ?? 4000,
      modelConfig: json['modelConfig'] as String?,
      pauseBetweenTurns: json['pauseBetweenTurns'] as bool? ?? false,
      pauseBeforeFirst: json['pauseBeforeFirst'] as bool? ?? false,
      logConversation: json['logConversation'] as bool? ?? true,
      stripThinkingTags: json['stripThinkingTags'] as bool? ?? true,
      copilotModel: json['copilotModel'] as String?,
      conversationLogPath:
          json['conversationLogPath'] as String? ?? '_ai/bot_conversations',
      goalReachedMarker:
          json['goalReachedMarker'] as String? ?? '__GOAL_REACHED__',
      profileKeys: (json['profileKeys'] as List?)?.cast<String>() ?? [],
    );
  }

  @override
  String toString() =>
      'ConversationConfig(maxTurns: $maxTurns, temp: $temperature, '
      'profiles: ${profileKeys.length})';
}

/// Result of a single-turn Ollama→Copilot round-trip.
class SingleTurnResult {
  /// The local model's generated output.
  final String localModelOutput;

  /// Token stats from the local model.
  final AiTokenStats? localModelStats;

  /// Copilot's response (null if `sendToCopilot` was false).
  final CopilotResponse? copilotResponse;

  SingleTurnResult({
    required this.localModelOutput,
    this.localModelStats,
    this.copilotResponse,
  });

  factory SingleTurnResult.fromJson(Map<String, dynamic> json) {
    return SingleTurnResult(
      localModelOutput: json['localModelOutput'] as String? ?? '',
      localModelStats: json['localModelStats'] is Map<String, dynamic>
          ? AiTokenStats.fromJson(
              json['localModelStats'] as Map<String, dynamic>)
          : null,
      copilotResponse: json['copilotResponse'] is Map<String, dynamic>
          ? CopilotResponse.fromJson(
              json['copilotResponse'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() =>
      'SingleTurnResult(output: ${localModelOutput.length} chars'
      '${copilotResponse != null ? ", copilot: ${copilotResponse!.generatedMarkdown.length} chars" : ""})';
}

/// Result of a stop/halt/continue/addInfo operation.
class ConversationActionResult {
  /// Whether the operation succeeded.
  final bool success;

  /// Human-readable message.
  final String message;

  /// Whether the conversation is currently halted (for halt/continue).
  final bool? halted;

  ConversationActionResult({
    required this.success,
    required this.message,
    this.halted,
  });

  factory ConversationActionResult.fromJson(Map<String, dynamic> json) {
    return ConversationActionResult(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      halted: json['halted'] as bool?,
    );
  }

  @override
  String toString() =>
      'ConversationActionResult(success: $success, message: $message)';
}

/// Conversation log retrieved from disk.
class ConversationLog {
  /// Whether the log was found.
  final bool found;

  /// Conversation ID.
  final String conversationId;

  /// Full file path to the log.
  final String? logFilePath;

  /// Markdown content of the log.
  final String? content;

  ConversationLog({
    required this.found,
    required this.conversationId,
    this.logFilePath,
    this.content,
  });

  factory ConversationLog.fromJson(Map<String, dynamic> json) {
    return ConversationLog(
      found: json['found'] as bool? ?? false,
      conversationId: json['conversationId'] as String? ?? '',
      logFilePath: json['logFilePath'] as String?,
      content: json['content'] as String?,
    );
  }

  @override
  String toString() =>
      'ConversationLog(id: $conversationId, found: $found'
      '${content != null ? ", ${content!.length} chars" : ""})';
}

// ============================================================================
// AI Conversation API — Static Methods
// ============================================================================

/// AI Conversation API — bot conversation orchestration.
///
/// Provides type-safe Dart access to the DartScript Bot Conversation feature,
/// which orchestrates multi-turn conversations between a local Ollama model
/// and GitHub Copilot, or between two local model personas (self-talk mode).
///
/// All methods are static and require [VSCode.initialize] to have been
/// called first.
///
/// ## Examples
///
/// ```dart
/// // Start a conversation with defaults
/// final result = await AiConversationApi.start(
///   goal: 'Add comprehensive error handling to the auth module',
/// );
///
/// // Start with a specific profile and limited turns
/// final result2 = await AiConversationApi.start(
///   goal: 'Debug the login timeout issue',
///   profile: 'debug',
///   maxTurns: 5,
/// );
///
/// // Self-talk mode (two model personas)
/// final result3 = await AiConversationApi.start(
///   goal: 'Design a caching strategy for the API layer',
///   conversationMode: ConversationMode.ollamaOllama,
/// );
///
/// // Check status during a conversation
/// final status = await AiConversationApi.status();
/// if (status.active) {
///   print('Turn ${status.turnsCompleted}/${status.maxTurns}');
/// }
///
/// // Halt, add info, then continue
/// await AiConversationApi.halt();
/// await AiConversationApi.addInfo('Also consider rate limiting');
/// await AiConversationApi.continueConversation();
/// ```
class AiConversationApi {
  AiConversationApi._();

  /// Get the adapter from the VSCode singleton.
  static VSCodeAdapter get _adapter => VSCode.instance.adapter;

  // --------------------------------------------------------------------------
  // Conversation lifecycle
  // --------------------------------------------------------------------------

  /// Start a bot conversation.
  ///
  /// This starts a multi-turn loop where a local Ollama model generates
  /// prompts for Copilot (or for another local model persona in self-talk
  /// mode). The call blocks until the conversation completes.
  ///
  /// [goal] — what the conversation should achieve (required).
  /// [description] — additional context or constraints.
  /// [profile] — conversation profile key (null → default config).
  /// [maxTurns] — override max turns (null → profile/config default).
  /// [temperature] — override temperature (null → profile/config default).
  /// [modelConfig] — override model config key.
  /// [historyMode] — override history mode.
  /// [includeFileContext] — workspace file paths to include as context.
  /// [pauseBetweenTurns] — pause for user review between turns.
  /// [conversationMode] — `ollamaCopilot` or `ollamaOllama`.
  /// [timeoutSeconds] — max wait time (default 1800s = 30 min).
  static Future<ConversationResult> start({
    required String goal,
    String? description,
    String? profile,
    int? maxTurns,
    double? temperature,
    String? modelConfig,
    HistoryMode? historyMode,
    List<String>? includeFileContext,
    bool? pauseBetweenTurns,
    ConversationMode? conversationMode,
    int timeoutSeconds = 1800,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.startVce',
      {
        'goal': goal,
        'description': ?description,
        'profile': ?profile,
        'maxTurns': ?maxTurns,
        'temperature': ?temperature,
        'modelConfig': ?modelConfig,
        'historyMode': ?historyMode?.value,
        'includeFileContext': ?includeFileContext,
        'pauseBetweenTurns': ?pauseBetweenTurns,
        'conversationMode': ?conversationMode?.value,
      },
      scriptName: 'AiConversationApi.start',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return ConversationResult.fromJson(result);
  }

  /// Stop the active conversation.
  ///
  /// [reason] — optional human-readable reason for stopping.
  static Future<ConversationActionResult> stop({
    String? reason,
    int timeoutSeconds = 30,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.stopVce',
      {'reason': ?reason},
      scriptName: 'AiConversationApi.stop',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return ConversationActionResult.fromJson(result);
  }

  /// Halt (pause) the active conversation between turns.
  ///
  /// The conversation loop will wait at the start of the next turn
  /// until [continueConversation] is called.
  ///
  /// [reason] — optional reason for halting.
  static Future<ConversationActionResult> halt({
    String? reason,
    int timeoutSeconds = 30,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.haltVce',
      {'reason': ?reason},
      scriptName: 'AiConversationApi.halt',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return ConversationActionResult.fromJson(result);
  }

  /// Continue a halted conversation.
  ///
  /// Resumes the conversation loop from where it was halted.
  /// Any input added via [addInfo] will be injected into the next prompt.
  static Future<ConversationActionResult> continueConversation({
    int timeoutSeconds = 30,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.continueVce',
      {},
      scriptName: 'AiConversationApi.continueConversation',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return ConversationActionResult.fromJson(result);
  }

  /// Add additional user input to the next prompt.
  ///
  /// The text will be drained and injected into the local model's prompt
  /// at the next turn. Multiple calls are concatenated.
  ///
  /// [text] — the additional context or instructions to inject.
  static Future<ConversationActionResult> addInfo(
    String text, {
    int timeoutSeconds = 30,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.addInfoVce',
      {'text': text},
      scriptName: 'AiConversationApi.addInfo',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return ConversationActionResult.fromJson(result);
  }

  // --------------------------------------------------------------------------
  // Status & Monitoring
  // --------------------------------------------------------------------------

  /// Get the status of the active conversation.
  ///
  /// Returns a [ConversationStatus] with active/halted state, turn count,
  /// goal, profile, and pending user input count.
  static Future<ConversationStatus> status({
    int timeoutSeconds = 30,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.statusVce',
      {},
      scriptName: 'AiConversationApi.status',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return ConversationStatus.fromJson(result);
  }

  /// Retrieve a conversation log by ID.
  ///
  /// [conversationId] — the unique conversation ID (e.g. from
  /// [ConversationResult.conversationId]).
  static Future<ConversationLog> getLog(
    String conversationId, {
    int timeoutSeconds = 30,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.getLogVce',
      {'conversationId': conversationId},
      scriptName: 'AiConversationApi.getLog',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return ConversationLog.fromJson(result);
  }

  // --------------------------------------------------------------------------
  // Configuration
  // --------------------------------------------------------------------------

  /// Get the resolved bot conversation configuration.
  ///
  /// Returns the full merged config (defaults + send_to_chat.json overrides)
  /// including a list of available profile keys.
  static Future<ConversationConfig> getConfig({
    int timeoutSeconds = 30,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.getConfigVce',
      {},
      scriptName: 'AiConversationApi.getConfig',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return ConversationConfig.fromJson(result);
  }

  /// List available conversation profiles.
  ///
  /// Returns a list of [ConversationProfile] with key, label, and overrides.
  static Future<List<ConversationProfile>> getProfiles({
    int timeoutSeconds = 30,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.getProfilesVce',
      {},
      scriptName: 'AiConversationApi.getProfiles',
      timeout: Duration(seconds: timeoutSeconds),
    );
    final profiles = result['profiles'] as List?;
    return profiles
            ?.map((p) =>
                ConversationProfile.fromJson(p as Map<String, dynamic>))
            .toList() ??
        [];
  }

  // --------------------------------------------------------------------------
  // Single Turn
  // --------------------------------------------------------------------------

  /// Run a single Ollama→Copilot round-trip without managing conversation
  /// state.
  ///
  /// Useful for one-off queries where you don't need a full multi-turn loop.
  ///
  /// [prompt] — the prompt for the local model (required).
  /// [systemPrompt] — system prompt for the local model.
  /// [modelConfig] — model config key.
  /// [temperature] — generation temperature.
  /// [sendToCopilot] — whether to also send the local model's output to
  ///   Copilot (default true). Set to false to only get the local model's
  ///   output.
  /// [copilotSuffix] — text appended to the prompt when sending to Copilot.
  static Future<SingleTurnResult> singleTurn({
    required String prompt,
    String? systemPrompt,
    String? modelConfig,
    double? temperature,
    bool sendToCopilot = true,
    String? copilotSuffix,
    int timeoutSeconds = 300,
  }) async {
    final result = await _adapter.sendRequest(
      'botConversation.singleTurnVce',
      {
        'prompt': prompt,
        'systemPrompt': ?systemPrompt,
        'modelConfig': ?modelConfig,
        'temperature': ?temperature,
        'sendToCopilot': sendToCopilot,
        'copilotSuffix': ?copilotSuffix,
      },
      scriptName: 'AiConversationApi.singleTurn',
      timeout: Duration(seconds: timeoutSeconds),
    );
    return SingleTurnResult.fromJson(result);
  }
}

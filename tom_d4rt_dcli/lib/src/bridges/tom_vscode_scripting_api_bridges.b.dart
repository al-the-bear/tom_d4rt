// D4rt Bridge - Generated file, do not edit
// Sources: 31 files
// Generated: 2026-08-12T10:16:01.930386

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member, unnecessary_cast, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_is_empty, unnecessary_question_mark, unreachable_switch_case, unintended_html_in_doc_comment, empty_constructor_bodies, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, must_call_super, no_logic_in_create_state, use_key_in_widget_constructors, annotate_overrides, non_const_argument_for_const_parameter, unnecessary_import

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';

import 'package:tom_vscode_scripting_api/script_globals.dart' as $tom_vscode_scripting_api_1;
import 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart' as $tom_vscode_scripting_api_2;
import 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart' as $tom_vscode_scripting_api_3;
import 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart' as $tom_vscode_scripting_api_4;
import 'package:tom_vscode_scripting_api/src/agent_sdk_permission_dispatch.dart' as $tom_vscode_scripting_api_5;
import 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart' as $tom_vscode_scripting_api_6;
import 'package:tom_vscode_scripting_api/src/agent_sdk_query.dart' as $tom_vscode_scripting_api_7;
import 'package:tom_vscode_scripting_api/src/agent_sdk_tool_registry.dart' as $tom_vscode_scripting_api_8;
import 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart' as $tom_vscode_scripting_api_9;
import 'package:tom_vscode_scripting_api/src/ai_prompt_api.dart' as $tom_vscode_scripting_api_10;
import 'package:tom_vscode_scripting_api/src/bridge_discovery.dart' as $tom_vscode_scripting_api_11;
import 'package:tom_vscode_scripting_api/src/bridge_request_dispatcher.dart' as $tom_vscode_scripting_api_12;
import 'package:tom_vscode_scripting_api/src/tom_chat_api.dart' as $tom_vscode_scripting_api_13;
import 'package:tom_vscode_scripting_api/src/tom_document_api.dart' as $tom_vscode_scripting_api_14;
import 'package:tom_vscode_scripting_api/src/tom_queue_api.dart' as $tom_vscode_scripting_api_15;
import 'package:tom_vscode_scripting_api/src/tom_timed_api.dart' as $tom_vscode_scripting_api_16;
import 'package:tom_vscode_scripting_api/src/tom_todo_api.dart' as $tom_vscode_scripting_api_17;
import 'package:tom_vscode_scripting_api/src/tom_tools_api.dart' as $tom_vscode_scripting_api_18;
import 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart' as $tom_vscode_scripting_api_19;
import 'package:tom_vscode_scripting_api/src/vscode.dart' as $tom_vscode_scripting_api_20;
import 'package:tom_vscode_scripting_api/src/vscode_adapter.dart' as $tom_vscode_scripting_api_21;
import 'package:tom_vscode_scripting_api/src/vscode_bridge_adapter.dart' as $tom_vscode_scripting_api_22;
import 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart' as $tom_vscode_scripting_api_23;
import 'package:tom_vscode_scripting_api/src/vscode_chat.dart' as $tom_vscode_scripting_api_24;
import 'package:tom_vscode_scripting_api/src/vscode_commands.dart' as $tom_vscode_scripting_api_25;
import 'package:tom_vscode_scripting_api/src/vscode_extensions.dart' as $tom_vscode_scripting_api_26;
import 'package:tom_vscode_scripting_api/src/vscode_helper.dart' as $tom_vscode_scripting_api_27;
import 'package:tom_vscode_scripting_api/src/vscode_lm.dart' as $tom_vscode_scripting_api_28;
import 'package:tom_vscode_scripting_api/src/vscode_types.dart' as $tom_vscode_scripting_api_29;
import 'package:tom_vscode_scripting_api/src/vscode_window.dart' as $tom_vscode_scripting_api_30;
import 'package:tom_vscode_scripting_api/src/vscode_workspace.dart' as $tom_vscode_scripting_api_31;

/// Bridge class for tom_vscode_scripting_api module.
class TomVscodeScriptingApiBridge {
  /// Returns all bridge class definitions.
  ///
  /// Eager — building every class. Prefer [bridgeClassThunks] +
  /// [bridgeClassTypes] for lazy registration (Step #17); this remains
  /// for diagnostics and callers that need the full list.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createVSCodeAdapterBridge(),
      _createVSCodeBridgeResultBridge(),
      _createVSCodeBridgeClientBridge(),
      _createVSCodeBridgeAdapterBridge(),
      _createLazyVSCodeBridgeAdapterBridge(),
      _createBridgeWorkspaceNotFoundExceptionBridge(),
      _createVSCodeBridge(),
      _createVSCodeCommandsBridge(),
      _createVSCodeCommonCommandsBridge(),
      _createExtensionBridge(),
      _createVSCodeExtensionsBridge(),
      _createVSCodeLanguageModelBridge(),
      _createLanguageModelChatBridge(),
      _createLanguageModelChatMessageBridge(),
      _createLanguageModelChatResponseBridge(),
      _createLanguageModelToolResultBridge(),
      _createLanguageModelToolInformationBridge(),
      _createVSCodeWindowBridge(),
      _createVSCodeWorkspaceBridge(),
      _createVSCodeChatBridge(),
      _createChatParticipantBridge(),
      _createChatRequestBridge(),
      _createChatPromptReferenceBridge(),
      _createChatContextBridge(),
      _createChatResultBridge(),
      _createChatErrorDetailsBridge(),
      _createChatResponseStreamBridge(),
      _createHelperLoggingBridge(),
      _createVsCodeHelperBridge(),
      _createVsProgressBridge(),
      _createFileBatchBridge(),
      _createVSCodeUriBridge(),
      _createWorkspaceFolderBridge(),
      _createTextDocumentBridge(),
      _createPositionBridge(),
      _createRangeBridge(),
      _createSelectionBridge(),
      _createTextEditorBridge(),
      _createQuickPickItemBridge(),
      _createInputBoxOptionsBridge(),
      _createMessageOptionsBridge(),
      _createTerminalOptionsBridge(),
      _createFileSystemWatcherOptionsBridge(),
      _createSdkMessageBridge(),
      _createSdkAssistantMessageBridge(),
      _createSdkUserMessageBridge(),
      _createSdkResultMessageBridge(),
      _createSdkSystemMessageBridge(),
      _createSdkPartialAssistantMessageBridge(),
      _createSdkSystemEventBridge(),
      _createSdkUnknownMessageBridge(),
      _createContentBlockBridge(),
      _createTextBlockBridge(),
      _createThinkingBlockBridge(),
      _createToolUseBlockBridge(),
      _createToolResultBlockBridge(),
      _createUnknownBlockBridge(),
      _createPermissionRuleValueBridge(),
      _createPermissionUpdateBridge(),
      _createPermissionUpdateRulesBridge(),
      _createPermissionUpdateSetModeBridge(),
      _createPermissionUpdateDirectoriesBridge(),
      _createPermissionResultBridge(),
      _createPermissionAllowBridge(),
      _createPermissionDenyBridge(),
      _createCanUseToolContextBridge(),
      _createCallToolResultBridge(),
      _createSdkMcpToolBridge(),
      _createMcpServerToolPolicyBridge(),
      _createMcpServerConfigBridge(),
      _createMcpStdioServerConfigBridge(),
      _createMcpSSEServerConfigBridge(),
      _createMcpHttpServerConfigBridge(),
      _createMcpSdkServerConfigBridge(),
      _createSystemPromptBridge(),
      _createSystemPromptTextBridge(),
      _createSystemPromptListBridge(),
      _createSystemPromptPresetBridge(),
      _createToolsConfigBridge(),
      _createToolsListBridge(),
      _createToolsClaudeCodePresetBridge(),
      _createThinkingConfigBridge(),
      _createThinkingAdaptiveBridge(),
      _createThinkingEnabledBridge(),
      _createThinkingDisabledBridge(),
      _createSkillsBridge(),
      _createSkillsListBridge(),
      _createSkillsAllBridge(),
      _createSettingsRefBridge(),
      _createSettingsPathBridge(),
      _createSettingsInlineBridge(),
      _createOutputFormatBridge(),
      _createTaskBudgetBridge(),
      _createPluginConfigBridge(),
      _createAgentDefinitionBridge(),
      _createOptionsBridge(),
      _createAgentSdkTransportBridge(),
      _createAgentSdkQueryExceptionBridge(),
      _createAgentQueryBridge(),
      _createAgentSdkClientBridge(),
      _createVSCodeBridgeAgentSdkTransportBridge(),
      _createBridgeRequestDispatcherBridge(),
      _createAgentSdkToolRegistryBridge(),
      _createAiTokenStatsBridge(),
      _createAiPromptResultBridge(),
      _createAiPromptProfileBridge(),
      _createAiModelConfigBridge(),
      _createAiModelsResultBridge(),
      _createAiPromptApiBridge(),
      _createCopilotResponseBridge(),
      _createConversationExchangeBridge(),
      _createConversationResultBridge(),
      _createConversationStatusBridge(),
      _createConversationProfileBridge(),
      _createConversationConfigBridge(),
      _createSingleTurnResultBridge(),
      _createConversationActionResultBridge(),
      _createConversationLogBridge(),
      _createAiConversationApiBridge(),
      _createTodoReferenceBridge(),
      _createTodoScopeBridge(),
      _createTodoItemBridge(),
      _createTodoListResultBridge(),
      _createTodoFileListResultBridge(),
      _createTomTodoApiBridge(),
      _createQueuedFollowUpBridge(),
      _createQueuedPromptBridge(),
      _createQueueListResultBridge(),
      _createQueueItemInputBridge(),
      _createFollowUpInputBridge(),
      _createTomQueueApiBridge(),
      _createScheduledTimeBridge(),
      _createTimedRequestBridge(),
      _createTimedRequestListResultBridge(),
      _createTimedRequestInputBridge(),
      _createTomTimedApiBridge(),
      _createDocumentInfoBridge(),
      _createDocumentListResultBridge(),
      _createDocumentContentBridge(),
      _createTrailEntryBridge(),
      _createTrailListResultBridge(),
      _createGuidelineInfoBridge(),
      _createGuidelineListResultBridge(),
      _createTomDocumentApiBridge(),
      _createProjectInfoBridge(),
      _createProjectListResultBridge(),
      _createQuestInfoBridge(),
      _createQuestListResultBridge(),
      _createWorkspaceInfoBridge(),
      _createChatVariableBridge(),
      _createChatVariableListResultBridge(),
      _createTomWorkspaceApiBridge(),
      _createToolDefinitionJsonBridge(),
      _createTomToolsApiBridge(),
      _createSendToChatResultBridge(),
      _createTomChatApiBridge(),
    ];
  }

  /// Returns deferred factory thunks keyed by class name.
  ///
  /// Each thunk builds one class's [BridgedClass] on demand. Plugs into
  /// the interpreter's lazy registry via [registerBridges] (Step #17).
  static Map<String, BridgedClass Function()> bridgeClassThunks() {
    return {
      'VSCodeAdapter': _createVSCodeAdapterBridge,
      'VSCodeBridgeResult': _createVSCodeBridgeResultBridge,
      'VSCodeBridgeClient': _createVSCodeBridgeClientBridge,
      'VSCodeBridgeAdapter': _createVSCodeBridgeAdapterBridge,
      'LazyVSCodeBridgeAdapter': _createLazyVSCodeBridgeAdapterBridge,
      'BridgeWorkspaceNotFoundException': _createBridgeWorkspaceNotFoundExceptionBridge,
      'VSCode': _createVSCodeBridge,
      'VSCodeCommands': _createVSCodeCommandsBridge,
      'VSCodeCommonCommands': _createVSCodeCommonCommandsBridge,
      'Extension': _createExtensionBridge,
      'VSCodeExtensions': _createVSCodeExtensionsBridge,
      'VSCodeLanguageModel': _createVSCodeLanguageModelBridge,
      'LanguageModelChat': _createLanguageModelChatBridge,
      'LanguageModelChatMessage': _createLanguageModelChatMessageBridge,
      'LanguageModelChatResponse': _createLanguageModelChatResponseBridge,
      'LanguageModelToolResult': _createLanguageModelToolResultBridge,
      'LanguageModelToolInformation': _createLanguageModelToolInformationBridge,
      'VSCodeWindow': _createVSCodeWindowBridge,
      'VSCodeWorkspace': _createVSCodeWorkspaceBridge,
      'VSCodeChat': _createVSCodeChatBridge,
      'ChatParticipant': _createChatParticipantBridge,
      'ChatRequest': _createChatRequestBridge,
      'ChatPromptReference': _createChatPromptReferenceBridge,
      'ChatContext': _createChatContextBridge,
      'ChatResult': _createChatResultBridge,
      'ChatErrorDetails': _createChatErrorDetailsBridge,
      'ChatResponseStream': _createChatResponseStreamBridge,
      'HelperLogging': _createHelperLoggingBridge,
      'VsCodeHelper': _createVsCodeHelperBridge,
      'VsProgress': _createVsProgressBridge,
      'FileBatch': _createFileBatchBridge,
      'VSCodeUri': _createVSCodeUriBridge,
      'WorkspaceFolder': _createWorkspaceFolderBridge,
      'TextDocument': _createTextDocumentBridge,
      'Position': _createPositionBridge,
      'Range': _createRangeBridge,
      'Selection': _createSelectionBridge,
      'TextEditor': _createTextEditorBridge,
      'QuickPickItem': _createQuickPickItemBridge,
      'InputBoxOptions': _createInputBoxOptionsBridge,
      'MessageOptions': _createMessageOptionsBridge,
      'TerminalOptions': _createTerminalOptionsBridge,
      'FileSystemWatcherOptions': _createFileSystemWatcherOptionsBridge,
      'SdkMessage': _createSdkMessageBridge,
      'SdkAssistantMessage': _createSdkAssistantMessageBridge,
      'SdkUserMessage': _createSdkUserMessageBridge,
      'SdkResultMessage': _createSdkResultMessageBridge,
      'SdkSystemMessage': _createSdkSystemMessageBridge,
      'SdkPartialAssistantMessage': _createSdkPartialAssistantMessageBridge,
      'SdkSystemEvent': _createSdkSystemEventBridge,
      'SdkUnknownMessage': _createSdkUnknownMessageBridge,
      'ContentBlock': _createContentBlockBridge,
      'TextBlock': _createTextBlockBridge,
      'ThinkingBlock': _createThinkingBlockBridge,
      'ToolUseBlock': _createToolUseBlockBridge,
      'ToolResultBlock': _createToolResultBlockBridge,
      'UnknownBlock': _createUnknownBlockBridge,
      'PermissionRuleValue': _createPermissionRuleValueBridge,
      'PermissionUpdate': _createPermissionUpdateBridge,
      'PermissionUpdateRules': _createPermissionUpdateRulesBridge,
      'PermissionUpdateSetMode': _createPermissionUpdateSetModeBridge,
      'PermissionUpdateDirectories': _createPermissionUpdateDirectoriesBridge,
      'PermissionResult': _createPermissionResultBridge,
      'PermissionAllow': _createPermissionAllowBridge,
      'PermissionDeny': _createPermissionDenyBridge,
      'CanUseToolContext': _createCanUseToolContextBridge,
      'CallToolResult': _createCallToolResultBridge,
      'SdkMcpTool': _createSdkMcpToolBridge,
      'McpServerToolPolicy': _createMcpServerToolPolicyBridge,
      'McpServerConfig': _createMcpServerConfigBridge,
      'McpStdioServerConfig': _createMcpStdioServerConfigBridge,
      'McpSSEServerConfig': _createMcpSSEServerConfigBridge,
      'McpHttpServerConfig': _createMcpHttpServerConfigBridge,
      'McpSdkServerConfig': _createMcpSdkServerConfigBridge,
      'SystemPrompt': _createSystemPromptBridge,
      'SystemPromptText': _createSystemPromptTextBridge,
      'SystemPromptList': _createSystemPromptListBridge,
      'SystemPromptPreset': _createSystemPromptPresetBridge,
      'ToolsConfig': _createToolsConfigBridge,
      'ToolsList': _createToolsListBridge,
      'ToolsClaudeCodePreset': _createToolsClaudeCodePresetBridge,
      'ThinkingConfig': _createThinkingConfigBridge,
      'ThinkingAdaptive': _createThinkingAdaptiveBridge,
      'ThinkingEnabled': _createThinkingEnabledBridge,
      'ThinkingDisabled': _createThinkingDisabledBridge,
      'Skills': _createSkillsBridge,
      'SkillsList': _createSkillsListBridge,
      'SkillsAll': _createSkillsAllBridge,
      'SettingsRef': _createSettingsRefBridge,
      'SettingsPath': _createSettingsPathBridge,
      'SettingsInline': _createSettingsInlineBridge,
      'OutputFormat': _createOutputFormatBridge,
      'TaskBudget': _createTaskBudgetBridge,
      'PluginConfig': _createPluginConfigBridge,
      'AgentDefinition': _createAgentDefinitionBridge,
      'Options': _createOptionsBridge,
      'AgentSdkTransport': _createAgentSdkTransportBridge,
      'AgentSdkQueryException': _createAgentSdkQueryExceptionBridge,
      'AgentQuery': _createAgentQueryBridge,
      'AgentSdkClient': _createAgentSdkClientBridge,
      'VSCodeBridgeAgentSdkTransport': _createVSCodeBridgeAgentSdkTransportBridge,
      'BridgeRequestDispatcher': _createBridgeRequestDispatcherBridge,
      'AgentSdkToolRegistry': _createAgentSdkToolRegistryBridge,
      'AiTokenStats': _createAiTokenStatsBridge,
      'AiPromptResult': _createAiPromptResultBridge,
      'AiPromptProfile': _createAiPromptProfileBridge,
      'AiModelConfig': _createAiModelConfigBridge,
      'AiModelsResult': _createAiModelsResultBridge,
      'AiPromptApi': _createAiPromptApiBridge,
      'CopilotResponse': _createCopilotResponseBridge,
      'ConversationExchange': _createConversationExchangeBridge,
      'ConversationResult': _createConversationResultBridge,
      'ConversationStatus': _createConversationStatusBridge,
      'ConversationProfile': _createConversationProfileBridge,
      'ConversationConfig': _createConversationConfigBridge,
      'SingleTurnResult': _createSingleTurnResultBridge,
      'ConversationActionResult': _createConversationActionResultBridge,
      'ConversationLog': _createConversationLogBridge,
      'AiConversationApi': _createAiConversationApiBridge,
      'TodoReference': _createTodoReferenceBridge,
      'TodoScope': _createTodoScopeBridge,
      'TodoItem': _createTodoItemBridge,
      'TodoListResult': _createTodoListResultBridge,
      'TodoFileListResult': _createTodoFileListResultBridge,
      'TomTodoApi': _createTomTodoApiBridge,
      'QueuedFollowUp': _createQueuedFollowUpBridge,
      'QueuedPrompt': _createQueuedPromptBridge,
      'QueueListResult': _createQueueListResultBridge,
      'QueueItemInput': _createQueueItemInputBridge,
      'FollowUpInput': _createFollowUpInputBridge,
      'TomQueueApi': _createTomQueueApiBridge,
      'ScheduledTime': _createScheduledTimeBridge,
      'TimedRequest': _createTimedRequestBridge,
      'TimedRequestListResult': _createTimedRequestListResultBridge,
      'TimedRequestInput': _createTimedRequestInputBridge,
      'TomTimedApi': _createTomTimedApiBridge,
      'DocumentInfo': _createDocumentInfoBridge,
      'DocumentListResult': _createDocumentListResultBridge,
      'DocumentContent': _createDocumentContentBridge,
      'TrailEntry': _createTrailEntryBridge,
      'TrailListResult': _createTrailListResultBridge,
      'GuidelineInfo': _createGuidelineInfoBridge,
      'GuidelineListResult': _createGuidelineListResultBridge,
      'TomDocumentApi': _createTomDocumentApiBridge,
      'ProjectInfo': _createProjectInfoBridge,
      'ProjectListResult': _createProjectListResultBridge,
      'QuestInfo': _createQuestInfoBridge,
      'QuestListResult': _createQuestListResultBridge,
      'WorkspaceInfo': _createWorkspaceInfoBridge,
      'ChatVariable': _createChatVariableBridge,
      'ChatVariableListResult': _createChatVariableListResultBridge,
      'TomWorkspaceApi': _createTomWorkspaceApiBridge,
      'ToolDefinitionJson': _createToolDefinitionJsonBridge,
      'TomToolsApi': _createTomToolsApiBridge,
      'SendToChatResult': _createSendToChatResultBridge,
      'TomChatApi': _createTomChatApiBridge,
    };
  }

  /// Returns native [Type]s keyed by class name, parallel to
  /// [bridgeClassThunks] (Step #17). Used to register the native-type
  /// lookup thunk without building the BridgedClass.
  static Map<String, Type> bridgeClassTypes() {
    return {
      'VSCodeAdapter': $tom_vscode_scripting_api_21.VSCodeAdapter,
      'VSCodeBridgeResult': $tom_vscode_scripting_api_23.VSCodeBridgeResult,
      'VSCodeBridgeClient': $tom_vscode_scripting_api_23.VSCodeBridgeClient,
      'VSCodeBridgeAdapter': $tom_vscode_scripting_api_22.VSCodeBridgeAdapter,
      'LazyVSCodeBridgeAdapter': $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter,
      'BridgeWorkspaceNotFoundException': $tom_vscode_scripting_api_11.BridgeWorkspaceNotFoundException,
      'VSCode': $tom_vscode_scripting_api_20.VSCode,
      'VSCodeCommands': $tom_vscode_scripting_api_25.VSCodeCommands,
      'VSCodeCommonCommands': $tom_vscode_scripting_api_25.VSCodeCommonCommands,
      'Extension': $tom_vscode_scripting_api_26.Extension,
      'VSCodeExtensions': $tom_vscode_scripting_api_26.VSCodeExtensions,
      'VSCodeLanguageModel': $tom_vscode_scripting_api_28.VSCodeLanguageModel,
      'LanguageModelChat': $tom_vscode_scripting_api_28.LanguageModelChat,
      'LanguageModelChatMessage': $tom_vscode_scripting_api_28.LanguageModelChatMessage,
      'LanguageModelChatResponse': $tom_vscode_scripting_api_28.LanguageModelChatResponse,
      'LanguageModelToolResult': $tom_vscode_scripting_api_28.LanguageModelToolResult,
      'LanguageModelToolInformation': $tom_vscode_scripting_api_28.LanguageModelToolInformation,
      'VSCodeWindow': $tom_vscode_scripting_api_30.VSCodeWindow,
      'VSCodeWorkspace': $tom_vscode_scripting_api_31.VSCodeWorkspace,
      'VSCodeChat': $tom_vscode_scripting_api_24.VSCodeChat,
      'ChatParticipant': $tom_vscode_scripting_api_24.ChatParticipant,
      'ChatRequest': $tom_vscode_scripting_api_24.ChatRequest,
      'ChatPromptReference': $tom_vscode_scripting_api_24.ChatPromptReference,
      'ChatContext': $tom_vscode_scripting_api_24.ChatContext,
      'ChatResult': $tom_vscode_scripting_api_24.ChatResult,
      'ChatErrorDetails': $tom_vscode_scripting_api_24.ChatErrorDetails,
      'ChatResponseStream': $tom_vscode_scripting_api_24.ChatResponseStream,
      'HelperLogging': $tom_vscode_scripting_api_27.HelperLogging,
      'VsCodeHelper': $tom_vscode_scripting_api_27.VsCodeHelper,
      'VsProgress': $tom_vscode_scripting_api_27.VsProgress,
      'FileBatch': $tom_vscode_scripting_api_27.FileBatch,
      'VSCodeUri': $tom_vscode_scripting_api_29.VSCodeUri,
      'WorkspaceFolder': $tom_vscode_scripting_api_29.WorkspaceFolder,
      'TextDocument': $tom_vscode_scripting_api_29.TextDocument,
      'Position': $tom_vscode_scripting_api_29.Position,
      'Range': $tom_vscode_scripting_api_29.Range,
      'Selection': $tom_vscode_scripting_api_29.Selection,
      'TextEditor': $tom_vscode_scripting_api_29.TextEditor,
      'QuickPickItem': $tom_vscode_scripting_api_29.QuickPickItem,
      'InputBoxOptions': $tom_vscode_scripting_api_29.InputBoxOptions,
      'MessageOptions': $tom_vscode_scripting_api_29.MessageOptions,
      'TerminalOptions': $tom_vscode_scripting_api_29.TerminalOptions,
      'FileSystemWatcherOptions': $tom_vscode_scripting_api_29.FileSystemWatcherOptions,
      'SdkMessage': $tom_vscode_scripting_api_3.SdkMessage,
      'SdkAssistantMessage': $tom_vscode_scripting_api_3.SdkAssistantMessage,
      'SdkUserMessage': $tom_vscode_scripting_api_3.SdkUserMessage,
      'SdkResultMessage': $tom_vscode_scripting_api_3.SdkResultMessage,
      'SdkSystemMessage': $tom_vscode_scripting_api_3.SdkSystemMessage,
      'SdkPartialAssistantMessage': $tom_vscode_scripting_api_3.SdkPartialAssistantMessage,
      'SdkSystemEvent': $tom_vscode_scripting_api_3.SdkSystemEvent,
      'SdkUnknownMessage': $tom_vscode_scripting_api_3.SdkUnknownMessage,
      'ContentBlock': $tom_vscode_scripting_api_3.ContentBlock,
      'TextBlock': $tom_vscode_scripting_api_3.TextBlock,
      'ThinkingBlock': $tom_vscode_scripting_api_3.ThinkingBlock,
      'ToolUseBlock': $tom_vscode_scripting_api_3.ToolUseBlock,
      'ToolResultBlock': $tom_vscode_scripting_api_3.ToolResultBlock,
      'UnknownBlock': $tom_vscode_scripting_api_3.UnknownBlock,
      'PermissionRuleValue': $tom_vscode_scripting_api_6.PermissionRuleValue,
      'PermissionUpdate': $tom_vscode_scripting_api_6.PermissionUpdate,
      'PermissionUpdateRules': $tom_vscode_scripting_api_6.PermissionUpdateRules,
      'PermissionUpdateSetMode': $tom_vscode_scripting_api_6.PermissionUpdateSetMode,
      'PermissionUpdateDirectories': $tom_vscode_scripting_api_6.PermissionUpdateDirectories,
      'PermissionResult': $tom_vscode_scripting_api_6.PermissionResult,
      'PermissionAllow': $tom_vscode_scripting_api_6.PermissionAllow,
      'PermissionDeny': $tom_vscode_scripting_api_6.PermissionDeny,
      'CanUseToolContext': $tom_vscode_scripting_api_6.CanUseToolContext,
      'CallToolResult': $tom_vscode_scripting_api_2.CallToolResult,
      'SdkMcpTool': $tom_vscode_scripting_api_2.SdkMcpTool,
      'McpServerToolPolicy': $tom_vscode_scripting_api_2.McpServerToolPolicy,
      'McpServerConfig': $tom_vscode_scripting_api_2.McpServerConfig,
      'McpStdioServerConfig': $tom_vscode_scripting_api_2.McpStdioServerConfig,
      'McpSSEServerConfig': $tom_vscode_scripting_api_2.McpSSEServerConfig,
      'McpHttpServerConfig': $tom_vscode_scripting_api_2.McpHttpServerConfig,
      'McpSdkServerConfig': $tom_vscode_scripting_api_2.McpSdkServerConfig,
      'SystemPrompt': $tom_vscode_scripting_api_4.SystemPrompt,
      'SystemPromptText': $tom_vscode_scripting_api_4.SystemPromptText,
      'SystemPromptList': $tom_vscode_scripting_api_4.SystemPromptList,
      'SystemPromptPreset': $tom_vscode_scripting_api_4.SystemPromptPreset,
      'ToolsConfig': $tom_vscode_scripting_api_4.ToolsConfig,
      'ToolsList': $tom_vscode_scripting_api_4.ToolsList,
      'ToolsClaudeCodePreset': $tom_vscode_scripting_api_4.ToolsClaudeCodePreset,
      'ThinkingConfig': $tom_vscode_scripting_api_4.ThinkingConfig,
      'ThinkingAdaptive': $tom_vscode_scripting_api_4.ThinkingAdaptive,
      'ThinkingEnabled': $tom_vscode_scripting_api_4.ThinkingEnabled,
      'ThinkingDisabled': $tom_vscode_scripting_api_4.ThinkingDisabled,
      'Skills': $tom_vscode_scripting_api_4.Skills,
      'SkillsList': $tom_vscode_scripting_api_4.SkillsList,
      'SkillsAll': $tom_vscode_scripting_api_4.SkillsAll,
      'SettingsRef': $tom_vscode_scripting_api_4.SettingsRef,
      'SettingsPath': $tom_vscode_scripting_api_4.SettingsPath,
      'SettingsInline': $tom_vscode_scripting_api_4.SettingsInline,
      'OutputFormat': $tom_vscode_scripting_api_4.OutputFormat,
      'TaskBudget': $tom_vscode_scripting_api_4.TaskBudget,
      'PluginConfig': $tom_vscode_scripting_api_4.PluginConfig,
      'AgentDefinition': $tom_vscode_scripting_api_4.AgentDefinition,
      'Options': $tom_vscode_scripting_api_4.Options,
      'AgentSdkTransport': $tom_vscode_scripting_api_7.AgentSdkTransport,
      'AgentSdkQueryException': $tom_vscode_scripting_api_7.AgentSdkQueryException,
      'AgentQuery': $tom_vscode_scripting_api_7.AgentQuery,
      'AgentSdkClient': $tom_vscode_scripting_api_7.AgentSdkClient,
      'VSCodeBridgeAgentSdkTransport': $tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport,
      'BridgeRequestDispatcher': $tom_vscode_scripting_api_12.BridgeRequestDispatcher,
      'AgentSdkToolRegistry': $tom_vscode_scripting_api_8.AgentSdkToolRegistry,
      'AiTokenStats': $tom_vscode_scripting_api_10.AiTokenStats,
      'AiPromptResult': $tom_vscode_scripting_api_10.AiPromptResult,
      'AiPromptProfile': $tom_vscode_scripting_api_10.AiPromptProfile,
      'AiModelConfig': $tom_vscode_scripting_api_10.AiModelConfig,
      'AiModelsResult': $tom_vscode_scripting_api_10.AiModelsResult,
      'AiPromptApi': $tom_vscode_scripting_api_10.AiPromptApi,
      'CopilotResponse': $tom_vscode_scripting_api_9.CopilotResponse,
      'ConversationExchange': $tom_vscode_scripting_api_9.ConversationExchange,
      'ConversationResult': $tom_vscode_scripting_api_9.ConversationResult,
      'ConversationStatus': $tom_vscode_scripting_api_9.ConversationStatus,
      'ConversationProfile': $tom_vscode_scripting_api_9.ConversationProfile,
      'ConversationConfig': $tom_vscode_scripting_api_9.ConversationConfig,
      'SingleTurnResult': $tom_vscode_scripting_api_9.SingleTurnResult,
      'ConversationActionResult': $tom_vscode_scripting_api_9.ConversationActionResult,
      'ConversationLog': $tom_vscode_scripting_api_9.ConversationLog,
      'AiConversationApi': $tom_vscode_scripting_api_9.AiConversationApi,
      'TodoReference': $tom_vscode_scripting_api_17.TodoReference,
      'TodoScope': $tom_vscode_scripting_api_17.TodoScope,
      'TodoItem': $tom_vscode_scripting_api_17.TodoItem,
      'TodoListResult': $tom_vscode_scripting_api_17.TodoListResult,
      'TodoFileListResult': $tom_vscode_scripting_api_17.TodoFileListResult,
      'TomTodoApi': $tom_vscode_scripting_api_17.TomTodoApi,
      'QueuedFollowUp': $tom_vscode_scripting_api_15.QueuedFollowUp,
      'QueuedPrompt': $tom_vscode_scripting_api_15.QueuedPrompt,
      'QueueListResult': $tom_vscode_scripting_api_15.QueueListResult,
      'QueueItemInput': $tom_vscode_scripting_api_15.QueueItemInput,
      'FollowUpInput': $tom_vscode_scripting_api_15.FollowUpInput,
      'TomQueueApi': $tom_vscode_scripting_api_15.TomQueueApi,
      'ScheduledTime': $tom_vscode_scripting_api_16.ScheduledTime,
      'TimedRequest': $tom_vscode_scripting_api_16.TimedRequest,
      'TimedRequestListResult': $tom_vscode_scripting_api_16.TimedRequestListResult,
      'TimedRequestInput': $tom_vscode_scripting_api_16.TimedRequestInput,
      'TomTimedApi': $tom_vscode_scripting_api_16.TomTimedApi,
      'DocumentInfo': $tom_vscode_scripting_api_14.DocumentInfo,
      'DocumentListResult': $tom_vscode_scripting_api_14.DocumentListResult,
      'DocumentContent': $tom_vscode_scripting_api_14.DocumentContent,
      'TrailEntry': $tom_vscode_scripting_api_14.TrailEntry,
      'TrailListResult': $tom_vscode_scripting_api_14.TrailListResult,
      'GuidelineInfo': $tom_vscode_scripting_api_14.GuidelineInfo,
      'GuidelineListResult': $tom_vscode_scripting_api_14.GuidelineListResult,
      'TomDocumentApi': $tom_vscode_scripting_api_14.TomDocumentApi,
      'ProjectInfo': $tom_vscode_scripting_api_19.ProjectInfo,
      'ProjectListResult': $tom_vscode_scripting_api_19.ProjectListResult,
      'QuestInfo': $tom_vscode_scripting_api_19.QuestInfo,
      'QuestListResult': $tom_vscode_scripting_api_19.QuestListResult,
      'WorkspaceInfo': $tom_vscode_scripting_api_19.WorkspaceInfo,
      'ChatVariable': $tom_vscode_scripting_api_19.ChatVariable,
      'ChatVariableListResult': $tom_vscode_scripting_api_19.ChatVariableListResult,
      'TomWorkspaceApi': $tom_vscode_scripting_api_19.TomWorkspaceApi,
      'ToolDefinitionJson': $tom_vscode_scripting_api_18.ToolDefinitionJson,
      'TomToolsApi': $tom_vscode_scripting_api_18.TomToolsApi,
      'SendToChatResult': $tom_vscode_scripting_api_13.SendToChatResult,
      'TomChatApi': $tom_vscode_scripting_api_13.TomChatApi,
    };
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'VSCodeAdapter': 'package:tom_vscode_scripting_api/src/vscode_adapter.dart',
      'VSCodeBridgeResult': 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart',
      'VSCodeBridgeClient': 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart',
      'VSCodeBridgeAdapter': 'package:tom_vscode_scripting_api/src/vscode_bridge_adapter.dart',
      'LazyVSCodeBridgeAdapter': 'package:tom_vscode_scripting_api/src/vscode_bridge_adapter.dart',
      'BridgeWorkspaceNotFoundException': 'package:tom_vscode_scripting_api/src/bridge_discovery.dart',
      'VSCode': 'package:tom_vscode_scripting_api/src/vscode.dart',
      'VSCodeCommands': 'package:tom_vscode_scripting_api/src/vscode_commands.dart',
      'VSCodeCommonCommands': 'package:tom_vscode_scripting_api/src/vscode_commands.dart',
      'Extension': 'package:tom_vscode_scripting_api/src/vscode_extensions.dart',
      'VSCodeExtensions': 'package:tom_vscode_scripting_api/src/vscode_extensions.dart',
      'VSCodeLanguageModel': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelChat': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelChatMessage': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelChatResponse': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelToolResult': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'LanguageModelToolInformation': 'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'VSCodeWindow': 'package:tom_vscode_scripting_api/src/vscode_window.dart',
      'VSCodeWorkspace': 'package:tom_vscode_scripting_api/src/vscode_workspace.dart',
      'VSCodeChat': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatParticipant': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatRequest': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatPromptReference': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatContext': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatResult': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatErrorDetails': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'ChatResponseStream': 'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'HelperLogging': 'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'VsCodeHelper': 'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'VsProgress': 'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'FileBatch': 'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'VSCodeUri': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'WorkspaceFolder': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'TextDocument': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'Position': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'Range': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'Selection': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'TextEditor': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'QuickPickItem': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'InputBoxOptions': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'MessageOptions': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'TerminalOptions': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'FileSystemWatcherOptions': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'SdkMessage': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'SdkAssistantMessage': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'SdkUserMessage': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'SdkResultMessage': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'SdkSystemMessage': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'SdkPartialAssistantMessage': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'SdkSystemEvent': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'SdkUnknownMessage': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'ContentBlock': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'TextBlock': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'ThinkingBlock': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'ToolUseBlock': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'ToolResultBlock': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'UnknownBlock': 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'PermissionRuleValue': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionUpdate': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionUpdateRules': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionUpdateSetMode': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionUpdateDirectories': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionResult': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionAllow': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionDeny': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'CanUseToolContext': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'CallToolResult': 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'SdkMcpTool': 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'McpServerToolPolicy': 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'McpServerConfig': 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'McpStdioServerConfig': 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'McpSSEServerConfig': 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'McpHttpServerConfig': 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'McpSdkServerConfig': 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'SystemPrompt': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'SystemPromptText': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'SystemPromptList': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'SystemPromptPreset': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'ToolsConfig': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'ToolsList': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'ToolsClaudeCodePreset': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'ThinkingConfig': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'ThinkingAdaptive': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'ThinkingEnabled': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'ThinkingDisabled': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'Skills': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'SkillsList': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'SkillsAll': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'SettingsRef': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'SettingsPath': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'SettingsInline': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'OutputFormat': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'TaskBudget': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'PluginConfig': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'AgentDefinition': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'Options': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'AgentSdkTransport': 'package:tom_vscode_scripting_api/src/agent_sdk_query.dart',
      'AgentSdkQueryException': 'package:tom_vscode_scripting_api/src/agent_sdk_query.dart',
      'AgentQuery': 'package:tom_vscode_scripting_api/src/agent_sdk_query.dart',
      'AgentSdkClient': 'package:tom_vscode_scripting_api/src/agent_sdk_query.dart',
      'VSCodeBridgeAgentSdkTransport': 'package:tom_vscode_scripting_api/src/agent_sdk_query.dart',
      'BridgeRequestDispatcher': 'package:tom_vscode_scripting_api/src/bridge_request_dispatcher.dart',
      'AgentSdkToolRegistry': 'package:tom_vscode_scripting_api/src/agent_sdk_tool_registry.dart',
      'AiTokenStats': 'package:tom_vscode_scripting_api/src/ai_prompt_api.dart',
      'AiPromptResult': 'package:tom_vscode_scripting_api/src/ai_prompt_api.dart',
      'AiPromptProfile': 'package:tom_vscode_scripting_api/src/ai_prompt_api.dart',
      'AiModelConfig': 'package:tom_vscode_scripting_api/src/ai_prompt_api.dart',
      'AiModelsResult': 'package:tom_vscode_scripting_api/src/ai_prompt_api.dart',
      'AiPromptApi': 'package:tom_vscode_scripting_api/src/ai_prompt_api.dart',
      'CopilotResponse': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'ConversationExchange': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'ConversationResult': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'ConversationStatus': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'ConversationProfile': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'ConversationConfig': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'SingleTurnResult': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'ConversationActionResult': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'ConversationLog': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'AiConversationApi': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'TodoReference': 'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'TodoScope': 'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'TodoItem': 'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'TodoListResult': 'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'TodoFileListResult': 'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'TomTodoApi': 'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'QueuedFollowUp': 'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'QueuedPrompt': 'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'QueueListResult': 'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'QueueItemInput': 'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'FollowUpInput': 'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'TomQueueApi': 'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'ScheduledTime': 'package:tom_vscode_scripting_api/src/tom_timed_api.dart',
      'TimedRequest': 'package:tom_vscode_scripting_api/src/tom_timed_api.dart',
      'TimedRequestListResult': 'package:tom_vscode_scripting_api/src/tom_timed_api.dart',
      'TimedRequestInput': 'package:tom_vscode_scripting_api/src/tom_timed_api.dart',
      'TomTimedApi': 'package:tom_vscode_scripting_api/src/tom_timed_api.dart',
      'DocumentInfo': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'DocumentListResult': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'DocumentContent': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'TrailEntry': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'TrailListResult': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'GuidelineInfo': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'GuidelineListResult': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'TomDocumentApi': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'ProjectInfo': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'ProjectListResult': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'QuestInfo': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'QuestListResult': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'WorkspaceInfo': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'ChatVariable': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'ChatVariableListResult': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'TomWorkspaceApi': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'ToolDefinitionJson': 'package:tom_vscode_scripting_api/src/tom_tools_api.dart',
      'TomToolsApi': 'package:tom_vscode_scripting_api/src/tom_tools_api.dart',
      'SendToChatResult': 'package:tom_vscode_scripting_api/src/tom_chat_api.dart',
      'TomChatApi': 'package:tom_vscode_scripting_api/src/tom_chat_api.dart',
    };
  }

  /// Returns a map of class names to their flattened (transitive)
  /// native supertype names (superclasses, interfaces and mixins).
  ///
  /// Fed to `BridgedClass.registerSupertypes` so interpreted subclasses
  /// of bridged classes pass `is`/subtype checks against bridged
  /// ancestors and the interface-proxy supertype walk resolves up the
  /// chain.
  static Map<String, List<String>> classSupertypes() {
    return {
      'VSCodeBridgeAdapter': ['VSCodeAdapter'],
      'LazyVSCodeBridgeAdapter': ['VSCodeAdapter'],
      'BridgeWorkspaceNotFoundException': ['Exception'],
      'Selection': ['Range'],
      'SdkAssistantMessage': ['SdkMessage'],
      'SdkUserMessage': ['SdkMessage'],
      'SdkResultMessage': ['SdkMessage'],
      'SdkSystemMessage': ['SdkMessage'],
      'SdkPartialAssistantMessage': ['SdkMessage'],
      'SdkSystemEvent': ['SdkMessage'],
      'SdkUnknownMessage': ['SdkMessage'],
      'TextBlock': ['ContentBlock'],
      'ThinkingBlock': ['ContentBlock'],
      'ToolUseBlock': ['ContentBlock'],
      'ToolResultBlock': ['ContentBlock'],
      'UnknownBlock': ['ContentBlock'],
      'PermissionUpdateRules': ['PermissionUpdate'],
      'PermissionUpdateSetMode': ['PermissionUpdate'],
      'PermissionUpdateDirectories': ['PermissionUpdate'],
      'PermissionAllow': ['PermissionResult'],
      'PermissionDeny': ['PermissionResult'],
      'McpStdioServerConfig': ['McpServerConfig'],
      'McpSSEServerConfig': ['McpServerConfig'],
      'McpHttpServerConfig': ['McpServerConfig'],
      'McpSdkServerConfig': ['McpServerConfig'],
      'SystemPromptText': ['SystemPrompt'],
      'SystemPromptList': ['SystemPrompt'],
      'SystemPromptPreset': ['SystemPrompt'],
      'ToolsList': ['ToolsConfig'],
      'ToolsClaudeCodePreset': ['ToolsConfig'],
      'ThinkingAdaptive': ['ThinkingConfig'],
      'ThinkingEnabled': ['ThinkingConfig'],
      'ThinkingDisabled': ['ThinkingConfig'],
      'SkillsList': ['Skills'],
      'SkillsAll': ['Skills'],
      'SettingsPath': ['SettingsRef'],
      'SettingsInline': ['SettingsRef'],
      'AgentSdkQueryException': ['Exception'],
      'AgentQuery': ['StreamView', 'Stream'],
      'VSCodeBridgeAgentSdkTransport': ['AgentSdkTransport'],
    };
  }

  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
    };
  }

  /// Returns the list of function typedef names declared in this library.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are
  /// registered so that they can be used as type arguments in D4rt scripts.
  static List<String> functionTypedefs() {
    return [
      'BridgeRequestHandler',
      'BridgePortProbe',
      'BridgeIdentityFetcher',
      'BridgeAdapterFactory',
      'ChatRequestHandler',
      'CanUseTool',
      'ToolHandler',
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$tom_vscode_scripting_api_29.DiagnosticSeverity>(
        name: 'DiagnosticSeverity',
        values: $tom_vscode_scripting_api_29.DiagnosticSeverity.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_29.DiagnosticSeverity).value,
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_6.PermissionMode>(
        name: 'PermissionMode',
        values: $tom_vscode_scripting_api_6.PermissionMode.values,
        getters: {
          'wire': (visitor, target) => (target as $tom_vscode_scripting_api_6.PermissionMode).wire,
        },
        methods: {
          'toJson': (visitor, target, positional, named, typeArgs) {
            final t = target as $tom_vscode_scripting_api_6.PermissionMode;
            return Function.apply(t.toJson, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
        staticMethods: {
          'fromWire': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_6.PermissionMode.fromWire, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_6.PermissionBehavior>(
        name: 'PermissionBehavior',
        values: $tom_vscode_scripting_api_6.PermissionBehavior.values,
        getters: {
          'wire': (visitor, target) => (target as $tom_vscode_scripting_api_6.PermissionBehavior).wire,
        },
        staticMethods: {
          'fromWire': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_6.PermissionBehavior.fromWire, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_6.PermissionUpdateDestination>(
        name: 'PermissionUpdateDestination',
        values: $tom_vscode_scripting_api_6.PermissionUpdateDestination.values,
        getters: {
          'wire': (visitor, target) => (target as $tom_vscode_scripting_api_6.PermissionUpdateDestination).wire,
        },
        staticMethods: {
          'fromWire': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_6.PermissionUpdateDestination.fromWire, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_6.PermissionDecisionClassification>(
        name: 'PermissionDecisionClassification',
        values: $tom_vscode_scripting_api_6.PermissionDecisionClassification.values,
        getters: {
          'wire': (visitor, target) => (target as $tom_vscode_scripting_api_6.PermissionDecisionClassification).wire,
        },
        staticMethods: {
          'fromWire': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_6.PermissionDecisionClassification.fromWire, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_4.SettingSource>(
        name: 'SettingSource',
        values: $tom_vscode_scripting_api_4.SettingSource.values,
        getters: {
          'wire': (visitor, target) => (target as $tom_vscode_scripting_api_4.SettingSource).wire,
        },
        staticMethods: {
          'fromWire': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_4.SettingSource.fromWire, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_4.EffortLevel>(
        name: 'EffortLevel',
        values: $tom_vscode_scripting_api_4.EffortLevel.values,
        getters: {
          'wire': (visitor, target) => (target as $tom_vscode_scripting_api_4.EffortLevel).wire,
        },
        staticMethods: {
          'fromWire': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_4.EffortLevel.fromWire, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_9.ConversationMode>(
        name: 'ConversationMode',
        values: $tom_vscode_scripting_api_9.ConversationMode.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_9.ConversationMode).value,
        },
        methods: {
          'toString': (visitor, target, positional, named, typeArgs) {
            final t = target as $tom_vscode_scripting_api_9.ConversationMode;
            return Function.apply(t.toString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_9.ConversationMode.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_9.HistoryMode>(
        name: 'HistoryMode',
        values: $tom_vscode_scripting_api_9.HistoryMode.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_9.HistoryMode).value,
        },
        methods: {
          'toString': (visitor, target, positional, named, typeArgs) {
            final t = target as $tom_vscode_scripting_api_9.HistoryMode;
            return Function.apply(t.toString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_9.HistoryMode.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_17.TodoStatus>(
        name: 'TodoStatus',
        values: $tom_vscode_scripting_api_17.TodoStatus.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_17.TodoStatus).value,
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_17.TodoStatus.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_17.TodoPriority>(
        name: 'TodoPriority',
        values: $tom_vscode_scripting_api_17.TodoPriority.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_17.TodoPriority).value,
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_17.TodoPriority.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_15.QueuedPromptStatus>(
        name: 'QueuedPromptStatus',
        values: $tom_vscode_scripting_api_15.QueuedPromptStatus.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_15.QueuedPromptStatus).value,
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_15.QueuedPromptStatus.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_15.QueuedPromptType>(
        name: 'QueuedPromptType',
        values: $tom_vscode_scripting_api_15.QueuedPromptType.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_15.QueuedPromptType).value,
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_15.QueuedPromptType.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_16.TimedRequestStatus>(
        name: 'TimedRequestStatus',
        values: $tom_vscode_scripting_api_16.TimedRequestStatus.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_16.TimedRequestStatus).value,
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_16.TimedRequestStatus.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_16.ScheduleMode>(
        name: 'ScheduleMode',
        values: $tom_vscode_scripting_api_16.ScheduleMode.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_16.ScheduleMode).value,
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_16.ScheduleMode.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_14.DocumentFolder>(
        name: 'DocumentFolder',
        values: $tom_vscode_scripting_api_14.DocumentFolder.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_14.DocumentFolder).value,
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_14.DocumentFolder.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_vscode_scripting_api_19.ProjectType>(
        name: 'ProjectType',
        values: $tom_vscode_scripting_api_19.ProjectType.values,
        getters: {
          'value': (visitor, target) => (target as $tom_vscode_scripting_api_19.ProjectType).value,
        },
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) {
            return Function.apply($tom_vscode_scripting_api_19.ProjectType.fromString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'DiagnosticSeverity': 'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'PermissionMode': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionBehavior': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionUpdateDestination': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'PermissionDecisionClassification': 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'SettingSource': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'EffortLevel': 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'ConversationMode': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'HistoryMode': 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'TodoStatus': 'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'TodoPriority': 'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'QueuedPromptStatus': 'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'QueuedPromptType': 'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'TimedRequestStatus': 'package:tom_vscode_scripting_api/src/tom_timed_api.dart',
      'ScheduleMode': 'package:tom_vscode_scripting_api/src/tom_timed_api.dart',
      'DocumentFolder': 'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'ProjectType': 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
    };
  }

  /// GEN-107: Library re-exports declared by the bridged source
  /// libraries. Each tuple mirrors a Dart `export '…'` directive.
  /// Consumed by `registerBridges` via `D4rt.registerLibraryReExport`
  /// (mirrored on `D4rtRunner` in tom_d4rt_ast).
  static List<({String source, String target, Set<String>? show, Set<String>? hide})>
  bridgeReExports() {
    return [
      (source: 'package:tom_vscode_scripting_api/script_globals.dart', target: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_adapter.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_bridge_adapter.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/bridge_discovery.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_commands.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_extensions.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_lm.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_window.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_workspace.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_chat.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_helper.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/vscode_types.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/agent_sdk_options.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/agent_sdk_query.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/bridge_request_dispatcher.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/agent_sdk_tool_registry.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/agent_sdk_permission_dispatch.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/ai_prompt_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/ai_conversation_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/tom_todo_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/tom_queue_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/tom_timed_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/tom_document_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/tom_workspace_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/tom_tools_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/src/tom_chat_api.dart', show: null, hide: null),
      (source: 'package:tom_vscode_scripting_api/tom_vscode_scripting_api.dart', target: 'package:tom_vscode_scripting_api/script_globals.dart', show: null, hide: null),
    ];
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Step #17 — register deferred factory thunks (not pre-built
    // BridgedClass objects): a script touching N of the M classes
    // materializes ≈N (each thunk builds its class on first resolve).
    final classThunks = bridgeClassThunks();
    final classTypes = bridgeClassTypes();
    final classSources = classSourceUris();
    for (final entry in classThunks.entries) {
      interpreter.registerBridgedClassLazy(
        entry.key,
        classTypes[entry.key]!,
        entry.value,
        importPath,
        sourceUri: classSources[entry.key],
      );
    }

    // Register the flattened native supertype table so
    // interpreted subclasses pass subtype checks against bridged
    // ancestors. Idempotent — safe to call per barrel.
    BridgedClass.registerSupertypes(classSupertypes());

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
    }

    // Register global variables
    registerGlobalVariables(interpreter, importPath);

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }

    // Register function typedefs for type resolution
    final typedefs = functionTypedefs();
    for (final name in typedefs) {
      interpreter.registerFunctionTypedef(name, importPath);
    }

    // GEN-107: Register library re-exports
    for (final r in bridgeReExports()) {
      interpreter.registerLibraryReExport(r.source, r.target, show: r.show, hide: r.hide);
    }
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('defaultVSCodeBridgePort', $tom_vscode_scripting_api_23.defaultVSCodeBridgePort, importPath, sourceUri: 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart');
    } catch (e) {
      errors.add('Failed to register variable "defaultVSCodeBridgePort": $e');
    }
    try {
      interpreter.registerGlobalVariable('maxVSCodeBridgePort', $tom_vscode_scripting_api_23.maxVSCodeBridgePort, importPath, sourceUri: 'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart');
    } catch (e) {
      errors.add('Failed to register variable "maxVSCodeBridgePort": $e');
    }
    interpreter.registerGlobalGetter('vscode', () => $tom_vscode_scripting_api_1.vscode, importPath, sourceUri: 'package:tom_vscode_scripting_api/script_globals.dart');
    interpreter.registerGlobalGetter('window', () => $tom_vscode_scripting_api_1.window, importPath, sourceUri: 'package:tom_vscode_scripting_api/script_globals.dart');
    interpreter.registerGlobalGetter('workspace', () => $tom_vscode_scripting_api_1.workspace, importPath, sourceUri: 'package:tom_vscode_scripting_api/script_globals.dart');
    interpreter.registerGlobalGetter('commands', () => $tom_vscode_scripting_api_1.commands, importPath, sourceUri: 'package:tom_vscode_scripting_api/script_globals.dart');
    interpreter.registerGlobalGetter('extensions', () => $tom_vscode_scripting_api_1.extensions, importPath, sourceUri: 'package:tom_vscode_scripting_api/script_globals.dart');
    interpreter.registerGlobalGetter('lm', () => $tom_vscode_scripting_api_1.lm, importPath, sourceUri: 'package:tom_vscode_scripting_api/script_globals.dart');
    interpreter.registerGlobalGetter('chat', () => $tom_vscode_scripting_api_1.chat, importPath, sourceUri: 'package:tom_vscode_scripting_api/script_globals.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (tom_vscode_scripting_api):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'findBridgePortForWorkspace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findBridgePortForWorkspace');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'findBridgePortForWorkspace');
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'findBridgePortForWorkspace');
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, minPort: minPort);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'findBridgePortForWorkspace');
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, maxPort: maxPort);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'findBridgePortForWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'findBridgePortForWorkspace');
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, minPort: minPort, maxPort: maxPort);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, probe: probe);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'findBridgePortForWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, minPort: minPort, probe: probe);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'findBridgePortForWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, maxPort: maxPort, probe: probe);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'findBridgePortForWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'findBridgePortForWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, minPort: minPort, maxPort: maxPort, probe: probe);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'findBridgePortForWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, minPort: minPort, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'findBridgePortForWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, maxPort: maxPort, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'findBridgePortForWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'findBridgePortForWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, minPort: minPort, maxPort: maxPort, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'findBridgePortForWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, minPort: minPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'findBridgePortForWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, maxPort: maxPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'findBridgePortForWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'findBridgePortForWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.findBridgePortForWorkspace(name, host: host, minPort: minPort, maxPort: maxPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'scanBridgePorts': (visitor, positional, named, typeArgs) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'scanBridgePorts');
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, minPort: minPort);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'scanBridgePorts');
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, maxPort: maxPort);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'scanBridgePorts');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'scanBridgePorts');
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, minPort: minPort, maxPort: maxPort);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, probe: probe);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'scanBridgePorts');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, minPort: minPort, probe: probe);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'scanBridgePorts');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, maxPort: maxPort, probe: probe);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'scanBridgePorts');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'scanBridgePorts');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, minPort: minPort, maxPort: maxPort, probe: probe);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'scanBridgePorts');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, minPort: minPort, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'scanBridgePorts');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, maxPort: maxPort, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'scanBridgePorts');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'scanBridgePorts');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, minPort: minPort, maxPort: maxPort, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'scanBridgePorts');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, minPort: minPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'scanBridgePorts');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, maxPort: maxPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'scanBridgePorts');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'scanBridgePorts');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.scanBridgePorts(host: host, minPort: minPort, maxPort: maxPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'connectToWorkspace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'connectToWorkspace');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'connectToWorkspace');
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        final initializeVSCode = D4.getNamedArgWithDefault<bool>(named, 'initializeVSCode', false);
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, maxPort: maxPort);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, maxPort: maxPort);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, probe: probe);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, probe: probe);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, maxPort: maxPort, probe: probe);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, maxPort: maxPort, probe: probe);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, maxPort: maxPort, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, maxPort: maxPort, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, maxPort: maxPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity') && !named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, maxPort: maxPort, probe: probe, fetchIdentity: fetchIdentity);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, adapterFactory: adapterFactory);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, adapterFactory: adapterFactory);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, maxPort: maxPort, adapterFactory: adapterFactory);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && !named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, maxPort: maxPort, adapterFactory: adapterFactory);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, probe: probe, adapterFactory: adapterFactory);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, probe: probe, adapterFactory: adapterFactory);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, maxPort: maxPort, probe: probe, adapterFactory: adapterFactory);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && !named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, maxPort: maxPort, probe: probe, adapterFactory: adapterFactory);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, fetchIdentity: fetchIdentity, adapterFactory: adapterFactory);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, fetchIdentity: fetchIdentity, adapterFactory: adapterFactory);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, maxPort: maxPort, fetchIdentity: fetchIdentity, adapterFactory: adapterFactory);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && !named.containsKey('probe') && named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, maxPort: maxPort, fetchIdentity: fetchIdentity, adapterFactory: adapterFactory);
        }
        if (!named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, probe: probe, fetchIdentity: fetchIdentity, adapterFactory: adapterFactory);
        }
        if (named.containsKey('minPort') && !named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, probe: probe, fetchIdentity: fetchIdentity, adapterFactory: adapterFactory);
        }
        if (!named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, maxPort: maxPort, probe: probe, fetchIdentity: fetchIdentity, adapterFactory: adapterFactory);
        }
        if (named.containsKey('minPort') && named.containsKey('maxPort') && named.containsKey('probe') && named.containsKey('fetchIdentity') && named.containsKey('adapterFactory')) {
          final minPort = D4.getRequiredNamedArg<int>(named, 'minPort', 'connectToWorkspace');
          final maxPort = D4.getRequiredNamedArg<int>(named, 'maxPort', 'connectToWorkspace');
          final probeRaw = named['probe'];
          final probe = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, probeRaw, [p0, p1])).then((v) => v as bool); }) as Future<bool> Function(String, int);
          final fetchIdentityRaw = named['fetchIdentity'];
          final fetchIdentity = ((String p0, int p1) { return Future.value(D4.callInterpreterCallback(visitor!, fetchIdentityRaw, [p0, p1])).then((v) => v as String?); }) as Future<String?> Function(String, int);
          final adapterFactoryRaw = named['adapterFactory'];
          final adapterFactory = ((String p0, int p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(D4.callInterpreterCallback(visitor!, adapterFactoryRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter; }) as $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter Function(String, int);
          return $tom_vscode_scripting_api_11.connectToWorkspace(name, host: host, initializeVSCode: initializeVSCode, minPort: minPort, maxPort: maxPort, probe: probe, fetchIdentity: fetchIdentity, adapterFactory: adapterFactory);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'fetchBridgeWorkspaceName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'fetchBridgeWorkspaceName');
        final host = D4.getRequiredArg<String>(positional, 0, 'host', 'fetchBridgeWorkspaceName');
        final port = D4.getRequiredArg<int>(positional, 1, 'port', 'fetchBridgeWorkspaceName');
        return $tom_vscode_scripting_api_11.fetchBridgeWorkspaceName(host, port);
      },
      'normalizeWorkspaceName': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'normalizeWorkspaceName');
        final value = D4.getRequiredArg<String>(positional, 0, 'value', 'normalizeWorkspaceName');
        return $tom_vscode_scripting_api_11.normalizeWorkspaceName(value);
      },
      'dispatchCanUseTool': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'dispatchCanUseTool');
        if (positional.isEmpty) {
          throw ArgumentError('dispatchCanUseTool: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final callback = ((String p0, Map<String, dynamic> p1, $tom_vscode_scripting_api_6.CanUseToolContext p2) { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [p0, p1, p2])).then((v) => v as $tom_vscode_scripting_api_6.PermissionResult); }) as Future<$tom_vscode_scripting_api_6.PermissionResult> Function(String, Map<String, dynamic>, $tom_vscode_scripting_api_6.CanUseToolContext);
        final params = D4.getRequiredArg<Map<String, dynamic>>(positional, 1, 'params', 'dispatchCanUseTool');
        return $tom_vscode_scripting_api_5.dispatchCanUseTool(callback, params);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'findBridgePortForWorkspace': 'package:tom_vscode_scripting_api/src/bridge_discovery.dart',
      'scanBridgePorts': 'package:tom_vscode_scripting_api/src/bridge_discovery.dart',
      'connectToWorkspace': 'package:tom_vscode_scripting_api/src/bridge_discovery.dart',
      'fetchBridgeWorkspaceName': 'package:tom_vscode_scripting_api/src/bridge_discovery.dart',
      'normalizeWorkspaceName': 'package:tom_vscode_scripting_api/src/bridge_discovery.dart',
      'dispatchCanUseTool': 'package:tom_vscode_scripting_api/src/agent_sdk_permission_dispatch.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'findBridgePortForWorkspace': 'Future<int> findBridgePortForWorkspace(String name, {String host = \'127.0.0.1\', int minPort = defaultVSCodeBridgePort, int maxPort = maxVSCodeBridgePort, BridgePortProbe probe = _defaultProbe, BridgeIdentityFetcher fetchIdentity = fetchBridgeWorkspaceName})',
      'scanBridgePorts': 'Future<Map<int, String>> scanBridgePorts({String host = \'127.0.0.1\', int minPort = defaultVSCodeBridgePort, int maxPort = maxVSCodeBridgePort, BridgePortProbe probe = _defaultProbe, BridgeIdentityFetcher fetchIdentity = fetchBridgeWorkspaceName})',
      'connectToWorkspace': 'Future<LazyVSCodeBridgeAdapter> connectToWorkspace(String name, {String host = \'127.0.0.1\', int minPort = defaultVSCodeBridgePort, int maxPort = maxVSCodeBridgePort, BridgePortProbe probe = _defaultProbe, BridgeIdentityFetcher fetchIdentity = fetchBridgeWorkspaceName, bool initializeVSCode = false, BridgeAdapterFactory adapterFactory = _defaultAdapterFactory})',
      'fetchBridgeWorkspaceName': 'Future<String?> fetchBridgeWorkspaceName(String host, int port)',
      'normalizeWorkspaceName': 'String normalizeWorkspaceName(String value)',
      'dispatchCanUseTool': 'Future<Map<String, dynamic>> dispatchCanUseTool(CanUseTool callback, Map<String, dynamic> params)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:tom_vscode_scripting_api/script_globals.dart',
      'package:tom_vscode_scripting_api/src/agent_sdk_mcp.dart',
      'package:tom_vscode_scripting_api/src/agent_sdk_messages.dart',
      'package:tom_vscode_scripting_api/src/agent_sdk_options.dart',
      'package:tom_vscode_scripting_api/src/agent_sdk_permission_dispatch.dart',
      'package:tom_vscode_scripting_api/src/agent_sdk_permissions.dart',
      'package:tom_vscode_scripting_api/src/agent_sdk_query.dart',
      'package:tom_vscode_scripting_api/src/agent_sdk_tool_registry.dart',
      'package:tom_vscode_scripting_api/src/ai_conversation_api.dart',
      'package:tom_vscode_scripting_api/src/ai_prompt_api.dart',
      'package:tom_vscode_scripting_api/src/bridge_discovery.dart',
      'package:tom_vscode_scripting_api/src/bridge_request_dispatcher.dart',
      'package:tom_vscode_scripting_api/src/tom_chat_api.dart',
      'package:tom_vscode_scripting_api/src/tom_document_api.dart',
      'package:tom_vscode_scripting_api/src/tom_queue_api.dart',
      'package:tom_vscode_scripting_api/src/tom_timed_api.dart',
      'package:tom_vscode_scripting_api/src/tom_todo_api.dart',
      'package:tom_vscode_scripting_api/src/tom_tools_api.dart',
      'package:tom_vscode_scripting_api/src/tom_workspace_api.dart',
      'package:tom_vscode_scripting_api/src/vscode.dart',
      'package:tom_vscode_scripting_api/src/vscode_adapter.dart',
      'package:tom_vscode_scripting_api/src/vscode_bridge_adapter.dart',
      'package:tom_vscode_scripting_api/src/vscode_bridge_client.dart',
      'package:tom_vscode_scripting_api/src/vscode_chat.dart',
      'package:tom_vscode_scripting_api/src/vscode_commands.dart',
      'package:tom_vscode_scripting_api/src/vscode_extensions.dart',
      'package:tom_vscode_scripting_api/src/vscode_helper.dart',
      'package:tom_vscode_scripting_api/src/vscode_lm.dart',
      'package:tom_vscode_scripting_api/src/vscode_types.dart',
      'package:tom_vscode_scripting_api/src/vscode_window.dart',
      'package:tom_vscode_scripting_api/src/vscode_workspace.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:tom_vscode_scripting_api/script_globals.dart';";
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'DiagnosticSeverity',
    'PermissionMode',
    'PermissionBehavior',
    'PermissionUpdateDestination',
    'PermissionDecisionClassification',
    'SettingSource',
    'EffortLevel',
    'ConversationMode',
    'HistoryMode',
    'TodoStatus',
    'TodoPriority',
    'QueuedPromptStatus',
    'QueuedPromptType',
    'TimedRequestStatus',
    'ScheduleMode',
    'DocumentFolder',
    'ProjectType',
  ];

}

// =============================================================================
// VSCodeAdapter Bridge
// =============================================================================

BridgedClass _createVSCodeAdapterBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_21.VSCodeAdapter,
    name: 'VSCodeAdapter',
    isAssignable: (v) => v is $tom_vscode_scripting_api_21.VSCodeAdapter,
    isAbstract: true,
    constructors: {
    },
    methods: {
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_21.VSCodeAdapter>(target, 'VSCodeAdapter');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "params" at position 1');
        }
        final params = D4.coerceMap<String, dynamic>(positional[1], 'params');
        final scriptName = D4.getOptionalNamedArg<String?>(named, 'scriptName');
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(seconds: 60));
        return t.sendRequest(method, params, scriptName: scriptName, timeout: timeout);
      },
    },
    methodSignatures: {
      'sendRequest': 'Future<Map<String, dynamic>> sendRequest(String method, Map<String, dynamic> params, {String? scriptName, Duration timeout = const Duration(seconds: 60)})',
    },
  );
}

// =============================================================================
// VSCodeBridgeResult Bridge
// =============================================================================

BridgedClass _createVSCodeBridgeResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_23.VSCodeBridgeResult,
    name: 'VSCodeBridgeResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_23.VSCodeBridgeResult,
    constructors: {
      '': (visitor, positional, named) {
        final success = D4.getRequiredNamedArg<bool>(named, 'success', 'VSCodeBridgeResult');
        final output = D4.getNamedArgWithDefault<String>(named, 'output', '');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final stackTrace = D4.getOptionalNamedArg<String?>(named, 'stackTrace');
        final exception = D4.getOptionalNamedArg<String?>(named, 'exception');
        final exceptionStackTrace = D4.getOptionalNamedArg<String?>(named, 'exceptionStackTrace');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VSCodeBridgeResult');
        if (!named.containsKey('value')) {
          return $tom_vscode_scripting_api_23.VSCodeBridgeResult(success: success, output: output, error: error, stackTrace: stackTrace, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration);
        }
        if (named.containsKey('value')) {
          final value = D4.getRequiredNamedArg<dynamic>(named, 'value', 'VSCodeBridgeResult');
          return $tom_vscode_scripting_api_23.VSCodeBridgeResult(success: success, output: output, error: error, stackTrace: stackTrace, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration, value: value);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'success': (visitor, positional, named) {
        final output = D4.getNamedArgWithDefault<String>(named, 'output', '');
        final exception = D4.getOptionalNamedArg<String?>(named, 'exception');
        final exceptionStackTrace = D4.getOptionalNamedArg<String?>(named, 'exceptionStackTrace');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VSCodeBridgeResult');
        if (!named.containsKey('value')) {
          return $tom_vscode_scripting_api_23.VSCodeBridgeResult.success(output: output, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration);
        }
        if (named.containsKey('value')) {
          final value = D4.getRequiredNamedArg<dynamic>(named, 'value', 'VSCodeBridgeResult');
          return $tom_vscode_scripting_api_23.VSCodeBridgeResult.success(output: output, exception: exception, exceptionStackTrace: exceptionStackTrace, duration: duration, value: value);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'failure': (visitor, positional, named) {
        final error = D4.getRequiredNamedArg<String>(named, 'error', 'VSCodeBridgeResult');
        final stackTrace = D4.getOptionalNamedArg<String?>(named, 'stackTrace');
        final output = D4.getNamedArgWithDefault<String>(named, 'output', '');
        final duration = D4.getRequiredNamedArg<Duration>(named, 'duration', 'VSCodeBridgeResult');
        return $tom_vscode_scripting_api_23.VSCodeBridgeResult.failure(error: error, stackTrace: stackTrace, output: output, duration: duration);
      },
    },
    getters: {
      'success': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').success,
      'value': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').value,
      'output': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').output,
      'error': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').error,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').stackTrace,
      'exception': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').exception,
      'exceptionStackTrace': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').exceptionStackTrace,
      'duration': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').duration,
      'hasException': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeResult>(target, 'VSCodeBridgeResult').hasException,
    },
    constructorSignatures: {
      '': 'const VSCodeBridgeResult({required bool success, dynamic value, String output = \'\', String? error, String? stackTrace, String? exception, String? exceptionStackTrace, required Duration duration})',
      'success': 'factory VSCodeBridgeResult.success({dynamic value, String output = \'\', String? exception, String? exceptionStackTrace, required Duration duration})',
      'failure': 'factory VSCodeBridgeResult.failure({required String error, String? stackTrace, String output = \'\', required Duration duration})',
    },
    getterSignatures: {
      'success': 'bool get success',
      'value': 'dynamic get value',
      'output': 'String get output',
      'error': 'String? get error',
      'stackTrace': 'String? get stackTrace',
      'exception': 'String? get exception',
      'exceptionStackTrace': 'String? get exceptionStackTrace',
      'duration': 'Duration get duration',
      'hasException': 'bool get hasException',
    },
  );
}

// =============================================================================
// VSCodeBridgeClient Bridge
// =============================================================================

BridgedClass _createVSCodeBridgeClientBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_23.VSCodeBridgeClient,
    name: 'VSCodeBridgeClient',
    isAssignable: (v) => v is $tom_vscode_scripting_api_23.VSCodeBridgeClient,
    constructors: {
      '': (visitor, positional, named) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        final connectTimeout = D4.getNamedArgWithDefault<Duration>(named, 'connectTimeout', const Duration(seconds: 5));
        final requestTimeout = D4.getNamedArgWithDefault<Duration>(named, 'requestTimeout', const Duration(seconds: 30));
        if (!named.containsKey('port')) {
          return $tom_vscode_scripting_api_23.VSCodeBridgeClient(host: host, connectTimeout: connectTimeout, requestTimeout: requestTimeout);
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<int>(named, 'port', 'VSCodeBridgeClient');
          return $tom_vscode_scripting_api_23.VSCodeBridgeClient(host: host, connectTimeout: connectTimeout, requestTimeout: requestTimeout, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'host': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').host,
      'port': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').port,
      'connectTimeout': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').connectTimeout,
      'requestTimeout': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').requestTimeout,
      'notifications': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').notifications,
      'isConnected': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient').isConnected,
    },
    methods: {
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        return t.connect();
      },
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        return t.disconnect();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "params" at position 1');
        }
        final params = D4.coerceMap<String, dynamic>(positional[1], 'params');
        return t.sendRequest(method, params);
      },
      'registerRequestHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 2, 'registerRequestHandler');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'registerRequestHandler');
        if (positional.length <= 1) {
          throw ArgumentError('registerRequestHandler: Missing required argument "handler" at position 1');
        }
        final handlerRaw = positional[1];
        t.registerRequestHandler(method, ((Map<String, dynamic> p0) { return D4.castCallbackResult<FutureOr<Object?>>(D4.callInterpreterCallback(visitor!, handlerRaw, [p0])); }) as FutureOr<Object?> Function(Map<String, dynamic>));
        return null;
      },
      'unregisterRequestHandler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'unregisterRequestHandler');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'unregisterRequestHandler');
        t.unregisterRequestHandler(method);
        return null;
      },
      'executeExpression': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeExpression');
        final expression = D4.getRequiredArg<String>(positional, 0, 'expression', 'executeExpression');
        return t.executeExpression(expression);
      },
      'executeScriptFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeScriptFile');
        final filePath = D4.getRequiredArg<String>(positional, 0, 'filePath', 'executeScriptFile');
        return t.executeScriptFile(filePath);
      },
      'executeScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(target, 'VSCodeBridgeClient');
        D4.requireMinArgs(positional, 1, 'executeScript');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'executeScript');
        return t.executeScript(code);
      },
    },
    staticMethods: {
      'isAvailable': (visitor, positional, named, typeArgs) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        if (!named.containsKey('port')) {
          return $tom_vscode_scripting_api_23.VSCodeBridgeClient.isAvailable(host: host);
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<int>(named, 'port', 'isAvailable');
          return $tom_vscode_scripting_api_23.VSCodeBridgeClient.isAvailable(host: host, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    constructorSignatures: {
      '': 'VSCodeBridgeClient({String host = \'127.0.0.1\', int port = defaultVSCodeBridgePort, Duration connectTimeout = const Duration(seconds: 5), Duration requestTimeout = const Duration(seconds: 30)})',
    },
    methodSignatures: {
      'connect': 'Future<bool> connect()',
      'disconnect': 'Future<void> disconnect()',
      'sendRequest': 'Future<Map<String, dynamic>> sendRequest(String method, Map<String, dynamic> params)',
      'registerRequestHandler': 'void registerRequestHandler(String method, BridgeRequestHandler handler)',
      'unregisterRequestHandler': 'void unregisterRequestHandler(String method)',
      'executeExpression': 'Future<VSCodeBridgeResult> executeExpression(String expression)',
      'executeScriptFile': 'Future<VSCodeBridgeResult> executeScriptFile(String filePath)',
      'executeScript': 'Future<VSCodeBridgeResult> executeScript(String code)',
    },
    getterSignatures: {
      'host': 'String get host',
      'port': 'int get port',
      'connectTimeout': 'Duration get connectTimeout',
      'requestTimeout': 'Duration get requestTimeout',
      'notifications': 'Stream<Map<String, dynamic>> get notifications',
      'isConnected': 'bool get isConnected',
    },
    staticMethodSignatures: {
      'isAvailable': 'Future<bool> isAvailable({String host = \'127.0.0.1\', int port = defaultVSCodeBridgePort})',
    },
  );
}

// =============================================================================
// VSCodeBridgeAdapter Bridge
// =============================================================================

BridgedClass _createVSCodeBridgeAdapterBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_22.VSCodeBridgeAdapter,
    name: 'VSCodeBridgeAdapter',
    isAssignable: (v) => v is $tom_vscode_scripting_api_22.VSCodeBridgeAdapter,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeBridgeAdapter');
        final client = D4.getRequiredArg<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(positional, 0, 'client', 'VSCodeBridgeAdapter');
        return $tom_vscode_scripting_api_22.VSCodeBridgeAdapter(client);
      },
    },
    getters: {
      'client': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_22.VSCodeBridgeAdapter>(target, 'VSCodeBridgeAdapter').client,
      'isConnected': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_22.VSCodeBridgeAdapter>(target, 'VSCodeBridgeAdapter').isConnected,
    },
    methods: {
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_22.VSCodeBridgeAdapter>(target, 'VSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "params" at position 1');
        }
        final params = D4.coerceMap<String, dynamic>(positional[1], 'params');
        final scriptName = D4.getOptionalNamedArg<String?>(named, 'scriptName');
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(seconds: 60));
        return t.sendRequest(method, params, scriptName: scriptName, timeout: timeout);
      },
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_22.VSCodeBridgeAdapter>(target, 'VSCodeBridgeAdapter');
        return t.disconnect();
      },
    },
    constructorSignatures: {
      '': 'VSCodeBridgeAdapter(VSCodeBridgeClient client)',
    },
    methodSignatures: {
      'sendRequest': 'Future<Map<String, dynamic>> sendRequest(String method, Map<String, dynamic> params, {String? scriptName, Duration timeout = const Duration(seconds: 60)})',
      'disconnect': 'Future<void> disconnect()',
    },
    getterSignatures: {
      'client': 'VSCodeBridgeClient get client',
      'isConnected': 'bool get isConnected',
    },
  );
}

// =============================================================================
// LazyVSCodeBridgeAdapter Bridge
// =============================================================================

BridgedClass _createLazyVSCodeBridgeAdapterBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter,
    name: 'LazyVSCodeBridgeAdapter',
    isAssignable: (v) => v is $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final host = D4.getNamedArgWithDefault<String>(named, 'host', '127.0.0.1');
        final onStatusMessageRaw = named['onStatusMessage'];
        final onErrorMessageRaw = named['onErrorMessage'];
        if (!named.containsKey('port')) {
          return $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter(host: host, onStatusMessage: onStatusMessageRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onStatusMessageRaw, [p0]); }, onErrorMessage: onErrorMessageRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onErrorMessageRaw, [p0]); });
        }
        if (named.containsKey('port')) {
          final port = D4.getRequiredNamedArg<int>(named, 'port', 'LazyVSCodeBridgeAdapter');
          return $tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter(host: host, onStatusMessage: onStatusMessageRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onStatusMessageRaw, [p0]); }, onErrorMessage: onErrorMessageRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onErrorMessageRaw, [p0]); }, port: port);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'onStatusMessage': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').onStatusMessage,
      'onErrorMessage': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').onErrorMessage,
      'host': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').host,
      'port': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').port,
      'isConnected': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter').isConnected,
    },
    methods: {
      'setHostPort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 2, 'setHostPort');
        final host = D4.getRequiredArg<String>(positional, 0, 'host', 'setHostPort');
        final port = D4.getRequiredArg<int>(positional, 1, 'port', 'setHostPort');
        return t.setHostPort(host, port);
      },
      'setPort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 1, 'setPort');
        final port = D4.getRequiredArg<int>(positional, 0, 'port', 'setPort');
        return t.setPort(port);
      },
      'connect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        return t.connect();
      },
      'disconnect': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        return t.disconnect();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_22.LazyVSCodeBridgeAdapter>(target, 'LazyVSCodeBridgeAdapter');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "params" at position 1');
        }
        final params = D4.coerceMap<String, dynamic>(positional[1], 'params');
        final scriptName = D4.getOptionalNamedArg<String?>(named, 'scriptName');
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(seconds: 60));
        return t.sendRequest(method, params, scriptName: scriptName, timeout: timeout);
      },
    },
    constructorSignatures: {
      '': 'LazyVSCodeBridgeAdapter({String host = \'127.0.0.1\', int port = defaultVSCodeBridgePort, void Function(String message)? onStatusMessage, void Function(String message)? onErrorMessage})',
    },
    methodSignatures: {
      'setHostPort': 'Future<void> setHostPort(String host, int port)',
      'setPort': 'Future<void> setPort(int port)',
      'connect': 'Future<bool> connect()',
      'disconnect': 'Future<void> disconnect()',
      'sendRequest': 'Future<Map<String, dynamic>> sendRequest(String method, Map<String, dynamic> params, {String? scriptName, Duration timeout = const Duration(seconds: 60)})',
    },
    getterSignatures: {
      'onStatusMessage': 'void Function(String message)? get onStatusMessage',
      'onErrorMessage': 'void Function(String message)? get onErrorMessage',
      'host': 'String get host',
      'port': 'int get port',
      'isConnected': 'bool get isConnected',
    },
  );
}

// =============================================================================
// BridgeWorkspaceNotFoundException Bridge
// =============================================================================

BridgedClass _createBridgeWorkspaceNotFoundExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_11.BridgeWorkspaceNotFoundException,
    name: 'BridgeWorkspaceNotFoundException',
    isAssignable: (v) => v is $tom_vscode_scripting_api_11.BridgeWorkspaceNotFoundException,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'BridgeWorkspaceNotFoundException');
        final workspaceName = D4.getRequiredArg<String>(positional, 0, 'workspaceName', 'BridgeWorkspaceNotFoundException');
        final minPort = D4.getRequiredArg<int>(positional, 1, 'minPort', 'BridgeWorkspaceNotFoundException');
        final maxPort = D4.getRequiredArg<int>(positional, 2, 'maxPort', 'BridgeWorkspaceNotFoundException');
        return $tom_vscode_scripting_api_11.BridgeWorkspaceNotFoundException(workspaceName, minPort, maxPort);
      },
    },
    getters: {
      'workspaceName': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_11.BridgeWorkspaceNotFoundException>(target, 'BridgeWorkspaceNotFoundException').workspaceName,
      'minPort': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_11.BridgeWorkspaceNotFoundException>(target, 'BridgeWorkspaceNotFoundException').minPort,
      'maxPort': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_11.BridgeWorkspaceNotFoundException>(target, 'BridgeWorkspaceNotFoundException').maxPort,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_11.BridgeWorkspaceNotFoundException>(target, 'BridgeWorkspaceNotFoundException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'BridgeWorkspaceNotFoundException(String workspaceName, int minPort, int maxPort)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'workspaceName': 'String get workspaceName',
      'minPort': 'int get minPort',
      'maxPort': 'int get maxPort',
    },
  );
}

// =============================================================================
// VSCode Bridge
// =============================================================================

BridgedClass _createVSCodeBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_20.VSCode,
    name: 'VSCode',
    isAssignable: (v) => v is $tom_vscode_scripting_api_20.VSCode,
    constructors: {
    },
    getters: {
      'workspace': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').workspace,
      'window': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').window,
      'commands': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').commands,
      'extensions': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').extensions,
      'lm': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').lm,
      'chat': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').chat,
      'adapter': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').adapter,
    },
    setters: {
      'workspace': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').workspace = D4.extractBridgedArg<$tom_vscode_scripting_api_31.VSCodeWorkspace>(value, 'workspace'),
      'window': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').window = D4.extractBridgedArg<$tom_vscode_scripting_api_30.VSCodeWindow>(value, 'window'),
      'commands': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').commands = D4.extractBridgedArg<$tom_vscode_scripting_api_25.VSCodeCommands>(value, 'commands'),
      'extensions': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').extensions = D4.extractBridgedArg<$tom_vscode_scripting_api_26.VSCodeExtensions>(value, 'extensions'),
      'lm': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').lm = D4.extractBridgedArg<$tom_vscode_scripting_api_28.VSCodeLanguageModel>(value, 'lm'),
      'chat': (visitor, target, value) => 
        D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode').chat = D4.extractBridgedArg<$tom_vscode_scripting_api_24.VSCodeChat>(value, 'chat'),
    },
    methods: {
      'getVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.getVersion(timeoutSeconds: timeoutSeconds);
      },
      'getEnv': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.getEnv(timeoutSeconds: timeoutSeconds);
      },
      'openExternal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode');
        D4.requireMinArgs(positional, 1, 'openExternal');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'openExternal');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.openExternal(uri, timeoutSeconds: timeoutSeconds);
      },
      'copyToClipboard': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode');
        D4.requireMinArgs(positional, 1, 'copyToClipboard');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'copyToClipboard');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.copyToClipboard(text, timeoutSeconds: timeoutSeconds);
      },
      'readFromClipboard': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_20.VSCode>(target, 'VSCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return t.readFromClipboard(timeoutSeconds: timeoutSeconds);
      },
    },
    staticGetters: {
      'instance': (visitor) => $tom_vscode_scripting_api_20.VSCode.instance,
      'isInitialized': (visitor) => $tom_vscode_scripting_api_20.VSCode.isInitialized,
    },
    staticMethods: {
      'initialize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'initialize');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'initialize');
        return $tom_vscode_scripting_api_20.VSCode.initialize(adapter);
      },
    },
    methodSignatures: {
      'getVersion': 'Future<String> getVersion({int timeoutSeconds = 10})',
      'getEnv': 'Future<Map<String, dynamic>> getEnv({int timeoutSeconds = 10})',
      'openExternal': 'Future<bool> openExternal(String uri, {int timeoutSeconds = 30})',
      'copyToClipboard': 'Future<void> copyToClipboard(String text, {int timeoutSeconds = 10})',
      'readFromClipboard': 'Future<String> readFromClipboard({int timeoutSeconds = 10})',
    },
    getterSignatures: {
      'workspace': 'VSCodeWorkspace get workspace',
      'window': 'VSCodeWindow get window',
      'commands': 'VSCodeCommands get commands',
      'extensions': 'VSCodeExtensions get extensions',
      'lm': 'VSCodeLanguageModel get lm',
      'chat': 'VSCodeChat get chat',
      'adapter': 'VSCodeAdapter get adapter',
    },
    setterSignatures: {
      'workspace': 'set workspace(dynamic value)',
      'window': 'set window(dynamic value)',
      'commands': 'set commands(dynamic value)',
      'extensions': 'set extensions(dynamic value)',
      'lm': 'set lm(dynamic value)',
      'chat': 'set chat(dynamic value)',
    },
    staticMethodSignatures: {
      'initialize': 'void initialize(VSCodeAdapter adapter)',
    },
    staticGetterSignatures: {
      'instance': 'VSCode get instance',
      'isInitialized': 'bool get isInitialized',
    },
  );
}

// =============================================================================
// VSCodeCommands Bridge
// =============================================================================

BridgedClass _createVSCodeCommandsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_25.VSCodeCommands,
    name: 'VSCodeCommands',
    isAssignable: (v) => v is $tom_vscode_scripting_api_25.VSCodeCommands,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeCommands');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, '_adapter', 'VSCodeCommands');
        return $tom_vscode_scripting_api_25.VSCodeCommands(adapter);
      },
    },
    methods: {
      'executeCommand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_25.VSCodeCommands>(target, 'VSCodeCommands');
        D4.requireMinArgs(positional, 1, 'executeCommand');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'executeCommand');
        final args = D4.getOptionalNamedArg<List?>(named, 'args');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.executeCommand(command, args: args, timeoutSeconds: timeoutSeconds);
      },
      'getCommands': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_25.VSCodeCommands>(target, 'VSCodeCommands');
        final filterInternal = D4.getNamedArgWithDefault<bool>(named, 'filterInternal', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getCommands(filterInternal: filterInternal, timeoutSeconds: timeoutSeconds);
      },
      'registerCommand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_25.VSCodeCommands>(target, 'VSCodeCommands');
        D4.requireMinArgs(positional, 2, 'registerCommand');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'registerCommand');
        final handlerScript = D4.getRequiredArg<String>(positional, 1, 'handlerScript', 'registerCommand');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.registerCommand(command, handlerScript, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeCommands(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'executeCommand': 'Future executeCommand(String command, {List? args, int timeoutSeconds = 120})',
      'getCommands': 'Future<List<String>> getCommands({bool filterInternal = false, int timeoutSeconds = 60})',
      'registerCommand': 'Future<bool> registerCommand(String command, String handlerScript, {int timeoutSeconds = 120})',
    },
  );
}

// =============================================================================
// VSCodeCommonCommands Bridge
// =============================================================================

BridgedClass _createVSCodeCommonCommandsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_25.VSCodeCommonCommands,
    name: 'VSCodeCommonCommands',
    isAssignable: (v) => v is $tom_vscode_scripting_api_25.VSCodeCommonCommands,
    constructors: {
      '': (visitor, positional, named) {
        return $tom_vscode_scripting_api_25.VSCodeCommonCommands();
      },
    },
    staticGetters: {
      'openFile': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.openFile,
      'openFolder': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.openFolder,
      'newUntitledFile': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.newUntitledFile,
      'saveFile': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.saveFile,
      'saveAllFiles': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.saveAllFiles,
      'closeActiveEditor': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.closeActiveEditor,
      'showCommands': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.showCommands,
      'quickOpen': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.quickOpen,
      'goToFile': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.goToFile,
      'goToSymbol': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.goToSymbol,
      'goToLine': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.goToLine,
      'findInFiles': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.findInFiles,
      'replaceInFiles': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.replaceInFiles,
      'toggleTerminal': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.toggleTerminal,
      'newTerminal': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.newTerminal,
      'toggleSidebar': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.toggleSidebar,
      'togglePanel': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.togglePanel,
      'formatDocument': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.formatDocument,
      'organizeImports': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.organizeImports,
      'renameSymbol': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.renameSymbol,
      'goToDefinition': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.goToDefinition,
      'goToReferences': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.goToReferences,
      'showHover': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.showHover,
      'commentLine': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.commentLine,
      'copyLineDown': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.copyLineDown,
      'moveLineDown': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.moveLineDown,
      'deleteLine': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.deleteLine,
      'reloadWindow': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.reloadWindow,
      'showExtensions': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.showExtensions,
      'installExtension': (visitor) => $tom_vscode_scripting_api_25.VSCodeCommonCommands.installExtension,
    },
    constructorSignatures: {
      '': 'VSCodeCommonCommands()',
    },
    staticGetterSignatures: {
      'openFile': 'String get openFile',
      'openFolder': 'String get openFolder',
      'newUntitledFile': 'String get newUntitledFile',
      'saveFile': 'String get saveFile',
      'saveAllFiles': 'String get saveAllFiles',
      'closeActiveEditor': 'String get closeActiveEditor',
      'showCommands': 'String get showCommands',
      'quickOpen': 'String get quickOpen',
      'goToFile': 'String get goToFile',
      'goToSymbol': 'String get goToSymbol',
      'goToLine': 'String get goToLine',
      'findInFiles': 'String get findInFiles',
      'replaceInFiles': 'String get replaceInFiles',
      'toggleTerminal': 'String get toggleTerminal',
      'newTerminal': 'String get newTerminal',
      'toggleSidebar': 'String get toggleSidebar',
      'togglePanel': 'String get togglePanel',
      'formatDocument': 'String get formatDocument',
      'organizeImports': 'String get organizeImports',
      'renameSymbol': 'String get renameSymbol',
      'goToDefinition': 'String get goToDefinition',
      'goToReferences': 'String get goToReferences',
      'showHover': 'String get showHover',
      'commentLine': 'String get commentLine',
      'copyLineDown': 'String get copyLineDown',
      'moveLineDown': 'String get moveLineDown',
      'deleteLine': 'String get deleteLine',
      'reloadWindow': 'String get reloadWindow',
      'showExtensions': 'String get showExtensions',
      'installExtension': 'String get installExtension',
    },
  );
}

// =============================================================================
// Extension Bridge
// =============================================================================

BridgedClass _createExtensionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_26.Extension,
    name: 'Extension',
    isAssignable: (v) => v is $tom_vscode_scripting_api_26.Extension,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'Extension');
        final extensionUri = D4.getRequiredNamedArg<String>(named, 'extensionUri', 'Extension');
        final extensionPath = D4.getRequiredNamedArg<String>(named, 'extensionPath', 'Extension');
        final isActive = D4.getRequiredNamedArg<bool>(named, 'isActive', 'Extension');
        if (!named.containsKey('packageJSON') || named['packageJSON'] == null) {
          throw ArgumentError('Extension: Missing required named argument "packageJSON"');
        }
        final packageJSON = D4.coerceMap<String, dynamic>(named['packageJSON'], 'packageJSON');
        final extensionKind = D4.getOptionalNamedArg<String?>(named, 'extensionKind');
        return $tom_vscode_scripting_api_26.Extension(id: id, extensionUri: extensionUri, extensionPath: extensionPath, isActive: isActive, packageJSON: packageJSON, extensionKind: extensionKind);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Extension');
        if (positional.isEmpty) {
          throw ArgumentError('Extension: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_26.Extension.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_26.Extension>(target, 'Extension').id,
      'extensionUri': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_26.Extension>(target, 'Extension').extensionUri,
      'extensionPath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_26.Extension>(target, 'Extension').extensionPath,
      'isActive': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_26.Extension>(target, 'Extension').isActive,
      'packageJSON': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_26.Extension>(target, 'Extension').packageJSON,
      'extensionKind': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_26.Extension>(target, 'Extension').extensionKind,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.Extension>(target, 'Extension');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Extension({required String id, required String extensionUri, required String extensionPath, required bool isActive, required Map<String, dynamic> packageJSON, String? extensionKind})',
      'fromJson': 'factory Extension.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'extensionUri': 'String get extensionUri',
      'extensionPath': 'String get extensionPath',
      'isActive': 'bool get isActive',
      'packageJSON': 'Map<String, dynamic> get packageJSON',
      'extensionKind': 'String? get extensionKind',
    },
  );
}

// =============================================================================
// VSCodeExtensions Bridge
// =============================================================================

BridgedClass _createVSCodeExtensionsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_26.VSCodeExtensions,
    name: 'VSCodeExtensions',
    isAssignable: (v) => v is $tom_vscode_scripting_api_26.VSCodeExtensions,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeExtensions');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, '_adapter', 'VSCodeExtensions');
        return $tom_vscode_scripting_api_26.VSCodeExtensions(adapter);
      },
    },
    methods: {
      'getAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.VSCodeExtensions>(target, 'VSCodeExtensions');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getAll(timeoutSeconds: timeoutSeconds);
      },
      'getExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtension');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtension');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtension(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'isInstalled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'isInstalled');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'isInstalled');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.isInstalled(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionExports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionExports');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionExports');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.getExtensionExports(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'activateExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'activateExtension');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'activateExtension');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return t.activateExtension(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionVersion');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionVersion');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionVersion(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionDisplayName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionDisplayName');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionDisplayName');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionDisplayName(extensionId, timeoutSeconds: timeoutSeconds);
      },
      'getExtensionDescription': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_26.VSCodeExtensions>(target, 'VSCodeExtensions');
        D4.requireMinArgs(positional, 1, 'getExtensionDescription');
        final extensionId = D4.getRequiredArg<String>(positional, 0, 'extensionId', 'getExtensionDescription');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getExtensionDescription(extensionId, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeExtensions(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'getAll': 'Future<List<Extension>> getAll({int timeoutSeconds = 60})',
      'getExtension': 'Future<Extension?> getExtension(String extensionId, {int timeoutSeconds = 60})',
      'isInstalled': 'Future<bool> isInstalled(String extensionId, {int timeoutSeconds = 60})',
      'getExtensionExports': 'Future getExtensionExports(String extensionId, {int timeoutSeconds = 120})',
      'activateExtension': 'Future<bool> activateExtension(String extensionId, {int timeoutSeconds = 180})',
      'getExtensionVersion': 'Future<String?> getExtensionVersion(String extensionId, {int timeoutSeconds = 60})',
      'getExtensionDisplayName': 'Future<String?> getExtensionDisplayName(String extensionId, {int timeoutSeconds = 60})',
      'getExtensionDescription': 'Future<String?> getExtensionDescription(String extensionId, {int timeoutSeconds = 60})',
    },
  );
}

// =============================================================================
// VSCodeLanguageModel Bridge
// =============================================================================

BridgedClass _createVSCodeLanguageModelBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_28.VSCodeLanguageModel,
    name: 'VSCodeLanguageModel',
    isAssignable: (v) => v is $tom_vscode_scripting_api_28.VSCodeLanguageModel,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeLanguageModel');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, '_adapter', 'VSCodeLanguageModel');
        return $tom_vscode_scripting_api_28.VSCodeLanguageModel(adapter);
      },
    },
    methods: {
      'selectChatModels': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.VSCodeLanguageModel>(target, 'VSCodeLanguageModel');
        final vendor = D4.getOptionalNamedArg<String?>(named, 'vendor');
        final family = D4.getOptionalNamedArg<String?>(named, 'family');
        final id = D4.getOptionalNamedArg<String?>(named, 'id');
        final version = D4.getOptionalNamedArg<String?>(named, 'version');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.selectChatModels(vendor: vendor, family: family, id: id, version: version, timeoutSeconds: timeoutSeconds);
      },
      'invokeTool': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.VSCodeLanguageModel>(target, 'VSCodeLanguageModel');
        D4.requireMinArgs(positional, 2, 'invokeTool');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeTool');
        if (positional.length <= 1) {
          throw ArgumentError('invokeTool: Missing required argument "options" at position 1');
        }
        final options = D4.coerceMap<String, dynamic>(positional[1], 'options');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return t.invokeTool(name, options, timeoutSeconds: timeoutSeconds);
      },
      'registerTool': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.VSCodeLanguageModel>(target, 'VSCodeLanguageModel');
        D4.requireMinArgs(positional, 2, 'registerTool');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerTool');
        if (positional.length <= 1) {
          throw ArgumentError('registerTool: Missing required argument "tool" at position 1');
        }
        final tool = D4.coerceMap<String, dynamic>(positional[1], 'tool');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.registerTool(name, tool, timeoutSeconds: timeoutSeconds);
      },
      'getTools': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.VSCodeLanguageModel>(target, 'VSCodeLanguageModel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getTools(timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeLanguageModel(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'selectChatModels': 'Future<List<LanguageModelChat>> selectChatModels({String? vendor, String? family, String? id, String? version, int timeoutSeconds = 60})',
      'invokeTool': 'Future<LanguageModelToolResult> invokeTool(String name, Map<String, dynamic> options, {int timeoutSeconds = 300})',
      'registerTool': 'Future<void> registerTool(String name, Map<String, dynamic> tool, {int timeoutSeconds = 120})',
      'getTools': 'Future<List<LanguageModelToolInformation>> getTools({int timeoutSeconds = 60})',
    },
  );
}

// =============================================================================
// LanguageModelChat Bridge
// =============================================================================

BridgedClass _createLanguageModelChatBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_28.LanguageModelChat,
    name: 'LanguageModelChat',
    isAssignable: (v) => v is $tom_vscode_scripting_api_28.LanguageModelChat,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'LanguageModelChat');
        final vendor = D4.getRequiredNamedArg<String>(named, 'vendor', 'LanguageModelChat');
        final family = D4.getRequiredNamedArg<String>(named, 'family', 'LanguageModelChat');
        final version = D4.getRequiredNamedArg<String>(named, 'version', 'LanguageModelChat');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'LanguageModelChat');
        final maxInputTokens = D4.getRequiredNamedArg<int>(named, 'maxInputTokens', 'LanguageModelChat');
        return $tom_vscode_scripting_api_28.LanguageModelChat(id: id, vendor: vendor, family: family, version: version, name: name, maxInputTokens: maxInputTokens);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChat');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelChat: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_28.LanguageModelChat.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat').id,
      'vendor': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat').vendor,
      'family': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat').family,
      'version': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat').version,
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat').name,
      'maxInputTokens': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat').maxInputTokens,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat');
        return t.toJson();
      },
      'sendRequest': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat');
        D4.requireMinArgs(positional, 2, 'sendRequest');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'sendRequest');
        if (positional.length <= 1) {
          throw ArgumentError('sendRequest: Missing required argument "messages" at position 1');
        }
        final messages = D4.coerceList<$tom_vscode_scripting_api_28.LanguageModelChatMessage>(positional[1], 'messages');
        final modelOptions = D4.coerceMapOrNull<String, dynamic>(named['modelOptions'], 'modelOptions');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return t.sendRequest(adapter, messages, modelOptions: modelOptions, timeoutSeconds: timeoutSeconds);
      },
      'countTokens': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChat>(target, 'LanguageModelChat');
        D4.requireMinArgs(positional, 2, 'countTokens');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'countTokens');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'countTokens');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.countTokens(adapter, text, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'LanguageModelChat({required String id, required String vendor, required String family, required String version, required String name, required int maxInputTokens})',
      'fromJson': 'factory LanguageModelChat.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'sendRequest': 'Future<LanguageModelChatResponse> sendRequest(VSCodeAdapter adapter, List<LanguageModelChatMessage> messages, {Map<String, dynamic>? modelOptions, int timeoutSeconds = 300})',
      'countTokens': 'Future<int> countTokens(VSCodeAdapter adapter, String text, {int timeoutSeconds = 120})',
    },
    getterSignatures: {
      'id': 'String get id',
      'vendor': 'String get vendor',
      'family': 'String get family',
      'version': 'String get version',
      'name': 'String get name',
      'maxInputTokens': 'int get maxInputTokens',
    },
  );
}

// =============================================================================
// LanguageModelChatMessage Bridge
// =============================================================================

BridgedClass _createLanguageModelChatMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_28.LanguageModelChatMessage,
    name: 'LanguageModelChatMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_28.LanguageModelChatMessage,
    constructors: {
      '': (visitor, positional, named) {
        final role = D4.getRequiredNamedArg<String>(named, 'role', 'LanguageModelChatMessage');
        final content = D4.getRequiredNamedArg<String>(named, 'content', 'LanguageModelChatMessage');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        return $tom_vscode_scripting_api_28.LanguageModelChatMessage(role: role, content: content, name: name);
      },
      'user': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatMessage');
        final content = D4.getRequiredArg<String>(positional, 0, 'content', 'LanguageModelChatMessage');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        return $tom_vscode_scripting_api_28.LanguageModelChatMessage.user(content, name: name);
      },
      'assistant': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatMessage');
        final content = D4.getRequiredArg<String>(positional, 0, 'content', 'LanguageModelChatMessage');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        return $tom_vscode_scripting_api_28.LanguageModelChatMessage.assistant(content, name: name);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatMessage');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelChatMessage: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_28.LanguageModelChatMessage.fromJson(json);
      },
    },
    getters: {
      'role': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChatMessage>(target, 'LanguageModelChatMessage').role,
      'content': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChatMessage>(target, 'LanguageModelChatMessage').content,
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChatMessage>(target, 'LanguageModelChatMessage').name,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChatMessage>(target, 'LanguageModelChatMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelChatMessage({required String role, required String content, String? name})',
      'user': 'factory LanguageModelChatMessage.user(String content, {String? name})',
      'assistant': 'factory LanguageModelChatMessage.assistant(String content, {String? name})',
      'fromJson': 'factory LanguageModelChatMessage.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'role': 'String get role',
      'content': 'String get content',
      'name': 'String? get name',
    },
  );
}

// =============================================================================
// LanguageModelChatResponse Bridge
// =============================================================================

BridgedClass _createLanguageModelChatResponseBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_28.LanguageModelChatResponse,
    name: 'LanguageModelChatResponse',
    isAssignable: (v) => v is $tom_vscode_scripting_api_28.LanguageModelChatResponse,
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'LanguageModelChatResponse');
        if (!named.containsKey('streamParts') || named['streamParts'] == null) {
          throw ArgumentError('LanguageModelChatResponse: Missing required named argument "streamParts"');
        }
        final streamParts = D4.coerceList<String>(named['streamParts'], 'streamParts');
        return $tom_vscode_scripting_api_28.LanguageModelChatResponse(text: text, streamParts: streamParts);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelChatResponse');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelChatResponse: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_28.LanguageModelChatResponse.fromJson(json);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChatResponse>(target, 'LanguageModelChatResponse').text,
      'streamParts': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChatResponse>(target, 'LanguageModelChatResponse').streamParts,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelChatResponse>(target, 'LanguageModelChatResponse');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelChatResponse({required String text, required List<String> streamParts})',
      'fromJson': 'factory LanguageModelChatResponse.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'text': 'String get text',
      'streamParts': 'List<String> get streamParts',
    },
  );
}

// =============================================================================
// LanguageModelToolResult Bridge
// =============================================================================

BridgedClass _createLanguageModelToolResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_28.LanguageModelToolResult,
    name: 'LanguageModelToolResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_28.LanguageModelToolResult,
    constructors: {
      '': (visitor, positional, named) {
        final content = D4.getRequiredNamedArg<List>(named, 'content', 'LanguageModelToolResult');
        return $tom_vscode_scripting_api_28.LanguageModelToolResult(content: content);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelToolResult');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelToolResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_28.LanguageModelToolResult.fromJson(json);
      },
    },
    getters: {
      'content': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelToolResult>(target, 'LanguageModelToolResult').content,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelToolResult>(target, 'LanguageModelToolResult');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelToolResult({required List content})',
      'fromJson': 'factory LanguageModelToolResult.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'content': 'List get content',
    },
  );
}

// =============================================================================
// LanguageModelToolInformation Bridge
// =============================================================================

BridgedClass _createLanguageModelToolInformationBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_28.LanguageModelToolInformation,
    name: 'LanguageModelToolInformation',
    isAssignable: (v) => v is $tom_vscode_scripting_api_28.LanguageModelToolInformation,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'LanguageModelToolInformation');
        final description = D4.getRequiredNamedArg<String>(named, 'description', 'LanguageModelToolInformation');
        if (!named.containsKey('inputSchema') || named['inputSchema'] == null) {
          throw ArgumentError('LanguageModelToolInformation: Missing required named argument "inputSchema"');
        }
        final inputSchema = D4.coerceMap<String, dynamic>(named['inputSchema'], 'inputSchema');
        return $tom_vscode_scripting_api_28.LanguageModelToolInformation(name: name, description: description, inputSchema: inputSchema);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LanguageModelToolInformation');
        if (positional.isEmpty) {
          throw ArgumentError('LanguageModelToolInformation: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_28.LanguageModelToolInformation.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').name,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').description,
      'inputSchema': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelToolInformation>(target, 'LanguageModelToolInformation').inputSchema,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_28.LanguageModelToolInformation>(target, 'LanguageModelToolInformation');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'LanguageModelToolInformation({required String name, required String description, required Map<String, dynamic> inputSchema})',
      'fromJson': 'factory LanguageModelToolInformation.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String get description',
      'inputSchema': 'Map<String, dynamic> get inputSchema',
    },
  );
}

// =============================================================================
// VSCodeWindow Bridge
// =============================================================================

BridgedClass _createVSCodeWindowBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_30.VSCodeWindow,
    name: 'VSCodeWindow',
    isAssignable: (v) => v is $tom_vscode_scripting_api_30.VSCodeWindow,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeWindow');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, '_adapter', 'VSCodeWindow');
        return $tom_vscode_scripting_api_30.VSCodeWindow(adapter);
      },
    },
    methods: {
      'showInformationMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showInformationMessage');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showInformationMessage');
        final items = D4.coerceListOrNull<String>(named['items'], 'items');
        final options = D4.getOptionalNamedArg<$tom_vscode_scripting_api_29.MessageOptions?>(named, 'options');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 5 * 60);
        return t.showInformationMessage(message, items: items, options: options, timeoutSeconds: timeoutSeconds);
      },
      'showWarningMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showWarningMessage');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showWarningMessage');
        final items = D4.coerceListOrNull<String>(named['items'], 'items');
        final options = D4.getOptionalNamedArg<$tom_vscode_scripting_api_29.MessageOptions?>(named, 'options');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 5 * 60);
        return t.showWarningMessage(message, items: items, options: options, timeoutSeconds: timeoutSeconds);
      },
      'showErrorMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showErrorMessage');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showErrorMessage');
        final items = D4.coerceListOrNull<String>(named['items'], 'items');
        final options = D4.getOptionalNamedArg<$tom_vscode_scripting_api_29.MessageOptions?>(named, 'options');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 5 * 60);
        return t.showErrorMessage(message, items: items, options: options, timeoutSeconds: timeoutSeconds);
      },
      'showQuickPick': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showQuickPick');
        if (positional.isEmpty) {
          throw ArgumentError('showQuickPick: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<String>(positional[0], 'items');
        final placeHolder = D4.getOptionalNamedArg<String?>(named, 'placeHolder');
        final canPickMany = D4.getNamedArgWithDefault<bool>(named, 'canPickMany', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30 * 60);
        final fallbackValueOnTimeout = D4.getOptionalNamedArg<String?>(named, 'fallbackValueOnTimeout');
        final failOnTimeout = D4.getNamedArgWithDefault<bool>(named, 'failOnTimeout', false);
        return t.showQuickPick(items, placeHolder: placeHolder, canPickMany: canPickMany, timeoutSeconds: timeoutSeconds, fallbackValueOnTimeout: fallbackValueOnTimeout, failOnTimeout: failOnTimeout);
      },
      'showInputBox': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        final prompt = D4.getOptionalNamedArg<String?>(named, 'prompt');
        final placeHolder = D4.getOptionalNamedArg<String?>(named, 'placeHolder');
        final value = D4.getOptionalNamedArg<String?>(named, 'value');
        final password = D4.getNamedArgWithDefault<bool>(named, 'password', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30 * 60);
        final fallbackValueOnTimeout = D4.getOptionalNamedArg<String?>(named, 'fallbackValueOnTimeout');
        final failOnTimeout = D4.getNamedArgWithDefault<bool>(named, 'failOnTimeout', false);
        return t.showInputBox(prompt: prompt, placeHolder: placeHolder, value: value, password: password, timeoutSeconds: timeoutSeconds, fallbackValueOnTimeout: fallbackValueOnTimeout, failOnTimeout: failOnTimeout);
      },
      'getActiveTextEditor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        return t.getActiveTextEditor();
      },
      'showTextDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showTextDocument');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'showTextDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10 * 60);
        return t.showTextDocument(path, timeoutSeconds: timeoutSeconds);
      },
      'createOutputChannel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'createOutputChannel');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'createOutputChannel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.createOutputChannel(name, timeoutSeconds: timeoutSeconds);
      },
      'appendToOutputChannel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 2, 'appendToOutputChannel');
        final channelName = D4.getRequiredArg<String>(positional, 0, 'channelName', 'appendToOutputChannel');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'appendToOutputChannel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.appendToOutputChannel(channelName, text, timeoutSeconds: timeoutSeconds);
      },
      'showOutputChannel': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showOutputChannel');
        final channelName = D4.getRequiredArg<String>(positional, 0, 'channelName', 'showOutputChannel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.showOutputChannel(channelName, timeoutSeconds: timeoutSeconds);
      },
      'createTerminal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final shellPath = D4.getOptionalNamedArg<String?>(named, 'shellPath');
        final shellArgs = D4.coerceListOrNull<String>(named['shellArgs'], 'shellArgs');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.createTerminal(name: name, shellPath: shellPath, shellArgs: shellArgs, timeoutSeconds: timeoutSeconds);
      },
      'sendTextToTerminal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 2, 'sendTextToTerminal');
        final terminalName = D4.getRequiredArg<String>(positional, 0, 'terminalName', 'sendTextToTerminal');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'sendTextToTerminal');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.sendTextToTerminal(terminalName, text, timeoutSeconds: timeoutSeconds);
      },
      'showTerminal': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'showTerminal');
        final terminalName = D4.getRequiredArg<String>(positional, 0, 'terminalName', 'showTerminal');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.showTerminal(terminalName, timeoutSeconds: timeoutSeconds);
      },
      'setStatusBarMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        D4.requireMinArgs(positional, 1, 'setStatusBarMessage');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'setStatusBarMessage');
        final timeout = D4.getOptionalNamedArg<int?>(named, 'timeout');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return t.setStatusBarMessage(message, timeout: timeout, timeoutSeconds: timeoutSeconds);
      },
      'showSaveDialog': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        final defaultUri = D4.getOptionalNamedArg<String?>(named, 'defaultUri');
        final filters = D4.coerceMapOrNull<String, List<String>>(named['filters'], 'filters');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30 * 60);
        return t.showSaveDialog(defaultUri: defaultUri, filters: filters, title: title, timeoutSeconds: timeoutSeconds);
      },
      'showOpenDialog': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_30.VSCodeWindow>(target, 'VSCodeWindow');
        final canSelectFiles = D4.getNamedArgWithDefault<bool>(named, 'canSelectFiles', true);
        final canSelectFolders = D4.getNamedArgWithDefault<bool>(named, 'canSelectFolders', false);
        final canSelectMany = D4.getNamedArgWithDefault<bool>(named, 'canSelectMany', false);
        final defaultUri = D4.getOptionalNamedArg<String?>(named, 'defaultUri');
        final filters = D4.coerceMapOrNull<String, List<String>>(named['filters'], 'filters');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30 * 60);
        return t.showOpenDialog(canSelectFiles: canSelectFiles, canSelectFolders: canSelectFolders, canSelectMany: canSelectMany, defaultUri: defaultUri, filters: filters, title: title, timeoutSeconds: timeoutSeconds);
      },
    },
    constructorSignatures: {
      '': 'VSCodeWindow(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'showInformationMessage': 'Future<String?> showInformationMessage(String message, {List<String>? items, MessageOptions? options, int timeoutSeconds = 5 * 60})',
      'showWarningMessage': 'Future<String?> showWarningMessage(String message, {List<String>? items, MessageOptions? options, int timeoutSeconds = 5 * 60})',
      'showErrorMessage': 'Future<String?> showErrorMessage(String message, {List<String>? items, MessageOptions? options, int timeoutSeconds = 5 * 60})',
      'showQuickPick': 'Future<String?> showQuickPick(List<String> items, {String? placeHolder, bool canPickMany = false, int timeoutSeconds = 30 * 60, String? fallbackValueOnTimeout, bool failOnTimeout = false})',
      'showInputBox': 'Future<String?> showInputBox({String? prompt, String? placeHolder, String? value, bool password = false, int timeoutSeconds = 30 * 60, String? fallbackValueOnTimeout, bool failOnTimeout = false})',
      'getActiveTextEditor': 'Future<TextEditor?> getActiveTextEditor()',
      'showTextDocument': 'Future<TextEditor?> showTextDocument(String path, {int timeoutSeconds = 10 * 60})',
      'createOutputChannel': 'Future<String> createOutputChannel(String name, {int timeoutSeconds = 30})',
      'appendToOutputChannel': 'Future<void> appendToOutputChannel(String channelName, String text, {int timeoutSeconds = 30})',
      'showOutputChannel': 'Future<void> showOutputChannel(String channelName, {int timeoutSeconds = 30})',
      'createTerminal': 'Future<String> createTerminal({String? name, String? shellPath, List<String>? shellArgs, int timeoutSeconds = 120})',
      'sendTextToTerminal': 'Future<void> sendTextToTerminal(String terminalName, String text, {int timeoutSeconds = 120})',
      'showTerminal': 'Future<void> showTerminal(String terminalName, {int timeoutSeconds = 120})',
      'setStatusBarMessage': 'Future<void> setStatusBarMessage(String message, {int? timeout, int timeoutSeconds = 120})',
      'showSaveDialog': 'Future<String?> showSaveDialog({String? defaultUri, Map<String, List<String>>? filters, String? title, int timeoutSeconds = 30 * 60})',
      'showOpenDialog': 'Future<List<String>> showOpenDialog({bool canSelectFiles = true, bool canSelectFolders = false, bool canSelectMany = false, String? defaultUri, Map<String, List<String>>? filters, String? title, int timeoutSeconds = 30 * 60})',
    },
  );
}

// =============================================================================
// VSCodeWorkspace Bridge
// =============================================================================

BridgedClass _createVSCodeWorkspaceBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_31.VSCodeWorkspace,
    name: 'VSCodeWorkspace',
    isAssignable: (v) => v is $tom_vscode_scripting_api_31.VSCodeWorkspace,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeWorkspace');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, '_adapter', 'VSCodeWorkspace');
        return $tom_vscode_scripting_api_31.VSCodeWorkspace(adapter);
      },
    },
    methods: {
      'getWorkspaceFolders': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.getWorkspaceFolders(timeoutSeconds: timeoutSeconds);
      },
      'getWorkspaceFolder': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'getWorkspaceFolder');
        final uri = D4.getRequiredArg<$tom_vscode_scripting_api_29.VSCodeUri>(positional, 0, 'uri', 'getWorkspaceFolder');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return t.getWorkspaceFolder(uri, timeoutSeconds: timeoutSeconds);
      },
      'openTextDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'openTextDocument');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'openTextDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.openTextDocument(path, timeoutSeconds: timeoutSeconds);
      },
      'saveTextDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'saveTextDocument');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'saveTextDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.saveTextDocument(path, timeoutSeconds: timeoutSeconds);
      },
      'findFiles': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'findFiles');
        final include = D4.getRequiredArg<String>(positional, 0, 'include', 'findFiles');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.findFiles(include, exclude: exclude, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'findFilePaths': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        final include = D4.getRequiredNamedArg<String>(named, 'include', 'findFilePaths');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.findFilePaths(include: include, exclude: exclude, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'getConfiguration': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'getConfiguration');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'getConfiguration');
        final scope = D4.getOptionalNamedArg<String?>(named, 'scope');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.getConfiguration(section, scope: scope, timeoutSeconds: timeoutSeconds);
      },
      'updateConfiguration': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 3, 'updateConfiguration');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'updateConfiguration');
        final key = D4.getRequiredArg<String>(positional, 1, 'key', 'updateConfiguration');
        final value = D4.getRequiredArg<dynamic>(positional, 2, 'value', 'updateConfiguration');
        final global = D4.getNamedArgWithDefault<bool>(named, 'global', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return t.updateConfiguration(section, key, value, global: global, timeoutSeconds: timeoutSeconds);
      },
      'getRootPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        return t.getRootPath();
      },
      'getWorkspaceName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        return t.getWorkspaceName();
      },
      'readFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'readFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'readFile');
        return t.readFile(path);
      },
      'writeFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 2, 'writeFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'writeFile');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'writeFile');
        return t.writeFile(path, content);
      },
      'deleteFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'deleteFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'deleteFile');
        return t.deleteFile(path);
      },
      'fileExists': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_31.VSCodeWorkspace>(target, 'VSCodeWorkspace');
        D4.requireMinArgs(positional, 1, 'fileExists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'fileExists');
        return t.fileExists(path);
      },
    },
    constructorSignatures: {
      '': 'VSCodeWorkspace(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'getWorkspaceFolders': 'Future<List<WorkspaceFolder>> getWorkspaceFolders({int timeoutSeconds = 30})',
      'getWorkspaceFolder': 'Future<WorkspaceFolder?> getWorkspaceFolder(VSCodeUri uri, {int timeoutSeconds = 30})',
      'openTextDocument': 'Future<TextDocument?> openTextDocument(String path, {int timeoutSeconds = 60})',
      'saveTextDocument': 'Future<bool> saveTextDocument(String path, {int timeoutSeconds = 60})',
      'findFiles': 'Future<List<VSCodeUri>> findFiles(String include, {String? exclude, int? maxResults, int timeoutSeconds = 60})',
      'findFilePaths': 'Future<List<String>> findFilePaths({required String include, String? exclude, int? maxResults, int timeoutSeconds = 60})',
      'getConfiguration': 'Future getConfiguration(String section, {String? scope, int timeoutSeconds = 60})',
      'updateConfiguration': 'Future<bool> updateConfiguration(String section, String key, dynamic value, {bool global = false, int timeoutSeconds = 60})',
      'getRootPath': 'Future<String?> getRootPath()',
      'getWorkspaceName': 'Future<String?> getWorkspaceName()',
      'readFile': 'Future<String> readFile(String path)',
      'writeFile': 'Future<bool> writeFile(String path, String content)',
      'deleteFile': 'Future<bool> deleteFile(String path)',
      'fileExists': 'Future<bool> fileExists(String path)',
    },
  );
}

// =============================================================================
// VSCodeChat Bridge
// =============================================================================

BridgedClass _createVSCodeChatBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_24.VSCodeChat,
    name: 'VSCodeChat',
    isAssignable: (v) => v is $tom_vscode_scripting_api_24.VSCodeChat,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeChat');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, '_adapter', 'VSCodeChat');
        return $tom_vscode_scripting_api_24.VSCodeChat(adapter);
      },
    },
    methods: {
      'createChatParticipant': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.VSCodeChat>(target, 'VSCodeChat');
        D4.requireMinArgs(positional, 1, 'createChatParticipant');
        final id = D4.getRequiredArg<String>(positional, 0, 'id', 'createChatParticipant');
        if (!named.containsKey('handler') || named['handler'] == null) {
          throw ArgumentError('createChatParticipant: Missing required named argument "handler"');
        }
        final handlerRaw = named['handler'];
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final fullName = D4.getOptionalNamedArg<String?>(named, 'fullName');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return t.createChatParticipant(id, handler: (($tom_vscode_scripting_api_24.ChatRequest p0, $tom_vscode_scripting_api_24.ChatContext p1, $tom_vscode_scripting_api_24.ChatResponseStream p2) { return Future.value(D4.callInterpreterCallback(visitor!, handlerRaw, [p0, p1, p2])).then((v) => v as $tom_vscode_scripting_api_24.ChatResult); }) as Future<$tom_vscode_scripting_api_24.ChatResult> Function($tom_vscode_scripting_api_24.ChatRequest, $tom_vscode_scripting_api_24.ChatContext, $tom_vscode_scripting_api_24.ChatResponseStream), description: description, fullName: fullName, timeoutSeconds: timeoutSeconds);
      },
    },
    staticMethods: {
      'handleChatRequest': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'handleChatRequest');
        if (positional.isEmpty) {
          throw ArgumentError('handleChatRequest: Missing required argument "params" at position 0');
        }
        final params = D4.coerceMap<String, dynamic>(positional[0], 'params');
        return $tom_vscode_scripting_api_24.VSCodeChat.handleChatRequest(params);
      },
    },
    constructorSignatures: {
      '': 'VSCodeChat(VSCodeAdapter _adapter)',
    },
    methodSignatures: {
      'createChatParticipant': 'Future<ChatParticipant> createChatParticipant(String id, {required ChatRequestHandler handler, String? description, String? fullName, int timeoutSeconds = 300})',
    },
    staticMethodSignatures: {
      'handleChatRequest': 'Future<Map<String, dynamic>?> handleChatRequest(Map<String, dynamic> params)',
    },
  );
}

// =============================================================================
// ChatParticipant Bridge
// =============================================================================

BridgedClass _createChatParticipantBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_24.ChatParticipant,
    name: 'ChatParticipant',
    isAssignable: (v) => v is $tom_vscode_scripting_api_24.ChatParticipant,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'ChatParticipant');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final fullName = D4.getOptionalNamedArg<String?>(named, 'fullName');
        return $tom_vscode_scripting_api_24.ChatParticipant(id: id, description: description, fullName: fullName);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatParticipant');
        if (positional.isEmpty) {
          throw ArgumentError('ChatParticipant: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_24.ChatParticipant.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatParticipant>(target, 'ChatParticipant').id,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatParticipant>(target, 'ChatParticipant').description,
      'fullName': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatParticipant>(target, 'ChatParticipant').fullName,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatParticipant>(target, 'ChatParticipant');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatParticipant({required String id, String? description, String? fullName})',
      'fromJson': 'factory ChatParticipant.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'description': 'String? get description',
      'fullName': 'String? get fullName',
    },
  );
}

// =============================================================================
// ChatRequest Bridge
// =============================================================================

BridgedClass _createChatRequestBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_24.ChatRequest,
    name: 'ChatRequest',
    isAssignable: (v) => v is $tom_vscode_scripting_api_24.ChatRequest,
    constructors: {
      '': (visitor, positional, named) {
        final prompt = D4.getRequiredNamedArg<String>(named, 'prompt', 'ChatRequest');
        final command = D4.getRequiredNamedArg<String>(named, 'command', 'ChatRequest');
        if (!named.containsKey('references') || named['references'] == null) {
          throw ArgumentError('ChatRequest: Missing required named argument "references"');
        }
        final references = D4.coerceList<$tom_vscode_scripting_api_24.ChatPromptReference>(named['references'], 'references');
        return $tom_vscode_scripting_api_24.ChatRequest(prompt: prompt, command: command, references: references);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatRequest');
        if (positional.isEmpty) {
          throw ArgumentError('ChatRequest: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_24.ChatRequest.fromJson(json);
      },
    },
    getters: {
      'prompt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatRequest>(target, 'ChatRequest').prompt,
      'command': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatRequest>(target, 'ChatRequest').command,
      'references': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatRequest>(target, 'ChatRequest').references,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatRequest>(target, 'ChatRequest');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatRequest({required String prompt, required String command, required List<ChatPromptReference> references})',
      'fromJson': 'factory ChatRequest.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'prompt': 'String get prompt',
      'command': 'String get command',
      'references': 'List<ChatPromptReference> get references',
    },
  );
}

// =============================================================================
// ChatPromptReference Bridge
// =============================================================================

BridgedClass _createChatPromptReferenceBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_24.ChatPromptReference,
    name: 'ChatPromptReference',
    isAssignable: (v) => v is $tom_vscode_scripting_api_24.ChatPromptReference,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'ChatPromptReference');
        final value = D4.getRequiredNamedArg<dynamic>(named, 'value', 'ChatPromptReference');
        final modelDescription = D4.getOptionalNamedArg<String?>(named, 'modelDescription');
        return $tom_vscode_scripting_api_24.ChatPromptReference(id: id, value: value, modelDescription: modelDescription);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatPromptReference');
        if (positional.isEmpty) {
          throw ArgumentError('ChatPromptReference: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_24.ChatPromptReference.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatPromptReference>(target, 'ChatPromptReference').id,
      'value': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatPromptReference>(target, 'ChatPromptReference').value,
      'modelDescription': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatPromptReference>(target, 'ChatPromptReference').modelDescription,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatPromptReference>(target, 'ChatPromptReference');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatPromptReference({required String id, required dynamic value, String? modelDescription})',
      'fromJson': 'factory ChatPromptReference.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'value': 'dynamic get value',
      'modelDescription': 'String? get modelDescription',
    },
  );
}

// =============================================================================
// ChatContext Bridge
// =============================================================================

BridgedClass _createChatContextBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_24.ChatContext,
    name: 'ChatContext',
    isAssignable: (v) => v is $tom_vscode_scripting_api_24.ChatContext,
    constructors: {
      '': (visitor, positional, named) {
        final history = D4.getRequiredNamedArg<List>(named, 'history', 'ChatContext');
        return $tom_vscode_scripting_api_24.ChatContext(history: history);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatContext');
        if (positional.isEmpty) {
          throw ArgumentError('ChatContext: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_24.ChatContext.fromJson(json);
      },
    },
    getters: {
      'history': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatContext>(target, 'ChatContext').history,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatContext>(target, 'ChatContext');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatContext({required List history})',
      'fromJson': 'factory ChatContext.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'history': 'List get history',
    },
  );
}

// =============================================================================
// ChatResult Bridge
// =============================================================================

BridgedClass _createChatResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_24.ChatResult,
    name: 'ChatResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_24.ChatResult,
    constructors: {
      '': (visitor, positional, named) {
        final metadata = D4.coerceMapOrNull<String, dynamic>(named['metadata'], 'metadata');
        final errorDetails = D4.getOptionalNamedArg<$tom_vscode_scripting_api_24.ChatErrorDetails?>(named, 'errorDetails');
        return $tom_vscode_scripting_api_24.ChatResult(metadata: metadata, errorDetails: errorDetails);
      },
    },
    getters: {
      'metadata': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatResult>(target, 'ChatResult').metadata,
      'errorDetails': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatResult>(target, 'ChatResult').errorDetails,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatResult>(target, 'ChatResult');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatResult({Map<String, dynamic>? metadata, ChatErrorDetails? errorDetails})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'metadata': 'Map<String, dynamic>? get metadata',
      'errorDetails': 'ChatErrorDetails? get errorDetails',
    },
  );
}

// =============================================================================
// ChatErrorDetails Bridge
// =============================================================================

BridgedClass _createChatErrorDetailsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_24.ChatErrorDetails,
    name: 'ChatErrorDetails',
    isAssignable: (v) => v is $tom_vscode_scripting_api_24.ChatErrorDetails,
    constructors: {
      '': (visitor, positional, named) {
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'ChatErrorDetails');
        final responseIsFiltered = D4.getOptionalNamedArg<bool?>(named, 'responseIsFiltered');
        return $tom_vscode_scripting_api_24.ChatErrorDetails(message: message, responseIsFiltered: responseIsFiltered);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatErrorDetails>(target, 'ChatErrorDetails').message,
      'responseIsFiltered': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_24.ChatErrorDetails>(target, 'ChatErrorDetails').responseIsFiltered,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatErrorDetails>(target, 'ChatErrorDetails');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ChatErrorDetails({required String message, bool? responseIsFiltered})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'message': 'String get message',
      'responseIsFiltered': 'bool? get responseIsFiltered',
    },
  );
}

// =============================================================================
// ChatResponseStream Bridge
// =============================================================================

BridgedClass _createChatResponseStreamBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_24.ChatResponseStream,
    name: 'ChatResponseStream',
    isAssignable: (v) => v is $tom_vscode_scripting_api_24.ChatResponseStream,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ChatResponseStream');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, '_adapter', 'ChatResponseStream');
        final streamId = D4.getRequiredArg<String>(positional, 1, '_streamId', 'ChatResponseStream');
        return $tom_vscode_scripting_api_24.ChatResponseStream(adapter, streamId);
      },
    },
    methods: {
      'markdown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'markdown');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'markdown');
        return t.markdown(text);
      },
      'anchor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'anchor');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'anchor');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        return t.anchor(uri, title: title);
      },
      'button': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'button');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'button');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final arguments = D4.getOptionalNamedArg<List?>(named, 'arguments');
        return t.button(command, title: title, arguments: arguments);
      },
      'filetree': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'filetree');
        if (positional.isEmpty) {
          throw ArgumentError('filetree: Missing required argument "files" at position 0');
        }
        final files = D4.coerceList<String>(positional[0], 'files');
        final baseUri = D4.getOptionalNamedArg<String?>(named, 'baseUri');
        return t.filetree(files, baseUri: baseUri);
      },
      'progress': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'progress');
        final value = D4.getRequiredArg<String>(positional, 0, 'value', 'progress');
        return t.progress(value);
      },
      'reference': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'reference');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'reference');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        return t.reference(uri, title: title);
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_24.ChatResponseStream>(target, 'ChatResponseStream');
        D4.requireMinArgs(positional, 1, 'error');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'error');
        return t.error(message);
      },
    },
    constructorSignatures: {
      '': 'ChatResponseStream(VSCodeAdapter _adapter, String _streamId)',
    },
    methodSignatures: {
      'markdown': 'Future<void> markdown(String text)',
      'anchor': 'Future<void> anchor(String uri, {String? title})',
      'button': 'Future<void> button(String command, {String? title, List? arguments})',
      'filetree': 'Future<void> filetree(List<String> files, {String? baseUri})',
      'progress': 'Future<void> progress(String value)',
      'reference': 'Future<void> reference(String uri, {String? title})',
      'error': 'Future<void> error(String message)',
    },
  );
}

// =============================================================================
// HelperLogging Bridge
// =============================================================================

BridgedClass _createHelperLoggingBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_27.HelperLogging,
    name: 'HelperLogging',
    isAssignable: (v) => v is $tom_vscode_scripting_api_27.HelperLogging,
    constructors: {
      '': (visitor, positional, named) {
        return $tom_vscode_scripting_api_27.HelperLogging();
      },
    },
    staticGetters: {
      'debugLogging': (visitor) => $tom_vscode_scripting_api_27.HelperLogging.debugLogging,
    },
    staticSetters: {
      'debugLogging': (visitor, value) => 
        $tom_vscode_scripting_api_27.HelperLogging.debugLogging = D4.extractBridgedArg<bool>(value, 'debugLogging'),
    },
    constructorSignatures: {
      '': 'HelperLogging()',
    },
    staticGetterSignatures: {
      'debugLogging': 'bool get debugLogging',
    },
    staticSetterSignatures: {
      'debugLogging': 'set debugLogging(dynamic value)',
    },
  );
}

// =============================================================================
// VsCodeHelper Bridge
// =============================================================================

BridgedClass _createVsCodeHelperBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_27.VsCodeHelper,
    name: 'VsCodeHelper',
    isAssignable: (v) => v is $tom_vscode_scripting_api_27.VsCodeHelper,
    constructors: {
    },
    staticMethods: {
      'getVSCode': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_27.VsCodeHelper.getVSCode();
      },
      'setVSCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setVSCode');
        final vscode = D4.getRequiredArg<$tom_vscode_scripting_api_20.VSCode>(positional, 0, 'vscode', 'setVSCode');
        return $tom_vscode_scripting_api_27.VsCodeHelper.setVSCode(vscode);
      },
      'initialize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'initialize');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'initialize');
        return $tom_vscode_scripting_api_27.VsCodeHelper.initialize(adapter);
      },
      'getWindowId': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getWindowId(timeoutSeconds: timeoutSeconds);
      },
      'generateTimestampId': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_27.VsCodeHelper.generateTimestampId();
      },
      'showInfo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showInfo');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showInfo');
        final choices = D4.coerceListOrNull<String>(named['choices'], 'choices');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.showInfo(message, choices: choices, timeoutSeconds: timeoutSeconds);
      },
      'showWarning': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showWarning');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showWarning');
        final choices = D4.coerceListOrNull<String>(named['choices'], 'choices');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.showWarning(message, choices: choices, timeoutSeconds: timeoutSeconds);
      },
      'showError': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showError');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'showError');
        final choices = D4.coerceListOrNull<String>(named['choices'], 'choices');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.showError(message, choices: choices, timeoutSeconds: timeoutSeconds);
      },
      'quickPick': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'quickPick');
        if (positional.isEmpty) {
          throw ArgumentError('quickPick: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<String>(positional[0], 'items');
        final placeholder = D4.getOptionalNamedArg<String?>(named, 'placeholder');
        final canPickMany = D4.getNamedArgWithDefault<bool>(named, 'canPickMany', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 1800);
        final fallbackValueOnTimeout = D4.getOptionalNamedArg<String?>(named, 'fallbackValueOnTimeout');
        final failOnTimeout = D4.getNamedArgWithDefault<bool>(named, 'failOnTimeout', false);
        return $tom_vscode_scripting_api_27.VsCodeHelper.quickPick(items, placeholder: placeholder, canPickMany: canPickMany, timeoutSeconds: timeoutSeconds, fallbackValueOnTimeout: fallbackValueOnTimeout, failOnTimeout: failOnTimeout);
      },
      'inputBox': (visitor, positional, named, typeArgs) {
        final prompt = D4.getOptionalNamedArg<String?>(named, 'prompt');
        final placeholder = D4.getOptionalNamedArg<String?>(named, 'placeholder');
        final defaultValue = D4.getOptionalNamedArg<String?>(named, 'defaultValue');
        final password = D4.getNamedArgWithDefault<bool>(named, 'password', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 1800);
        final fallbackValueOnTimeout = D4.getOptionalNamedArg<String?>(named, 'fallbackValueOnTimeout');
        final failOnTimeout = D4.getNamedArgWithDefault<bool>(named, 'failOnTimeout', false);
        return $tom_vscode_scripting_api_27.VsCodeHelper.inputBox(prompt: prompt, placeholder: placeholder, defaultValue: defaultValue, password: password, timeoutSeconds: timeoutSeconds, fallbackValueOnTimeout: fallbackValueOnTimeout, failOnTimeout: failOnTimeout);
      },
      'getWorkspaceRoot': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getWorkspaceRoot(timeoutSeconds: timeoutSeconds);
      },
      'getWorkspaceFolders': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getWorkspaceFolders(timeoutSeconds: timeoutSeconds);
      },
      'getActiveTextEditor': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getActiveTextEditor(timeoutSeconds: timeoutSeconds);
      },
      'findFiles': (visitor, positional, named, typeArgs) {
        final include = D4.getRequiredNamedArg<String>(named, 'include', 'findFiles');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.findFiles(include: include, exclude: exclude, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'readFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'readFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'readFile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.readFile(path, timeoutSeconds: timeoutSeconds);
      },
      'writeFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'writeFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'writeFile');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'writeFile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.writeFile(path, content, timeoutSeconds: timeoutSeconds);
      },
      'createFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'createFile');
        final content = D4.getNamedArgWithDefault<String>(named, 'content', '');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.createFile(path, content: content, timeoutSeconds: timeoutSeconds);
      },
      'deleteFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'deleteFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'deleteFile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.deleteFile(path, timeoutSeconds: timeoutSeconds);
      },
      'fileExists': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fileExists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'fileExists');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_27.VsCodeHelper.fileExists(path, timeoutSeconds: timeoutSeconds);
      },
      'executeCommand': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'executeCommand');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'executeCommand');
        final args = D4.getOptionalNamedArg<List?>(named, 'args');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.executeCommand(command, args: args, timeoutSeconds: timeoutSeconds);
      },
      'setStatus': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setStatus');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'setStatus');
        final timeout = D4.getOptionalNamedArg<int?>(named, 'timeout');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.setStatus(message, timeout: timeout, timeoutSeconds: timeoutSeconds);
      },
      'createOutput': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createOutput');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'createOutput');
        final initialContent = D4.getOptionalNamedArg<String?>(named, 'initialContent');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.createOutput(name, initialContent: initialContent, timeoutSeconds: timeoutSeconds);
      },
      'appendOutput': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'appendOutput');
        final channel = D4.getRequiredArg<String>(positional, 0, 'channel', 'appendOutput');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'appendOutput');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.appendOutput(channel, text, timeoutSeconds: timeoutSeconds);
      },
      'copyToClipboard': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'copyToClipboard');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'copyToClipboard');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return $tom_vscode_scripting_api_27.VsCodeHelper.copyToClipboard(text, timeoutSeconds: timeoutSeconds);
      },
      'readClipboard': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 10);
        return $tom_vscode_scripting_api_27.VsCodeHelper.readClipboard(timeoutSeconds: timeoutSeconds);
      },
      'openFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'openFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'openFile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 600);
        return $tom_vscode_scripting_api_27.VsCodeHelper.openFile(path, timeoutSeconds: timeoutSeconds);
      },
      'getConfig': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getConfig');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'getConfig');
        final key = D4.getOptionalNamedArg<String?>(named, 'key');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getConfig(section, key: key, timeoutSeconds: timeoutSeconds);
      },
      'setConfig': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'setConfig');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'setConfig');
        final key = D4.getRequiredArg<String>(positional, 1, 'key', 'setConfig');
        final value = D4.getRequiredArg<dynamic>(positional, 2, 'value', 'setConfig');
        final global = D4.getNamedArgWithDefault<bool>(named, 'global', true);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.setConfig(section, key, value, global: global, timeoutSeconds: timeoutSeconds);
      },
      'runPubGet': (visitor, positional, named, typeArgs) {
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.runPubGet(workingDirectory: workingDirectory, timeoutSeconds: timeoutSeconds);
      },
      'runPubUpgrade': (visitor, positional, named, typeArgs) {
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.runPubUpgrade(workingDirectory: workingDirectory, timeoutSeconds: timeoutSeconds);
      },
      'addDependency': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addDependency');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'addDependency');
        final version = D4.getOptionalNamedArg<String?>(named, 'version');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.addDependency(name, version: version, timeoutSeconds: timeoutSeconds);
      },
      'getDiagnostics': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getDiagnostics');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'getDiagnostics');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getDiagnostics(uri, timeoutSeconds: timeoutSeconds);
      },
      'formatDocument': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'formatDocument');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'formatDocument');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.formatDocument(uri, timeoutSeconds: timeoutSeconds);
      },
      'organizeImports': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'organizeImports');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'organizeImports');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.organizeImports(uri, timeoutSeconds: timeoutSeconds);
      },
      'hotReload': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.hotReload(timeoutSeconds: timeoutSeconds);
      },
      'hotRestart': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 240);
        return $tom_vscode_scripting_api_27.VsCodeHelper.hotRestart(timeoutSeconds: timeoutSeconds);
      },
      'getFlutterDevices': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getFlutterDevices(timeoutSeconds: timeoutSeconds);
      },
      'runFlutterApp': (visitor, positional, named, typeArgs) {
        final deviceId = D4.getOptionalNamedArg<String?>(named, 'deviceId');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 420);
        return $tom_vscode_scripting_api_27.VsCodeHelper.runFlutterApp(deviceId: deviceId, timeoutSeconds: timeoutSeconds);
      },
      'askCopilot': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'askCopilot');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'askCopilot');
        final context = D4.getOptionalNamedArg<String?>(named, 'context');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.askCopilot(prompt, context: context, timeoutSeconds: timeoutSeconds);
      },
      'askCopilotChat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'askCopilotChat');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'askCopilotChat');
        final requestId = D4.getOptionalNamedArg<String?>(named, 'requestId');
        final pollIntervalSeconds = D4.getNamedArgWithDefault<int>(named, 'pollIntervalSeconds', 10);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 7200);
        final customResponseInstructions = D4.getNamedArgWithDefault<bool>(named, 'customResponseInstructions', false);
        return $tom_vscode_scripting_api_27.VsCodeHelper.askCopilotChat(prompt, requestId: requestId, pollIntervalSeconds: pollIntervalSeconds, timeoutSeconds: timeoutSeconds, customResponseInstructions: customResponseInstructions);
      },
      'askModel': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'askModel');
        final modelId = D4.getRequiredArg<String>(positional, 0, 'modelId', 'askModel');
        final prompt = D4.getRequiredArg<String>(positional, 1, 'prompt', 'askModel');
        final context = D4.getOptionalNamedArg<String?>(named, 'context');
        final vendor = D4.getNamedArgWithDefault<String>(named, 'vendor', 'copilot');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.askModel(modelId, prompt, context: context, vendor: vendor, timeoutSeconds: timeoutSeconds);
      },
      'getCopilotSuggestion': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'getCopilotSuggestion');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'getCopilotSuggestion');
        final instruction = D4.getRequiredArg<String>(positional, 1, 'instruction', 'getCopilotSuggestion');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getCopilotSuggestion(code, instruction, timeoutSeconds: timeoutSeconds);
      },
      'explainCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'explainCode');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'explainCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.explainCode(code, timeoutSeconds: timeoutSeconds);
      },
      'reviewCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'reviewCode');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'reviewCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.reviewCode(code, timeoutSeconds: timeoutSeconds);
      },
      'generateTests': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'generateTests');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'generateTests');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.generateTests(code, timeoutSeconds: timeoutSeconds);
      },
      'fixCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'fixCode');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'fixCode');
        final error = D4.getRequiredArg<String>(positional, 1, 'error', 'fixCode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.fixCode(code, error, timeoutSeconds: timeoutSeconds);
      },
      'selectCopilotModel': (visitor, positional, named, typeArgs) {
        final family = D4.getOptionalNamedArg<String?>(named, 'family');
        final vendor = D4.getOptionalNamedArg<String?>(named, 'vendor');
        final id = D4.getOptionalNamedArg<String?>(named, 'id');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.selectCopilotModel(family: family, vendor: vendor, id: id, timeoutSeconds: timeoutSeconds);
      },
      'getCopilotModels': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getCopilotModels(timeoutSeconds: timeoutSeconds);
      },
      'replaceText': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 6, 'replaceText');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'replaceText');
        final startLine = D4.getRequiredArg<int>(positional, 1, 'startLine', 'replaceText');
        final startChar = D4.getRequiredArg<int>(positional, 2, 'startChar', 'replaceText');
        final endLine = D4.getRequiredArg<int>(positional, 3, 'endLine', 'replaceText');
        final endChar = D4.getRequiredArg<int>(positional, 4, 'endChar', 'replaceText');
        final text = D4.getRequiredArg<String>(positional, 5, 'text', 'replaceText');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.replaceText(uri, startLine, startChar, endLine, endChar, text, timeoutSeconds: timeoutSeconds);
      },
      'insertSnippet': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'insertSnippet');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'insertSnippet');
        final line = D4.getRequiredArg<int>(positional, 1, 'line', 'insertSnippet');
        final character = D4.getRequiredArg<int>(positional, 2, 'character', 'insertSnippet');
        final snippet = D4.getRequiredArg<String>(positional, 3, 'snippet', 'insertSnippet');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.insertSnippet(uri, line, character, snippet, timeoutSeconds: timeoutSeconds);
      },
      'applyWorkspaceEdit': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'applyWorkspaceEdit');
        if (positional.isEmpty) {
          throw ArgumentError('applyWorkspaceEdit: Missing required argument "edits" at position 0');
        }
        final edits = D4.coerceList<Map<String, dynamic>>(positional[0], 'edits');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.applyWorkspaceEdit(edits, timeoutSeconds: timeoutSeconds);
      },
      'getSelection': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getSelection(timeoutSeconds: timeoutSeconds);
      },
      'setSelection': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 4, 'setSelection');
        final startLine = D4.getRequiredArg<int>(positional, 0, 'startLine', 'setSelection');
        final startChar = D4.getRequiredArg<int>(positional, 1, 'startChar', 'setSelection');
        final endLine = D4.getRequiredArg<int>(positional, 2, 'endLine', 'setSelection');
        final endChar = D4.getRequiredArg<int>(positional, 3, 'endChar', 'setSelection');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.setSelection(startLine, startChar, endLine, endChar, timeoutSeconds: timeoutSeconds);
      },
      'getCursorPosition': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 60);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getCursorPosition(timeoutSeconds: timeoutSeconds);
      },
      'getProjectFiles': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getProjectFiles');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'getProjectFiles');
        final excludeTests = D4.getNamedArgWithDefault<bool>(named, 'excludeTests', true);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getProjectFiles(pattern, excludeTests: excludeTests, timeoutSeconds: timeoutSeconds);
      },
      'getGitRoot': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getGitRoot(timeoutSeconds: timeoutSeconds);
      },
      'getProjectType': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getProjectType(timeoutSeconds: timeoutSeconds);
      },
      'searchInWorkspace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'searchInWorkspace');
        final query = D4.getRequiredArg<String>(positional, 0, 'query', 'searchInWorkspace');
        final includePattern = D4.getOptionalNamedArg<String?>(named, 'includePattern');
        final excludePattern = D4.getOptionalNamedArg<String?>(named, 'excludePattern');
        final isRegex = D4.getNamedArgWithDefault<bool>(named, 'isRegex', false);
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.searchInWorkspace(query, includePattern: includePattern, excludePattern: excludePattern, isRegex: isRegex, maxResults: maxResults, timeoutSeconds: timeoutSeconds);
      },
      'replaceInWorkspace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'replaceInWorkspace');
        final query = D4.getRequiredArg<String>(positional, 0, 'query', 'replaceInWorkspace');
        final replacement = D4.getRequiredArg<String>(positional, 1, 'replacement', 'replaceInWorkspace');
        final includePattern = D4.getOptionalNamedArg<String?>(named, 'includePattern');
        final excludePattern = D4.getOptionalNamedArg<String?>(named, 'excludePattern');
        final isRegex = D4.getNamedArgWithDefault<bool>(named, 'isRegex', false);
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.replaceInWorkspace(query, replacement, includePattern: includePattern, excludePattern: excludePattern, isRegex: isRegex, timeoutSeconds: timeoutSeconds);
      },
      'runTests': (visitor, positional, named, typeArgs) {
        final uri = D4.getOptionalNamedArg<String?>(named, 'uri');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 420);
        return $tom_vscode_scripting_api_27.VsCodeHelper.runTests(uri: uri, timeoutSeconds: timeoutSeconds);
      },
      'runTestsWithCoverage': (visitor, positional, named, typeArgs) {
        final uri = D4.getOptionalNamedArg<String?>(named, 'uri');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 600);
        return $tom_vscode_scripting_api_27.VsCodeHelper.runTestsWithCoverage(uri: uri, timeoutSeconds: timeoutSeconds);
      },
      'getTestResults': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 240);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getTestResults(timeoutSeconds: timeoutSeconds);
      },
      'startDebugging': (visitor, positional, named, typeArgs) {
        final config = D4.coerceMapOrNull<String, dynamic>(named['config'], 'config');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_27.VsCodeHelper.startDebugging(config: config, timeoutSeconds: timeoutSeconds);
      },
      'stopDebugging': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.stopDebugging(timeoutSeconds: timeoutSeconds);
      },
      'setBreakpoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setBreakpoint');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'setBreakpoint');
        final line = D4.getRequiredArg<int>(positional, 1, 'line', 'setBreakpoint');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.setBreakpoint(uri, line, timeoutSeconds: timeoutSeconds);
      },
      'removeBreakpoint': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'removeBreakpoint');
        final uri = D4.getRequiredArg<String>(positional, 0, 'uri', 'removeBreakpoint');
        final line = D4.getRequiredArg<int>(positional, 1, 'line', 'removeBreakpoint');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.removeBreakpoint(uri, line, timeoutSeconds: timeoutSeconds);
      },
      'getBreakpoints': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 180);
        return $tom_vscode_scripting_api_27.VsCodeHelper.getBreakpoints(timeoutSeconds: timeoutSeconds);
      },
    },
    staticMethodSignatures: {
      'getVSCode': 'VSCode getVSCode()',
      'setVSCode': 'void setVSCode(VSCode vscode)',
      'initialize': 'void initialize(VSCodeAdapter adapter)',
      'getWindowId': 'Future<String> getWindowId({int timeoutSeconds = 30})',
      'generateTimestampId': 'String generateTimestampId()',
      'showInfo': 'Future<String?> showInfo(String message, {List<String>? choices, int timeoutSeconds = 300})',
      'showWarning': 'Future<String?> showWarning(String message, {List<String>? choices, int timeoutSeconds = 300})',
      'showError': 'Future<String?> showError(String message, {List<String>? choices, int timeoutSeconds = 300})',
      'quickPick': 'Future<String?> quickPick(List<String> items, {String? placeholder, bool canPickMany = false, int timeoutSeconds = 1800, String? fallbackValueOnTimeout, bool failOnTimeout = false})',
      'inputBox': 'Future<String?> inputBox({String? prompt, String? placeholder, String? defaultValue, bool password = false, int timeoutSeconds = 1800, String? fallbackValueOnTimeout, bool failOnTimeout = false})',
      'getWorkspaceRoot': 'Future<String?> getWorkspaceRoot({int timeoutSeconds = 30})',
      'getWorkspaceFolders': 'Future<List?> getWorkspaceFolders({int timeoutSeconds = 30})',
      'getActiveTextEditor': 'Future getActiveTextEditor({int timeoutSeconds = 30})',
      'findFiles': 'Future<List<String>> findFiles({required String include, String? exclude, int? maxResults, int timeoutSeconds = 60})',
      'readFile': 'Future<String> readFile(String path, {int timeoutSeconds = 60})',
      'writeFile': 'Future<bool> writeFile(String path, String content, {int timeoutSeconds = 60})',
      'createFile': 'Future<bool> createFile(String path, {String content = \'\', int timeoutSeconds = 60})',
      'deleteFile': 'Future<bool> deleteFile(String path, {int timeoutSeconds = 60})',
      'fileExists': 'Future<bool> fileExists(String path, {int timeoutSeconds = 30})',
      'executeCommand': 'Future executeCommand(String command, {List? args, int timeoutSeconds = 120})',
      'setStatus': 'Future<void> setStatus(String message, {int? timeout, int timeoutSeconds = 120})',
      'createOutput': 'Future<String> createOutput(String name, {String? initialContent, int timeoutSeconds = 60})',
      'appendOutput': 'Future<void> appendOutput(String channel, String text, {int timeoutSeconds = 60})',
      'copyToClipboard': 'Future<void> copyToClipboard(String text, {int timeoutSeconds = 10})',
      'readClipboard': 'Future<String> readClipboard({int timeoutSeconds = 10})',
      'openFile': 'Future<void> openFile(String path, {int timeoutSeconds = 600})',
      'getConfig': 'Future getConfig(String section, {String? key, int timeoutSeconds = 60})',
      'setConfig': 'Future<bool> setConfig(String section, String key, dynamic value, {bool global = true, int timeoutSeconds = 60})',
      'runPubGet': 'Future<bool> runPubGet({String? workingDirectory, int timeoutSeconds = 300})',
      'runPubUpgrade': 'Future<bool> runPubUpgrade({String? workingDirectory, int timeoutSeconds = 300})',
      'addDependency': 'Future<bool> addDependency(String name, {String? version, int timeoutSeconds = 180})',
      'getDiagnostics': 'Future<List<Map<String, dynamic>>> getDiagnostics(String uri, {int timeoutSeconds = 120})',
      'formatDocument': 'Future<bool> formatDocument(String uri, {int timeoutSeconds = 180})',
      'organizeImports': 'Future<bool> organizeImports(String uri, {int timeoutSeconds = 180})',
      'hotReload': 'Future<bool> hotReload({int timeoutSeconds = 180})',
      'hotRestart': 'Future<bool> hotRestart({int timeoutSeconds = 240})',
      'getFlutterDevices': 'Future<List<Map<String, dynamic>>> getFlutterDevices({int timeoutSeconds = 180})',
      'runFlutterApp': 'Future<bool> runFlutterApp({String? deviceId, int timeoutSeconds = 420})',
      'askCopilot': 'Future<String> askCopilot(String prompt, {String? context, int timeoutSeconds = 300})',
      'askCopilotChat': 'Future<Map<String, dynamic>> askCopilotChat(String prompt, {String? requestId, int pollIntervalSeconds = 10, int timeoutSeconds = 7200, bool customResponseInstructions = false})',
      'askModel': 'Future<String> askModel(String modelId, String prompt, {String? context, String vendor = \'copilot\', int timeoutSeconds = 300})',
      'getCopilotSuggestion': 'Future<String> getCopilotSuggestion(String code, String instruction, {int timeoutSeconds = 300})',
      'explainCode': 'Future<String> explainCode(String code, {int timeoutSeconds = 300})',
      'reviewCode': 'Future<String> reviewCode(String code, {int timeoutSeconds = 300})',
      'generateTests': 'Future<String> generateTests(String code, {int timeoutSeconds = 300})',
      'fixCode': 'Future<String> fixCode(String code, String error, {int timeoutSeconds = 300})',
      'selectCopilotModel': 'Future<LanguageModelChat?> selectCopilotModel({String? family, String? vendor, String? id, int timeoutSeconds = 120})',
      'getCopilotModels': 'Future<List<LanguageModelChat>> getCopilotModels({int timeoutSeconds = 120})',
      'replaceText': 'Future<bool> replaceText(String uri, int startLine, int startChar, int endLine, int endChar, String text, {int timeoutSeconds = 180})',
      'insertSnippet': 'Future<bool> insertSnippet(String uri, int line, int character, String snippet, {int timeoutSeconds = 180})',
      'applyWorkspaceEdit': 'Future<bool> applyWorkspaceEdit(List<Map<String, dynamic>> edits, {int timeoutSeconds = 180})',
      'getSelection': 'Future<Selection?> getSelection({int timeoutSeconds = 60})',
      'setSelection': 'Future<bool> setSelection(int startLine, int startChar, int endLine, int endChar, {int timeoutSeconds = 120})',
      'getCursorPosition': 'Future<Position?> getCursorPosition({int timeoutSeconds = 60})',
      'getProjectFiles': 'Future<List<String>> getProjectFiles(String pattern, {bool excludeTests = true, int timeoutSeconds = 120})',
      'getGitRoot': 'Future<String?> getGitRoot({int timeoutSeconds = 120})',
      'getProjectType': 'Future<String> getProjectType({int timeoutSeconds = 120})',
      'searchInWorkspace': 'Future<List<Map<String, dynamic>>> searchInWorkspace(String query, {String? includePattern, String? excludePattern, bool isRegex = false, int? maxResults, int timeoutSeconds = 180})',
      'replaceInWorkspace': 'Future<bool> replaceInWorkspace(String query, String replacement, {String? includePattern, String? excludePattern, bool isRegex = false, int timeoutSeconds = 180})',
      'runTests': 'Future<Map<String, dynamic>> runTests({String? uri, int timeoutSeconds = 420})',
      'runTestsWithCoverage': 'Future<Map<String, dynamic>> runTestsWithCoverage({String? uri, int timeoutSeconds = 600})',
      'getTestResults': 'Future<List<Map<String, dynamic>>> getTestResults({int timeoutSeconds = 240})',
      'startDebugging': 'Future<bool> startDebugging({Map<String, dynamic>? config, int timeoutSeconds = 300})',
      'stopDebugging': 'Future<bool> stopDebugging({int timeoutSeconds = 180})',
      'setBreakpoint': 'Future<bool> setBreakpoint(String uri, int line, {int timeoutSeconds = 180})',
      'removeBreakpoint': 'Future<bool> removeBreakpoint(String uri, int line, {int timeoutSeconds = 180})',
      'getBreakpoints': 'Future<List<Map<String, dynamic>>> getBreakpoints({int timeoutSeconds = 180})',
    },
  );
}

// =============================================================================
// VsProgress Bridge
// =============================================================================

BridgedClass _createVsProgressBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_27.VsProgress,
    name: 'VsProgress',
    isAssignable: (v) => v is $tom_vscode_scripting_api_27.VsProgress,
    constructors: {
    },
    getters: {
      'channelName': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_27.VsProgress>(target, 'VsProgress').channelName,
    },
    methods: {
      'report': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_27.VsProgress>(target, 'VsProgress');
        D4.requireMinArgs(positional, 1, 'report');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'report');
        return t.report(message);
      },
      'complete': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_27.VsProgress>(target, 'VsProgress');
        return t.complete();
      },
      'error': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_27.VsProgress>(target, 'VsProgress');
        D4.requireMinArgs(positional, 1, 'error');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'error');
        return t.error(message);
      },
    },
    staticMethods: {
      'create': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'create');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'create');
        return $tom_vscode_scripting_api_27.VsProgress.create(name);
      },
    },
    methodSignatures: {
      'report': 'Future<void> report(String message)',
      'complete': 'Future<void> complete()',
      'error': 'Future<void> error(String message)',
    },
    getterSignatures: {
      'channelName': 'String get channelName',
    },
    staticMethodSignatures: {
      'create': 'Future<VsProgress> create(String name)',
    },
  );
}

// =============================================================================
// FileBatch Bridge
// =============================================================================

BridgedClass _createFileBatchBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_27.FileBatch,
    name: 'FileBatch',
    isAssignable: (v) => v is $tom_vscode_scripting_api_27.FileBatch,
    constructors: {
    },
    getters: {
      'files': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_27.FileBatch>(target, 'FileBatch').files,
      'count': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_27.FileBatch>(target, 'FileBatch').count,
    },
    methods: {
      'process': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_27.FileBatch>(target, 'FileBatch');
        D4.requireMinArgs(positional, 1, 'process');
        if (positional.isEmpty) {
          throw ArgumentError('process: Missing required argument "processor" at position 0');
        }
        final processorRaw = positional[0];
        return t.process<Object?>(((String p0, String p1) { return Future.value(D4.callInterpreterCallback(visitor!, processorRaw, [p0, p1])).then((v) => v as dynamic); }) as Future<dynamic> Function(String, String));
      },
      'filter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_27.FileBatch>(target, 'FileBatch');
        D4.requireMinArgs(positional, 1, 'filter');
        if (positional.isEmpty) {
          throw ArgumentError('filter: Missing required argument "predicate" at position 0');
        }
        final predicateRaw = positional[0];
        return t.filter(((String p0) { return D4.callInterpreterCallback(visitor!, predicateRaw, [p0]) as bool; }) as bool Function(String));
      },
    },
    staticMethods: {
      'fromPattern': (visitor, positional, named, typeArgs) {
        final include = D4.getRequiredNamedArg<String>(named, 'include', 'fromPattern');
        final exclude = D4.getOptionalNamedArg<String?>(named, 'exclude');
        final maxResults = D4.getOptionalNamedArg<int?>(named, 'maxResults');
        return $tom_vscode_scripting_api_27.FileBatch.fromPattern(include: include, exclude: exclude, maxResults: maxResults);
      },
    },
    methodSignatures: {
      'process': 'Future<List<T>> process(Future<T> Function(String path, String content) processor)',
      'filter': 'Future<FileBatch> filter(bool Function(String path) predicate)',
    },
    getterSignatures: {
      'files': 'List<String> get files',
      'count': 'int get count',
    },
    staticMethodSignatures: {
      'fromPattern': 'Future<FileBatch> fromPattern({required String include, String? exclude, int? maxResults})',
    },
  );
}

// =============================================================================
// VSCodeUri Bridge
// =============================================================================

BridgedClass _createVSCodeUriBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.VSCodeUri,
    name: 'VSCodeUri',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.VSCodeUri,
    constructors: {
      '': (visitor, positional, named) {
        final scheme = D4.getRequiredNamedArg<String>(named, 'scheme', 'VSCodeUri');
        final authority = D4.getNamedArgWithDefault<String>(named, 'authority', '');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'VSCodeUri');
        final query = D4.getNamedArgWithDefault<String>(named, 'query', '');
        final fragment = D4.getNamedArgWithDefault<String>(named, 'fragment', '');
        final fsPath = D4.getRequiredNamedArg<String>(named, 'fsPath', 'VSCodeUri');
        return $tom_vscode_scripting_api_29.VSCodeUri(scheme: scheme, authority: authority, path: path, query: query, fragment: fragment, fsPath: fsPath);
      },
      'file': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeUri');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'VSCodeUri');
        return $tom_vscode_scripting_api_29.VSCodeUri.file(path);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeUri');
        if (positional.isEmpty) {
          throw ArgumentError('VSCodeUri: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_29.VSCodeUri.fromJson(json);
      },
    },
    getters: {
      'scheme': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.VSCodeUri>(target, 'VSCodeUri').scheme,
      'authority': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.VSCodeUri>(target, 'VSCodeUri').authority,
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.VSCodeUri>(target, 'VSCodeUri').path,
      'query': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.VSCodeUri>(target, 'VSCodeUri').query,
      'fragment': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.VSCodeUri>(target, 'VSCodeUri').fragment,
      'fsPath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.VSCodeUri>(target, 'VSCodeUri').fsPath,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.VSCodeUri>(target, 'VSCodeUri');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.VSCodeUri>(target, 'VSCodeUri');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'VSCodeUri({required String scheme, String authority = \'\', required String path, String query = \'\', String fragment = \'\', required String fsPath})',
      'file': 'factory VSCodeUri.file(String path)',
      'fromJson': 'factory VSCodeUri.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'scheme': 'String get scheme',
      'authority': 'String get authority',
      'path': 'String get path',
      'query': 'String get query',
      'fragment': 'String get fragment',
      'fsPath': 'String get fsPath',
    },
  );
}

// =============================================================================
// WorkspaceFolder Bridge
// =============================================================================

BridgedClass _createWorkspaceFolderBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.WorkspaceFolder,
    name: 'WorkspaceFolder',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.WorkspaceFolder,
    constructors: {
      '': (visitor, positional, named) {
        final uri = D4.getRequiredNamedArg<$tom_vscode_scripting_api_29.VSCodeUri>(named, 'uri', 'WorkspaceFolder');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'WorkspaceFolder');
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'WorkspaceFolder');
        return $tom_vscode_scripting_api_29.WorkspaceFolder(uri: uri, name: name, index: index);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WorkspaceFolder');
        if (positional.isEmpty) {
          throw ArgumentError('WorkspaceFolder: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_29.WorkspaceFolder.fromJson(json);
      },
    },
    getters: {
      'uri': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.WorkspaceFolder>(target, 'WorkspaceFolder').uri,
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.WorkspaceFolder>(target, 'WorkspaceFolder').name,
      'index': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.WorkspaceFolder>(target, 'WorkspaceFolder').index,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.WorkspaceFolder>(target, 'WorkspaceFolder');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'WorkspaceFolder({required VSCodeUri uri, required String name, required int index})',
      'fromJson': 'factory WorkspaceFolder.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'uri': 'VSCodeUri get uri',
      'name': 'String get name',
      'index': 'int get index',
    },
  );
}

// =============================================================================
// TextDocument Bridge
// =============================================================================

BridgedClass _createTextDocumentBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.TextDocument,
    name: 'TextDocument',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.TextDocument,
    constructors: {
      '': (visitor, positional, named) {
        final uri = D4.getRequiredNamedArg<$tom_vscode_scripting_api_29.VSCodeUri>(named, 'uri', 'TextDocument');
        final fileName = D4.getRequiredNamedArg<String>(named, 'fileName', 'TextDocument');
        final isUntitled = D4.getRequiredNamedArg<bool>(named, 'isUntitled', 'TextDocument');
        final languageId = D4.getRequiredNamedArg<String>(named, 'languageId', 'TextDocument');
        final version = D4.getRequiredNamedArg<int>(named, 'version', 'TextDocument');
        final isDirty = D4.getRequiredNamedArg<bool>(named, 'isDirty', 'TextDocument');
        final isClosed = D4.getRequiredNamedArg<bool>(named, 'isClosed', 'TextDocument');
        final lineCount = D4.getRequiredNamedArg<int>(named, 'lineCount', 'TextDocument');
        return $tom_vscode_scripting_api_29.TextDocument(uri: uri, fileName: fileName, isUntitled: isUntitled, languageId: languageId, version: version, isDirty: isDirty, isClosed: isClosed, lineCount: lineCount);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextDocument');
        if (positional.isEmpty) {
          throw ArgumentError('TextDocument: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_29.TextDocument.fromJson(json);
      },
    },
    getters: {
      'uri': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument').uri,
      'fileName': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument').fileName,
      'isUntitled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument').isUntitled,
      'languageId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument').languageId,
      'version': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument').version,
      'isDirty': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument').isDirty,
      'isClosed': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument').isClosed,
      'lineCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument').lineCount,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.TextDocument>(target, 'TextDocument');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TextDocument({required VSCodeUri uri, required String fileName, required bool isUntitled, required String languageId, required int version, required bool isDirty, required bool isClosed, required int lineCount})',
      'fromJson': 'factory TextDocument.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'uri': 'VSCodeUri get uri',
      'fileName': 'String get fileName',
      'isUntitled': 'bool get isUntitled',
      'languageId': 'String get languageId',
      'version': 'int get version',
      'isDirty': 'bool get isDirty',
      'isClosed': 'bool get isClosed',
      'lineCount': 'int get lineCount',
    },
  );
}

// =============================================================================
// Position Bridge
// =============================================================================

BridgedClass _createPositionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.Position,
    name: 'Position',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.Position,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Position');
        final line = D4.getRequiredArg<int>(positional, 0, 'line', 'Position');
        final character = D4.getRequiredArg<int>(positional, 1, 'character', 'Position');
        return $tom_vscode_scripting_api_29.Position(line, character);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Position');
        if (positional.isEmpty) {
          throw ArgumentError('Position: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_29.Position.fromJson(json);
      },
    },
    getters: {
      'line': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Position>(target, 'Position').line,
      'character': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Position>(target, 'Position').character,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.Position>(target, 'Position');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Position(int line, int character)',
      'fromJson': 'factory Position.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'line': 'int get line',
      'character': 'int get character',
    },
  );
}

// =============================================================================
// Range Bridge
// =============================================================================

BridgedClass _createRangeBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.Range,
    name: 'Range',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.Range,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Range');
        final start = D4.getRequiredArg<$tom_vscode_scripting_api_29.Position>(positional, 0, 'start', 'Range');
        final end = D4.getRequiredArg<$tom_vscode_scripting_api_29.Position>(positional, 1, 'end', 'Range');
        return $tom_vscode_scripting_api_29.Range(start, end);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Range');
        if (positional.isEmpty) {
          throw ArgumentError('Range: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_29.Range.fromJson(json);
      },
    },
    getters: {
      'start': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Range>(target, 'Range').start,
      'end': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Range>(target, 'Range').end,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.Range>(target, 'Range');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Range(Position start, Position end)',
      'fromJson': 'factory Range.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'start': 'Position get start',
      'end': 'Position get end',
    },
  );
}

// =============================================================================
// Selection Bridge
// =============================================================================

BridgedClass _createSelectionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.Selection,
    name: 'Selection',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.Selection,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Selection');
        final anchor = D4.getRequiredArg<$tom_vscode_scripting_api_29.Position>(positional, 0, 'anchor', 'Selection');
        final active = D4.getRequiredArg<$tom_vscode_scripting_api_29.Position>(positional, 1, 'active', 'Selection');
        final isReversed = D4.getRequiredArg<bool>(positional, 2, 'isReversed', 'Selection');
        return $tom_vscode_scripting_api_29.Selection(anchor, active, isReversed);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Selection');
        if (positional.isEmpty) {
          throw ArgumentError('Selection: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_29.Selection.fromJson(json);
      },
    },
    getters: {
      'start': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Selection>(target, 'Selection').start,
      'end': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Selection>(target, 'Selection').end,
      'anchor': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Selection>(target, 'Selection').anchor,
      'active': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Selection>(target, 'Selection').active,
      'isReversed': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.Selection>(target, 'Selection').isReversed,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.Selection>(target, 'Selection');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Selection(Position anchor, Position active, bool isReversed)',
      'fromJson': 'factory Selection.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'start': 'Position get start',
      'end': 'Position get end',
      'anchor': 'Position get anchor',
      'active': 'Position get active',
      'isReversed': 'bool get isReversed',
    },
  );
}

// =============================================================================
// TextEditor Bridge
// =============================================================================

BridgedClass _createTextEditorBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.TextEditor,
    name: 'TextEditor',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.TextEditor,
    constructors: {
      '': (visitor, positional, named) {
        final document = D4.getRequiredNamedArg<$tom_vscode_scripting_api_29.TextDocument>(named, 'document', 'TextEditor');
        final selection = D4.getRequiredNamedArg<$tom_vscode_scripting_api_29.Selection>(named, 'selection', 'TextEditor');
        if (!named.containsKey('selections') || named['selections'] == null) {
          throw ArgumentError('TextEditor: Missing required named argument "selections"');
        }
        final selections = D4.coerceList<$tom_vscode_scripting_api_29.Selection>(named['selections'], 'selections');
        final visibleRanges = D4.getOptionalNamedArg<$tom_vscode_scripting_api_29.Range?>(named, 'visibleRanges');
        return $tom_vscode_scripting_api_29.TextEditor(document: document, selection: selection, selections: selections, visibleRanges: visibleRanges);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextEditor');
        if (positional.isEmpty) {
          throw ArgumentError('TextEditor: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_29.TextEditor.fromJson(json);
      },
    },
    getters: {
      'document': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextEditor>(target, 'TextEditor').document,
      'selection': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextEditor>(target, 'TextEditor').selection,
      'selections': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextEditor>(target, 'TextEditor').selections,
      'visibleRanges': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TextEditor>(target, 'TextEditor').visibleRanges,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.TextEditor>(target, 'TextEditor');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TextEditor({required TextDocument document, required Selection selection, required List<Selection> selections, Range? visibleRanges})',
      'fromJson': 'factory TextEditor.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'document': 'TextDocument get document',
      'selection': 'Selection get selection',
      'selections': 'List<Selection> get selections',
      'visibleRanges': 'Range? get visibleRanges',
    },
  );
}

// =============================================================================
// QuickPickItem Bridge
// =============================================================================

BridgedClass _createQuickPickItemBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.QuickPickItem,
    name: 'QuickPickItem',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.QuickPickItem,
    constructors: {
      '': (visitor, positional, named) {
        final label = D4.getRequiredNamedArg<String>(named, 'label', 'QuickPickItem');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final detail = D4.getOptionalNamedArg<String?>(named, 'detail');
        final picked = D4.getNamedArgWithDefault<bool>(named, 'picked', false);
        return $tom_vscode_scripting_api_29.QuickPickItem(label: label, description: description, detail: detail, picked: picked);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'QuickPickItem');
        if (positional.isEmpty) {
          throw ArgumentError('QuickPickItem: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_29.QuickPickItem.fromJson(json);
      },
    },
    getters: {
      'label': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.QuickPickItem>(target, 'QuickPickItem').label,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.QuickPickItem>(target, 'QuickPickItem').description,
      'detail': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.QuickPickItem>(target, 'QuickPickItem').detail,
      'picked': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.QuickPickItem>(target, 'QuickPickItem').picked,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.QuickPickItem>(target, 'QuickPickItem');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'QuickPickItem({required String label, String? description, String? detail, bool picked = false})',
      'fromJson': 'factory QuickPickItem.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'label': 'String get label',
      'description': 'String? get description',
      'detail': 'String? get detail',
      'picked': 'bool get picked',
    },
  );
}

// =============================================================================
// InputBoxOptions Bridge
// =============================================================================

BridgedClass _createInputBoxOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.InputBoxOptions,
    name: 'InputBoxOptions',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.InputBoxOptions,
    constructors: {
      '': (visitor, positional, named) {
        final prompt = D4.getOptionalNamedArg<String?>(named, 'prompt');
        final placeHolder = D4.getOptionalNamedArg<String?>(named, 'placeHolder');
        final value = D4.getOptionalNamedArg<String?>(named, 'value');
        final password = D4.getNamedArgWithDefault<bool>(named, 'password', false);
        return $tom_vscode_scripting_api_29.InputBoxOptions(prompt: prompt, placeHolder: placeHolder, value: value, password: password);
      },
    },
    getters: {
      'prompt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.InputBoxOptions>(target, 'InputBoxOptions').prompt,
      'placeHolder': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.InputBoxOptions>(target, 'InputBoxOptions').placeHolder,
      'value': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.InputBoxOptions>(target, 'InputBoxOptions').value,
      'password': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.InputBoxOptions>(target, 'InputBoxOptions').password,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.InputBoxOptions>(target, 'InputBoxOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'InputBoxOptions({String? prompt, String? placeHolder, String? value, bool password = false})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'prompt': 'String? get prompt',
      'placeHolder': 'String? get placeHolder',
      'value': 'String? get value',
      'password': 'bool get password',
    },
  );
}

// =============================================================================
// MessageOptions Bridge
// =============================================================================

BridgedClass _createMessageOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.MessageOptions,
    name: 'MessageOptions',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.MessageOptions,
    constructors: {
      '': (visitor, positional, named) {
        final modal = D4.getNamedArgWithDefault<bool>(named, 'modal', false);
        final detail = D4.getOptionalNamedArg<String?>(named, 'detail');
        return $tom_vscode_scripting_api_29.MessageOptions(modal: modal, detail: detail);
      },
    },
    getters: {
      'modal': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.MessageOptions>(target, 'MessageOptions').modal,
      'detail': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.MessageOptions>(target, 'MessageOptions').detail,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.MessageOptions>(target, 'MessageOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'MessageOptions({bool modal = false, String? detail})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'modal': 'bool get modal',
      'detail': 'String? get detail',
    },
  );
}

// =============================================================================
// TerminalOptions Bridge
// =============================================================================

BridgedClass _createTerminalOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.TerminalOptions,
    name: 'TerminalOptions',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.TerminalOptions,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final shellPath = D4.getOptionalNamedArg<String?>(named, 'shellPath');
        final shellArgs = D4.coerceListOrNull<String>(named['shellArgs'], 'shellArgs');
        final cwd = D4.getOptionalNamedArg<String?>(named, 'cwd');
        final env = D4.coerceMapOrNull<String, String>(named['env'], 'env');
        return $tom_vscode_scripting_api_29.TerminalOptions(name: name, shellPath: shellPath, shellArgs: shellArgs, cwd: cwd, env: env);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TerminalOptions>(target, 'TerminalOptions').name,
      'shellPath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TerminalOptions>(target, 'TerminalOptions').shellPath,
      'shellArgs': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TerminalOptions>(target, 'TerminalOptions').shellArgs,
      'cwd': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TerminalOptions>(target, 'TerminalOptions').cwd,
      'env': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.TerminalOptions>(target, 'TerminalOptions').env,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.TerminalOptions>(target, 'TerminalOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TerminalOptions({String? name, String? shellPath, List<String>? shellArgs, String? cwd, Map<String, String>? env})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String? get name',
      'shellPath': 'String? get shellPath',
      'shellArgs': 'List<String>? get shellArgs',
      'cwd': 'String? get cwd',
      'env': 'Map<String, String>? get env',
    },
  );
}

// =============================================================================
// FileSystemWatcherOptions Bridge
// =============================================================================

BridgedClass _createFileSystemWatcherOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_29.FileSystemWatcherOptions,
    name: 'FileSystemWatcherOptions',
    isAssignable: (v) => v is $tom_vscode_scripting_api_29.FileSystemWatcherOptions,
    constructors: {
      '': (visitor, positional, named) {
        final ignoreCreateEvents = D4.getNamedArgWithDefault<bool>(named, 'ignoreCreateEvents', false);
        final ignoreChangeEvents = D4.getNamedArgWithDefault<bool>(named, 'ignoreChangeEvents', false);
        final ignoreDeleteEvents = D4.getNamedArgWithDefault<bool>(named, 'ignoreDeleteEvents', false);
        return $tom_vscode_scripting_api_29.FileSystemWatcherOptions(ignoreCreateEvents: ignoreCreateEvents, ignoreChangeEvents: ignoreChangeEvents, ignoreDeleteEvents: ignoreDeleteEvents);
      },
    },
    getters: {
      'ignoreCreateEvents': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreCreateEvents,
      'ignoreChangeEvents': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreChangeEvents,
      'ignoreDeleteEvents': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_29.FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions').ignoreDeleteEvents,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_29.FileSystemWatcherOptions>(target, 'FileSystemWatcherOptions');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'FileSystemWatcherOptions({bool ignoreCreateEvents = false, bool ignoreChangeEvents = false, bool ignoreDeleteEvents = false})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'ignoreCreateEvents': 'bool get ignoreCreateEvents',
      'ignoreChangeEvents': 'bool get ignoreChangeEvents',
      'ignoreDeleteEvents': 'bool get ignoreDeleteEvents',
    },
  );
}

// =============================================================================
// SdkMessage Bridge
// =============================================================================

BridgedClass _createSdkMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.SdkMessage,
    name: 'SdkMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.SdkMessage,
    constructors: {
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkMessage');
        if (positional.isEmpty) {
          throw ArgumentError('SdkMessage: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_3.SdkMessage.fromJson(json);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkMessage>(target, 'SdkMessage').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkMessage>(target, 'SdkMessage').type,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkMessage>(target, 'SdkMessage').sessionId,
      'uuid': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkMessage>(target, 'SdkMessage').uuid,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.SdkMessage>(target, 'SdkMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      'fromJson': 'factory SdkMessage.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'sessionId': 'String? get sessionId',
      'uuid': 'String? get uuid',
    },
  );
}

// =============================================================================
// SdkAssistantMessage Bridge
// =============================================================================

BridgedClass _createSdkAssistantMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.SdkAssistantMessage,
    name: 'SdkAssistantMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.SdkAssistantMessage,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkAssistantMessage');
        if (positional.isEmpty) {
          throw ArgumentError('SdkAssistantMessage: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.SdkAssistantMessage(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage').type,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage').sessionId,
      'uuid': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage').uuid,
      'parentToolUseId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage').parentToolUseId,
      'error': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage').error,
      'message': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage').message,
      'content': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage').content,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.SdkAssistantMessage>(target, 'SdkAssistantMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'SdkAssistantMessage(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'sessionId': 'String? get sessionId',
      'uuid': 'String? get uuid',
      'parentToolUseId': 'String? get parentToolUseId',
      'error': 'String? get error',
      'message': 'Map<String, dynamic>? get message',
      'content': 'List<ContentBlock> get content',
    },
  );
}

// =============================================================================
// SdkUserMessage Bridge
// =============================================================================

BridgedClass _createSdkUserMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.SdkUserMessage,
    name: 'SdkUserMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.SdkUserMessage,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkUserMessage');
        if (positional.isEmpty) {
          throw ArgumentError('SdkUserMessage: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.SdkUserMessage(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage').type,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage').sessionId,
      'uuid': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage').uuid,
      'parentToolUseId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage').parentToolUseId,
      'isReplay': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage').isReplay,
      'message': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage').message,
      'content': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage').content,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.SdkUserMessage>(target, 'SdkUserMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'SdkUserMessage(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'sessionId': 'String? get sessionId',
      'uuid': 'String? get uuid',
      'parentToolUseId': 'String? get parentToolUseId',
      'isReplay': 'bool get isReplay',
      'message': 'Map<String, dynamic>? get message',
      'content': 'List<ContentBlock> get content',
    },
  );
}

// =============================================================================
// SdkResultMessage Bridge
// =============================================================================

BridgedClass _createSdkResultMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.SdkResultMessage,
    name: 'SdkResultMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.SdkResultMessage,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkResultMessage');
        if (positional.isEmpty) {
          throw ArgumentError('SdkResultMessage: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.SdkResultMessage(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').type,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').sessionId,
      'uuid': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').uuid,
      'subtype': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').subtype,
      'isError': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').isError,
      'result': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').result,
      'numTurns': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').numTurns,
      'durationMs': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').durationMs,
      'durationApiMs': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').durationApiMs,
      'stopReason': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').stopReason,
      'totalCostUsd': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').totalCostUsd,
      'usage': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage').usage,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.SdkResultMessage>(target, 'SdkResultMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'SdkResultMessage(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'sessionId': 'String? get sessionId',
      'uuid': 'String? get uuid',
      'subtype': 'String? get subtype',
      'isError': 'bool get isError',
      'result': 'String? get result',
      'numTurns': 'int? get numTurns',
      'durationMs': 'int? get durationMs',
      'durationApiMs': 'int? get durationApiMs',
      'stopReason': 'String? get stopReason',
      'totalCostUsd': 'double? get totalCostUsd',
      'usage': 'Map<String, dynamic>? get usage',
    },
  );
}

// =============================================================================
// SdkSystemMessage Bridge
// =============================================================================

BridgedClass _createSdkSystemMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.SdkSystemMessage,
    name: 'SdkSystemMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.SdkSystemMessage,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkSystemMessage');
        if (positional.isEmpty) {
          throw ArgumentError('SdkSystemMessage: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.SdkSystemMessage(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').type,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').sessionId,
      'uuid': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').uuid,
      'subtype': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').subtype,
      'model': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').model,
      'cwd': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').cwd,
      'tools': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').tools,
      'permissionMode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').permissionMode,
      'slashCommands': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').slashCommands,
      'apiKeySource': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').apiKeySource,
      'mcpServers': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage').mcpServers,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemMessage>(target, 'SdkSystemMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'SdkSystemMessage(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'sessionId': 'String? get sessionId',
      'uuid': 'String? get uuid',
      'subtype': 'String? get subtype',
      'model': 'String? get model',
      'cwd': 'String? get cwd',
      'tools': 'List<String> get tools',
      'permissionMode': 'String? get permissionMode',
      'slashCommands': 'List<String> get slashCommands',
      'apiKeySource': 'String? get apiKeySource',
      'mcpServers': 'List<Map<String, dynamic>> get mcpServers',
    },
  );
}

// =============================================================================
// SdkPartialAssistantMessage Bridge
// =============================================================================

BridgedClass _createSdkPartialAssistantMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.SdkPartialAssistantMessage,
    name: 'SdkPartialAssistantMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.SdkPartialAssistantMessage,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkPartialAssistantMessage');
        if (positional.isEmpty) {
          throw ArgumentError('SdkPartialAssistantMessage: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.SdkPartialAssistantMessage(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkPartialAssistantMessage>(target, 'SdkPartialAssistantMessage').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkPartialAssistantMessage>(target, 'SdkPartialAssistantMessage').type,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkPartialAssistantMessage>(target, 'SdkPartialAssistantMessage').sessionId,
      'uuid': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkPartialAssistantMessage>(target, 'SdkPartialAssistantMessage').uuid,
      'event': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkPartialAssistantMessage>(target, 'SdkPartialAssistantMessage').event,
      'parentToolUseId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkPartialAssistantMessage>(target, 'SdkPartialAssistantMessage').parentToolUseId,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.SdkPartialAssistantMessage>(target, 'SdkPartialAssistantMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'SdkPartialAssistantMessage(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'sessionId': 'String? get sessionId',
      'uuid': 'String? get uuid',
      'event': 'Map<String, dynamic>? get event',
      'parentToolUseId': 'String? get parentToolUseId',
    },
  );
}

// =============================================================================
// SdkSystemEvent Bridge
// =============================================================================

BridgedClass _createSdkSystemEventBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.SdkSystemEvent,
    name: 'SdkSystemEvent',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.SdkSystemEvent,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkSystemEvent');
        if (positional.isEmpty) {
          throw ArgumentError('SdkSystemEvent: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.SdkSystemEvent(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemEvent>(target, 'SdkSystemEvent').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemEvent>(target, 'SdkSystemEvent').type,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemEvent>(target, 'SdkSystemEvent').sessionId,
      'uuid': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemEvent>(target, 'SdkSystemEvent').uuid,
      'subtype': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemEvent>(target, 'SdkSystemEvent').subtype,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.SdkSystemEvent>(target, 'SdkSystemEvent');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'SdkSystemEvent(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'sessionId': 'String? get sessionId',
      'uuid': 'String? get uuid',
      'subtype': 'String? get subtype',
    },
  );
}

// =============================================================================
// SdkUnknownMessage Bridge
// =============================================================================

BridgedClass _createSdkUnknownMessageBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.SdkUnknownMessage,
    name: 'SdkUnknownMessage',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.SdkUnknownMessage,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkUnknownMessage');
        if (positional.isEmpty) {
          throw ArgumentError('SdkUnknownMessage: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.SdkUnknownMessage(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUnknownMessage>(target, 'SdkUnknownMessage').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUnknownMessage>(target, 'SdkUnknownMessage').type,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUnknownMessage>(target, 'SdkUnknownMessage').sessionId,
      'uuid': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.SdkUnknownMessage>(target, 'SdkUnknownMessage').uuid,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.SdkUnknownMessage>(target, 'SdkUnknownMessage');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'SdkUnknownMessage(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'sessionId': 'String? get sessionId',
      'uuid': 'String? get uuid',
    },
  );
}

// =============================================================================
// ContentBlock Bridge
// =============================================================================

BridgedClass _createContentBlockBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.ContentBlock,
    name: 'ContentBlock',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.ContentBlock,
    constructors: {
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ContentBlock');
        if (positional.isEmpty) {
          throw ArgumentError('ContentBlock: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_3.ContentBlock.fromJson(json);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ContentBlock>(target, 'ContentBlock').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ContentBlock>(target, 'ContentBlock').type,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.ContentBlock>(target, 'ContentBlock');
        return t.toJson();
      },
    },
    constructorSignatures: {
      'fromJson': 'factory ContentBlock.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
    },
  );
}

// =============================================================================
// TextBlock Bridge
// =============================================================================

BridgedClass _createTextBlockBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.TextBlock,
    name: 'TextBlock',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.TextBlock,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TextBlock');
        if (positional.isEmpty) {
          throw ArgumentError('TextBlock: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.TextBlock(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.TextBlock>(target, 'TextBlock').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.TextBlock>(target, 'TextBlock').type,
      'text': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.TextBlock>(target, 'TextBlock').text,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.TextBlock>(target, 'TextBlock');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TextBlock(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'text': 'String get text',
    },
  );
}

// =============================================================================
// ThinkingBlock Bridge
// =============================================================================

BridgedClass _createThinkingBlockBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.ThinkingBlock,
    name: 'ThinkingBlock',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.ThinkingBlock,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ThinkingBlock');
        if (positional.isEmpty) {
          throw ArgumentError('ThinkingBlock: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.ThinkingBlock(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ThinkingBlock>(target, 'ThinkingBlock').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ThinkingBlock>(target, 'ThinkingBlock').type,
      'thinking': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ThinkingBlock>(target, 'ThinkingBlock').thinking,
      'signature': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ThinkingBlock>(target, 'ThinkingBlock').signature,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.ThinkingBlock>(target, 'ThinkingBlock');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ThinkingBlock(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'thinking': 'String get thinking',
      'signature': 'String? get signature',
    },
  );
}

// =============================================================================
// ToolUseBlock Bridge
// =============================================================================

BridgedClass _createToolUseBlockBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.ToolUseBlock,
    name: 'ToolUseBlock',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.ToolUseBlock,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ToolUseBlock');
        if (positional.isEmpty) {
          throw ArgumentError('ToolUseBlock: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.ToolUseBlock(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolUseBlock>(target, 'ToolUseBlock').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolUseBlock>(target, 'ToolUseBlock').type,
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolUseBlock>(target, 'ToolUseBlock').id,
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolUseBlock>(target, 'ToolUseBlock').name,
      'input': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolUseBlock>(target, 'ToolUseBlock').input,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.ToolUseBlock>(target, 'ToolUseBlock');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ToolUseBlock(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'id': 'String get id',
      'name': 'String get name',
      'input': 'Map<String, dynamic> get input',
    },
  );
}

// =============================================================================
// ToolResultBlock Bridge
// =============================================================================

BridgedClass _createToolResultBlockBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.ToolResultBlock,
    name: 'ToolResultBlock',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.ToolResultBlock,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ToolResultBlock');
        if (positional.isEmpty) {
          throw ArgumentError('ToolResultBlock: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.ToolResultBlock(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolResultBlock>(target, 'ToolResultBlock').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolResultBlock>(target, 'ToolResultBlock').type,
      'toolUseId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolResultBlock>(target, 'ToolResultBlock').toolUseId,
      'content': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolResultBlock>(target, 'ToolResultBlock').content,
      'isError': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.ToolResultBlock>(target, 'ToolResultBlock').isError,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.ToolResultBlock>(target, 'ToolResultBlock');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ToolResultBlock(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
      'toolUseId': 'String get toolUseId',
      'content': 'Object? get content',
      'isError': 'bool get isError',
    },
  );
}

// =============================================================================
// UnknownBlock Bridge
// =============================================================================

BridgedClass _createUnknownBlockBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_3.UnknownBlock,
    name: 'UnknownBlock',
    isAssignable: (v) => v is $tom_vscode_scripting_api_3.UnknownBlock,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'UnknownBlock');
        if (positional.isEmpty) {
          throw ArgumentError('UnknownBlock: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_3.UnknownBlock(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.UnknownBlock>(target, 'UnknownBlock').raw,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_3.UnknownBlock>(target, 'UnknownBlock').type,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_3.UnknownBlock>(target, 'UnknownBlock');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'UnknownBlock(Map<String, dynamic> raw)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'type': 'String get type',
    },
  );
}

// =============================================================================
// PermissionRuleValue Bridge
// =============================================================================

BridgedClass _createPermissionRuleValueBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.PermissionRuleValue,
    name: 'PermissionRuleValue',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.PermissionRuleValue,
    constructors: {
      '': (visitor, positional, named) {
        final toolName = D4.getRequiredNamedArg<String>(named, 'toolName', 'PermissionRuleValue');
        final ruleContent = D4.getOptionalNamedArg<String?>(named, 'ruleContent');
        return $tom_vscode_scripting_api_6.PermissionRuleValue(toolName: toolName, ruleContent: ruleContent);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PermissionRuleValue');
        if (positional.isEmpty) {
          throw ArgumentError('PermissionRuleValue: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_6.PermissionRuleValue.fromJson(json);
      },
    },
    getters: {
      'toolName': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionRuleValue>(target, 'PermissionRuleValue').toolName,
      'ruleContent': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionRuleValue>(target, 'PermissionRuleValue').ruleContent,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.PermissionRuleValue>(target, 'PermissionRuleValue');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'PermissionRuleValue({required String toolName, String? ruleContent})',
      'fromJson': 'factory PermissionRuleValue.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'toolName': 'String get toolName',
      'ruleContent': 'String? get ruleContent',
    },
  );
}

// =============================================================================
// PermissionUpdate Bridge
// =============================================================================

BridgedClass _createPermissionUpdateBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.PermissionUpdate,
    name: 'PermissionUpdate',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.PermissionUpdate,
    constructors: {
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PermissionUpdate');
        if (positional.isEmpty) {
          throw ArgumentError('PermissionUpdate: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_6.PermissionUpdate.fromJson(json);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdate>(target, 'PermissionUpdate').type,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdate>(target, 'PermissionUpdate');
        return t.toJson();
      },
    },
    constructorSignatures: {
      'fromJson': 'factory PermissionUpdate.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
    },
  );
}

// =============================================================================
// PermissionUpdateRules Bridge
// =============================================================================

BridgedClass _createPermissionUpdateRulesBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.PermissionUpdateRules,
    name: 'PermissionUpdateRules',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.PermissionUpdateRules,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final type = D4.getRequiredNamedArg<String>(named, 'type', 'PermissionUpdateRules');
        if (!named.containsKey('rules') || named['rules'] == null) {
          throw ArgumentError('PermissionUpdateRules: Missing required named argument "rules"');
        }
        final rules = D4.coerceList<$tom_vscode_scripting_api_6.PermissionRuleValue>(named['rules'], 'rules');
        final behavior = D4.getRequiredNamedArg<$tom_vscode_scripting_api_6.PermissionBehavior>(named, 'behavior', 'PermissionUpdateRules');
        final destination = D4.getRequiredNamedArg<$tom_vscode_scripting_api_6.PermissionUpdateDestination>(named, 'destination', 'PermissionUpdateRules');
        return $tom_vscode_scripting_api_6.PermissionUpdateRules(type: type, rules: rules, behavior: behavior, destination: destination);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateRules>(target, 'PermissionUpdateRules').type,
      'rules': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateRules>(target, 'PermissionUpdateRules').rules,
      'behavior': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateRules>(target, 'PermissionUpdateRules').behavior,
      'destination': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateRules>(target, 'PermissionUpdateRules').destination,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateRules>(target, 'PermissionUpdateRules');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'PermissionUpdateRules({required String type, required List<PermissionRuleValue> rules, required PermissionBehavior behavior, required PermissionUpdateDestination destination})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
      'rules': 'List<PermissionRuleValue> get rules',
      'behavior': 'PermissionBehavior get behavior',
      'destination': 'PermissionUpdateDestination get destination',
    },
  );
}

// =============================================================================
// PermissionUpdateSetMode Bridge
// =============================================================================

BridgedClass _createPermissionUpdateSetModeBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.PermissionUpdateSetMode,
    name: 'PermissionUpdateSetMode',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.PermissionUpdateSetMode,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final mode = D4.getRequiredNamedArg<$tom_vscode_scripting_api_6.PermissionMode>(named, 'mode', 'PermissionUpdateSetMode');
        final destination = D4.getRequiredNamedArg<$tom_vscode_scripting_api_6.PermissionUpdateDestination>(named, 'destination', 'PermissionUpdateSetMode');
        return $tom_vscode_scripting_api_6.PermissionUpdateSetMode(mode: mode, destination: destination);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateSetMode>(target, 'PermissionUpdateSetMode').type,
      'mode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateSetMode>(target, 'PermissionUpdateSetMode').mode,
      'destination': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateSetMode>(target, 'PermissionUpdateSetMode').destination,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateSetMode>(target, 'PermissionUpdateSetMode');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'PermissionUpdateSetMode({required PermissionMode mode, required PermissionUpdateDestination destination})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
      'mode': 'PermissionMode get mode',
      'destination': 'PermissionUpdateDestination get destination',
    },
  );
}

// =============================================================================
// PermissionUpdateDirectories Bridge
// =============================================================================

BridgedClass _createPermissionUpdateDirectoriesBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.PermissionUpdateDirectories,
    name: 'PermissionUpdateDirectories',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.PermissionUpdateDirectories,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final type = D4.getRequiredNamedArg<String>(named, 'type', 'PermissionUpdateDirectories');
        if (!named.containsKey('directories') || named['directories'] == null) {
          throw ArgumentError('PermissionUpdateDirectories: Missing required named argument "directories"');
        }
        final directories = D4.coerceList<String>(named['directories'], 'directories');
        final destination = D4.getRequiredNamedArg<$tom_vscode_scripting_api_6.PermissionUpdateDestination>(named, 'destination', 'PermissionUpdateDirectories');
        return $tom_vscode_scripting_api_6.PermissionUpdateDirectories(type: type, directories: directories, destination: destination);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateDirectories>(target, 'PermissionUpdateDirectories').type,
      'directories': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateDirectories>(target, 'PermissionUpdateDirectories').directories,
      'destination': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateDirectories>(target, 'PermissionUpdateDirectories').destination,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.PermissionUpdateDirectories>(target, 'PermissionUpdateDirectories');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'PermissionUpdateDirectories({required String type, required List<String> directories, required PermissionUpdateDestination destination})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
      'directories': 'List<String> get directories',
      'destination': 'PermissionUpdateDestination get destination',
    },
  );
}

// =============================================================================
// PermissionResult Bridge
// =============================================================================

BridgedClass _createPermissionResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.PermissionResult,
    name: 'PermissionResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.PermissionResult,
    constructors: {
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PermissionResult');
        if (positional.isEmpty) {
          throw ArgumentError('PermissionResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_6.PermissionResult.fromJson(json);
      },
    },
    getters: {
      'behavior': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionResult>(target, 'PermissionResult').behavior,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.PermissionResult>(target, 'PermissionResult');
        return t.toJson();
      },
    },
    constructorSignatures: {
      'fromJson': 'factory PermissionResult.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'behavior': 'String get behavior',
    },
  );
}

// =============================================================================
// PermissionAllow Bridge
// =============================================================================

BridgedClass _createPermissionAllowBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.PermissionAllow,
    name: 'PermissionAllow',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.PermissionAllow,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final updatedInput = D4.coerceMapOrNull<String, dynamic>(named['updatedInput'], 'updatedInput');
        final updatedPermissions = D4.coerceListOrNull<$tom_vscode_scripting_api_6.PermissionUpdate>(named['updatedPermissions'], 'updatedPermissions');
        final toolUseId = D4.getOptionalNamedArg<String?>(named, 'toolUseId');
        final decisionClassification = D4.getOptionalNamedArg<$tom_vscode_scripting_api_6.PermissionDecisionClassification?>(named, 'decisionClassification');
        return $tom_vscode_scripting_api_6.PermissionAllow(updatedInput: updatedInput, updatedPermissions: updatedPermissions, toolUseId: toolUseId, decisionClassification: decisionClassification);
      },
    },
    getters: {
      'behavior': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionAllow>(target, 'PermissionAllow').behavior,
      'updatedInput': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionAllow>(target, 'PermissionAllow').updatedInput,
      'updatedPermissions': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionAllow>(target, 'PermissionAllow').updatedPermissions,
      'toolUseId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionAllow>(target, 'PermissionAllow').toolUseId,
      'decisionClassification': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionAllow>(target, 'PermissionAllow').decisionClassification,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.PermissionAllow>(target, 'PermissionAllow');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'PermissionAllow({Map<String, dynamic>? updatedInput, List<PermissionUpdate>? updatedPermissions, String? toolUseId, PermissionDecisionClassification? decisionClassification})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'behavior': 'String get behavior',
      'updatedInput': 'Map<String, dynamic>? get updatedInput',
      'updatedPermissions': 'List<PermissionUpdate>? get updatedPermissions',
      'toolUseId': 'String? get toolUseId',
      'decisionClassification': 'PermissionDecisionClassification? get decisionClassification',
    },
  );
}

// =============================================================================
// PermissionDeny Bridge
// =============================================================================

BridgedClass _createPermissionDenyBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.PermissionDeny,
    name: 'PermissionDeny',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.PermissionDeny,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'PermissionDeny');
        final interrupt = D4.getOptionalNamedArg<bool?>(named, 'interrupt');
        final toolUseId = D4.getOptionalNamedArg<String?>(named, 'toolUseId');
        final decisionClassification = D4.getOptionalNamedArg<$tom_vscode_scripting_api_6.PermissionDecisionClassification?>(named, 'decisionClassification');
        return $tom_vscode_scripting_api_6.PermissionDeny(message: message, interrupt: interrupt, toolUseId: toolUseId, decisionClassification: decisionClassification);
      },
    },
    getters: {
      'behavior': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionDeny>(target, 'PermissionDeny').behavior,
      'message': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionDeny>(target, 'PermissionDeny').message,
      'interrupt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionDeny>(target, 'PermissionDeny').interrupt,
      'toolUseId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionDeny>(target, 'PermissionDeny').toolUseId,
      'decisionClassification': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.PermissionDeny>(target, 'PermissionDeny').decisionClassification,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_6.PermissionDeny>(target, 'PermissionDeny');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'PermissionDeny({required String message, bool? interrupt, String? toolUseId, PermissionDecisionClassification? decisionClassification})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'behavior': 'String get behavior',
      'message': 'String get message',
      'interrupt': 'bool? get interrupt',
      'toolUseId': 'String? get toolUseId',
      'decisionClassification': 'PermissionDecisionClassification? get decisionClassification',
    },
  );
}

// =============================================================================
// CanUseToolContext Bridge
// =============================================================================

BridgedClass _createCanUseToolContextBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_6.CanUseToolContext,
    name: 'CanUseToolContext',
    isAssignable: (v) => v is $tom_vscode_scripting_api_6.CanUseToolContext,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CanUseToolContext');
        if (positional.isEmpty) {
          throw ArgumentError('CanUseToolContext: Missing required argument "raw" at position 0');
        }
        final raw = D4.coerceMap<String, dynamic>(positional[0], 'raw');
        return $tom_vscode_scripting_api_6.CanUseToolContext(raw);
      },
    },
    getters: {
      'raw': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.CanUseToolContext>(target, 'CanUseToolContext').raw,
      'suggestions': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_6.CanUseToolContext>(target, 'CanUseToolContext').suggestions,
    },
    constructorSignatures: {
      '': 'const CanUseToolContext(Map<String, dynamic> raw)',
    },
    getterSignatures: {
      'raw': 'Map<String, dynamic> get raw',
      'suggestions': 'List<PermissionUpdate> get suggestions',
    },
  );
}

// =============================================================================
// CallToolResult Bridge
// =============================================================================

BridgedClass _createCallToolResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_2.CallToolResult,
    name: 'CallToolResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_2.CallToolResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('content') || named['content'] == null) {
          throw ArgumentError('CallToolResult: Missing required named argument "content"');
        }
        final content = D4.coerceList<Map<String, dynamic>>(named['content'], 'content');
        final isError = D4.getOptionalNamedArg<bool?>(named, 'isError');
        return $tom_vscode_scripting_api_2.CallToolResult(content: content, isError: isError);
      },
      'text': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CallToolResult');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'CallToolResult');
        final isError = D4.getOptionalNamedArg<bool?>(named, 'isError');
        return $tom_vscode_scripting_api_2.CallToolResult.text(text, isError: isError);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CallToolResult');
        if (positional.isEmpty) {
          throw ArgumentError('CallToolResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_2.CallToolResult.fromJson(json);
      },
    },
    getters: {
      'content': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.CallToolResult>(target, 'CallToolResult').content,
      'isError': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.CallToolResult>(target, 'CallToolResult').isError,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.CallToolResult>(target, 'CallToolResult');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'CallToolResult({required List<Map<String, dynamic>> content, bool? isError})',
      'text': 'factory CallToolResult.text(String text, {bool? isError})',
      'fromJson': 'factory CallToolResult.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'content': 'List<Map<String, dynamic>> get content',
      'isError': 'bool? get isError',
    },
  );
}

// =============================================================================
// SdkMcpTool Bridge
// =============================================================================

BridgedClass _createSdkMcpToolBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_2.SdkMcpTool,
    name: 'SdkMcpTool',
    isAssignable: (v) => v is $tom_vscode_scripting_api_2.SdkMcpTool,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'SdkMcpTool');
        final description = D4.getRequiredNamedArg<String>(named, 'description', 'SdkMcpTool');
        if (!named.containsKey('inputSchema') || named['inputSchema'] == null) {
          throw ArgumentError('SdkMcpTool: Missing required named argument "inputSchema"');
        }
        final inputSchema = D4.coerceMap<String, dynamic>(named['inputSchema'], 'inputSchema');
        final handlerRaw = named['handler'];
        return $tom_vscode_scripting_api_2.SdkMcpTool(name: name, description: description, inputSchema: inputSchema, handler: handlerRaw == null ? null : ((Map<String, dynamic> p0) { return Future.value(D4.callInterpreterCallback(visitor!, handlerRaw, [p0])).then((v) => v as $tom_vscode_scripting_api_2.CallToolResult); }) as Future<$tom_vscode_scripting_api_2.CallToolResult> Function(Map<String, dynamic>));
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SdkMcpTool');
        if (positional.isEmpty) {
          throw ArgumentError('SdkMcpTool: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_2.SdkMcpTool.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.SdkMcpTool>(target, 'SdkMcpTool').name,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.SdkMcpTool>(target, 'SdkMcpTool').description,
      'inputSchema': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.SdkMcpTool>(target, 'SdkMcpTool').inputSchema,
      'handler': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.SdkMcpTool>(target, 'SdkMcpTool').handler,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.SdkMcpTool>(target, 'SdkMcpTool');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'SdkMcpTool({required String name, required String description, required Map<String, dynamic> inputSchema, ToolHandler? handler})',
      'fromJson': 'factory SdkMcpTool.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String get description',
      'inputSchema': 'Map<String, dynamic> get inputSchema',
      'handler': 'ToolHandler? get handler',
    },
  );
}

// =============================================================================
// McpServerToolPolicy Bridge
// =============================================================================

BridgedClass _createMcpServerToolPolicyBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_2.McpServerToolPolicy,
    name: 'McpServerToolPolicy',
    isAssignable: (v) => v is $tom_vscode_scripting_api_2.McpServerToolPolicy,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'McpServerToolPolicy');
        final permissionPolicy = D4.getRequiredNamedArg<String>(named, 'permissionPolicy', 'McpServerToolPolicy');
        return $tom_vscode_scripting_api_2.McpServerToolPolicy(name: name, permissionPolicy: permissionPolicy);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'McpServerToolPolicy');
        if (positional.isEmpty) {
          throw ArgumentError('McpServerToolPolicy: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_2.McpServerToolPolicy.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpServerToolPolicy>(target, 'McpServerToolPolicy').name,
      'permissionPolicy': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpServerToolPolicy>(target, 'McpServerToolPolicy').permissionPolicy,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.McpServerToolPolicy>(target, 'McpServerToolPolicy');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'McpServerToolPolicy({required String name, required String permissionPolicy})',
      'fromJson': 'factory McpServerToolPolicy.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String get name',
      'permissionPolicy': 'String get permissionPolicy',
    },
  );
}

// =============================================================================
// McpServerConfig Bridge
// =============================================================================

BridgedClass _createMcpServerConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_2.McpServerConfig,
    name: 'McpServerConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_2.McpServerConfig,
    constructors: {
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'McpServerConfig');
        if (positional.isEmpty) {
          throw ArgumentError('McpServerConfig: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_2.McpServerConfig.fromJson(json);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpServerConfig>(target, 'McpServerConfig').type,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.McpServerConfig>(target, 'McpServerConfig');
        return t.toJson();
      },
    },
    constructorSignatures: {
      'fromJson': 'factory McpServerConfig.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
    },
  );
}

// =============================================================================
// McpStdioServerConfig Bridge
// =============================================================================

BridgedClass _createMcpStdioServerConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_2.McpStdioServerConfig,
    name: 'McpStdioServerConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_2.McpStdioServerConfig,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final command = D4.getRequiredNamedArg<String>(named, 'command', 'McpStdioServerConfig');
        final args = D4.coerceListOrNull<String>(named['args'], 'args');
        final env = D4.coerceMapOrNull<String, String>(named['env'], 'env');
        final alwaysLoad = D4.getOptionalNamedArg<bool?>(named, 'alwaysLoad');
        return $tom_vscode_scripting_api_2.McpStdioServerConfig(command: command, args: args, env: env, alwaysLoad: alwaysLoad);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'McpStdioServerConfig');
        if (positional.isEmpty) {
          throw ArgumentError('McpStdioServerConfig: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_2.McpStdioServerConfig.fromJson(json);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpStdioServerConfig>(target, 'McpStdioServerConfig').type,
      'command': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpStdioServerConfig>(target, 'McpStdioServerConfig').command,
      'args': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpStdioServerConfig>(target, 'McpStdioServerConfig').args,
      'env': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpStdioServerConfig>(target, 'McpStdioServerConfig').env,
      'alwaysLoad': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpStdioServerConfig>(target, 'McpStdioServerConfig').alwaysLoad,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.McpStdioServerConfig>(target, 'McpStdioServerConfig');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'McpStdioServerConfig({required String command, List<String>? args, Map<String, String>? env, bool? alwaysLoad})',
      'fromJson': 'factory McpStdioServerConfig.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
      'command': 'String get command',
      'args': 'List<String>? get args',
      'env': 'Map<String, String>? get env',
      'alwaysLoad': 'bool? get alwaysLoad',
    },
  );
}

// =============================================================================
// McpSSEServerConfig Bridge
// =============================================================================

BridgedClass _createMcpSSEServerConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_2.McpSSEServerConfig,
    name: 'McpSSEServerConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_2.McpSSEServerConfig,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'McpSSEServerConfig');
        final headers = D4.coerceMapOrNull<String, String>(named['headers'], 'headers');
        final tools = D4.coerceListOrNull<$tom_vscode_scripting_api_2.McpServerToolPolicy>(named['tools'], 'tools');
        final alwaysLoad = D4.getOptionalNamedArg<bool?>(named, 'alwaysLoad');
        return $tom_vscode_scripting_api_2.McpSSEServerConfig(url: url, headers: headers, tools: tools, alwaysLoad: alwaysLoad);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'McpSSEServerConfig');
        if (positional.isEmpty) {
          throw ArgumentError('McpSSEServerConfig: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_2.McpSSEServerConfig.fromJson(json);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSSEServerConfig>(target, 'McpSSEServerConfig').type,
      'url': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSSEServerConfig>(target, 'McpSSEServerConfig').url,
      'headers': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSSEServerConfig>(target, 'McpSSEServerConfig').headers,
      'tools': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSSEServerConfig>(target, 'McpSSEServerConfig').tools,
      'alwaysLoad': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSSEServerConfig>(target, 'McpSSEServerConfig').alwaysLoad,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.McpSSEServerConfig>(target, 'McpSSEServerConfig');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'McpSSEServerConfig({required String url, Map<String, String>? headers, List<McpServerToolPolicy>? tools, bool? alwaysLoad})',
      'fromJson': 'factory McpSSEServerConfig.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
      'url': 'String get url',
      'headers': 'Map<String, String>? get headers',
      'tools': 'List<McpServerToolPolicy>? get tools',
      'alwaysLoad': 'bool? get alwaysLoad',
    },
  );
}

// =============================================================================
// McpHttpServerConfig Bridge
// =============================================================================

BridgedClass _createMcpHttpServerConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_2.McpHttpServerConfig,
    name: 'McpHttpServerConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_2.McpHttpServerConfig,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'McpHttpServerConfig');
        final headers = D4.coerceMapOrNull<String, String>(named['headers'], 'headers');
        final tools = D4.coerceListOrNull<$tom_vscode_scripting_api_2.McpServerToolPolicy>(named['tools'], 'tools');
        final alwaysLoad = D4.getOptionalNamedArg<bool?>(named, 'alwaysLoad');
        return $tom_vscode_scripting_api_2.McpHttpServerConfig(url: url, headers: headers, tools: tools, alwaysLoad: alwaysLoad);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'McpHttpServerConfig');
        if (positional.isEmpty) {
          throw ArgumentError('McpHttpServerConfig: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_2.McpHttpServerConfig.fromJson(json);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpHttpServerConfig>(target, 'McpHttpServerConfig').type,
      'url': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpHttpServerConfig>(target, 'McpHttpServerConfig').url,
      'headers': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpHttpServerConfig>(target, 'McpHttpServerConfig').headers,
      'tools': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpHttpServerConfig>(target, 'McpHttpServerConfig').tools,
      'alwaysLoad': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpHttpServerConfig>(target, 'McpHttpServerConfig').alwaysLoad,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.McpHttpServerConfig>(target, 'McpHttpServerConfig');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'McpHttpServerConfig({required String url, Map<String, String>? headers, List<McpServerToolPolicy>? tools, bool? alwaysLoad})',
      'fromJson': 'factory McpHttpServerConfig.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
      'url': 'String get url',
      'headers': 'Map<String, String>? get headers',
      'tools': 'List<McpServerToolPolicy>? get tools',
      'alwaysLoad': 'bool? get alwaysLoad',
    },
  );
}

// =============================================================================
// McpSdkServerConfig Bridge
// =============================================================================

BridgedClass _createMcpSdkServerConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_2.McpSdkServerConfig,
    name: 'McpSdkServerConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_2.McpSdkServerConfig,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'McpSdkServerConfig');
        final version = D4.getNamedArgWithDefault<String>(named, 'version', '1.0.0');
        final tools = named.containsKey('tools') && named['tools'] != null
            ? D4.coerceList<$tom_vscode_scripting_api_2.SdkMcpTool>(named['tools'], 'tools')
            : const <$tom_vscode_scripting_api_2.SdkMcpTool>[];
        return $tom_vscode_scripting_api_2.McpSdkServerConfig(name: name, version: version, tools: tools);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'McpSdkServerConfig');
        if (positional.isEmpty) {
          throw ArgumentError('McpSdkServerConfig: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_2.McpSdkServerConfig.fromJson(json);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSdkServerConfig>(target, 'McpSdkServerConfig').type,
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSdkServerConfig>(target, 'McpSdkServerConfig').name,
      'version': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSdkServerConfig>(target, 'McpSdkServerConfig').version,
      'tools': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_2.McpSdkServerConfig>(target, 'McpSdkServerConfig').tools,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_2.McpSdkServerConfig>(target, 'McpSdkServerConfig');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'McpSdkServerConfig({required String name, String version = \'1.0.0\', List<SdkMcpTool> tools = const []})',
      'fromJson': 'factory McpSdkServerConfig.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String get type',
      'name': 'String get name',
      'version': 'String get version',
      'tools': 'List<SdkMcpTool> get tools',
    },
  );
}

// =============================================================================
// SystemPrompt Bridge
// =============================================================================

BridgedClass _createSystemPromptBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SystemPrompt,
    name: 'SystemPrompt',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SystemPrompt,
    constructors: {
      'fromWire': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SystemPrompt');
        final value = D4.getRequiredArg<Object>(positional, 0, 'value', 'SystemPrompt');
        return $tom_vscode_scripting_api_4.SystemPrompt.fromWire(value);
      },
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SystemPrompt>(target, 'SystemPrompt');
        return t.toWire();
      },
    },
    constructorSignatures: {
      'fromWire': 'factory SystemPrompt.fromWire(Object value)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
  );
}

// =============================================================================
// SystemPromptText Bridge
// =============================================================================

BridgedClass _createSystemPromptTextBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SystemPromptText,
    name: 'SystemPromptText',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SystemPromptText,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SystemPromptText');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'SystemPromptText');
        return $tom_vscode_scripting_api_4.SystemPromptText(text);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.SystemPromptText>(target, 'SystemPromptText').text,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SystemPromptText>(target, 'SystemPromptText');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const SystemPromptText(String text)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
    getterSignatures: {
      'text': 'String get text',
    },
  );
}

// =============================================================================
// SystemPromptList Bridge
// =============================================================================

BridgedClass _createSystemPromptListBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SystemPromptList,
    name: 'SystemPromptList',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SystemPromptList,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SystemPromptList');
        if (positional.isEmpty) {
          throw ArgumentError('SystemPromptList: Missing required argument "sections" at position 0');
        }
        final sections = D4.coerceList<String>(positional[0], 'sections');
        return $tom_vscode_scripting_api_4.SystemPromptList(sections);
      },
    },
    getters: {
      'sections': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.SystemPromptList>(target, 'SystemPromptList').sections,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SystemPromptList>(target, 'SystemPromptList');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const SystemPromptList(List<String> sections)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
    getterSignatures: {
      'sections': 'List<String> get sections',
    },
  );
}

// =============================================================================
// SystemPromptPreset Bridge
// =============================================================================

BridgedClass _createSystemPromptPresetBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SystemPromptPreset,
    name: 'SystemPromptPreset',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SystemPromptPreset,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final append = D4.getOptionalNamedArg<String?>(named, 'append');
        final excludeDynamicSections = D4.getOptionalNamedArg<bool?>(named, 'excludeDynamicSections');
        return $tom_vscode_scripting_api_4.SystemPromptPreset(append: append, excludeDynamicSections: excludeDynamicSections);
      },
    },
    getters: {
      'append': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.SystemPromptPreset>(target, 'SystemPromptPreset').append,
      'excludeDynamicSections': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.SystemPromptPreset>(target, 'SystemPromptPreset').excludeDynamicSections,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SystemPromptPreset>(target, 'SystemPromptPreset');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const SystemPromptPreset({String? append, bool? excludeDynamicSections})',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
    getterSignatures: {
      'append': 'String? get append',
      'excludeDynamicSections': 'bool? get excludeDynamicSections',
    },
  );
}

// =============================================================================
// ToolsConfig Bridge
// =============================================================================

BridgedClass _createToolsConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ToolsConfig,
    name: 'ToolsConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ToolsConfig,
    constructors: {
      'fromWire': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ToolsConfig');
        final value = D4.getRequiredArg<Object>(positional, 0, 'value', 'ToolsConfig');
        return $tom_vscode_scripting_api_4.ToolsConfig.fromWire(value);
      },
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ToolsConfig>(target, 'ToolsConfig');
        return t.toWire();
      },
    },
    constructorSignatures: {
      'fromWire': 'factory ToolsConfig.fromWire(Object value)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
  );
}

// =============================================================================
// ToolsList Bridge
// =============================================================================

BridgedClass _createToolsListBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ToolsList,
    name: 'ToolsList',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ToolsList,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ToolsList');
        if (positional.isEmpty) {
          throw ArgumentError('ToolsList: Missing required argument "names" at position 0');
        }
        final names = D4.coerceList<String>(positional[0], 'names');
        return $tom_vscode_scripting_api_4.ToolsList(names);
      },
    },
    getters: {
      'names': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ToolsList>(target, 'ToolsList').names,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ToolsList>(target, 'ToolsList');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const ToolsList(List<String> names)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
    getterSignatures: {
      'names': 'List<String> get names',
    },
  );
}

// =============================================================================
// ToolsClaudeCodePreset Bridge
// =============================================================================

BridgedClass _createToolsClaudeCodePresetBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ToolsClaudeCodePreset,
    name: 'ToolsClaudeCodePreset',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ToolsClaudeCodePreset,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        return $tom_vscode_scripting_api_4.ToolsClaudeCodePreset();
      },
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ToolsClaudeCodePreset>(target, 'ToolsClaudeCodePreset');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const ToolsClaudeCodePreset()',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
  );
}

// =============================================================================
// ThinkingConfig Bridge
// =============================================================================

BridgedClass _createThinkingConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ThinkingConfig,
    name: 'ThinkingConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ThinkingConfig,
    constructors: {
      'fromWire': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ThinkingConfig');
        if (positional.isEmpty) {
          throw ArgumentError('ThinkingConfig: Missing required argument "value" at position 0');
        }
        final value = D4.coerceMap<String, dynamic>(positional[0], 'value');
        return $tom_vscode_scripting_api_4.ThinkingConfig.fromWire(value);
      },
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ThinkingConfig>(target, 'ThinkingConfig');
        return t.toWire();
      },
    },
    constructorSignatures: {
      'fromWire': 'factory ThinkingConfig.fromWire(Map<String, dynamic> value)',
    },
    methodSignatures: {
      'toWire': 'Map<String, dynamic> toWire()',
    },
  );
}

// =============================================================================
// ThinkingAdaptive Bridge
// =============================================================================

BridgedClass _createThinkingAdaptiveBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ThinkingAdaptive,
    name: 'ThinkingAdaptive',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ThinkingAdaptive,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final display = D4.getOptionalNamedArg<String?>(named, 'display');
        return $tom_vscode_scripting_api_4.ThinkingAdaptive(display: display);
      },
    },
    getters: {
      'display': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ThinkingAdaptive>(target, 'ThinkingAdaptive').display,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ThinkingAdaptive>(target, 'ThinkingAdaptive');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const ThinkingAdaptive({String? display})',
    },
    methodSignatures: {
      'toWire': 'Map<String, dynamic> toWire()',
    },
    getterSignatures: {
      'display': 'String? get display',
    },
  );
}

// =============================================================================
// ThinkingEnabled Bridge
// =============================================================================

BridgedClass _createThinkingEnabledBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ThinkingEnabled,
    name: 'ThinkingEnabled',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ThinkingEnabled,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        final budgetTokens = D4.getOptionalNamedArg<int?>(named, 'budgetTokens');
        final display = D4.getOptionalNamedArg<String?>(named, 'display');
        return $tom_vscode_scripting_api_4.ThinkingEnabled(budgetTokens: budgetTokens, display: display);
      },
    },
    getters: {
      'budgetTokens': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ThinkingEnabled>(target, 'ThinkingEnabled').budgetTokens,
      'display': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.ThinkingEnabled>(target, 'ThinkingEnabled').display,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ThinkingEnabled>(target, 'ThinkingEnabled');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const ThinkingEnabled({int? budgetTokens, String? display})',
    },
    methodSignatures: {
      'toWire': 'Map<String, dynamic> toWire()',
    },
    getterSignatures: {
      'budgetTokens': 'int? get budgetTokens',
      'display': 'String? get display',
    },
  );
}

// =============================================================================
// ThinkingDisabled Bridge
// =============================================================================

BridgedClass _createThinkingDisabledBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.ThinkingDisabled,
    name: 'ThinkingDisabled',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.ThinkingDisabled,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        return $tom_vscode_scripting_api_4.ThinkingDisabled();
      },
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.ThinkingDisabled>(target, 'ThinkingDisabled');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const ThinkingDisabled()',
    },
    methodSignatures: {
      'toWire': 'Map<String, dynamic> toWire()',
    },
  );
}

// =============================================================================
// Skills Bridge
// =============================================================================

BridgedClass _createSkillsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.Skills,
    name: 'Skills',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.Skills,
    constructors: {
      'fromWire': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Skills');
        final value = D4.getRequiredArg<Object>(positional, 0, 'value', 'Skills');
        return $tom_vscode_scripting_api_4.Skills.fromWire(value);
      },
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.Skills>(target, 'Skills');
        return t.toWire();
      },
    },
    constructorSignatures: {
      'fromWire': 'factory Skills.fromWire(Object value)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
  );
}

// =============================================================================
// SkillsList Bridge
// =============================================================================

BridgedClass _createSkillsListBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SkillsList,
    name: 'SkillsList',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SkillsList,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SkillsList');
        if (positional.isEmpty) {
          throw ArgumentError('SkillsList: Missing required argument "names" at position 0');
        }
        final names = D4.coerceList<String>(positional[0], 'names');
        return $tom_vscode_scripting_api_4.SkillsList(names);
      },
    },
    getters: {
      'names': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.SkillsList>(target, 'SkillsList').names,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SkillsList>(target, 'SkillsList');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const SkillsList(List<String> names)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
    getterSignatures: {
      'names': 'List<String> get names',
    },
  );
}

// =============================================================================
// SkillsAll Bridge
// =============================================================================

BridgedClass _createSkillsAllBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SkillsAll,
    name: 'SkillsAll',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SkillsAll,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        return $tom_vscode_scripting_api_4.SkillsAll();
      },
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SkillsAll>(target, 'SkillsAll');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const SkillsAll()',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
  );
}

// =============================================================================
// SettingsRef Bridge
// =============================================================================

BridgedClass _createSettingsRefBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SettingsRef,
    name: 'SettingsRef',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SettingsRef,
    constructors: {
      'fromWire': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SettingsRef');
        final value = D4.getRequiredArg<Object>(positional, 0, 'value', 'SettingsRef');
        return $tom_vscode_scripting_api_4.SettingsRef.fromWire(value);
      },
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SettingsRef>(target, 'SettingsRef');
        return t.toWire();
      },
    },
    constructorSignatures: {
      'fromWire': 'factory SettingsRef.fromWire(Object value)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
  );
}

// =============================================================================
// SettingsPath Bridge
// =============================================================================

BridgedClass _createSettingsPathBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SettingsPath,
    name: 'SettingsPath',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SettingsPath,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SettingsPath');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'SettingsPath');
        return $tom_vscode_scripting_api_4.SettingsPath(path);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.SettingsPath>(target, 'SettingsPath').path,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SettingsPath>(target, 'SettingsPath');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const SettingsPath(String path)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
    getterSignatures: {
      'path': 'String get path',
    },
  );
}

// =============================================================================
// SettingsInline Bridge
// =============================================================================

BridgedClass _createSettingsInlineBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.SettingsInline,
    name: 'SettingsInline',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.SettingsInline,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SettingsInline');
        if (positional.isEmpty) {
          throw ArgumentError('SettingsInline: Missing required argument "settings" at position 0');
        }
        final settings = D4.coerceMap<String, dynamic>(positional[0], 'settings');
        return $tom_vscode_scripting_api_4.SettingsInline(settings);
      },
    },
    getters: {
      'settings': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.SettingsInline>(target, 'SettingsInline').settings,
    },
    methods: {
      'toWire': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.SettingsInline>(target, 'SettingsInline');
        return t.toWire();
      },
    },
    constructorSignatures: {
      '': 'const SettingsInline(Map<String, dynamic> settings)',
    },
    methodSignatures: {
      'toWire': 'Object toWire()',
    },
    getterSignatures: {
      'settings': 'Map<String, dynamic> get settings',
    },
  );
}

// =============================================================================
// OutputFormat Bridge
// =============================================================================

BridgedClass _createOutputFormatBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.OutputFormat,
    name: 'OutputFormat',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.OutputFormat,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('schema') || named['schema'] == null) {
          throw ArgumentError('OutputFormat: Missing required named argument "schema"');
        }
        final schema = D4.coerceMap<String, dynamic>(named['schema'], 'schema');
        return $tom_vscode_scripting_api_4.OutputFormat(schema: schema);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'OutputFormat');
        if (positional.isEmpty) {
          throw ArgumentError('OutputFormat: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_4.OutputFormat.fromJson(json);
      },
    },
    getters: {
      'schema': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.OutputFormat>(target, 'OutputFormat').schema,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.OutputFormat>(target, 'OutputFormat');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'OutputFormat({required Map<String, dynamic> schema})',
      'fromJson': 'factory OutputFormat.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'schema': 'Map<String, dynamic> get schema',
    },
  );
}

// =============================================================================
// TaskBudget Bridge
// =============================================================================

BridgedClass _createTaskBudgetBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.TaskBudget,
    name: 'TaskBudget',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.TaskBudget,
    constructors: {
      '': (visitor, positional, named) {
        final total = D4.getRequiredNamedArg<num>(named, 'total', 'TaskBudget');
        return $tom_vscode_scripting_api_4.TaskBudget(total: total);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TaskBudget');
        if (positional.isEmpty) {
          throw ArgumentError('TaskBudget: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_4.TaskBudget.fromJson(json);
      },
    },
    getters: {
      'total': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.TaskBudget>(target, 'TaskBudget').total,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.TaskBudget>(target, 'TaskBudget');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TaskBudget({required num total})',
      'fromJson': 'factory TaskBudget.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'total': 'num get total',
    },
  );
}

// =============================================================================
// PluginConfig Bridge
// =============================================================================

BridgedClass _createPluginConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.PluginConfig,
    name: 'PluginConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.PluginConfig,
    constructors: {
      '': (visitor, positional, named) {
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'PluginConfig');
        return $tom_vscode_scripting_api_4.PluginConfig(path: path);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PluginConfig');
        if (positional.isEmpty) {
          throw ArgumentError('PluginConfig: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_4.PluginConfig.fromJson(json);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.PluginConfig>(target, 'PluginConfig').path,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.PluginConfig>(target, 'PluginConfig');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'PluginConfig({required String path})',
      'fromJson': 'factory PluginConfig.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'path': 'String get path',
    },
  );
}

// =============================================================================
// AgentDefinition Bridge
// =============================================================================

BridgedClass _createAgentDefinitionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.AgentDefinition,
    name: 'AgentDefinition',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.AgentDefinition,
    constructors: {
      '': (visitor, positional, named) {
        final description = D4.getRequiredNamedArg<String>(named, 'description', 'AgentDefinition');
        final prompt = D4.getRequiredNamedArg<String>(named, 'prompt', 'AgentDefinition');
        final tools = D4.coerceListOrNull<String>(named['tools'], 'tools');
        final model = D4.getOptionalNamedArg<String?>(named, 'model');
        final permissionMode = D4.getOptionalNamedArg<$tom_vscode_scripting_api_6.PermissionMode?>(named, 'permissionMode');
        return $tom_vscode_scripting_api_4.AgentDefinition(description: description, prompt: prompt, tools: tools, model: model, permissionMode: permissionMode);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AgentDefinition');
        if (positional.isEmpty) {
          throw ArgumentError('AgentDefinition: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_4.AgentDefinition.fromJson(json);
      },
    },
    getters: {
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.AgentDefinition>(target, 'AgentDefinition').description,
      'prompt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.AgentDefinition>(target, 'AgentDefinition').prompt,
      'tools': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.AgentDefinition>(target, 'AgentDefinition').tools,
      'model': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.AgentDefinition>(target, 'AgentDefinition').model,
      'permissionMode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.AgentDefinition>(target, 'AgentDefinition').permissionMode,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.AgentDefinition>(target, 'AgentDefinition');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'AgentDefinition({required String description, required String prompt, List<String>? tools, String? model, PermissionMode? permissionMode})',
      'fromJson': 'factory AgentDefinition.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'description': 'String get description',
      'prompt': 'String get prompt',
      'tools': 'List<String>? get tools',
      'model': 'String? get model',
      'permissionMode': 'PermissionMode? get permissionMode',
    },
  );
}

// =============================================================================
// Options Bridge
// =============================================================================

BridgedClass _createOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_4.Options,
    name: 'Options',
    isAssignable: (v) => v is $tom_vscode_scripting_api_4.Options,
    constructors: {
      '': (visitor, positional, named) {
        final model = D4.getOptionalNamedArg<String?>(named, 'model');
        final fallbackModel = D4.getOptionalNamedArg<String?>(named, 'fallbackModel');
        final systemPrompt = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.SystemPrompt?>(named, 'systemPrompt');
        final tools = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.ToolsConfig?>(named, 'tools');
        final allowedTools = D4.coerceListOrNull<String>(named['allowedTools'], 'allowedTools');
        final disallowedTools = D4.coerceListOrNull<String>(named['disallowedTools'], 'disallowedTools');
        final mcpServers = D4.coerceMapOrNull<String, $tom_vscode_scripting_api_2.McpServerConfig>(named['mcpServers'], 'mcpServers');
        final maxTurns = D4.getOptionalNamedArg<int?>(named, 'maxTurns');
        final maxBudgetUsd = D4.getOptionalNamedArg<double?>(named, 'maxBudgetUsd');
        final taskBudget = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.TaskBudget?>(named, 'taskBudget');
        final permissionMode = D4.getOptionalNamedArg<$tom_vscode_scripting_api_6.PermissionMode?>(named, 'permissionMode');
        final planModeInstructions = D4.getOptionalNamedArg<String?>(named, 'planModeInstructions');
        final allowDangerouslySkipPermissions = D4.getOptionalNamedArg<bool?>(named, 'allowDangerouslySkipPermissions');
        final permissionPromptToolName = D4.getOptionalNamedArg<String?>(named, 'permissionPromptToolName');
        final settingSources = D4.coerceListOrNull<$tom_vscode_scripting_api_4.SettingSource>(named['settingSources'], 'settingSources');
        final settings = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.SettingsRef?>(named, 'settings');
        final managedSettings = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.SettingsRef?>(named, 'managedSettings');
        final cwd = D4.getOptionalNamedArg<String?>(named, 'cwd');
        final additionalDirectories = D4.coerceListOrNull<String>(named['additionalDirectories'], 'additionalDirectories');
        final continueSession = D4.getOptionalNamedArg<bool?>(named, 'continueSession');
        final resume = D4.getOptionalNamedArg<String?>(named, 'resume');
        final sessionId = D4.getOptionalNamedArg<String?>(named, 'sessionId');
        final resumeSessionAt = D4.getOptionalNamedArg<String?>(named, 'resumeSessionAt');
        final forkSession = D4.getOptionalNamedArg<bool?>(named, 'forkSession');
        final persistSession = D4.getOptionalNamedArg<bool?>(named, 'persistSession');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final env = D4.coerceMapOrNull<String, String>(named['env'], 'env');
        final extraArgs = D4.coerceMapOrNull<String, String?>(named['extraArgs'], 'extraArgs');
        final strictMcpConfig = D4.getOptionalNamedArg<bool?>(named, 'strictMcpConfig');
        final agent = D4.getOptionalNamedArg<String?>(named, 'agent');
        final agents = D4.coerceMapOrNull<String, $tom_vscode_scripting_api_4.AgentDefinition>(named['agents'], 'agents');
        final skills = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.Skills?>(named, 'skills');
        final plugins = D4.coerceListOrNull<$tom_vscode_scripting_api_4.PluginConfig>(named['plugins'], 'plugins');
        final betas = D4.coerceListOrNull<String>(named['betas'], 'betas');
        final outputFormat = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.OutputFormat?>(named, 'outputFormat');
        final toolConfig = D4.coerceMapOrNull<String, dynamic>(named['toolConfig'], 'toolConfig');
        final thinking = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.ThinkingConfig?>(named, 'thinking');
        final effort = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.EffortLevel?>(named, 'effort');
        final maxThinkingTokens = D4.getOptionalNamedArg<int?>(named, 'maxThinkingTokens');
        final includePartialMessages = D4.getOptionalNamedArg<bool?>(named, 'includePartialMessages');
        final includeHookEvents = D4.getOptionalNamedArg<bool?>(named, 'includeHookEvents');
        final forwardSubagentText = D4.getOptionalNamedArg<bool?>(named, 'forwardSubagentText');
        final promptSuggestions = D4.getOptionalNamedArg<bool?>(named, 'promptSuggestions');
        final agentProgressSummaries = D4.getOptionalNamedArg<bool?>(named, 'agentProgressSummaries');
        final enableFileCheckpointing = D4.getOptionalNamedArg<bool?>(named, 'enableFileCheckpointing');
        final sandbox = D4.coerceMapOrNull<String, dynamic>(named['sandbox'], 'sandbox');
        final debug = D4.getOptionalNamedArg<bool?>(named, 'debug');
        final debugFile = D4.getOptionalNamedArg<String?>(named, 'debugFile');
        final loadTimeoutMs = D4.getOptionalNamedArg<int?>(named, 'loadTimeoutMs');
        final canUseToolRaw = named['canUseTool'];
        final onStderrRaw = named['onStderr'];
        return $tom_vscode_scripting_api_4.Options(model: model, fallbackModel: fallbackModel, systemPrompt: systemPrompt, tools: tools, allowedTools: allowedTools, disallowedTools: disallowedTools, mcpServers: mcpServers, maxTurns: maxTurns, maxBudgetUsd: maxBudgetUsd, taskBudget: taskBudget, permissionMode: permissionMode, planModeInstructions: planModeInstructions, allowDangerouslySkipPermissions: allowDangerouslySkipPermissions, permissionPromptToolName: permissionPromptToolName, settingSources: settingSources, settings: settings, managedSettings: managedSettings, cwd: cwd, additionalDirectories: additionalDirectories, continueSession: continueSession, resume: resume, sessionId: sessionId, resumeSessionAt: resumeSessionAt, forkSession: forkSession, persistSession: persistSession, title: title, env: env, extraArgs: extraArgs, strictMcpConfig: strictMcpConfig, agent: agent, agents: agents, skills: skills, plugins: plugins, betas: betas, outputFormat: outputFormat, toolConfig: toolConfig, thinking: thinking, effort: effort, maxThinkingTokens: maxThinkingTokens, includePartialMessages: includePartialMessages, includeHookEvents: includeHookEvents, forwardSubagentText: forwardSubagentText, promptSuggestions: promptSuggestions, agentProgressSummaries: agentProgressSummaries, enableFileCheckpointing: enableFileCheckpointing, sandbox: sandbox, debug: debug, debugFile: debugFile, loadTimeoutMs: loadTimeoutMs, canUseTool: canUseToolRaw == null ? null : ((String p0, Map<String, dynamic> p1, $tom_vscode_scripting_api_6.CanUseToolContext p2) { return Future.value(D4.callInterpreterCallback(visitor!, canUseToolRaw, [p0, p1, p2])).then((v) => v as $tom_vscode_scripting_api_6.PermissionResult); }) as Future<$tom_vscode_scripting_api_6.PermissionResult> Function(String, Map<String, dynamic>, $tom_vscode_scripting_api_6.CanUseToolContext), onStderr: onStderrRaw == null ? null : (String p0) { D4.callInterpreterCallback(visitor!, onStderrRaw, [p0]); });
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Options');
        if (positional.isEmpty) {
          throw ArgumentError('Options: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_4.Options.fromJson(json);
      },
    },
    getters: {
      'model': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').model,
      'fallbackModel': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').fallbackModel,
      'systemPrompt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').systemPrompt,
      'tools': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').tools,
      'allowedTools': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').allowedTools,
      'disallowedTools': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').disallowedTools,
      'mcpServers': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').mcpServers,
      'maxTurns': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').maxTurns,
      'maxBudgetUsd': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').maxBudgetUsd,
      'taskBudget': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').taskBudget,
      'permissionMode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').permissionMode,
      'planModeInstructions': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').planModeInstructions,
      'allowDangerouslySkipPermissions': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').allowDangerouslySkipPermissions,
      'permissionPromptToolName': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').permissionPromptToolName,
      'settingSources': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').settingSources,
      'settings': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').settings,
      'managedSettings': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').managedSettings,
      'cwd': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').cwd,
      'additionalDirectories': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').additionalDirectories,
      'continueSession': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').continueSession,
      'resume': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').resume,
      'sessionId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').sessionId,
      'resumeSessionAt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').resumeSessionAt,
      'forkSession': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').forkSession,
      'persistSession': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').persistSession,
      'title': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').title,
      'env': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').env,
      'extraArgs': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').extraArgs,
      'strictMcpConfig': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').strictMcpConfig,
      'agent': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').agent,
      'agents': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').agents,
      'skills': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').skills,
      'plugins': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').plugins,
      'betas': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').betas,
      'outputFormat': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').outputFormat,
      'toolConfig': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').toolConfig,
      'thinking': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').thinking,
      'effort': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').effort,
      'maxThinkingTokens': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').maxThinkingTokens,
      'includePartialMessages': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').includePartialMessages,
      'includeHookEvents': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').includeHookEvents,
      'forwardSubagentText': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').forwardSubagentText,
      'promptSuggestions': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').promptSuggestions,
      'agentProgressSummaries': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').agentProgressSummaries,
      'enableFileCheckpointing': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').enableFileCheckpointing,
      'sandbox': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').sandbox,
      'debug': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').debug,
      'debugFile': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').debugFile,
      'loadTimeoutMs': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').loadTimeoutMs,
      'canUseTool': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').canUseTool,
      'onStderr': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options').onStderr,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_4.Options>(target, 'Options');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'Options({String? model, String? fallbackModel, SystemPrompt? systemPrompt, ToolsConfig? tools, List<String>? allowedTools, List<String>? disallowedTools, Map<String, McpServerConfig>? mcpServers, int? maxTurns, double? maxBudgetUsd, TaskBudget? taskBudget, PermissionMode? permissionMode, String? planModeInstructions, bool? allowDangerouslySkipPermissions, String? permissionPromptToolName, List<SettingSource>? settingSources, SettingsRef? settings, SettingsRef? managedSettings, String? cwd, List<String>? additionalDirectories, bool? continueSession, String? resume, String? sessionId, String? resumeSessionAt, bool? forkSession, bool? persistSession, String? title, Map<String, String>? env, Map<String, String?>? extraArgs, bool? strictMcpConfig, String? agent, Map<String, AgentDefinition>? agents, Skills? skills, List<PluginConfig>? plugins, List<String>? betas, OutputFormat? outputFormat, Map<String, dynamic>? toolConfig, ThinkingConfig? thinking, EffortLevel? effort, int? maxThinkingTokens, bool? includePartialMessages, bool? includeHookEvents, bool? forwardSubagentText, bool? promptSuggestions, bool? agentProgressSummaries, bool? enableFileCheckpointing, Map<String, dynamic>? sandbox, bool? debug, String? debugFile, int? loadTimeoutMs, CanUseTool? canUseTool, void Function(String line)? onStderr})',
      'fromJson': 'factory Options.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'model': 'String? get model',
      'fallbackModel': 'String? get fallbackModel',
      'systemPrompt': 'SystemPrompt? get systemPrompt',
      'tools': 'ToolsConfig? get tools',
      'allowedTools': 'List<String>? get allowedTools',
      'disallowedTools': 'List<String>? get disallowedTools',
      'mcpServers': 'Map<String, McpServerConfig>? get mcpServers',
      'maxTurns': 'int? get maxTurns',
      'maxBudgetUsd': 'double? get maxBudgetUsd',
      'taskBudget': 'TaskBudget? get taskBudget',
      'permissionMode': 'PermissionMode? get permissionMode',
      'planModeInstructions': 'String? get planModeInstructions',
      'allowDangerouslySkipPermissions': 'bool? get allowDangerouslySkipPermissions',
      'permissionPromptToolName': 'String? get permissionPromptToolName',
      'settingSources': 'List<SettingSource>? get settingSources',
      'settings': 'SettingsRef? get settings',
      'managedSettings': 'SettingsRef? get managedSettings',
      'cwd': 'String? get cwd',
      'additionalDirectories': 'List<String>? get additionalDirectories',
      'continueSession': 'bool? get continueSession',
      'resume': 'String? get resume',
      'sessionId': 'String? get sessionId',
      'resumeSessionAt': 'String? get resumeSessionAt',
      'forkSession': 'bool? get forkSession',
      'persistSession': 'bool? get persistSession',
      'title': 'String? get title',
      'env': 'Map<String, String>? get env',
      'extraArgs': 'Map<String, String?>? get extraArgs',
      'strictMcpConfig': 'bool? get strictMcpConfig',
      'agent': 'String? get agent',
      'agents': 'Map<String, AgentDefinition>? get agents',
      'skills': 'Skills? get skills',
      'plugins': 'List<PluginConfig>? get plugins',
      'betas': 'List<String>? get betas',
      'outputFormat': 'OutputFormat? get outputFormat',
      'toolConfig': 'Map<String, dynamic>? get toolConfig',
      'thinking': 'ThinkingConfig? get thinking',
      'effort': 'EffortLevel? get effort',
      'maxThinkingTokens': 'int? get maxThinkingTokens',
      'includePartialMessages': 'bool? get includePartialMessages',
      'includeHookEvents': 'bool? get includeHookEvents',
      'forwardSubagentText': 'bool? get forwardSubagentText',
      'promptSuggestions': 'bool? get promptSuggestions',
      'agentProgressSummaries': 'bool? get agentProgressSummaries',
      'enableFileCheckpointing': 'bool? get enableFileCheckpointing',
      'sandbox': 'Map<String, dynamic>? get sandbox',
      'debug': 'bool? get debug',
      'debugFile': 'String? get debugFile',
      'loadTimeoutMs': 'int? get loadTimeoutMs',
      'canUseTool': 'CanUseTool? get canUseTool',
      'onStderr': 'void Function(String line)? get onStderr',
    },
  );
}

// =============================================================================
// AgentSdkTransport Bridge
// =============================================================================

BridgedClass _createAgentSdkTransportBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_7.AgentSdkTransport,
    name: 'AgentSdkTransport',
    isAssignable: (v) => v is $tom_vscode_scripting_api_7.AgentSdkTransport,
    isAbstract: true,
    constructors: {
    },
    getters: {
      'chunks': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkTransport>(target, 'AgentSdkTransport').chunks,
    },
    methods: {
      'startQuery': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkTransport>(target, 'AgentSdkTransport');
        D4.requireMinArgs(positional, 1, 'startQuery');
        if (positional.isEmpty) {
          throw ArgumentError('startQuery: Missing required argument "params" at position 0');
        }
        final params = D4.coerceMap<String, dynamic>(positional[0], 'params');
        return t.startQuery(params);
      },
      'cancelQuery': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkTransport>(target, 'AgentSdkTransport');
        D4.requireMinArgs(positional, 1, 'cancelQuery');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'cancelQuery');
        return t.cancelQuery(streamId);
      },
      'registerTools': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkTransport>(target, 'AgentSdkTransport');
        D4.requireMinArgs(positional, 2, 'registerTools');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'registerTools');
        final registry = D4.getRequiredArg<$tom_vscode_scripting_api_8.AgentSdkToolRegistry>(positional, 1, 'registry', 'registerTools');
        t.registerTools(streamId, registry);
        return null;
      },
      'unregisterTools': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkTransport>(target, 'AgentSdkTransport');
        D4.requireMinArgs(positional, 1, 'unregisterTools');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'unregisterTools');
        t.unregisterTools(streamId);
        return null;
      },
      'registerCanUseTool': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkTransport>(target, 'AgentSdkTransport');
        D4.requireMinArgs(positional, 2, 'registerCanUseTool');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'registerCanUseTool');
        if (positional.length <= 1) {
          throw ArgumentError('registerCanUseTool: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.registerCanUseTool(streamId, ((String p0, Map<String, dynamic> p1, $tom_vscode_scripting_api_6.CanUseToolContext p2) { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [p0, p1, p2])).then((v) => v as $tom_vscode_scripting_api_6.PermissionResult); }) as Future<$tom_vscode_scripting_api_6.PermissionResult> Function(String, Map<String, dynamic>, $tom_vscode_scripting_api_6.CanUseToolContext));
        return null;
      },
      'unregisterCanUseTool': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkTransport>(target, 'AgentSdkTransport');
        D4.requireMinArgs(positional, 1, 'unregisterCanUseTool');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'unregisterCanUseTool');
        t.unregisterCanUseTool(streamId);
        return null;
      },
    },
    methodSignatures: {
      'startQuery': 'Future<void> startQuery(Map<String, dynamic> params)',
      'cancelQuery': 'Future<void> cancelQuery(String streamId)',
      'registerTools': 'void registerTools(String streamId, AgentSdkToolRegistry registry)',
      'unregisterTools': 'void unregisterTools(String streamId)',
      'registerCanUseTool': 'void registerCanUseTool(String streamId, CanUseTool callback)',
      'unregisterCanUseTool': 'void unregisterCanUseTool(String streamId)',
    },
    getterSignatures: {
      'chunks': 'Stream<Map<String, dynamic>> get chunks',
    },
  );
}

// =============================================================================
// AgentSdkQueryException Bridge
// =============================================================================

BridgedClass _createAgentSdkQueryExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_7.AgentSdkQueryException,
    name: 'AgentSdkQueryException',
    isAssignable: (v) => v is $tom_vscode_scripting_api_7.AgentSdkQueryException,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AgentSdkQueryException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'AgentSdkQueryException');
        return $tom_vscode_scripting_api_7.AgentSdkQueryException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkQueryException>(target, 'AgentSdkQueryException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkQueryException>(target, 'AgentSdkQueryException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'AgentSdkQueryException(String message)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'message': 'String get message',
    },
  );
}

// =============================================================================
// AgentQuery Bridge
// =============================================================================

BridgedClass _createAgentQueryBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_7.AgentQuery,
    name: 'AgentQuery',
    isAssignable: (v) => v is $tom_vscode_scripting_api_7.AgentQuery,
    hierarchyDepth: 2,
    constructors: {
    },
    getters: {
      'isBroadcast': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery').isBroadcast,
      'length': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery').length,
      'isEmpty': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery').isEmpty,
      'first': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery').first,
      'last': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery').last,
      'single': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery').single,
    },
    methods: {
      'interrupt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        return t.interrupt();
      },
      'asBroadcastStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        final onListenRaw = named['onListen'];
        final onCancelRaw = named['onCancel'];
        return t.asBroadcastStream(onListen: onListenRaw == null ? null : (StreamSubscription<$tom_vscode_scripting_api_3.SdkMessage> p0) { D4.callInterpreterCallback(visitor!, onListenRaw, [p0]); }, onCancel: onCancelRaw == null ? null : (StreamSubscription<$tom_vscode_scripting_api_3.SdkMessage> p0) { D4.callInterpreterCallback(visitor!, onCancelRaw, [p0]); });
      },
      'listen': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'listen');
        if (positional.isEmpty) {
          throw ArgumentError('listen: Missing required argument "onData" at position 0');
        }
        final onDataRaw = positional[0];
        final onError = D4.getOptionalNamedArg<Function?>(named, 'onError');
        final onDoneRaw = named['onDone'];
        final cancelOnError = D4.getOptionalNamedArg<bool?>(named, 'cancelOnError');
        return t.listen(onDataRaw == null ? null : ($tom_vscode_scripting_api_3.SdkMessage p0) { D4.callInterpreterCallback(visitor!, onDataRaw, [p0]); }, onError: onError, onDone: onDoneRaw == null ? null : () { D4.callInterpreterCallback(visitor!, onDoneRaw, []); }, cancelOnError: cancelOnError);
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage));
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "convert" at position 0');
        }
        final convertRaw = positional[0];
        return t.map<Object?>(($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, convertRaw, [p0])); });
      },
      'asyncMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'asyncMap');
        if (positional.isEmpty) {
          throw ArgumentError('asyncMap: Missing required argument "convert" at position 0');
        }
        final convertRaw = positional[0];
        return t.asyncMap<Object?>((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.castCallbackResult<FutureOr<Object?>>(D4.callInterpreterCallback(visitor!, convertRaw, [p0])); }) as FutureOr<Object?> Function($tom_vscode_scripting_api_3.SdkMessage));
      },
      'asyncExpand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'asyncExpand');
        if (positional.isEmpty) {
          throw ArgumentError('asyncExpand: Missing required argument "convert" at position 0');
        }
        final convertRaw = positional[0];
        return t.asyncExpand<Object?>((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.extractBridgedArg<Stream<dynamic>?>(D4.callInterpreterCallback(visitor!, convertRaw, [p0]), 'callback', visitor) as Stream<dynamic>?; }) as Stream<dynamic>? Function($tom_vscode_scripting_api_3.SdkMessage));
      },
      'handleError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'handleError');
        final onError = D4.getRequiredArg<Function>(positional, 0, 'onError', 'handleError');
        final testRaw = named['test'];
        return t.handleError(onError, test: testRaw == null ? null : ((dynamic p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function(dynamic));
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "convert" at position 0');
        }
        final convertRaw = positional[0];
        return t.expand<Object?>((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.extractBridgedArg<Iterable<dynamic>>(D4.callInterpreterCallback(visitor!, convertRaw, [p0]), 'callback', visitor) as Iterable<dynamic>; }) as Iterable<dynamic> Function($tom_vscode_scripting_api_3.SdkMessage));
      },
      'pipe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'pipe');
        final streamConsumer = D4.getRequiredArg<StreamConsumer<$tom_vscode_scripting_api_3.SdkMessage>>(positional, 0, 'streamConsumer', 'pipe');
        return t.pipe(streamConsumer);
      },
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'transform');
        final streamTransformer = D4.getRequiredArg<StreamTransformer<$tom_vscode_scripting_api_3.SdkMessage, dynamic>>(positional, 0, 'streamTransformer', 'transform');
        return t.transform(streamTransformer);
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((($tom_vscode_scripting_api_3.SdkMessage p0, $tom_vscode_scripting_api_3.SdkMessage p1) { return D4.extractBridgedArg<$tom_vscode_scripting_api_3.SdkMessage>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1]), 'callback', visitor) as $tom_vscode_scripting_api_3.SdkMessage; }) as $tom_vscode_scripting_api_3.SdkMessage Function($tom_vscode_scripting_api_3.SdkMessage, $tom_vscode_scripting_api_3.SdkMessage));
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold<Object?>(initialValue, (dynamic p0, $tom_vscode_scripting_api_3.SdkMessage p1) { return D4.castCallbackResult<dynamic>(D4.callInterpreterCallback(visitor!, combineRaw, [p0, p1])); });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'contains');
        final needle = D4.getRequiredArg<Object?>(positional, 0, 'needle', 'contains');
        return t.contains(needle);
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        return t.forEach(($tom_vscode_scripting_api_3.SdkMessage p0) { D4.callInterpreterCallback(visitor!, actionRaw, [p0]); });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage));
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage));
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        return t.cast();
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        return t.toList();
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        return t.toSet();
      },
      'drain': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        final futureValue = D4.getOptionalArg<dynamic>(positional, 0, 'futureValue');
        return t.drain(futureValue);
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage));
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage));
      },
      'distinct': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        final equalsRaw = positional.isNotEmpty ? positional[0] : null;
        return t.distinct(equalsRaw == null ? null : (($tom_vscode_scripting_api_3.SdkMessage p0, $tom_vscode_scripting_api_3.SdkMessage p1) { return D4.callInterpreterCallback(visitor!, equalsRaw, [p0, p1]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage, $tom_vscode_scripting_api_3.SdkMessage));
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage), orElse: orElseRaw == null ? null : (() { return D4.extractBridgedArg<$tom_vscode_scripting_api_3.SdkMessage>(D4.callInterpreterCallback(visitor!, orElseRaw, []), 'callback', visitor) as $tom_vscode_scripting_api_3.SdkMessage; }) as $tom_vscode_scripting_api_3.SdkMessage Function());
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage), orElse: orElseRaw == null ? null : (() { return D4.extractBridgedArg<$tom_vscode_scripting_api_3.SdkMessage>(D4.callInterpreterCallback(visitor!, orElseRaw, []), 'callback', visitor) as $tom_vscode_scripting_api_3.SdkMessage; }) as $tom_vscode_scripting_api_3.SdkMessage Function());
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((($tom_vscode_scripting_api_3.SdkMessage p0) { return D4.callInterpreterCallback(visitor!, testRaw, [p0]) as bool; }) as bool Function($tom_vscode_scripting_api_3.SdkMessage), orElse: orElseRaw == null ? null : (() { return D4.extractBridgedArg<$tom_vscode_scripting_api_3.SdkMessage>(D4.callInterpreterCallback(visitor!, orElseRaw, []), 'callback', visitor) as $tom_vscode_scripting_api_3.SdkMessage; }) as $tom_vscode_scripting_api_3.SdkMessage Function());
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'timeout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentQuery>(target, 'AgentQuery');
        D4.requireMinArgs(positional, 1, 'timeout');
        final timeLimit = D4.getRequiredArg<Duration>(positional, 0, 'timeLimit', 'timeout');
        final onTimeoutRaw = named['onTimeout'];
        return t.timeout(timeLimit, onTimeout: onTimeoutRaw == null ? null : (EventSink<$tom_vscode_scripting_api_3.SdkMessage> p0) { D4.callInterpreterCallback(visitor!, onTimeoutRaw, [p0]); });
      },
    },
    methodSignatures: {
      'interrupt': 'Future<void> interrupt()',
      'asBroadcastStream': 'Stream<SdkMessage> asBroadcastStream({void Function(StreamSubscription<SdkMessage> subscription)? onListen, void Function(StreamSubscription<SdkMessage> subscription)? onCancel})',
      'listen': 'StreamSubscription<SdkMessage> listen(void Function(SdkMessage value)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError})',
      'where': 'Stream<SdkMessage> where(bool Function(SdkMessage event) test)',
      'map': 'Stream<S> map(S Function(SdkMessage event) convert)',
      'asyncMap': 'Stream<E> asyncMap(FutureOr<E> Function(SdkMessage event) convert)',
      'asyncExpand': 'Stream<E> asyncExpand(Stream<E>? Function(SdkMessage event) convert)',
      'handleError': 'Stream<SdkMessage> handleError(Function onError, {bool Function(dynamic error)? test})',
      'expand': 'Stream<S> expand(Iterable<S> Function(SdkMessage element) convert)',
      'pipe': 'Future pipe(StreamConsumer<SdkMessage> streamConsumer)',
      'transform': 'Stream<S> transform(StreamTransformer<SdkMessage, S> streamTransformer)',
      'reduce': 'Future<SdkMessage> reduce(SdkMessage Function(SdkMessage previous, SdkMessage element) combine)',
      'fold': 'Future<S> fold(S initialValue, S Function(S previous, SdkMessage element) combine)',
      'join': 'Future<String> join([String separator = ""])',
      'contains': 'Future<bool> contains(Object? needle)',
      'forEach': 'Future<void> forEach(void Function(SdkMessage element) action)',
      'every': 'Future<bool> every(bool Function(SdkMessage element) test)',
      'any': 'Future<bool> any(bool Function(SdkMessage element) test)',
      'cast': 'Stream<R> cast()',
      'toList': 'Future<List<SdkMessage>> toList()',
      'toSet': 'Future<Set<SdkMessage>> toSet()',
      'drain': 'Future<E> drain([E? futureValue])',
      'take': 'Stream<SdkMessage> take(int count)',
      'takeWhile': 'Stream<SdkMessage> takeWhile(bool Function(SdkMessage element) test)',
      'skip': 'Stream<SdkMessage> skip(int count)',
      'skipWhile': 'Stream<SdkMessage> skipWhile(bool Function(SdkMessage element) test)',
      'distinct': 'Stream<SdkMessage> distinct([bool Function(SdkMessage previous, SdkMessage next)? equals])',
      'firstWhere': 'Future<SdkMessage> firstWhere(bool Function(SdkMessage element) test, {SdkMessage Function()? orElse})',
      'lastWhere': 'Future<SdkMessage> lastWhere(bool Function(SdkMessage element) test, {SdkMessage Function()? orElse})',
      'singleWhere': 'Future<SdkMessage> singleWhere(bool Function(SdkMessage element) test, {SdkMessage Function()? orElse})',
      'elementAt': 'Future<SdkMessage> elementAt(int index)',
      'timeout': 'Stream<SdkMessage> timeout(Duration timeLimit, {void Function(EventSink<SdkMessage> sink)? onTimeout})',
    },
    getterSignatures: {
      'isBroadcast': 'bool get isBroadcast',
      'length': 'Future<int> get length',
      'isEmpty': 'Future<bool> get isEmpty',
      'first': 'Future<SdkMessage> get first',
      'last': 'Future<SdkMessage> get last',
      'single': 'Future<SdkMessage> get single',
    },
  );
}

// =============================================================================
// AgentSdkClient Bridge
// =============================================================================

BridgedClass _createAgentSdkClientBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_7.AgentSdkClient,
    name: 'AgentSdkClient',
    isAssignable: (v) => v is $tom_vscode_scripting_api_7.AgentSdkClient,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AgentSdkClient');
        final transport = D4.getRequiredArg<$tom_vscode_scripting_api_7.AgentSdkTransport>(positional, 0, 'transport', 'AgentSdkClient');
        return $tom_vscode_scripting_api_7.AgentSdkClient(transport);
      },
    },
    getters: {
      'transport': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkClient>(target, 'AgentSdkClient').transport,
    },
    methods: {
      'query': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkClient>(target, 'AgentSdkClient');
        final prompt = D4.getRequiredNamedArg<String>(named, 'prompt', 'query');
        final options = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.Options?>(named, 'options');
        return t.query(prompt: prompt, options: options);
      },
      'collectQuery': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.AgentSdkClient>(target, 'AgentSdkClient');
        final prompt = D4.getRequiredNamedArg<String>(named, 'prompt', 'collectQuery');
        final options = D4.getOptionalNamedArg<$tom_vscode_scripting_api_4.Options?>(named, 'options');
        return t.collectQuery(prompt: prompt, options: options);
      },
    },
    constructorSignatures: {
      '': 'AgentSdkClient(AgentSdkTransport transport)',
    },
    methodSignatures: {
      'query': 'AgentQuery query({required String prompt, Options? options})',
      'collectQuery': 'Future<List<SdkMessage>> collectQuery({required String prompt, Options? options})',
    },
    getterSignatures: {
      'transport': 'AgentSdkTransport get transport',
    },
  );
}

// =============================================================================
// VSCodeBridgeAgentSdkTransport Bridge
// =============================================================================

BridgedClass _createVSCodeBridgeAgentSdkTransportBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport,
    name: 'VSCodeBridgeAgentSdkTransport',
    isAssignable: (v) => v is $tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport,
    hierarchyDepth: 1,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VSCodeBridgeAgentSdkTransport');
        final client = D4.getRequiredArg<$tom_vscode_scripting_api_23.VSCodeBridgeClient>(positional, 0, 'client', 'VSCodeBridgeAgentSdkTransport');
        return $tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport(client);
      },
    },
    getters: {
      'client': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport>(target, 'VSCodeBridgeAgentSdkTransport').client,
      'chunks': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport>(target, 'VSCodeBridgeAgentSdkTransport').chunks,
    },
    methods: {
      'startQuery': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport>(target, 'VSCodeBridgeAgentSdkTransport');
        D4.requireMinArgs(positional, 1, 'startQuery');
        if (positional.isEmpty) {
          throw ArgumentError('startQuery: Missing required argument "params" at position 0');
        }
        final params = D4.coerceMap<String, dynamic>(positional[0], 'params');
        return t.startQuery(params);
      },
      'cancelQuery': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport>(target, 'VSCodeBridgeAgentSdkTransport');
        D4.requireMinArgs(positional, 1, 'cancelQuery');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'cancelQuery');
        return t.cancelQuery(streamId);
      },
      'registerTools': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport>(target, 'VSCodeBridgeAgentSdkTransport');
        D4.requireMinArgs(positional, 2, 'registerTools');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'registerTools');
        final registry = D4.getRequiredArg<$tom_vscode_scripting_api_8.AgentSdkToolRegistry>(positional, 1, 'registry', 'registerTools');
        t.registerTools(streamId, registry);
        return null;
      },
      'unregisterTools': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport>(target, 'VSCodeBridgeAgentSdkTransport');
        D4.requireMinArgs(positional, 1, 'unregisterTools');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'unregisterTools');
        t.unregisterTools(streamId);
        return null;
      },
      'registerCanUseTool': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport>(target, 'VSCodeBridgeAgentSdkTransport');
        D4.requireMinArgs(positional, 2, 'registerCanUseTool');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'registerCanUseTool');
        if (positional.length <= 1) {
          throw ArgumentError('registerCanUseTool: Missing required argument "callback" at position 1');
        }
        final callbackRaw = positional[1];
        t.registerCanUseTool(streamId, ((String p0, Map<String, dynamic> p1, $tom_vscode_scripting_api_6.CanUseToolContext p2) { return Future.value(D4.callInterpreterCallback(visitor!, callbackRaw, [p0, p1, p2])).then((v) => v as $tom_vscode_scripting_api_6.PermissionResult); }) as Future<$tom_vscode_scripting_api_6.PermissionResult> Function(String, Map<String, dynamic>, $tom_vscode_scripting_api_6.CanUseToolContext));
        return null;
      },
      'unregisterCanUseTool': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_7.VSCodeBridgeAgentSdkTransport>(target, 'VSCodeBridgeAgentSdkTransport');
        D4.requireMinArgs(positional, 1, 'unregisterCanUseTool');
        final streamId = D4.getRequiredArg<String>(positional, 0, 'streamId', 'unregisterCanUseTool');
        t.unregisterCanUseTool(streamId);
        return null;
      },
    },
    constructorSignatures: {
      '': 'VSCodeBridgeAgentSdkTransport(VSCodeBridgeClient client)',
    },
    methodSignatures: {
      'startQuery': 'Future<void> startQuery(Map<String, dynamic> params)',
      'cancelQuery': 'Future<void> cancelQuery(String streamId)',
      'registerTools': 'void registerTools(String streamId, AgentSdkToolRegistry registry)',
      'unregisterTools': 'void unregisterTools(String streamId)',
      'registerCanUseTool': 'void registerCanUseTool(String streamId, CanUseTool callback)',
      'unregisterCanUseTool': 'void unregisterCanUseTool(String streamId)',
    },
    getterSignatures: {
      'client': 'VSCodeBridgeClient get client',
      'chunks': 'Stream<Map<String, dynamic>> get chunks',
    },
  );
}

// =============================================================================
// BridgeRequestDispatcher Bridge
// =============================================================================

BridgedClass _createBridgeRequestDispatcherBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_12.BridgeRequestDispatcher,
    name: 'BridgeRequestDispatcher',
    isAssignable: (v) => v is $tom_vscode_scripting_api_12.BridgeRequestDispatcher,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('sendReply') || named['sendReply'] == null) {
          throw ArgumentError('BridgeRequestDispatcher: Missing required named argument "sendReply"');
        }
        final sendReplyRaw = named['sendReply'];
        return $tom_vscode_scripting_api_12.BridgeRequestDispatcher(sendReply: (Map<String, dynamic> p0) { D4.callInterpreterCallback(visitor!, sendReplyRaw, [p0]); });
      },
    },
    methods: {
      'register': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_12.BridgeRequestDispatcher>(target, 'BridgeRequestDispatcher');
        D4.requireMinArgs(positional, 2, 'register');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'register');
        if (positional.length <= 1) {
          throw ArgumentError('register: Missing required argument "handler" at position 1');
        }
        final handlerRaw = positional[1];
        t.register(method, ((Map<String, dynamic> p0) { return D4.castCallbackResult<FutureOr<Object?>>(D4.callInterpreterCallback(visitor!, handlerRaw, [p0])); }) as FutureOr<Object?> Function(Map<String, dynamic>));
        return null;
      },
      'unregister': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_12.BridgeRequestDispatcher>(target, 'BridgeRequestDispatcher');
        D4.requireMinArgs(positional, 1, 'unregister');
        final method = D4.getRequiredArg<String>(positional, 0, 'method', 'unregister');
        t.unregister(method);
        return null;
      },
      'maybeHandle': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_12.BridgeRequestDispatcher>(target, 'BridgeRequestDispatcher');
        D4.requireMinArgs(positional, 1, 'maybeHandle');
        if (positional.isEmpty) {
          throw ArgumentError('maybeHandle: Missing required argument "message" at position 0');
        }
        final message = D4.coerceMap<String, dynamic>(positional[0], 'message');
        return t.maybeHandle(message);
      },
    },
    constructorSignatures: {
      '': 'BridgeRequestDispatcher({required void Function(Map<String, dynamic>) sendReply})',
    },
    methodSignatures: {
      'register': 'void register(String method, BridgeRequestHandler handler)',
      'unregister': 'void unregister(String method)',
      'maybeHandle': 'bool maybeHandle(Map<String, dynamic> message)',
    },
  );
}

// =============================================================================
// AgentSdkToolRegistry Bridge
// =============================================================================

BridgedClass _createAgentSdkToolRegistryBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_8.AgentSdkToolRegistry,
    name: 'AgentSdkToolRegistry',
    isAssignable: (v) => v is $tom_vscode_scripting_api_8.AgentSdkToolRegistry,
    constructors: {
      '': (visitor, positional, named) {
        return $tom_vscode_scripting_api_8.AgentSdkToolRegistry();
      },
    },
    getters: {
      'hasHandlers': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_8.AgentSdkToolRegistry>(target, 'AgentSdkToolRegistry').hasHandlers,
    },
    methods: {
      'addServers': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_8.AgentSdkToolRegistry>(target, 'AgentSdkToolRegistry');
        D4.requireMinArgs(positional, 1, 'addServers');
        if (positional.isEmpty) {
          throw ArgumentError('addServers: Missing required argument "mcpServers" at position 0');
        }
        final mcpServers = D4.coerceMapOrNull<String, $tom_vscode_scripting_api_2.McpServerConfig>(positional[0], 'mcpServers');
        return t.addServers(mcpServers);
      },
      'handleToolCall': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_8.AgentSdkToolRegistry>(target, 'AgentSdkToolRegistry');
        D4.requireMinArgs(positional, 1, 'handleToolCall');
        if (positional.isEmpty) {
          throw ArgumentError('handleToolCall: Missing required argument "params" at position 0');
        }
        final params = D4.coerceMap<String, dynamic>(positional[0], 'params');
        return t.handleToolCall(params);
      },
    },
    constructorSignatures: {
      '': 'AgentSdkToolRegistry()',
    },
    methodSignatures: {
      'addServers': 'bool addServers(Map<String, McpServerConfig>? mcpServers)',
      'handleToolCall': 'Future<Map<String, dynamic>> handleToolCall(Map<String, dynamic> params)',
    },
    getterSignatures: {
      'hasHandlers': 'bool get hasHandlers',
    },
  );
}

// =============================================================================
// AiTokenStats Bridge
// =============================================================================

BridgedClass _createAiTokenStatsBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_10.AiTokenStats,
    name: 'AiTokenStats',
    isAssignable: (v) => v is $tom_vscode_scripting_api_10.AiTokenStats,
    constructors: {
      '': (visitor, positional, named) {
        final promptTokens = D4.getRequiredNamedArg<int>(named, 'promptTokens', 'AiTokenStats');
        final completionTokens = D4.getRequiredNamedArg<int>(named, 'completionTokens', 'AiTokenStats');
        final totalDurationMs = D4.getRequiredNamedArg<double>(named, 'totalDurationMs', 'AiTokenStats');
        final loadDurationMs = D4.getRequiredNamedArg<double>(named, 'loadDurationMs', 'AiTokenStats');
        return $tom_vscode_scripting_api_10.AiTokenStats(promptTokens: promptTokens, completionTokens: completionTokens, totalDurationMs: totalDurationMs, loadDurationMs: loadDurationMs);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AiTokenStats');
        if (positional.isEmpty) {
          throw ArgumentError('AiTokenStats: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_10.AiTokenStats.fromJson(json);
      },
    },
    getters: {
      'promptTokens': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiTokenStats>(target, 'AiTokenStats').promptTokens,
      'completionTokens': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiTokenStats>(target, 'AiTokenStats').completionTokens,
      'totalDurationMs': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiTokenStats>(target, 'AiTokenStats').totalDurationMs,
      'loadDurationMs': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiTokenStats>(target, 'AiTokenStats').loadDurationMs,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_10.AiTokenStats>(target, 'AiTokenStats');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_10.AiTokenStats>(target, 'AiTokenStats');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'AiTokenStats({required int promptTokens, required int completionTokens, required double totalDurationMs, required double loadDurationMs})',
      'fromJson': 'factory AiTokenStats.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'promptTokens': 'int get promptTokens',
      'completionTokens': 'int get completionTokens',
      'totalDurationMs': 'double get totalDurationMs',
      'loadDurationMs': 'double get loadDurationMs',
    },
  );
}

// =============================================================================
// AiPromptResult Bridge
// =============================================================================

BridgedClass _createAiPromptResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_10.AiPromptResult,
    name: 'AiPromptResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_10.AiPromptResult,
    constructors: {
      '': (visitor, positional, named) {
        final success = D4.getRequiredNamedArg<bool>(named, 'success', 'AiPromptResult');
        final result = D4.getRequiredNamedArg<String>(named, 'result', 'AiPromptResult');
        final rawResponse = D4.getRequiredNamedArg<String>(named, 'rawResponse', 'AiPromptResult');
        final response = D4.getRequiredNamedArg<String>(named, 'response', 'AiPromptResult');
        final thinkTagContent = D4.getRequiredNamedArg<String>(named, 'thinkTagContent', 'AiPromptResult');
        final profile = D4.getRequiredNamedArg<String>(named, 'profile', 'AiPromptResult');
        final modelConfig = D4.getRequiredNamedArg<String>(named, 'modelConfig', 'AiPromptResult');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final tokenInfo = D4.getOptionalNamedArg<$tom_vscode_scripting_api_10.AiTokenStats?>(named, 'tokenInfo');
        return $tom_vscode_scripting_api_10.AiPromptResult(success: success, result: result, rawResponse: rawResponse, response: response, thinkTagContent: thinkTagContent, profile: profile, modelConfig: modelConfig, error: error, tokenInfo: tokenInfo);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AiPromptResult');
        if (positional.isEmpty) {
          throw ArgumentError('AiPromptResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_10.AiPromptResult.fromJson(json);
      },
    },
    getters: {
      'success': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').success,
      'result': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').result,
      'rawResponse': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').rawResponse,
      'response': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').response,
      'thinkTagContent': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').thinkTagContent,
      'profile': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').profile,
      'modelConfig': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').modelConfig,
      'error': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').error,
      'tokenInfo': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult').tokenInfo,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptResult>(target, 'AiPromptResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'AiPromptResult({required bool success, required String result, required String rawResponse, required String response, required String thinkTagContent, required String profile, required String modelConfig, String? error, AiTokenStats? tokenInfo})',
      'fromJson': 'factory AiPromptResult.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'success': 'bool get success',
      'result': 'String get result',
      'rawResponse': 'String get rawResponse',
      'response': 'String get response',
      'thinkTagContent': 'String get thinkTagContent',
      'profile': 'String get profile',
      'modelConfig': 'String get modelConfig',
      'error': 'String? get error',
      'tokenInfo': 'AiTokenStats? get tokenInfo',
    },
  );
}

// =============================================================================
// AiPromptProfile Bridge
// =============================================================================

BridgedClass _createAiPromptProfileBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_10.AiPromptProfile,
    name: 'AiPromptProfile',
    isAssignable: (v) => v is $tom_vscode_scripting_api_10.AiPromptProfile,
    constructors: {
      '': (visitor, positional, named) {
        final key = D4.getRequiredNamedArg<String>(named, 'key', 'AiPromptProfile');
        final label = D4.getRequiredNamedArg<String>(named, 'label', 'AiPromptProfile');
        final isDefault = D4.getNamedArgWithDefault<bool>(named, 'isDefault', false);
        final systemPrompt = D4.getOptionalNamedArg<String?>(named, 'systemPrompt');
        final resultTemplate = D4.getOptionalNamedArg<String?>(named, 'resultTemplate');
        final temperature = D4.getOptionalNamedArg<double?>(named, 'temperature');
        final modelConfig = D4.getOptionalNamedArg<String?>(named, 'modelConfig');
        return $tom_vscode_scripting_api_10.AiPromptProfile(key: key, label: label, isDefault: isDefault, systemPrompt: systemPrompt, resultTemplate: resultTemplate, temperature: temperature, modelConfig: modelConfig);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AiPromptProfile');
        if (positional.isEmpty) {
          throw ArgumentError('AiPromptProfile: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_10.AiPromptProfile.fromJson(json);
      },
    },
    getters: {
      'key': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile').key,
      'label': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile').label,
      'isDefault': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile').isDefault,
      'systemPrompt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile').systemPrompt,
      'resultTemplate': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile').resultTemplate,
      'temperature': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile').temperature,
      'modelConfig': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile').modelConfig,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_10.AiPromptProfile>(target, 'AiPromptProfile');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'AiPromptProfile({required String key, required String label, bool isDefault = false, String? systemPrompt, String? resultTemplate, double? temperature, String? modelConfig})',
      'fromJson': 'factory AiPromptProfile.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'key': 'String get key',
      'label': 'String get label',
      'isDefault': 'bool get isDefault',
      'systemPrompt': 'String? get systemPrompt',
      'resultTemplate': 'String? get resultTemplate',
      'temperature': 'double? get temperature',
      'modelConfig': 'String? get modelConfig',
    },
  );
}

// =============================================================================
// AiModelConfig Bridge
// =============================================================================

BridgedClass _createAiModelConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_10.AiModelConfig,
    name: 'AiModelConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_10.AiModelConfig,
    constructors: {
      '': (visitor, positional, named) {
        final key = D4.getRequiredNamedArg<String>(named, 'key', 'AiModelConfig');
        final ollamaUrl = D4.getRequiredNamedArg<String>(named, 'ollamaUrl', 'AiModelConfig');
        final model = D4.getRequiredNamedArg<String>(named, 'model', 'AiModelConfig');
        final temperature = D4.getRequiredNamedArg<double>(named, 'temperature', 'AiModelConfig');
        final stripThinkingTags = D4.getRequiredNamedArg<bool>(named, 'stripThinkingTags', 'AiModelConfig');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final isDefault = D4.getNamedArgWithDefault<bool>(named, 'isDefault', false);
        return $tom_vscode_scripting_api_10.AiModelConfig(key: key, ollamaUrl: ollamaUrl, model: model, temperature: temperature, stripThinkingTags: stripThinkingTags, description: description, isDefault: isDefault);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AiModelConfig');
        if (positional.isEmpty) {
          throw ArgumentError('AiModelConfig: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_10.AiModelConfig.fromJson(json);
      },
    },
    getters: {
      'key': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig').key,
      'ollamaUrl': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig').ollamaUrl,
      'model': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig').model,
      'temperature': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig').temperature,
      'stripThinkingTags': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig').stripThinkingTags,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig').description,
      'isDefault': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig').isDefault,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_10.AiModelConfig>(target, 'AiModelConfig');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'AiModelConfig({required String key, required String ollamaUrl, required String model, required double temperature, required bool stripThinkingTags, String? description, bool isDefault = false})',
      'fromJson': 'factory AiModelConfig.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'key': 'String get key',
      'ollamaUrl': 'String get ollamaUrl',
      'model': 'String get model',
      'temperature': 'double get temperature',
      'stripThinkingTags': 'bool get stripThinkingTags',
      'description': 'String? get description',
      'isDefault': 'bool get isDefault',
    },
  );
}

// =============================================================================
// AiModelsResult Bridge
// =============================================================================

BridgedClass _createAiModelsResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_10.AiModelsResult,
    name: 'AiModelsResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_10.AiModelsResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('models') || named['models'] == null) {
          throw ArgumentError('AiModelsResult: Missing required named argument "models"');
        }
        final models = D4.coerceList<$tom_vscode_scripting_api_10.AiModelConfig>(named['models'], 'models');
        final effectiveDefault = D4.getOptionalNamedArg<$tom_vscode_scripting_api_10.AiModelConfig?>(named, 'effectiveDefault');
        return $tom_vscode_scripting_api_10.AiModelsResult(models: models, effectiveDefault: effectiveDefault);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AiModelsResult');
        if (positional.isEmpty) {
          throw ArgumentError('AiModelsResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_10.AiModelsResult.fromJson(json);
      },
    },
    getters: {
      'models': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelsResult>(target, 'AiModelsResult').models,
      'effectiveDefault': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_10.AiModelsResult>(target, 'AiModelsResult').effectiveDefault,
    },
    constructorSignatures: {
      '': 'AiModelsResult({required List<AiModelConfig> models, AiModelConfig? effectiveDefault})',
      'fromJson': 'factory AiModelsResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'models': 'List<AiModelConfig> get models',
      'effectiveDefault': 'AiModelConfig? get effectiveDefault',
    },
  );
}

// =============================================================================
// AiPromptApi Bridge
// =============================================================================

BridgedClass _createAiPromptApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_10.AiPromptApi,
    name: 'AiPromptApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_10.AiPromptApi,
    constructors: {
    },
    staticMethods: {
      'process': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'process');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'process');
        final profile = D4.getOptionalNamedArg<String?>(named, 'profile');
        final model = D4.getOptionalNamedArg<String?>(named, 'model');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 120);
        return $tom_vscode_scripting_api_10.AiPromptApi.process(prompt, profile: profile, model: model, timeoutSeconds: timeoutSeconds);
      },
      'getProfiles': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_10.AiPromptApi.getProfiles(timeoutSeconds: timeoutSeconds);
      },
      'updateProfile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'updateProfile');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'updateProfile');
        if (positional.length <= 1) {
          throw ArgumentError('updateProfile: Missing required argument "profile" at position 1');
        }
        final profile = D4.coerceMap<String, dynamic>(positional[1], 'profile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_10.AiPromptApi.updateProfile(key, profile, timeoutSeconds: timeoutSeconds);
      },
      'removeProfile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removeProfile');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'removeProfile');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_10.AiPromptApi.removeProfile(key, timeoutSeconds: timeoutSeconds);
      },
      'getModels': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_10.AiPromptApi.getModels(timeoutSeconds: timeoutSeconds);
      },
      'updateModel': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'updateModel');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'updateModel');
        if (positional.length <= 1) {
          throw ArgumentError('updateModel: Missing required argument "model" at position 1');
        }
        final model = D4.coerceMap<String, dynamic>(positional[1], 'model');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_10.AiPromptApi.updateModel(key, model, timeoutSeconds: timeoutSeconds);
      },
      'removeModel': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removeModel');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'removeModel');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_10.AiPromptApi.removeModel(key, timeoutSeconds: timeoutSeconds);
      },
    },
    staticMethodSignatures: {
      'process': 'Future<AiPromptResult> process(String prompt, {String? profile, String? model, int timeoutSeconds = 120})',
      'getProfiles': 'Future<List<AiPromptProfile>> getProfiles({int timeoutSeconds = 30})',
      'updateProfile': 'Future<Map<String, dynamic>> updateProfile(String key, Map<String, dynamic> profile, {int timeoutSeconds = 30})',
      'removeProfile': 'Future<Map<String, dynamic>> removeProfile(String key, {int timeoutSeconds = 30})',
      'getModels': 'Future<AiModelsResult> getModels({int timeoutSeconds = 30})',
      'updateModel': 'Future<Map<String, dynamic>> updateModel(String key, Map<String, dynamic> model, {int timeoutSeconds = 30})',
      'removeModel': 'Future<Map<String, dynamic>> removeModel(String key, {int timeoutSeconds = 30})',
    },
  );
}

// =============================================================================
// CopilotResponse Bridge
// =============================================================================

BridgedClass _createCopilotResponseBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.CopilotResponse,
    name: 'CopilotResponse',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.CopilotResponse,
    constructors: {
      '': (visitor, positional, named) {
        final requestId = D4.getRequiredNamedArg<String>(named, 'requestId', 'CopilotResponse');
        final generatedMarkdown = D4.getRequiredNamedArg<String>(named, 'generatedMarkdown', 'CopilotResponse');
        final comments = D4.getOptionalNamedArg<String?>(named, 'comments');
        final references = named.containsKey('references') && named['references'] != null
            ? D4.coerceList<String>(named['references'], 'references')
            : const <String>[];
        final requestedAttachments = named.containsKey('requestedAttachments') && named['requestedAttachments'] != null
            ? D4.coerceList<String>(named['requestedAttachments'], 'requestedAttachments')
            : const <String>[];
        return $tom_vscode_scripting_api_9.CopilotResponse(requestId: requestId, generatedMarkdown: generatedMarkdown, comments: comments, references: references, requestedAttachments: requestedAttachments);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CopilotResponse');
        if (positional.isEmpty) {
          throw ArgumentError('CopilotResponse: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.CopilotResponse.fromJson(json);
      },
    },
    getters: {
      'requestId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.CopilotResponse>(target, 'CopilotResponse').requestId,
      'generatedMarkdown': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.CopilotResponse>(target, 'CopilotResponse').generatedMarkdown,
      'comments': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.CopilotResponse>(target, 'CopilotResponse').comments,
      'references': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.CopilotResponse>(target, 'CopilotResponse').references,
      'requestedAttachments': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.CopilotResponse>(target, 'CopilotResponse').requestedAttachments,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.CopilotResponse>(target, 'CopilotResponse');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.CopilotResponse>(target, 'CopilotResponse');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'CopilotResponse({required String requestId, required String generatedMarkdown, String? comments, List<String> references = const [], List<String> requestedAttachments = const []})',
      'fromJson': 'factory CopilotResponse.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'requestId': 'String get requestId',
      'generatedMarkdown': 'String get generatedMarkdown',
      'comments': 'String? get comments',
      'references': 'List<String> get references',
      'requestedAttachments': 'List<String> get requestedAttachments',
    },
  );
}

// =============================================================================
// ConversationExchange Bridge
// =============================================================================

BridgedClass _createConversationExchangeBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.ConversationExchange,
    name: 'ConversationExchange',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.ConversationExchange,
    constructors: {
      '': (visitor, positional, named) {
        final turn = D4.getRequiredNamedArg<int>(named, 'turn', 'ConversationExchange');
        final timestamp = D4.getRequiredNamedArg<DateTime>(named, 'timestamp', 'ConversationExchange');
        final promptToCopilot = D4.getRequiredNamedArg<String>(named, 'promptToCopilot', 'ConversationExchange');
        final copilotResponse = D4.getRequiredNamedArg<$tom_vscode_scripting_api_9.CopilotResponse>(named, 'copilotResponse', 'ConversationExchange');
        final localModelStats = D4.getOptionalNamedArg<$tom_vscode_scripting_api_10.AiTokenStats?>(named, 'localModelStats');
        return $tom_vscode_scripting_api_9.ConversationExchange(turn: turn, timestamp: timestamp, promptToCopilot: promptToCopilot, copilotResponse: copilotResponse, localModelStats: localModelStats);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConversationExchange');
        if (positional.isEmpty) {
          throw ArgumentError('ConversationExchange: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.ConversationExchange.fromJson(json);
      },
    },
    getters: {
      'turn': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationExchange>(target, 'ConversationExchange').turn,
      'timestamp': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationExchange>(target, 'ConversationExchange').timestamp,
      'promptToCopilot': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationExchange>(target, 'ConversationExchange').promptToCopilot,
      'copilotResponse': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationExchange>(target, 'ConversationExchange').copilotResponse,
      'localModelStats': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationExchange>(target, 'ConversationExchange').localModelStats,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.ConversationExchange>(target, 'ConversationExchange');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.ConversationExchange>(target, 'ConversationExchange');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ConversationExchange({required int turn, required DateTime timestamp, required String promptToCopilot, required CopilotResponse copilotResponse, AiTokenStats? localModelStats})',
      'fromJson': 'factory ConversationExchange.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'turn': 'int get turn',
      'timestamp': 'DateTime get timestamp',
      'promptToCopilot': 'String get promptToCopilot',
      'copilotResponse': 'CopilotResponse get copilotResponse',
      'localModelStats': 'AiTokenStats? get localModelStats',
    },
  );
}

// =============================================================================
// ConversationResult Bridge
// =============================================================================

BridgedClass _createConversationResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.ConversationResult,
    name: 'ConversationResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.ConversationResult,
    constructors: {
      '': (visitor, positional, named) {
        final conversationId = D4.getRequiredNamedArg<String>(named, 'conversationId', 'ConversationResult');
        final turns = D4.getRequiredNamedArg<int>(named, 'turns', 'ConversationResult');
        final goalReached = D4.getRequiredNamedArg<bool>(named, 'goalReached', 'ConversationResult');
        final logFilePath = D4.getRequiredNamedArg<String>(named, 'logFilePath', 'ConversationResult');
        if (!named.containsKey('exchanges') || named['exchanges'] == null) {
          throw ArgumentError('ConversationResult: Missing required named argument "exchanges"');
        }
        final exchanges = D4.coerceList<$tom_vscode_scripting_api_9.ConversationExchange>(named['exchanges'], 'exchanges');
        return $tom_vscode_scripting_api_9.ConversationResult(conversationId: conversationId, turns: turns, goalReached: goalReached, logFilePath: logFilePath, exchanges: exchanges);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConversationResult');
        if (positional.isEmpty) {
          throw ArgumentError('ConversationResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.ConversationResult.fromJson(json);
      },
    },
    getters: {
      'conversationId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationResult>(target, 'ConversationResult').conversationId,
      'turns': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationResult>(target, 'ConversationResult').turns,
      'goalReached': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationResult>(target, 'ConversationResult').goalReached,
      'logFilePath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationResult>(target, 'ConversationResult').logFilePath,
      'exchanges': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationResult>(target, 'ConversationResult').exchanges,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.ConversationResult>(target, 'ConversationResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ConversationResult({required String conversationId, required int turns, required bool goalReached, required String logFilePath, required List<ConversationExchange> exchanges})',
      'fromJson': 'factory ConversationResult.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'conversationId': 'String get conversationId',
      'turns': 'int get turns',
      'goalReached': 'bool get goalReached',
      'logFilePath': 'String get logFilePath',
      'exchanges': 'List<ConversationExchange> get exchanges',
    },
  );
}

// =============================================================================
// ConversationStatus Bridge
// =============================================================================

BridgedClass _createConversationStatusBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.ConversationStatus,
    name: 'ConversationStatus',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.ConversationStatus,
    constructors: {
      '': (visitor, positional, named) {
        final active = D4.getRequiredNamedArg<bool>(named, 'active', 'ConversationStatus');
        final halted = D4.getNamedArgWithDefault<bool>(named, 'halted', false);
        final conversationId = D4.getOptionalNamedArg<String?>(named, 'conversationId');
        final goal = D4.getOptionalNamedArg<String?>(named, 'goal');
        final profileKey = D4.getOptionalNamedArg<String?>(named, 'profileKey');
        final conversationMode = D4.getOptionalNamedArg<$tom_vscode_scripting_api_9.ConversationMode?>(named, 'conversationMode');
        final turnsCompleted = D4.getNamedArgWithDefault<int>(named, 'turnsCompleted', 0);
        final maxTurns = D4.getNamedArgWithDefault<int>(named, 'maxTurns', 0);
        final pendingUserInput = D4.getNamedArgWithDefault<int>(named, 'pendingUserInput', 0);
        return $tom_vscode_scripting_api_9.ConversationStatus(active: active, halted: halted, conversationId: conversationId, goal: goal, profileKey: profileKey, conversationMode: conversationMode, turnsCompleted: turnsCompleted, maxTurns: maxTurns, pendingUserInput: pendingUserInput);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConversationStatus');
        if (positional.isEmpty) {
          throw ArgumentError('ConversationStatus: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.ConversationStatus.fromJson(json);
      },
    },
    getters: {
      'active': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').active,
      'halted': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').halted,
      'conversationId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').conversationId,
      'goal': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').goal,
      'profileKey': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').profileKey,
      'conversationMode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').conversationMode,
      'turnsCompleted': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').turnsCompleted,
      'maxTurns': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').maxTurns,
      'pendingUserInput': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus').pendingUserInput,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.ConversationStatus>(target, 'ConversationStatus');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ConversationStatus({required bool active, bool halted = false, String? conversationId, String? goal, String? profileKey, ConversationMode? conversationMode, int turnsCompleted = 0, int maxTurns = 0, int pendingUserInput = 0})',
      'fromJson': 'factory ConversationStatus.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'active': 'bool get active',
      'halted': 'bool get halted',
      'conversationId': 'String? get conversationId',
      'goal': 'String? get goal',
      'profileKey': 'String? get profileKey',
      'conversationMode': 'ConversationMode? get conversationMode',
      'turnsCompleted': 'int get turnsCompleted',
      'maxTurns': 'int get maxTurns',
      'pendingUserInput': 'int get pendingUserInput',
    },
  );
}

// =============================================================================
// ConversationProfile Bridge
// =============================================================================

BridgedClass _createConversationProfileBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.ConversationProfile,
    name: 'ConversationProfile',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.ConversationProfile,
    constructors: {
      '': (visitor, positional, named) {
        final key = D4.getRequiredNamedArg<String>(named, 'key', 'ConversationProfile');
        final label = D4.getRequiredNamedArg<String>(named, 'label', 'ConversationProfile');
        final maxTurns = D4.getOptionalNamedArg<int?>(named, 'maxTurns');
        final temperature = D4.getOptionalNamedArg<double?>(named, 'temperature');
        final modelConfig = D4.getOptionalNamedArg<String?>(named, 'modelConfig');
        final historyMode = D4.getOptionalNamedArg<$tom_vscode_scripting_api_9.HistoryMode?>(named, 'historyMode');
        final goalReachedMarker = D4.getOptionalNamedArg<String?>(named, 'goalReachedMarker');
        return $tom_vscode_scripting_api_9.ConversationProfile(key: key, label: label, maxTurns: maxTurns, temperature: temperature, modelConfig: modelConfig, historyMode: historyMode, goalReachedMarker: goalReachedMarker);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConversationProfile');
        if (positional.isEmpty) {
          throw ArgumentError('ConversationProfile: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.ConversationProfile.fromJson(json);
      },
    },
    getters: {
      'key': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationProfile>(target, 'ConversationProfile').key,
      'label': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationProfile>(target, 'ConversationProfile').label,
      'maxTurns': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationProfile>(target, 'ConversationProfile').maxTurns,
      'temperature': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationProfile>(target, 'ConversationProfile').temperature,
      'modelConfig': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationProfile>(target, 'ConversationProfile').modelConfig,
      'historyMode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationProfile>(target, 'ConversationProfile').historyMode,
      'goalReachedMarker': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationProfile>(target, 'ConversationProfile').goalReachedMarker,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.ConversationProfile>(target, 'ConversationProfile');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ConversationProfile({required String key, required String label, int? maxTurns, double? temperature, String? modelConfig, HistoryMode? historyMode, String? goalReachedMarker})',
      'fromJson': 'factory ConversationProfile.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'key': 'String get key',
      'label': 'String get label',
      'maxTurns': 'int? get maxTurns',
      'temperature': 'double? get temperature',
      'modelConfig': 'String? get modelConfig',
      'historyMode': 'HistoryMode? get historyMode',
      'goalReachedMarker': 'String? get goalReachedMarker',
    },
  );
}

// =============================================================================
// ConversationConfig Bridge
// =============================================================================

BridgedClass _createConversationConfigBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.ConversationConfig,
    name: 'ConversationConfig',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.ConversationConfig,
    constructors: {
      '': (visitor, positional, named) {
        final maxTurns = D4.getRequiredNamedArg<int>(named, 'maxTurns', 'ConversationConfig');
        final temperature = D4.getRequiredNamedArg<double>(named, 'temperature', 'ConversationConfig');
        final historyMode = D4.getRequiredNamedArg<$tom_vscode_scripting_api_9.HistoryMode>(named, 'historyMode', 'ConversationConfig');
        final maxHistoryTokens = D4.getRequiredNamedArg<int>(named, 'maxHistoryTokens', 'ConversationConfig');
        final modelConfig = D4.getOptionalNamedArg<String?>(named, 'modelConfig');
        final pauseBetweenTurns = D4.getRequiredNamedArg<bool>(named, 'pauseBetweenTurns', 'ConversationConfig');
        final pauseBeforeFirst = D4.getRequiredNamedArg<bool>(named, 'pauseBeforeFirst', 'ConversationConfig');
        final logConversation = D4.getRequiredNamedArg<bool>(named, 'logConversation', 'ConversationConfig');
        final stripThinkingTags = D4.getRequiredNamedArg<bool>(named, 'stripThinkingTags', 'ConversationConfig');
        final copilotModel = D4.getOptionalNamedArg<String?>(named, 'copilotModel');
        final conversationLogPath = D4.getRequiredNamedArg<String>(named, 'conversationLogPath', 'ConversationConfig');
        final goalReachedMarker = D4.getRequiredNamedArg<String>(named, 'goalReachedMarker', 'ConversationConfig');
        if (!named.containsKey('profileKeys') || named['profileKeys'] == null) {
          throw ArgumentError('ConversationConfig: Missing required named argument "profileKeys"');
        }
        final profileKeys = D4.coerceList<String>(named['profileKeys'], 'profileKeys');
        return $tom_vscode_scripting_api_9.ConversationConfig(maxTurns: maxTurns, temperature: temperature, historyMode: historyMode, maxHistoryTokens: maxHistoryTokens, modelConfig: modelConfig, pauseBetweenTurns: pauseBetweenTurns, pauseBeforeFirst: pauseBeforeFirst, logConversation: logConversation, stripThinkingTags: stripThinkingTags, copilotModel: copilotModel, conversationLogPath: conversationLogPath, goalReachedMarker: goalReachedMarker, profileKeys: profileKeys);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConversationConfig');
        if (positional.isEmpty) {
          throw ArgumentError('ConversationConfig: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.ConversationConfig.fromJson(json);
      },
    },
    getters: {
      'maxTurns': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').maxTurns,
      'temperature': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').temperature,
      'historyMode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').historyMode,
      'maxHistoryTokens': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').maxHistoryTokens,
      'modelConfig': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').modelConfig,
      'pauseBetweenTurns': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').pauseBetweenTurns,
      'pauseBeforeFirst': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').pauseBeforeFirst,
      'logConversation': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').logConversation,
      'stripThinkingTags': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').stripThinkingTags,
      'copilotModel': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').copilotModel,
      'conversationLogPath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').conversationLogPath,
      'goalReachedMarker': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').goalReachedMarker,
      'profileKeys': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig').profileKeys,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.ConversationConfig>(target, 'ConversationConfig');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ConversationConfig({required int maxTurns, required double temperature, required HistoryMode historyMode, required int maxHistoryTokens, String? modelConfig, required bool pauseBetweenTurns, required bool pauseBeforeFirst, required bool logConversation, required bool stripThinkingTags, String? copilotModel, required String conversationLogPath, required String goalReachedMarker, required List<String> profileKeys})',
      'fromJson': 'factory ConversationConfig.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'maxTurns': 'int get maxTurns',
      'temperature': 'double get temperature',
      'historyMode': 'HistoryMode get historyMode',
      'maxHistoryTokens': 'int get maxHistoryTokens',
      'modelConfig': 'String? get modelConfig',
      'pauseBetweenTurns': 'bool get pauseBetweenTurns',
      'pauseBeforeFirst': 'bool get pauseBeforeFirst',
      'logConversation': 'bool get logConversation',
      'stripThinkingTags': 'bool get stripThinkingTags',
      'copilotModel': 'String? get copilotModel',
      'conversationLogPath': 'String get conversationLogPath',
      'goalReachedMarker': 'String get goalReachedMarker',
      'profileKeys': 'List<String> get profileKeys',
    },
  );
}

// =============================================================================
// SingleTurnResult Bridge
// =============================================================================

BridgedClass _createSingleTurnResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.SingleTurnResult,
    name: 'SingleTurnResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.SingleTurnResult,
    constructors: {
      '': (visitor, positional, named) {
        final localModelOutput = D4.getRequiredNamedArg<String>(named, 'localModelOutput', 'SingleTurnResult');
        final localModelStats = D4.getOptionalNamedArg<$tom_vscode_scripting_api_10.AiTokenStats?>(named, 'localModelStats');
        final copilotResponse = D4.getOptionalNamedArg<$tom_vscode_scripting_api_9.CopilotResponse?>(named, 'copilotResponse');
        return $tom_vscode_scripting_api_9.SingleTurnResult(localModelOutput: localModelOutput, localModelStats: localModelStats, copilotResponse: copilotResponse);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SingleTurnResult');
        if (positional.isEmpty) {
          throw ArgumentError('SingleTurnResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.SingleTurnResult.fromJson(json);
      },
    },
    getters: {
      'localModelOutput': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.SingleTurnResult>(target, 'SingleTurnResult').localModelOutput,
      'localModelStats': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.SingleTurnResult>(target, 'SingleTurnResult').localModelStats,
      'copilotResponse': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.SingleTurnResult>(target, 'SingleTurnResult').copilotResponse,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.SingleTurnResult>(target, 'SingleTurnResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'SingleTurnResult({required String localModelOutput, AiTokenStats? localModelStats, CopilotResponse? copilotResponse})',
      'fromJson': 'factory SingleTurnResult.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'localModelOutput': 'String get localModelOutput',
      'localModelStats': 'AiTokenStats? get localModelStats',
      'copilotResponse': 'CopilotResponse? get copilotResponse',
    },
  );
}

// =============================================================================
// ConversationActionResult Bridge
// =============================================================================

BridgedClass _createConversationActionResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.ConversationActionResult,
    name: 'ConversationActionResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.ConversationActionResult,
    constructors: {
      '': (visitor, positional, named) {
        final success = D4.getRequiredNamedArg<bool>(named, 'success', 'ConversationActionResult');
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'ConversationActionResult');
        final halted = D4.getOptionalNamedArg<bool?>(named, 'halted');
        return $tom_vscode_scripting_api_9.ConversationActionResult(success: success, message: message, halted: halted);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConversationActionResult');
        if (positional.isEmpty) {
          throw ArgumentError('ConversationActionResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.ConversationActionResult.fromJson(json);
      },
    },
    getters: {
      'success': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationActionResult>(target, 'ConversationActionResult').success,
      'message': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationActionResult>(target, 'ConversationActionResult').message,
      'halted': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationActionResult>(target, 'ConversationActionResult').halted,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.ConversationActionResult>(target, 'ConversationActionResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ConversationActionResult({required bool success, required String message, bool? halted})',
      'fromJson': 'factory ConversationActionResult.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'success': 'bool get success',
      'message': 'String get message',
      'halted': 'bool? get halted',
    },
  );
}

// =============================================================================
// ConversationLog Bridge
// =============================================================================

BridgedClass _createConversationLogBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.ConversationLog,
    name: 'ConversationLog',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.ConversationLog,
    constructors: {
      '': (visitor, positional, named) {
        final found = D4.getRequiredNamedArg<bool>(named, 'found', 'ConversationLog');
        final conversationId = D4.getRequiredNamedArg<String>(named, 'conversationId', 'ConversationLog');
        final logFilePath = D4.getOptionalNamedArg<String?>(named, 'logFilePath');
        final content = D4.getOptionalNamedArg<String?>(named, 'content');
        return $tom_vscode_scripting_api_9.ConversationLog(found: found, conversationId: conversationId, logFilePath: logFilePath, content: content);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ConversationLog');
        if (positional.isEmpty) {
          throw ArgumentError('ConversationLog: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_9.ConversationLog.fromJson(json);
      },
    },
    getters: {
      'found': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationLog>(target, 'ConversationLog').found,
      'conversationId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationLog>(target, 'ConversationLog').conversationId,
      'logFilePath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationLog>(target, 'ConversationLog').logFilePath,
      'content': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_9.ConversationLog>(target, 'ConversationLog').content,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_9.ConversationLog>(target, 'ConversationLog');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ConversationLog({required bool found, required String conversationId, String? logFilePath, String? content})',
      'fromJson': 'factory ConversationLog.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'found': 'bool get found',
      'conversationId': 'String get conversationId',
      'logFilePath': 'String? get logFilePath',
      'content': 'String? get content',
    },
  );
}

// =============================================================================
// AiConversationApi Bridge
// =============================================================================

BridgedClass _createAiConversationApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_9.AiConversationApi,
    name: 'AiConversationApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_9.AiConversationApi,
    constructors: {
    },
    staticMethods: {
      'start': (visitor, positional, named, typeArgs) {
        final goal = D4.getRequiredNamedArg<String>(named, 'goal', 'start');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final profile = D4.getOptionalNamedArg<String?>(named, 'profile');
        final maxTurns = D4.getOptionalNamedArg<int?>(named, 'maxTurns');
        final temperature = D4.getOptionalNamedArg<double?>(named, 'temperature');
        final modelConfig = D4.getOptionalNamedArg<String?>(named, 'modelConfig');
        final historyMode = D4.getOptionalNamedArg<$tom_vscode_scripting_api_9.HistoryMode?>(named, 'historyMode');
        final includeFileContext = D4.coerceListOrNull<String>(named['includeFileContext'], 'includeFileContext');
        final pauseBetweenTurns = D4.getOptionalNamedArg<bool?>(named, 'pauseBetweenTurns');
        final conversationMode = D4.getOptionalNamedArg<$tom_vscode_scripting_api_9.ConversationMode?>(named, 'conversationMode');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 1800);
        return $tom_vscode_scripting_api_9.AiConversationApi.start(goal: goal, description: description, profile: profile, maxTurns: maxTurns, temperature: temperature, modelConfig: modelConfig, historyMode: historyMode, includeFileContext: includeFileContext, pauseBetweenTurns: pauseBetweenTurns, conversationMode: conversationMode, timeoutSeconds: timeoutSeconds);
      },
      'stop': (visitor, positional, named, typeArgs) {
        final reason = D4.getOptionalNamedArg<String?>(named, 'reason');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_9.AiConversationApi.stop(reason: reason, timeoutSeconds: timeoutSeconds);
      },
      'halt': (visitor, positional, named, typeArgs) {
        final reason = D4.getOptionalNamedArg<String?>(named, 'reason');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_9.AiConversationApi.halt(reason: reason, timeoutSeconds: timeoutSeconds);
      },
      'continueConversation': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_9.AiConversationApi.continueConversation(timeoutSeconds: timeoutSeconds);
      },
      'addInfo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addInfo');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'addInfo');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_9.AiConversationApi.addInfo(text, timeoutSeconds: timeoutSeconds);
      },
      'status': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_9.AiConversationApi.status(timeoutSeconds: timeoutSeconds);
      },
      'getLog': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getLog');
        final conversationId = D4.getRequiredArg<String>(positional, 0, 'conversationId', 'getLog');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_9.AiConversationApi.getLog(conversationId, timeoutSeconds: timeoutSeconds);
      },
      'getConfig': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_9.AiConversationApi.getConfig(timeoutSeconds: timeoutSeconds);
      },
      'getProfiles': (visitor, positional, named, typeArgs) {
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 30);
        return $tom_vscode_scripting_api_9.AiConversationApi.getProfiles(timeoutSeconds: timeoutSeconds);
      },
      'singleTurn': (visitor, positional, named, typeArgs) {
        final prompt = D4.getRequiredNamedArg<String>(named, 'prompt', 'singleTurn');
        final systemPrompt = D4.getOptionalNamedArg<String?>(named, 'systemPrompt');
        final modelConfig = D4.getOptionalNamedArg<String?>(named, 'modelConfig');
        final temperature = D4.getOptionalNamedArg<double?>(named, 'temperature');
        final sendToCopilot = D4.getNamedArgWithDefault<bool>(named, 'sendToCopilot', true);
        final copilotSuffix = D4.getOptionalNamedArg<String?>(named, 'copilotSuffix');
        final timeoutSeconds = D4.getNamedArgWithDefault<int>(named, 'timeoutSeconds', 300);
        return $tom_vscode_scripting_api_9.AiConversationApi.singleTurn(prompt: prompt, systemPrompt: systemPrompt, modelConfig: modelConfig, temperature: temperature, sendToCopilot: sendToCopilot, copilotSuffix: copilotSuffix, timeoutSeconds: timeoutSeconds);
      },
    },
    staticMethodSignatures: {
      'start': 'Future<ConversationResult> start({required String goal, String? description, String? profile, int? maxTurns, double? temperature, String? modelConfig, HistoryMode? historyMode, List<String>? includeFileContext, bool? pauseBetweenTurns, ConversationMode? conversationMode, int timeoutSeconds = 1800})',
      'stop': 'Future<ConversationActionResult> stop({String? reason, int timeoutSeconds = 30})',
      'halt': 'Future<ConversationActionResult> halt({String? reason, int timeoutSeconds = 30})',
      'continueConversation': 'Future<ConversationActionResult> continueConversation({int timeoutSeconds = 30})',
      'addInfo': 'Future<ConversationActionResult> addInfo(String text, {int timeoutSeconds = 30})',
      'status': 'Future<ConversationStatus> status({int timeoutSeconds = 30})',
      'getLog': 'Future<ConversationLog> getLog(String conversationId, {int timeoutSeconds = 30})',
      'getConfig': 'Future<ConversationConfig> getConfig({int timeoutSeconds = 30})',
      'getProfiles': 'Future<List<ConversationProfile>> getProfiles({int timeoutSeconds = 30})',
      'singleTurn': 'Future<SingleTurnResult> singleTurn({required String prompt, String? systemPrompt, String? modelConfig, double? temperature, bool sendToCopilot = true, String? copilotSuffix, int timeoutSeconds = 300})',
    },
  );
}

// =============================================================================
// TodoReference Bridge
// =============================================================================

BridgedClass _createTodoReferenceBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_17.TodoReference,
    name: 'TodoReference',
    isAssignable: (v) => v is $tom_vscode_scripting_api_17.TodoReference,
    constructors: {
      '': (visitor, positional, named) {
        final type = D4.getOptionalNamedArg<String?>(named, 'type');
        final path = D4.getOptionalNamedArg<String?>(named, 'path');
        final url = D4.getOptionalNamedArg<String?>(named, 'url');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final lines = D4.getOptionalNamedArg<String?>(named, 'lines');
        return $tom_vscode_scripting_api_17.TodoReference(type: type, path: path, url: url, description: description, lines: lines);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TodoReference');
        if (positional.isEmpty) {
          throw ArgumentError('TodoReference: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_17.TodoReference.fromJson(json);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoReference>(target, 'TodoReference').type,
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoReference>(target, 'TodoReference').path,
      'url': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoReference>(target, 'TodoReference').url,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoReference>(target, 'TodoReference').description,
      'lines': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoReference>(target, 'TodoReference').lines,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_17.TodoReference>(target, 'TodoReference');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TodoReference({String? type, String? path, String? url, String? description, String? lines})',
      'fromJson': 'factory TodoReference.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'type': 'String? get type',
      'path': 'String? get path',
      'url': 'String? get url',
      'description': 'String? get description',
      'lines': 'String? get lines',
    },
  );
}

// =============================================================================
// TodoScope Bridge
// =============================================================================

BridgedClass _createTodoScopeBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_17.TodoScope,
    name: 'TodoScope',
    isAssignable: (v) => v is $tom_vscode_scripting_api_17.TodoScope,
    constructors: {
      '': (visitor, positional, named) {
        final project = D4.getOptionalNamedArg<String?>(named, 'project');
        final projects = D4.coerceListOrNull<String>(named['projects'], 'projects');
        final module = D4.getOptionalNamedArg<String?>(named, 'module');
        final area = D4.getOptionalNamedArg<String?>(named, 'area');
        final files = D4.coerceListOrNull<String>(named['files'], 'files');
        return $tom_vscode_scripting_api_17.TodoScope(project: project, projects: projects, module: module, area: area, files: files);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TodoScope');
        if (positional.isEmpty) {
          throw ArgumentError('TodoScope: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_17.TodoScope.fromJson(json);
      },
    },
    getters: {
      'project': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoScope>(target, 'TodoScope').project,
      'projects': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoScope>(target, 'TodoScope').projects,
      'module': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoScope>(target, 'TodoScope').module,
      'area': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoScope>(target, 'TodoScope').area,
      'files': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoScope>(target, 'TodoScope').files,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_17.TodoScope>(target, 'TodoScope');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TodoScope({String? project, List<String>? projects, String? module, String? area, List<String>? files})',
      'fromJson': 'factory TodoScope.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'project': 'String? get project',
      'projects': 'List<String>? get projects',
      'module': 'String? get module',
      'area': 'String? get area',
      'files': 'List<String>? get files',
    },
  );
}

// =============================================================================
// TodoItem Bridge
// =============================================================================

BridgedClass _createTodoItemBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_17.TodoItem,
    name: 'TodoItem',
    isAssignable: (v) => v is $tom_vscode_scripting_api_17.TodoItem,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'TodoItem');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final description = D4.getRequiredNamedArg<String>(named, 'description', 'TodoItem');
        final status = D4.getRequiredNamedArg<$tom_vscode_scripting_api_17.TodoStatus>(named, 'status', 'TodoItem');
        final priority = D4.getOptionalNamedArg<$tom_vscode_scripting_api_17.TodoPriority?>(named, 'priority');
        final tags = D4.coerceListOrNull<String>(named['tags'], 'tags');
        final scope = D4.getOptionalNamedArg<$tom_vscode_scripting_api_17.TodoScope?>(named, 'scope');
        final references = D4.coerceListOrNull<$tom_vscode_scripting_api_17.TodoReference>(named['references'], 'references');
        final dependencies = D4.coerceListOrNull<String>(named['dependencies'], 'dependencies');
        final blockedBy = D4.coerceListOrNull<String>(named['blockedBy'], 'blockedBy');
        final notes = D4.getOptionalNamedArg<String?>(named, 'notes');
        final created = D4.getOptionalNamedArg<String?>(named, 'created');
        final updated = D4.getOptionalNamedArg<String?>(named, 'updated');
        final completedDate = D4.getOptionalNamedArg<String?>(named, 'completedDate');
        final completedBy = D4.getOptionalNamedArg<String?>(named, 'completedBy');
        final sourceFile = D4.getOptionalNamedArg<String?>(named, 'sourceFile');
        return $tom_vscode_scripting_api_17.TodoItem(id: id, title: title, description: description, status: status, priority: priority, tags: tags, scope: scope, references: references, dependencies: dependencies, blockedBy: blockedBy, notes: notes, created: created, updated: updated, completedDate: completedDate, completedBy: completedBy, sourceFile: sourceFile);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TodoItem');
        if (positional.isEmpty) {
          throw ArgumentError('TodoItem: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_17.TodoItem.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').id,
      'title': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').title,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').description,
      'status': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').status,
      'priority': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').priority,
      'tags': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').tags,
      'scope': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').scope,
      'references': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').references,
      'dependencies': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').dependencies,
      'blockedBy': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').blockedBy,
      'notes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').notes,
      'created': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').created,
      'updated': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').updated,
      'completedDate': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').completedDate,
      'completedBy': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').completedBy,
      'sourceFile': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem').sourceFile,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem');
        return t.toJson();
      },
      'copyWith': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_17.TodoItem>(target, 'TodoItem');
        final id = D4.getOptionalNamedArg<String?>(named, 'id');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final status = D4.getOptionalNamedArg<$tom_vscode_scripting_api_17.TodoStatus?>(named, 'status');
        final priority = D4.getOptionalNamedArg<$tom_vscode_scripting_api_17.TodoPriority?>(named, 'priority');
        final tags = D4.coerceListOrNull<String>(named['tags'], 'tags');
        final scope = D4.getOptionalNamedArg<$tom_vscode_scripting_api_17.TodoScope?>(named, 'scope');
        final references = D4.coerceListOrNull<$tom_vscode_scripting_api_17.TodoReference>(named['references'], 'references');
        final dependencies = D4.coerceListOrNull<String>(named['dependencies'], 'dependencies');
        final blockedBy = D4.coerceListOrNull<String>(named['blockedBy'], 'blockedBy');
        final notes = D4.getOptionalNamedArg<String?>(named, 'notes');
        final created = D4.getOptionalNamedArg<String?>(named, 'created');
        final updated = D4.getOptionalNamedArg<String?>(named, 'updated');
        final completedDate = D4.getOptionalNamedArg<String?>(named, 'completedDate');
        final completedBy = D4.getOptionalNamedArg<String?>(named, 'completedBy');
        final sourceFile = D4.getOptionalNamedArg<String?>(named, 'sourceFile');
        return t.copyWith(id: id, title: title, description: description, status: status, priority: priority, tags: tags, scope: scope, references: references, dependencies: dependencies, blockedBy: blockedBy, notes: notes, created: created, updated: updated, completedDate: completedDate, completedBy: completedBy, sourceFile: sourceFile);
      },
    },
    constructorSignatures: {
      '': 'TodoItem({required String id, String? title, required String description, required TodoStatus status, TodoPriority? priority, List<String>? tags, TodoScope? scope, List<TodoReference>? references, List<String>? dependencies, List<String>? blockedBy, String? notes, String? created, String? updated, String? completedDate, String? completedBy, String? sourceFile})',
      'fromJson': 'factory TodoItem.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'copyWith': 'TodoItem copyWith({String? id, String? title, String? description, TodoStatus? status, TodoPriority? priority, List<String>? tags, TodoScope? scope, List<TodoReference>? references, List<String>? dependencies, List<String>? blockedBy, String? notes, String? created, String? updated, String? completedDate, String? completedBy, String? sourceFile})',
    },
    getterSignatures: {
      'id': 'String get id',
      'title': 'String? get title',
      'description': 'String get description',
      'status': 'TodoStatus get status',
      'priority': 'TodoPriority? get priority',
      'tags': 'List<String>? get tags',
      'scope': 'TodoScope? get scope',
      'references': 'List<TodoReference>? get references',
      'dependencies': 'List<String>? get dependencies',
      'blockedBy': 'List<String>? get blockedBy',
      'notes': 'String? get notes',
      'created': 'String? get created',
      'updated': 'String? get updated',
      'completedDate': 'String? get completedDate',
      'completedBy': 'String? get completedBy',
      'sourceFile': 'String? get sourceFile',
    },
  );
}

// =============================================================================
// TodoListResult Bridge
// =============================================================================

BridgedClass _createTodoListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_17.TodoListResult,
    name: 'TodoListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_17.TodoListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('todos') || named['todos'] == null) {
          throw ArgumentError('TodoListResult: Missing required named argument "todos"');
        }
        final todos = D4.coerceList<$tom_vscode_scripting_api_17.TodoItem>(named['todos'], 'todos');
        final questId = D4.getOptionalNamedArg<String?>(named, 'questId');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TodoListResult(todos: todos, questId: questId, file: file);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TodoListResult');
        if (positional.isEmpty) {
          throw ArgumentError('TodoListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_17.TodoListResult.fromJson(json);
      },
    },
    getters: {
      'todos': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoListResult>(target, 'TodoListResult').todos,
      'questId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoListResult>(target, 'TodoListResult').questId,
      'file': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoListResult>(target, 'TodoListResult').file,
    },
    constructorSignatures: {
      '': 'TodoListResult({required List<TodoItem> todos, String? questId, String? file})',
      'fromJson': 'factory TodoListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'todos': 'List<TodoItem> get todos',
      'questId': 'String? get questId',
      'file': 'String? get file',
    },
  );
}

// =============================================================================
// TodoFileListResult Bridge
// =============================================================================

BridgedClass _createTodoFileListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_17.TodoFileListResult,
    name: 'TodoFileListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_17.TodoFileListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('files') || named['files'] == null) {
          throw ArgumentError('TodoFileListResult: Missing required named argument "files"');
        }
        final files = D4.coerceList<String>(named['files'], 'files');
        final questId = D4.getOptionalNamedArg<String?>(named, 'questId');
        return $tom_vscode_scripting_api_17.TodoFileListResult(files: files, questId: questId);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TodoFileListResult');
        if (positional.isEmpty) {
          throw ArgumentError('TodoFileListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_17.TodoFileListResult.fromJson(json);
      },
    },
    getters: {
      'files': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoFileListResult>(target, 'TodoFileListResult').files,
      'questId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_17.TodoFileListResult>(target, 'TodoFileListResult').questId,
    },
    constructorSignatures: {
      '': 'TodoFileListResult({required List<String> files, String? questId})',
      'fromJson': 'factory TodoFileListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'files': 'List<String> get files',
      'questId': 'String? get questId',
    },
  );
}

// =============================================================================
// TomTodoApi Bridge
// =============================================================================

BridgedClass _createTomTodoApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_17.TomTodoApi,
    name: 'TomTodoApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_17.TomTodoApi,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'setAdapter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAdapter');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'setAdapter');
        return $tom_vscode_scripting_api_17.TomTodoApi.setAdapter(adapter);
      },
      'listQuestTodoFiles': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'listQuestTodoFiles');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'listQuestTodoFiles');
        return $tom_vscode_scripting_api_17.TomTodoApi.listQuestTodoFiles(questId);
      },
      'listQuestTodos': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'listQuestTodos');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'listQuestTodos');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.listQuestTodos(questId, file: file);
      },
      'getQuestTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'getQuestTodo');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'getQuestTodo');
        final todoId = D4.getRequiredArg<String>(positional, 1, 'todoId', 'getQuestTodo');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.getQuestTodo(questId, todoId, file: file);
      },
      'createQuestTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'createQuestTodo');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'createQuestTodo');
        final todo = D4.getRequiredArg<$tom_vscode_scripting_api_17.TodoItem>(positional, 1, 'todo', 'createQuestTodo');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.createQuestTodo(questId, todo, file: file);
      },
      'updateQuestTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'updateQuestTodo');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'updateQuestTodo');
        final todo = D4.getRequiredArg<$tom_vscode_scripting_api_17.TodoItem>(positional, 1, 'todo', 'updateQuestTodo');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.updateQuestTodo(questId, todo, file: file);
      },
      'deleteQuestTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'deleteQuestTodo');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'deleteQuestTodo');
        final todoId = D4.getRequiredArg<String>(positional, 1, 'todoId', 'deleteQuestTodo');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.deleteQuestTodo(questId, todoId, file: file);
      },
      'listWorkspaceTodoFiles': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_17.TomTodoApi.listWorkspaceTodoFiles();
      },
      'listWorkspaceTodos': (visitor, positional, named, typeArgs) {
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.listWorkspaceTodos(file: file);
      },
      'getWorkspaceTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getWorkspaceTodo');
        final todoId = D4.getRequiredArg<String>(positional, 0, 'todoId', 'getWorkspaceTodo');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.getWorkspaceTodo(todoId, file: file);
      },
      'createWorkspaceTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createWorkspaceTodo');
        final todo = D4.getRequiredArg<$tom_vscode_scripting_api_17.TodoItem>(positional, 0, 'todo', 'createWorkspaceTodo');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.createWorkspaceTodo(todo, file: file);
      },
      'updateWorkspaceTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'updateWorkspaceTodo');
        final todo = D4.getRequiredArg<$tom_vscode_scripting_api_17.TodoItem>(positional, 0, 'todo', 'updateWorkspaceTodo');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.updateWorkspaceTodo(todo, file: file);
      },
      'deleteWorkspaceTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'deleteWorkspaceTodo');
        final todoId = D4.getRequiredArg<String>(positional, 0, 'todoId', 'deleteWorkspaceTodo');
        final file = D4.getOptionalNamedArg<String?>(named, 'file');
        return $tom_vscode_scripting_api_17.TomTodoApi.deleteWorkspaceTodo(todoId, file: file);
      },
      'listSessionTodos': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_17.TomTodoApi.listSessionTodos();
      },
      'getSessionTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getSessionTodo');
        final todoId = D4.getRequiredArg<String>(positional, 0, 'todoId', 'getSessionTodo');
        return $tom_vscode_scripting_api_17.TomTodoApi.getSessionTodo(todoId);
      },
      'createSessionTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createSessionTodo');
        final todo = D4.getRequiredArg<$tom_vscode_scripting_api_17.TodoItem>(positional, 0, 'todo', 'createSessionTodo');
        return $tom_vscode_scripting_api_17.TomTodoApi.createSessionTodo(todo);
      },
      'updateSessionTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'updateSessionTodo');
        final todo = D4.getRequiredArg<$tom_vscode_scripting_api_17.TodoItem>(positional, 0, 'todo', 'updateSessionTodo');
        return $tom_vscode_scripting_api_17.TomTodoApi.updateSessionTodo(todo);
      },
      'deleteSessionTodo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'deleteSessionTodo');
        final todoId = D4.getRequiredArg<String>(positional, 0, 'todoId', 'deleteSessionTodo');
        return $tom_vscode_scripting_api_17.TomTodoApi.deleteSessionTodo(todoId);
      },
      'listAllTodos': (visitor, positional, named, typeArgs) {
        final includeQuest = D4.getNamedArgWithDefault<bool>(named, 'includeQuest', true);
        final includeWorkspace = D4.getNamedArgWithDefault<bool>(named, 'includeWorkspace', true);
        final includeSession = D4.getNamedArgWithDefault<bool>(named, 'includeSession', true);
        final questId = D4.getOptionalNamedArg<String?>(named, 'questId');
        return $tom_vscode_scripting_api_17.TomTodoApi.listAllTodos(includeQuest: includeQuest, includeWorkspace: includeWorkspace, includeSession: includeSession, questId: questId);
      },
    },
    staticMethodSignatures: {
      'setAdapter': 'void setAdapter(VSCodeAdapter adapter)',
      'listQuestTodoFiles': 'Future<TodoFileListResult> listQuestTodoFiles(String questId)',
      'listQuestTodos': 'Future<TodoListResult> listQuestTodos(String questId, {String? file})',
      'getQuestTodo': 'Future<TodoItem?> getQuestTodo(String questId, String todoId, {String? file})',
      'createQuestTodo': 'Future<TodoItem> createQuestTodo(String questId, TodoItem todo, {String? file})',
      'updateQuestTodo': 'Future<TodoItem> updateQuestTodo(String questId, TodoItem todo, {String? file})',
      'deleteQuestTodo': 'Future<bool> deleteQuestTodo(String questId, String todoId, {String? file})',
      'listWorkspaceTodoFiles': 'Future<TodoFileListResult> listWorkspaceTodoFiles()',
      'listWorkspaceTodos': 'Future<TodoListResult> listWorkspaceTodos({String? file})',
      'getWorkspaceTodo': 'Future<TodoItem?> getWorkspaceTodo(String todoId, {String? file})',
      'createWorkspaceTodo': 'Future<TodoItem> createWorkspaceTodo(TodoItem todo, {String? file})',
      'updateWorkspaceTodo': 'Future<TodoItem> updateWorkspaceTodo(TodoItem todo, {String? file})',
      'deleteWorkspaceTodo': 'Future<bool> deleteWorkspaceTodo(String todoId, {String? file})',
      'listSessionTodos': 'Future<TodoListResult> listSessionTodos()',
      'getSessionTodo': 'Future<TodoItem?> getSessionTodo(String todoId)',
      'createSessionTodo': 'Future<TodoItem> createSessionTodo(TodoItem todo)',
      'updateSessionTodo': 'Future<TodoItem> updateSessionTodo(TodoItem todo)',
      'deleteSessionTodo': 'Future<bool> deleteSessionTodo(String todoId)',
      'listAllTodos': 'Future<TodoListResult> listAllTodos({bool includeQuest = true, bool includeWorkspace = true, bool includeSession = true, String? questId})',
    },
  );
}

// =============================================================================
// QueuedFollowUp Bridge
// =============================================================================

BridgedClass _createQueuedFollowUpBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_15.QueuedFollowUp,
    name: 'QueuedFollowUp',
    isAssignable: (v) => v is $tom_vscode_scripting_api_15.QueuedFollowUp,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'QueuedFollowUp');
        final originalText = D4.getRequiredNamedArg<String>(named, 'originalText', 'QueuedFollowUp');
        final template = D4.getOptionalNamedArg<String?>(named, 'template');
        final reminderTemplateId = D4.getOptionalNamedArg<String?>(named, 'reminderTemplateId');
        final reminderTimeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'reminderTimeoutMinutes');
        final reminderRepeat = D4.getOptionalNamedArg<bool?>(named, 'reminderRepeat');
        final reminderEnabled = D4.getOptionalNamedArg<bool?>(named, 'reminderEnabled');
        final createdAt = D4.getRequiredNamedArg<String>(named, 'createdAt', 'QueuedFollowUp');
        return $tom_vscode_scripting_api_15.QueuedFollowUp(id: id, originalText: originalText, template: template, reminderTemplateId: reminderTemplateId, reminderTimeoutMinutes: reminderTimeoutMinutes, reminderRepeat: reminderRepeat, reminderEnabled: reminderEnabled, createdAt: createdAt);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'QueuedFollowUp');
        if (positional.isEmpty) {
          throw ArgumentError('QueuedFollowUp: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_15.QueuedFollowUp.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp').id,
      'originalText': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp').originalText,
      'template': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp').template,
      'reminderTemplateId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp').reminderTemplateId,
      'reminderTimeoutMinutes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp').reminderTimeoutMinutes,
      'reminderRepeat': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp').reminderRepeat,
      'reminderEnabled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp').reminderEnabled,
      'createdAt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp').createdAt,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_15.QueuedFollowUp>(target, 'QueuedFollowUp');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'QueuedFollowUp({required String id, required String originalText, String? template, String? reminderTemplateId, int? reminderTimeoutMinutes, bool? reminderRepeat, bool? reminderEnabled, required String createdAt})',
      'fromJson': 'factory QueuedFollowUp.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'originalText': 'String get originalText',
      'template': 'String? get template',
      'reminderTemplateId': 'String? get reminderTemplateId',
      'reminderTimeoutMinutes': 'int? get reminderTimeoutMinutes',
      'reminderRepeat': 'bool? get reminderRepeat',
      'reminderEnabled': 'bool? get reminderEnabled',
      'createdAt': 'String get createdAt',
    },
  );
}

// =============================================================================
// QueuedPrompt Bridge
// =============================================================================

BridgedClass _createQueuedPromptBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_15.QueuedPrompt,
    name: 'QueuedPrompt',
    isAssignable: (v) => v is $tom_vscode_scripting_api_15.QueuedPrompt,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'QueuedPrompt');
        final template = D4.getRequiredNamedArg<String>(named, 'template', 'QueuedPrompt');
        final answerWrapper = D4.getOptionalNamedArg<bool?>(named, 'answerWrapper');
        final originalText = D4.getRequiredNamedArg<String>(named, 'originalText', 'QueuedPrompt');
        final expandedText = D4.getRequiredNamedArg<String>(named, 'expandedText', 'QueuedPrompt');
        final status = D4.getRequiredNamedArg<$tom_vscode_scripting_api_15.QueuedPromptStatus>(named, 'status', 'QueuedPrompt');
        final type = D4.getRequiredNamedArg<$tom_vscode_scripting_api_15.QueuedPromptType>(named, 'type', 'QueuedPrompt');
        final createdAt = D4.getRequiredNamedArg<String>(named, 'createdAt', 'QueuedPrompt');
        final sentAt = D4.getOptionalNamedArg<String?>(named, 'sentAt');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final reminderTemplateId = D4.getOptionalNamedArg<String?>(named, 'reminderTemplateId');
        final reminderTimeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'reminderTimeoutMinutes');
        final reminderRepeat = D4.getOptionalNamedArg<bool?>(named, 'reminderRepeat');
        final reminderEnabled = D4.getOptionalNamedArg<bool?>(named, 'reminderEnabled');
        final reminderQueued = D4.getOptionalNamedArg<bool?>(named, 'reminderQueued');
        final reminderSentCount = D4.getOptionalNamedArg<int?>(named, 'reminderSentCount');
        final lastReminderAt = D4.getOptionalNamedArg<String?>(named, 'lastReminderAt');
        final requestId = D4.getOptionalNamedArg<String?>(named, 'requestId');
        final expectedRequestId = D4.getOptionalNamedArg<String?>(named, 'expectedRequestId');
        final followUps = D4.coerceListOrNull<$tom_vscode_scripting_api_15.QueuedFollowUp>(named['followUps'], 'followUps');
        final followUpIndex = D4.getOptionalNamedArg<int?>(named, 'followUpIndex');
        return $tom_vscode_scripting_api_15.QueuedPrompt(id: id, template: template, answerWrapper: answerWrapper, originalText: originalText, expandedText: expandedText, status: status, type: type, createdAt: createdAt, sentAt: sentAt, error: error, reminderTemplateId: reminderTemplateId, reminderTimeoutMinutes: reminderTimeoutMinutes, reminderRepeat: reminderRepeat, reminderEnabled: reminderEnabled, reminderQueued: reminderQueued, reminderSentCount: reminderSentCount, lastReminderAt: lastReminderAt, requestId: requestId, expectedRequestId: expectedRequestId, followUps: followUps, followUpIndex: followUpIndex);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'QueuedPrompt');
        if (positional.isEmpty) {
          throw ArgumentError('QueuedPrompt: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_15.QueuedPrompt.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').id,
      'template': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').template,
      'answerWrapper': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').answerWrapper,
      'originalText': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').originalText,
      'expandedText': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').expandedText,
      'status': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').status,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').type,
      'createdAt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').createdAt,
      'sentAt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').sentAt,
      'error': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').error,
      'reminderTemplateId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').reminderTemplateId,
      'reminderTimeoutMinutes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').reminderTimeoutMinutes,
      'reminderRepeat': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').reminderRepeat,
      'reminderEnabled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').reminderEnabled,
      'reminderQueued': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').reminderQueued,
      'reminderSentCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').reminderSentCount,
      'lastReminderAt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').lastReminderAt,
      'requestId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').requestId,
      'expectedRequestId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').expectedRequestId,
      'followUps': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').followUps,
      'followUpIndex': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt').followUpIndex,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_15.QueuedPrompt>(target, 'QueuedPrompt');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'QueuedPrompt({required String id, required String template, bool? answerWrapper, required String originalText, required String expandedText, required QueuedPromptStatus status, required QueuedPromptType type, required String createdAt, String? sentAt, String? error, String? reminderTemplateId, int? reminderTimeoutMinutes, bool? reminderRepeat, bool? reminderEnabled, bool? reminderQueued, int? reminderSentCount, String? lastReminderAt, String? requestId, String? expectedRequestId, List<QueuedFollowUp>? followUps, int? followUpIndex})',
      'fromJson': 'factory QueuedPrompt.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'template': 'String get template',
      'answerWrapper': 'bool? get answerWrapper',
      'originalText': 'String get originalText',
      'expandedText': 'String get expandedText',
      'status': 'QueuedPromptStatus get status',
      'type': 'QueuedPromptType get type',
      'createdAt': 'String get createdAt',
      'sentAt': 'String? get sentAt',
      'error': 'String? get error',
      'reminderTemplateId': 'String? get reminderTemplateId',
      'reminderTimeoutMinutes': 'int? get reminderTimeoutMinutes',
      'reminderRepeat': 'bool? get reminderRepeat',
      'reminderEnabled': 'bool? get reminderEnabled',
      'reminderQueued': 'bool? get reminderQueued',
      'reminderSentCount': 'int? get reminderSentCount',
      'lastReminderAt': 'String? get lastReminderAt',
      'requestId': 'String? get requestId',
      'expectedRequestId': 'String? get expectedRequestId',
      'followUps': 'List<QueuedFollowUp>? get followUps',
      'followUpIndex': 'int? get followUpIndex',
    },
  );
}

// =============================================================================
// QueueListResult Bridge
// =============================================================================

BridgedClass _createQueueListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_15.QueueListResult,
    name: 'QueueListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_15.QueueListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('items') || named['items'] == null) {
          throw ArgumentError('QueueListResult: Missing required named argument "items"');
        }
        final items = D4.coerceList<$tom_vscode_scripting_api_15.QueuedPrompt>(named['items'], 'items');
        final totalCount = D4.getRequiredNamedArg<int>(named, 'totalCount', 'QueueListResult');
        final pendingCount = D4.getRequiredNamedArg<int>(named, 'pendingCount', 'QueueListResult');
        final sentCount = D4.getRequiredNamedArg<int>(named, 'sentCount', 'QueueListResult');
        return $tom_vscode_scripting_api_15.QueueListResult(items: items, totalCount: totalCount, pendingCount: pendingCount, sentCount: sentCount);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'QueueListResult');
        if (positional.isEmpty) {
          throw ArgumentError('QueueListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_15.QueueListResult.fromJson(json);
      },
    },
    getters: {
      'items': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueListResult>(target, 'QueueListResult').items,
      'totalCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueListResult>(target, 'QueueListResult').totalCount,
      'pendingCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueListResult>(target, 'QueueListResult').pendingCount,
      'sentCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueListResult>(target, 'QueueListResult').sentCount,
    },
    constructorSignatures: {
      '': 'QueueListResult({required List<QueuedPrompt> items, required int totalCount, required int pendingCount, required int sentCount})',
      'fromJson': 'factory QueueListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'items': 'List<QueuedPrompt> get items',
      'totalCount': 'int get totalCount',
      'pendingCount': 'int get pendingCount',
      'sentCount': 'int get sentCount',
    },
  );
}

// =============================================================================
// QueueItemInput Bridge
// =============================================================================

BridgedClass _createQueueItemInputBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_15.QueueItemInput,
    name: 'QueueItemInput',
    isAssignable: (v) => v is $tom_vscode_scripting_api_15.QueueItemInput,
    constructors: {
      '': (visitor, positional, named) {
        final promptText = D4.getRequiredNamedArg<String>(named, 'promptText', 'QueueItemInput');
        final template = D4.getOptionalNamedArg<String?>(named, 'template');
        final answerWrapper = D4.getOptionalNamedArg<bool?>(named, 'answerWrapper');
        final reminderEnabled = D4.getOptionalNamedArg<bool?>(named, 'reminderEnabled');
        final reminderTemplateId = D4.getOptionalNamedArg<String?>(named, 'reminderTemplateId');
        final reminderTimeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'reminderTimeoutMinutes');
        final reminderRepeat = D4.getOptionalNamedArg<bool?>(named, 'reminderRepeat');
        return $tom_vscode_scripting_api_15.QueueItemInput(promptText: promptText, template: template, answerWrapper: answerWrapper, reminderEnabled: reminderEnabled, reminderTemplateId: reminderTemplateId, reminderTimeoutMinutes: reminderTimeoutMinutes, reminderRepeat: reminderRepeat);
      },
    },
    getters: {
      'promptText': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueItemInput>(target, 'QueueItemInput').promptText,
      'template': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueItemInput>(target, 'QueueItemInput').template,
      'answerWrapper': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueItemInput>(target, 'QueueItemInput').answerWrapper,
      'reminderEnabled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueItemInput>(target, 'QueueItemInput').reminderEnabled,
      'reminderTemplateId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueItemInput>(target, 'QueueItemInput').reminderTemplateId,
      'reminderTimeoutMinutes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueItemInput>(target, 'QueueItemInput').reminderTimeoutMinutes,
      'reminderRepeat': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.QueueItemInput>(target, 'QueueItemInput').reminderRepeat,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_15.QueueItemInput>(target, 'QueueItemInput');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'QueueItemInput({required String promptText, String? template, bool? answerWrapper, bool? reminderEnabled, String? reminderTemplateId, int? reminderTimeoutMinutes, bool? reminderRepeat})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'promptText': 'String get promptText',
      'template': 'String? get template',
      'answerWrapper': 'bool? get answerWrapper',
      'reminderEnabled': 'bool? get reminderEnabled',
      'reminderTemplateId': 'String? get reminderTemplateId',
      'reminderTimeoutMinutes': 'int? get reminderTimeoutMinutes',
      'reminderRepeat': 'bool? get reminderRepeat',
    },
  );
}

// =============================================================================
// FollowUpInput Bridge
// =============================================================================

BridgedClass _createFollowUpInputBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_15.FollowUpInput,
    name: 'FollowUpInput',
    isAssignable: (v) => v is $tom_vscode_scripting_api_15.FollowUpInput,
    constructors: {
      '': (visitor, positional, named) {
        final promptText = D4.getRequiredNamedArg<String>(named, 'promptText', 'FollowUpInput');
        final template = D4.getOptionalNamedArg<String?>(named, 'template');
        final reminderEnabled = D4.getOptionalNamedArg<bool?>(named, 'reminderEnabled');
        final reminderTemplateId = D4.getOptionalNamedArg<String?>(named, 'reminderTemplateId');
        final reminderTimeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'reminderTimeoutMinutes');
        final reminderRepeat = D4.getOptionalNamedArg<bool?>(named, 'reminderRepeat');
        return $tom_vscode_scripting_api_15.FollowUpInput(promptText: promptText, template: template, reminderEnabled: reminderEnabled, reminderTemplateId: reminderTemplateId, reminderTimeoutMinutes: reminderTimeoutMinutes, reminderRepeat: reminderRepeat);
      },
    },
    getters: {
      'promptText': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.FollowUpInput>(target, 'FollowUpInput').promptText,
      'template': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.FollowUpInput>(target, 'FollowUpInput').template,
      'reminderEnabled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.FollowUpInput>(target, 'FollowUpInput').reminderEnabled,
      'reminderTemplateId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.FollowUpInput>(target, 'FollowUpInput').reminderTemplateId,
      'reminderTimeoutMinutes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.FollowUpInput>(target, 'FollowUpInput').reminderTimeoutMinutes,
      'reminderRepeat': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_15.FollowUpInput>(target, 'FollowUpInput').reminderRepeat,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_15.FollowUpInput>(target, 'FollowUpInput');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'FollowUpInput({required String promptText, String? template, bool? reminderEnabled, String? reminderTemplateId, int? reminderTimeoutMinutes, bool? reminderRepeat})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'promptText': 'String get promptText',
      'template': 'String? get template',
      'reminderEnabled': 'bool? get reminderEnabled',
      'reminderTemplateId': 'String? get reminderTemplateId',
      'reminderTimeoutMinutes': 'int? get reminderTimeoutMinutes',
      'reminderRepeat': 'bool? get reminderRepeat',
    },
  );
}

// =============================================================================
// TomQueueApi Bridge
// =============================================================================

BridgedClass _createTomQueueApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_15.TomQueueApi,
    name: 'TomQueueApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_15.TomQueueApi,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'setAdapter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAdapter');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'setAdapter');
        return $tom_vscode_scripting_api_15.TomQueueApi.setAdapter(adapter);
      },
      'list': (visitor, positional, named, typeArgs) {
        final includeSent = D4.getNamedArgWithDefault<bool>(named, 'includeSent', false);
        final limit = D4.getOptionalNamedArg<int?>(named, 'limit');
        return $tom_vscode_scripting_api_15.TomQueueApi.list(includeSent: includeSent, limit: limit);
      },
      'get': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'get');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'get');
        return $tom_vscode_scripting_api_15.TomQueueApi.get(itemId);
      },
      'add': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'add');
        final input = D4.getRequiredArg<$tom_vscode_scripting_api_15.QueueItemInput>(positional, 0, 'input', 'add');
        return $tom_vscode_scripting_api_15.TomQueueApi.add(input);
      },
      'remove': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'remove');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'remove');
        return $tom_vscode_scripting_api_15.TomQueueApi.remove(itemId);
      },
      'clearPending': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_15.TomQueueApi.clearPending();
      },
      'clearSent': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_15.TomQueueApi.clearSent();
      },
      'updateStatus': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'updateStatus');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'updateStatus');
        final status = D4.getRequiredArg<$tom_vscode_scripting_api_15.QueuedPromptStatus>(positional, 1, 'status', 'updateStatus');
        return $tom_vscode_scripting_api_15.TomQueueApi.updateStatus(itemId, status);
      },
      'updateText': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'updateText');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'updateText');
        final text = D4.getRequiredArg<String>(positional, 1, 'text', 'updateText');
        return $tom_vscode_scripting_api_15.TomQueueApi.updateText(itemId, text);
      },
      'updateReminder': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'updateReminder');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'updateReminder');
        final enabled = D4.getOptionalNamedArg<bool?>(named, 'enabled');
        final templateId = D4.getOptionalNamedArg<String?>(named, 'templateId');
        final timeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'timeoutMinutes');
        final repeat = D4.getOptionalNamedArg<bool?>(named, 'repeat');
        return $tom_vscode_scripting_api_15.TomQueueApi.updateReminder(itemId, enabled: enabled, templateId: templateId, timeoutMinutes: timeoutMinutes, repeat: repeat);
      },
      'moveTo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'moveTo');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'moveTo');
        final newIndex = D4.getRequiredArg<int>(positional, 1, 'newIndex', 'moveTo');
        return $tom_vscode_scripting_api_15.TomQueueApi.moveTo(itemId, newIndex);
      },
      'moveUp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'moveUp');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'moveUp');
        return $tom_vscode_scripting_api_15.TomQueueApi.moveUp(itemId);
      },
      'moveDown': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'moveDown');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'moveDown');
        return $tom_vscode_scripting_api_15.TomQueueApi.moveDown(itemId);
      },
      'addFollowUp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'addFollowUp');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'addFollowUp');
        final input = D4.getRequiredArg<$tom_vscode_scripting_api_15.FollowUpInput>(positional, 1, 'input', 'addFollowUp');
        return $tom_vscode_scripting_api_15.TomQueueApi.addFollowUp(itemId, input);
      },
      'removeFollowUp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'removeFollowUp');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'removeFollowUp');
        final followUpId = D4.getRequiredArg<String>(positional, 1, 'followUpId', 'removeFollowUp');
        return $tom_vscode_scripting_api_15.TomQueueApi.removeFollowUp(itemId, followUpId);
      },
      'updateFollowUp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'updateFollowUp');
        final itemId = D4.getRequiredArg<String>(positional, 0, 'itemId', 'updateFollowUp');
        final followUpId = D4.getRequiredArg<String>(positional, 1, 'followUpId', 'updateFollowUp');
        final text = D4.getOptionalNamedArg<String?>(named, 'text');
        final template = D4.getOptionalNamedArg<String?>(named, 'template');
        final reminderEnabled = D4.getOptionalNamedArg<bool?>(named, 'reminderEnabled');
        final reminderTemplateId = D4.getOptionalNamedArg<String?>(named, 'reminderTemplateId');
        final reminderTimeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'reminderTimeoutMinutes');
        final reminderRepeat = D4.getOptionalNamedArg<bool?>(named, 'reminderRepeat');
        return $tom_vscode_scripting_api_15.TomQueueApi.updateFollowUp(itemId, followUpId, text: text, template: template, reminderEnabled: reminderEnabled, reminderTemplateId: reminderTemplateId, reminderTimeoutMinutes: reminderTimeoutMinutes, reminderRepeat: reminderRepeat);
      },
      'sendNext': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_15.TomQueueApi.sendNext();
      },
      'pause': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_15.TomQueueApi.pause();
      },
      'resume': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_15.TomQueueApi.resume();
      },
      'isPaused': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_15.TomQueueApi.isPaused();
      },
    },
    staticMethodSignatures: {
      'setAdapter': 'void setAdapter(VSCodeAdapter adapter)',
      'list': 'Future<QueueListResult> list({bool includeSent = false, int? limit})',
      'get': 'Future<QueuedPrompt?> get(String itemId)',
      'add': 'Future<QueuedPrompt> add(QueueItemInput input)',
      'remove': 'Future<bool> remove(String itemId)',
      'clearPending': 'Future<int> clearPending()',
      'clearSent': 'Future<int> clearSent()',
      'updateStatus': 'Future<QueuedPrompt> updateStatus(String itemId, QueuedPromptStatus status)',
      'updateText': 'Future<QueuedPrompt> updateText(String itemId, String text)',
      'updateReminder': 'Future<QueuedPrompt> updateReminder(String itemId, {bool? enabled, String? templateId, int? timeoutMinutes, bool? repeat})',
      'moveTo': 'Future<bool> moveTo(String itemId, int newIndex)',
      'moveUp': 'Future<bool> moveUp(String itemId)',
      'moveDown': 'Future<bool> moveDown(String itemId)',
      'addFollowUp': 'Future<QueuedFollowUp> addFollowUp(String itemId, FollowUpInput input)',
      'removeFollowUp': 'Future<bool> removeFollowUp(String itemId, String followUpId)',
      'updateFollowUp': 'Future<QueuedFollowUp> updateFollowUp(String itemId, String followUpId, {String? text, String? template, bool? reminderEnabled, String? reminderTemplateId, int? reminderTimeoutMinutes, bool? reminderRepeat})',
      'sendNext': 'Future<bool> sendNext()',
      'pause': 'Future<void> pause()',
      'resume': 'Future<void> resume()',
      'isPaused': 'Future<bool> isPaused()',
    },
  );
}

// =============================================================================
// ScheduledTime Bridge
// =============================================================================

BridgedClass _createScheduledTimeBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_16.ScheduledTime,
    name: 'ScheduledTime',
    isAssignable: (v) => v is $tom_vscode_scripting_api_16.ScheduledTime,
    constructors: {
      '': (visitor, positional, named) {
        final time = D4.getRequiredNamedArg<String>(named, 'time', 'ScheduledTime');
        final date = D4.getOptionalNamedArg<String?>(named, 'date');
        return $tom_vscode_scripting_api_16.ScheduledTime(time: time, date: date);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ScheduledTime');
        if (positional.isEmpty) {
          throw ArgumentError('ScheduledTime: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_16.ScheduledTime.fromJson(json);
      },
    },
    getters: {
      'time': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.ScheduledTime>(target, 'ScheduledTime').time,
      'date': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.ScheduledTime>(target, 'ScheduledTime').date,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_16.ScheduledTime>(target, 'ScheduledTime');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ScheduledTime({required String time, String? date})',
      'fromJson': 'factory ScheduledTime.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'time': 'String get time',
      'date': 'String? get date',
    },
  );
}

// =============================================================================
// TimedRequest Bridge
// =============================================================================

BridgedClass _createTimedRequestBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_16.TimedRequest,
    name: 'TimedRequest',
    isAssignable: (v) => v is $tom_vscode_scripting_api_16.TimedRequest,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'TimedRequest');
        final enabled = D4.getRequiredNamedArg<bool>(named, 'enabled', 'TimedRequest');
        final template = D4.getRequiredNamedArg<String>(named, 'template', 'TimedRequest');
        final answerWrapper = D4.getOptionalNamedArg<bool?>(named, 'answerWrapper');
        final originalText = D4.getRequiredNamedArg<String>(named, 'originalText', 'TimedRequest');
        final scheduleMode = D4.getRequiredNamedArg<$tom_vscode_scripting_api_16.ScheduleMode>(named, 'scheduleMode', 'TimedRequest');
        final intervalMinutes = D4.getOptionalNamedArg<int?>(named, 'intervalMinutes');
        final scheduledTimes = D4.coerceListOrNull<$tom_vscode_scripting_api_16.ScheduledTime>(named['scheduledTimes'], 'scheduledTimes');
        final reminderEnabled = D4.getOptionalNamedArg<bool?>(named, 'reminderEnabled');
        final reminderTemplateId = D4.getOptionalNamedArg<String?>(named, 'reminderTemplateId');
        final reminderTimeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'reminderTimeoutMinutes');
        final reminderRepeat = D4.getOptionalNamedArg<bool?>(named, 'reminderRepeat');
        final lastSentAt = D4.getOptionalNamedArg<String?>(named, 'lastSentAt');
        final status = D4.getRequiredNamedArg<$tom_vscode_scripting_api_16.TimedRequestStatus>(named, 'status', 'TimedRequest');
        return $tom_vscode_scripting_api_16.TimedRequest(id: id, enabled: enabled, template: template, answerWrapper: answerWrapper, originalText: originalText, scheduleMode: scheduleMode, intervalMinutes: intervalMinutes, scheduledTimes: scheduledTimes, reminderEnabled: reminderEnabled, reminderTemplateId: reminderTemplateId, reminderTimeoutMinutes: reminderTimeoutMinutes, reminderRepeat: reminderRepeat, lastSentAt: lastSentAt, status: status);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TimedRequest');
        if (positional.isEmpty) {
          throw ArgumentError('TimedRequest: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_16.TimedRequest.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').id,
      'enabled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').enabled,
      'template': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').template,
      'answerWrapper': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').answerWrapper,
      'originalText': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').originalText,
      'scheduleMode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').scheduleMode,
      'intervalMinutes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').intervalMinutes,
      'scheduledTimes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').scheduledTimes,
      'reminderEnabled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').reminderEnabled,
      'reminderTemplateId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').reminderTemplateId,
      'reminderTimeoutMinutes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').reminderTimeoutMinutes,
      'reminderRepeat': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').reminderRepeat,
      'lastSentAt': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').lastSentAt,
      'status': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest').status,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequest>(target, 'TimedRequest');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TimedRequest({required String id, required bool enabled, required String template, bool? answerWrapper, required String originalText, required ScheduleMode scheduleMode, int? intervalMinutes, List<ScheduledTime>? scheduledTimes, bool? reminderEnabled, String? reminderTemplateId, int? reminderTimeoutMinutes, bool? reminderRepeat, String? lastSentAt, required TimedRequestStatus status})',
      'fromJson': 'factory TimedRequest.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'id': 'String get id',
      'enabled': 'bool get enabled',
      'template': 'String get template',
      'answerWrapper': 'bool? get answerWrapper',
      'originalText': 'String get originalText',
      'scheduleMode': 'ScheduleMode get scheduleMode',
      'intervalMinutes': 'int? get intervalMinutes',
      'scheduledTimes': 'List<ScheduledTime>? get scheduledTimes',
      'reminderEnabled': 'bool? get reminderEnabled',
      'reminderTemplateId': 'String? get reminderTemplateId',
      'reminderTimeoutMinutes': 'int? get reminderTimeoutMinutes',
      'reminderRepeat': 'bool? get reminderRepeat',
      'lastSentAt': 'String? get lastSentAt',
      'status': 'TimedRequestStatus get status',
    },
  );
}

// =============================================================================
// TimedRequestListResult Bridge
// =============================================================================

BridgedClass _createTimedRequestListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_16.TimedRequestListResult,
    name: 'TimedRequestListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_16.TimedRequestListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('entries') || named['entries'] == null) {
          throw ArgumentError('TimedRequestListResult: Missing required named argument "entries"');
        }
        final entries = D4.coerceList<$tom_vscode_scripting_api_16.TimedRequest>(named['entries'], 'entries');
        final totalCount = D4.getRequiredNamedArg<int>(named, 'totalCount', 'TimedRequestListResult');
        final activeCount = D4.getRequiredNamedArg<int>(named, 'activeCount', 'TimedRequestListResult');
        final pausedCount = D4.getRequiredNamedArg<int>(named, 'pausedCount', 'TimedRequestListResult');
        final timerActivated = D4.getRequiredNamedArg<bool>(named, 'timerActivated', 'TimedRequestListResult');
        return $tom_vscode_scripting_api_16.TimedRequestListResult(entries: entries, totalCount: totalCount, activeCount: activeCount, pausedCount: pausedCount, timerActivated: timerActivated);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TimedRequestListResult');
        if (positional.isEmpty) {
          throw ArgumentError('TimedRequestListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_16.TimedRequestListResult.fromJson(json);
      },
    },
    getters: {
      'entries': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestListResult>(target, 'TimedRequestListResult').entries,
      'totalCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestListResult>(target, 'TimedRequestListResult').totalCount,
      'activeCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestListResult>(target, 'TimedRequestListResult').activeCount,
      'pausedCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestListResult>(target, 'TimedRequestListResult').pausedCount,
      'timerActivated': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestListResult>(target, 'TimedRequestListResult').timerActivated,
    },
    constructorSignatures: {
      '': 'TimedRequestListResult({required List<TimedRequest> entries, required int totalCount, required int activeCount, required int pausedCount, required bool timerActivated})',
      'fromJson': 'factory TimedRequestListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'entries': 'List<TimedRequest> get entries',
      'totalCount': 'int get totalCount',
      'activeCount': 'int get activeCount',
      'pausedCount': 'int get pausedCount',
      'timerActivated': 'bool get timerActivated',
    },
  );
}

// =============================================================================
// TimedRequestInput Bridge
// =============================================================================

BridgedClass _createTimedRequestInputBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_16.TimedRequestInput,
    name: 'TimedRequestInput',
    isAssignable: (v) => v is $tom_vscode_scripting_api_16.TimedRequestInput,
    constructors: {
      '': (visitor, positional, named) {
        final promptText = D4.getRequiredNamedArg<String>(named, 'promptText', 'TimedRequestInput');
        final template = D4.getOptionalNamedArg<String?>(named, 'template');
        final answerWrapper = D4.getOptionalNamedArg<bool?>(named, 'answerWrapper');
        final scheduleMode = D4.getRequiredNamedArg<$tom_vscode_scripting_api_16.ScheduleMode>(named, 'scheduleMode', 'TimedRequestInput');
        final intervalMinutes = D4.getOptionalNamedArg<int?>(named, 'intervalMinutes');
        final scheduledTimes = D4.coerceListOrNull<$tom_vscode_scripting_api_16.ScheduledTime>(named['scheduledTimes'], 'scheduledTimes');
        final reminderEnabled = D4.getOptionalNamedArg<bool?>(named, 'reminderEnabled');
        final reminderTemplateId = D4.getOptionalNamedArg<String?>(named, 'reminderTemplateId');
        final reminderTimeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'reminderTimeoutMinutes');
        final reminderRepeat = D4.getOptionalNamedArg<bool?>(named, 'reminderRepeat');
        return $tom_vscode_scripting_api_16.TimedRequestInput(promptText: promptText, template: template, answerWrapper: answerWrapper, scheduleMode: scheduleMode, intervalMinutes: intervalMinutes, scheduledTimes: scheduledTimes, reminderEnabled: reminderEnabled, reminderTemplateId: reminderTemplateId, reminderTimeoutMinutes: reminderTimeoutMinutes, reminderRepeat: reminderRepeat);
      },
    },
    getters: {
      'promptText': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').promptText,
      'template': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').template,
      'answerWrapper': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').answerWrapper,
      'scheduleMode': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').scheduleMode,
      'intervalMinutes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').intervalMinutes,
      'scheduledTimes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').scheduledTimes,
      'reminderEnabled': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').reminderEnabled,
      'reminderTemplateId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').reminderTemplateId,
      'reminderTimeoutMinutes': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').reminderTimeoutMinutes,
      'reminderRepeat': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput').reminderRepeat,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_16.TimedRequestInput>(target, 'TimedRequestInput');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'TimedRequestInput({required String promptText, String? template, bool? answerWrapper, required ScheduleMode scheduleMode, int? intervalMinutes, List<ScheduledTime>? scheduledTimes, bool? reminderEnabled, String? reminderTemplateId, int? reminderTimeoutMinutes, bool? reminderRepeat})',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'promptText': 'String get promptText',
      'template': 'String? get template',
      'answerWrapper': 'bool? get answerWrapper',
      'scheduleMode': 'ScheduleMode get scheduleMode',
      'intervalMinutes': 'int? get intervalMinutes',
      'scheduledTimes': 'List<ScheduledTime>? get scheduledTimes',
      'reminderEnabled': 'bool? get reminderEnabled',
      'reminderTemplateId': 'String? get reminderTemplateId',
      'reminderTimeoutMinutes': 'int? get reminderTimeoutMinutes',
      'reminderRepeat': 'bool? get reminderRepeat',
    },
  );
}

// =============================================================================
// TomTimedApi Bridge
// =============================================================================

BridgedClass _createTomTimedApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_16.TomTimedApi,
    name: 'TomTimedApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_16.TomTimedApi,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'setAdapter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAdapter');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'setAdapter');
        return $tom_vscode_scripting_api_16.TomTimedApi.setAdapter(adapter);
      },
      'list': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_16.TomTimedApi.list();
      },
      'get': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'get');
        final entryId = D4.getRequiredArg<String>(positional, 0, 'entryId', 'get');
        return $tom_vscode_scripting_api_16.TomTimedApi.get(entryId);
      },
      'create': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'create');
        final input = D4.getRequiredArg<$tom_vscode_scripting_api_16.TimedRequestInput>(positional, 0, 'input', 'create');
        return $tom_vscode_scripting_api_16.TomTimedApi.create(input);
      },
      'update': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'update');
        final entryId = D4.getRequiredArg<String>(positional, 0, 'entryId', 'update');
        final promptText = D4.getOptionalNamedArg<String?>(named, 'promptText');
        final template = D4.getOptionalNamedArg<String?>(named, 'template');
        final answerWrapper = D4.getOptionalNamedArg<bool?>(named, 'answerWrapper');
        final scheduleMode = D4.getOptionalNamedArg<$tom_vscode_scripting_api_16.ScheduleMode?>(named, 'scheduleMode');
        final intervalMinutes = D4.getOptionalNamedArg<int?>(named, 'intervalMinutes');
        final scheduledTimes = D4.coerceListOrNull<$tom_vscode_scripting_api_16.ScheduledTime>(named['scheduledTimes'], 'scheduledTimes');
        final reminderEnabled = D4.getOptionalNamedArg<bool?>(named, 'reminderEnabled');
        final reminderTemplateId = D4.getOptionalNamedArg<String?>(named, 'reminderTemplateId');
        final reminderTimeoutMinutes = D4.getOptionalNamedArg<int?>(named, 'reminderTimeoutMinutes');
        final reminderRepeat = D4.getOptionalNamedArg<bool?>(named, 'reminderRepeat');
        final status = D4.getOptionalNamedArg<$tom_vscode_scripting_api_16.TimedRequestStatus?>(named, 'status');
        return $tom_vscode_scripting_api_16.TomTimedApi.update(entryId, promptText: promptText, template: template, answerWrapper: answerWrapper, scheduleMode: scheduleMode, intervalMinutes: intervalMinutes, scheduledTimes: scheduledTimes, reminderEnabled: reminderEnabled, reminderTemplateId: reminderTemplateId, reminderTimeoutMinutes: reminderTimeoutMinutes, reminderRepeat: reminderRepeat, status: status);
      },
      'delete': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'delete');
        final entryId = D4.getRequiredArg<String>(positional, 0, 'entryId', 'delete');
        return $tom_vscode_scripting_api_16.TomTimedApi.delete(entryId);
      },
      'enable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'enable');
        final entryId = D4.getRequiredArg<String>(positional, 0, 'entryId', 'enable');
        return $tom_vscode_scripting_api_16.TomTimedApi.enable(entryId);
      },
      'disable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'disable');
        final entryId = D4.getRequiredArg<String>(positional, 0, 'entryId', 'disable');
        return $tom_vscode_scripting_api_16.TomTimedApi.disable(entryId);
      },
      'isTimerActivated': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_16.TomTimedApi.isTimerActivated();
      },
      'activateTimer': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_16.TomTimedApi.activateTimer();
      },
      'deactivateTimer': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_16.TomTimedApi.deactivateTimer();
      },
      'triggerCheck': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_16.TomTimedApi.triggerCheck();
      },
    },
    staticMethodSignatures: {
      'setAdapter': 'void setAdapter(VSCodeAdapter adapter)',
      'list': 'Future<TimedRequestListResult> list()',
      'get': 'Future<TimedRequest?> get(String entryId)',
      'create': 'Future<TimedRequest> create(TimedRequestInput input)',
      'update': 'Future<TimedRequest> update(String entryId, {String? promptText, String? template, bool? answerWrapper, ScheduleMode? scheduleMode, int? intervalMinutes, List<ScheduledTime>? scheduledTimes, bool? reminderEnabled, String? reminderTemplateId, int? reminderTimeoutMinutes, bool? reminderRepeat, TimedRequestStatus? status})',
      'delete': 'Future<bool> delete(String entryId)',
      'enable': 'Future<TimedRequest> enable(String entryId)',
      'disable': 'Future<TimedRequest> disable(String entryId)',
      'isTimerActivated': 'Future<bool> isTimerActivated()',
      'activateTimer': 'Future<void> activateTimer()',
      'deactivateTimer': 'Future<void> deactivateTimer()',
      'triggerCheck': 'Future<int> triggerCheck()',
    },
  );
}

// =============================================================================
// DocumentInfo Bridge
// =============================================================================

BridgedClass _createDocumentInfoBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_14.DocumentInfo,
    name: 'DocumentInfo',
    isAssignable: (v) => v is $tom_vscode_scripting_api_14.DocumentInfo,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'DocumentInfo');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'DocumentInfo');
        final relativePath = D4.getRequiredNamedArg<String>(named, 'relativePath', 'DocumentInfo');
        final isDirectory = D4.getRequiredNamedArg<bool>(named, 'isDirectory', 'DocumentInfo');
        final size = D4.getOptionalNamedArg<int?>(named, 'size');
        final modified = D4.getOptionalNamedArg<String?>(named, 'modified');
        final created = D4.getOptionalNamedArg<String?>(named, 'created');
        return $tom_vscode_scripting_api_14.DocumentInfo(name: name, path: path, relativePath: relativePath, isDirectory: isDirectory, size: size, modified: modified, created: created);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentInfo');
        if (positional.isEmpty) {
          throw ArgumentError('DocumentInfo: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_14.DocumentInfo.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentInfo>(target, 'DocumentInfo').name,
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentInfo>(target, 'DocumentInfo').path,
      'relativePath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentInfo>(target, 'DocumentInfo').relativePath,
      'isDirectory': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentInfo>(target, 'DocumentInfo').isDirectory,
      'size': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentInfo>(target, 'DocumentInfo').size,
      'modified': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentInfo>(target, 'DocumentInfo').modified,
      'created': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentInfo>(target, 'DocumentInfo').created,
    },
    constructorSignatures: {
      '': 'DocumentInfo({required String name, required String path, required String relativePath, required bool isDirectory, int? size, String? modified, String? created})',
      'fromJson': 'factory DocumentInfo.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'name': 'String get name',
      'path': 'String get path',
      'relativePath': 'String get relativePath',
      'isDirectory': 'bool get isDirectory',
      'size': 'int? get size',
      'modified': 'String? get modified',
      'created': 'String? get created',
    },
  );
}

// =============================================================================
// DocumentListResult Bridge
// =============================================================================

BridgedClass _createDocumentListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_14.DocumentListResult,
    name: 'DocumentListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_14.DocumentListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('documents') || named['documents'] == null) {
          throw ArgumentError('DocumentListResult: Missing required named argument "documents"');
        }
        final documents = D4.coerceList<$tom_vscode_scripting_api_14.DocumentInfo>(named['documents'], 'documents');
        final folder = D4.getRequiredNamedArg<String>(named, 'folder', 'DocumentListResult');
        final subfolder = D4.getOptionalNamedArg<String?>(named, 'subfolder');
        return $tom_vscode_scripting_api_14.DocumentListResult(documents: documents, folder: folder, subfolder: subfolder);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentListResult');
        if (positional.isEmpty) {
          throw ArgumentError('DocumentListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_14.DocumentListResult.fromJson(json);
      },
    },
    getters: {
      'documents': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentListResult>(target, 'DocumentListResult').documents,
      'folder': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentListResult>(target, 'DocumentListResult').folder,
      'subfolder': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentListResult>(target, 'DocumentListResult').subfolder,
    },
    constructorSignatures: {
      '': 'DocumentListResult({required List<DocumentInfo> documents, required String folder, String? subfolder})',
      'fromJson': 'factory DocumentListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'documents': 'List<DocumentInfo> get documents',
      'folder': 'String get folder',
      'subfolder': 'String? get subfolder',
    },
  );
}

// =============================================================================
// DocumentContent Bridge
// =============================================================================

BridgedClass _createDocumentContentBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_14.DocumentContent,
    name: 'DocumentContent',
    isAssignable: (v) => v is $tom_vscode_scripting_api_14.DocumentContent,
    constructors: {
      '': (visitor, positional, named) {
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'DocumentContent');
        final content = D4.getRequiredNamedArg<String>(named, 'content', 'DocumentContent');
        final encoding = D4.getOptionalNamedArg<String?>(named, 'encoding');
        final size = D4.getRequiredNamedArg<int>(named, 'size', 'DocumentContent');
        final modified = D4.getOptionalNamedArg<String?>(named, 'modified');
        return $tom_vscode_scripting_api_14.DocumentContent(path: path, content: content, encoding: encoding, size: size, modified: modified);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentContent');
        if (positional.isEmpty) {
          throw ArgumentError('DocumentContent: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_14.DocumentContent.fromJson(json);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentContent>(target, 'DocumentContent').path,
      'content': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentContent>(target, 'DocumentContent').content,
      'encoding': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentContent>(target, 'DocumentContent').encoding,
      'size': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentContent>(target, 'DocumentContent').size,
      'modified': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.DocumentContent>(target, 'DocumentContent').modified,
    },
    constructorSignatures: {
      '': 'DocumentContent({required String path, required String content, String? encoding, required int size, String? modified})',
      'fromJson': 'factory DocumentContent.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'path': 'String get path',
      'content': 'String get content',
      'encoding': 'String? get encoding',
      'size': 'int get size',
      'modified': 'String? get modified',
    },
  );
}

// =============================================================================
// TrailEntry Bridge
// =============================================================================

BridgedClass _createTrailEntryBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_14.TrailEntry,
    name: 'TrailEntry',
    isAssignable: (v) => v is $tom_vscode_scripting_api_14.TrailEntry,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'TrailEntry');
        final requestId = D4.getOptionalNamedArg<String?>(named, 'requestId');
        final promptFile = D4.getRequiredNamedArg<String>(named, 'promptFile', 'TrailEntry');
        final answerFile = D4.getOptionalNamedArg<String?>(named, 'answerFile');
        final promptContent = D4.getOptionalNamedArg<String?>(named, 'promptContent');
        final answerContent = D4.getOptionalNamedArg<String?>(named, 'answerContent');
        final timestamp = D4.getOptionalNamedArg<String?>(named, 'timestamp');
        final questId = D4.getOptionalNamedArg<String?>(named, 'questId');
        return $tom_vscode_scripting_api_14.TrailEntry(id: id, requestId: requestId, promptFile: promptFile, answerFile: answerFile, promptContent: promptContent, answerContent: answerContent, timestamp: timestamp, questId: questId);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TrailEntry');
        if (positional.isEmpty) {
          throw ArgumentError('TrailEntry: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_14.TrailEntry.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailEntry>(target, 'TrailEntry').id,
      'requestId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailEntry>(target, 'TrailEntry').requestId,
      'promptFile': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailEntry>(target, 'TrailEntry').promptFile,
      'answerFile': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailEntry>(target, 'TrailEntry').answerFile,
      'promptContent': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailEntry>(target, 'TrailEntry').promptContent,
      'answerContent': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailEntry>(target, 'TrailEntry').answerContent,
      'timestamp': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailEntry>(target, 'TrailEntry').timestamp,
      'questId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailEntry>(target, 'TrailEntry').questId,
    },
    constructorSignatures: {
      '': 'TrailEntry({required String id, String? requestId, required String promptFile, String? answerFile, String? promptContent, String? answerContent, String? timestamp, String? questId})',
      'fromJson': 'factory TrailEntry.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'id': 'String get id',
      'requestId': 'String? get requestId',
      'promptFile': 'String get promptFile',
      'answerFile': 'String? get answerFile',
      'promptContent': 'String? get promptContent',
      'answerContent': 'String? get answerContent',
      'timestamp': 'String? get timestamp',
      'questId': 'String? get questId',
    },
  );
}

// =============================================================================
// TrailListResult Bridge
// =============================================================================

BridgedClass _createTrailListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_14.TrailListResult,
    name: 'TrailListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_14.TrailListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('entries') || named['entries'] == null) {
          throw ArgumentError('TrailListResult: Missing required named argument "entries"');
        }
        final entries = D4.coerceList<$tom_vscode_scripting_api_14.TrailEntry>(named['entries'], 'entries');
        final totalCount = D4.getRequiredNamedArg<int>(named, 'totalCount', 'TrailListResult');
        final questId = D4.getOptionalNamedArg<String?>(named, 'questId');
        return $tom_vscode_scripting_api_14.TrailListResult(entries: entries, totalCount: totalCount, questId: questId);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TrailListResult');
        if (positional.isEmpty) {
          throw ArgumentError('TrailListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_14.TrailListResult.fromJson(json);
      },
    },
    getters: {
      'entries': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailListResult>(target, 'TrailListResult').entries,
      'totalCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailListResult>(target, 'TrailListResult').totalCount,
      'questId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.TrailListResult>(target, 'TrailListResult').questId,
    },
    constructorSignatures: {
      '': 'TrailListResult({required List<TrailEntry> entries, required int totalCount, String? questId})',
      'fromJson': 'factory TrailListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'entries': 'List<TrailEntry> get entries',
      'totalCount': 'int get totalCount',
      'questId': 'String? get questId',
    },
  );
}

// =============================================================================
// GuidelineInfo Bridge
// =============================================================================

BridgedClass _createGuidelineInfoBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_14.GuidelineInfo,
    name: 'GuidelineInfo',
    isAssignable: (v) => v is $tom_vscode_scripting_api_14.GuidelineInfo,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'GuidelineInfo');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'GuidelineInfo');
        final relativePath = D4.getRequiredNamedArg<String>(named, 'relativePath', 'GuidelineInfo');
        final category = D4.getOptionalNamedArg<String?>(named, 'category');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        return $tom_vscode_scripting_api_14.GuidelineInfo(name: name, path: path, relativePath: relativePath, category: category, description: description);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'GuidelineInfo');
        if (positional.isEmpty) {
          throw ArgumentError('GuidelineInfo: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_14.GuidelineInfo.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.GuidelineInfo>(target, 'GuidelineInfo').name,
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.GuidelineInfo>(target, 'GuidelineInfo').path,
      'relativePath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.GuidelineInfo>(target, 'GuidelineInfo').relativePath,
      'category': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.GuidelineInfo>(target, 'GuidelineInfo').category,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.GuidelineInfo>(target, 'GuidelineInfo').description,
    },
    constructorSignatures: {
      '': 'GuidelineInfo({required String name, required String path, required String relativePath, String? category, String? description})',
      'fromJson': 'factory GuidelineInfo.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'name': 'String get name',
      'path': 'String get path',
      'relativePath': 'String get relativePath',
      'category': 'String? get category',
      'description': 'String? get description',
    },
  );
}

// =============================================================================
// GuidelineListResult Bridge
// =============================================================================

BridgedClass _createGuidelineListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_14.GuidelineListResult,
    name: 'GuidelineListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_14.GuidelineListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('guidelines') || named['guidelines'] == null) {
          throw ArgumentError('GuidelineListResult: Missing required named argument "guidelines"');
        }
        final guidelines = D4.coerceList<$tom_vscode_scripting_api_14.GuidelineInfo>(named['guidelines'], 'guidelines');
        if (!named.containsKey('categories') || named['categories'] == null) {
          throw ArgumentError('GuidelineListResult: Missing required named argument "categories"');
        }
        final categories = D4.coerceList<String>(named['categories'], 'categories');
        return $tom_vscode_scripting_api_14.GuidelineListResult(guidelines: guidelines, categories: categories);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'GuidelineListResult');
        if (positional.isEmpty) {
          throw ArgumentError('GuidelineListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_14.GuidelineListResult.fromJson(json);
      },
    },
    getters: {
      'guidelines': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.GuidelineListResult>(target, 'GuidelineListResult').guidelines,
      'categories': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_14.GuidelineListResult>(target, 'GuidelineListResult').categories,
    },
    constructorSignatures: {
      '': 'GuidelineListResult({required List<GuidelineInfo> guidelines, required List<String> categories})',
      'fromJson': 'factory GuidelineListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'guidelines': 'List<GuidelineInfo> get guidelines',
      'categories': 'List<String> get categories',
    },
  );
}

// =============================================================================
// TomDocumentApi Bridge
// =============================================================================

BridgedClass _createTomDocumentApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_14.TomDocumentApi,
    name: 'TomDocumentApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_14.TomDocumentApi,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'setAdapter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAdapter');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'setAdapter');
        return $tom_vscode_scripting_api_14.TomDocumentApi.setAdapter(adapter);
      },
      'list': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'list');
        final folder = D4.getRequiredArg<$tom_vscode_scripting_api_14.DocumentFolder>(positional, 0, 'folder', 'list');
        final subfolder = D4.getOptionalNamedArg<String?>(named, 'subfolder');
        final pattern = D4.getOptionalNamedArg<String?>(named, 'pattern');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', false);
        return $tom_vscode_scripting_api_14.TomDocumentApi.list(folder, subfolder: subfolder, pattern: pattern, recursive: recursive);
      },
      'read': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'read');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'read');
        return $tom_vscode_scripting_api_14.TomDocumentApi.read(path);
      },
      'write': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'write');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'write');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'write');
        return $tom_vscode_scripting_api_14.TomDocumentApi.write(path, content);
      },
      'delete': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'delete');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'delete');
        return $tom_vscode_scripting_api_14.TomDocumentApi.delete(path);
      },
      'exists': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'exists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'exists');
        return $tom_vscode_scripting_api_14.TomDocumentApi.exists(path);
      },
      'listPrompts': (visitor, positional, named, typeArgs) {
        final pattern = D4.getOptionalNamedArg<String?>(named, 'pattern');
        return $tom_vscode_scripting_api_14.TomDocumentApi.listPrompts(pattern: pattern);
      },
      'readPrompt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'readPrompt');
        final filename = D4.getRequiredArg<String>(positional, 0, 'filename', 'readPrompt');
        return $tom_vscode_scripting_api_14.TomDocumentApi.readPrompt(filename);
      },
      'createPrompt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createPrompt');
        final content = D4.getRequiredArg<String>(positional, 0, 'content', 'createPrompt');
        final filename = D4.getOptionalNamedArg<String?>(named, 'filename');
        return $tom_vscode_scripting_api_14.TomDocumentApi.createPrompt(content, filename: filename);
      },
      'listAnswers': (visitor, positional, named, typeArgs) {
        final subfolder = D4.getOptionalNamedArg<String?>(named, 'subfolder');
        final pattern = D4.getOptionalNamedArg<String?>(named, 'pattern');
        return $tom_vscode_scripting_api_14.TomDocumentApi.listAnswers(subfolder: subfolder, pattern: pattern);
      },
      'readAnswer': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'readAnswer');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'readAnswer');
        return $tom_vscode_scripting_api_14.TomDocumentApi.readAnswer(path);
      },
      'listTrail': (visitor, positional, named, typeArgs) {
        final questId = D4.getOptionalNamedArg<String?>(named, 'questId');
        final limit = D4.getOptionalNamedArg<int?>(named, 'limit');
        final since = D4.getOptionalNamedArg<String?>(named, 'since');
        return $tom_vscode_scripting_api_14.TomDocumentApi.listTrail(questId: questId, limit: limit, since: since);
      },
      'getTrailEntry': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getTrailEntry');
        final entryId = D4.getRequiredArg<String>(positional, 0, 'entryId', 'getTrailEntry');
        return $tom_vscode_scripting_api_14.TomDocumentApi.getTrailEntry(entryId);
      },
      'findTrailByRequestId': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findTrailByRequestId');
        final requestId = D4.getRequiredArg<String>(positional, 0, 'requestId', 'findTrailByRequestId');
        return $tom_vscode_scripting_api_14.TomDocumentApi.findTrailByRequestId(requestId);
      },
      'listGuidelines': (visitor, positional, named, typeArgs) {
        final category = D4.getOptionalNamedArg<String?>(named, 'category');
        return $tom_vscode_scripting_api_14.TomDocumentApi.listGuidelines(category: category);
      },
      'readGuideline': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'readGuideline');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'readGuideline');
        return $tom_vscode_scripting_api_14.TomDocumentApi.readGuideline(name);
      },
      'listNotes': (visitor, positional, named, typeArgs) {
        final pattern = D4.getOptionalNamedArg<String?>(named, 'pattern');
        return $tom_vscode_scripting_api_14.TomDocumentApi.listNotes(pattern: pattern);
      },
      'readNote': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'readNote');
        final filename = D4.getRequiredArg<String>(positional, 0, 'filename', 'readNote');
        return $tom_vscode_scripting_api_14.TomDocumentApi.readNote(filename);
      },
      'writeNote': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'writeNote');
        final filename = D4.getRequiredArg<String>(positional, 0, 'filename', 'writeNote');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'writeNote');
        return $tom_vscode_scripting_api_14.TomDocumentApi.writeNote(filename, content);
      },
      'listQuestDocuments': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'listQuestDocuments');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'listQuestDocuments');
        final pattern = D4.getOptionalNamedArg<String?>(named, 'pattern');
        return $tom_vscode_scripting_api_14.TomDocumentApi.listQuestDocuments(questId, pattern: pattern);
      },
      'readQuestDocument': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'readQuestDocument');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'readQuestDocument');
        final filename = D4.getRequiredArg<String>(positional, 1, 'filename', 'readQuestDocument');
        return $tom_vscode_scripting_api_14.TomDocumentApi.readQuestDocument(questId, filename);
      },
      'writeQuestDocument': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'writeQuestDocument');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'writeQuestDocument');
        final filename = D4.getRequiredArg<String>(positional, 1, 'filename', 'writeQuestDocument');
        final content = D4.getRequiredArg<String>(positional, 2, 'content', 'writeQuestDocument');
        return $tom_vscode_scripting_api_14.TomDocumentApi.writeQuestDocument(questId, filename, content);
      },
    },
    staticMethodSignatures: {
      'setAdapter': 'void setAdapter(VSCodeAdapter adapter)',
      'list': 'Future<DocumentListResult> list(DocumentFolder folder, {String? subfolder, String? pattern, bool recursive = false})',
      'read': 'Future<DocumentContent> read(String path)',
      'write': 'Future<bool> write(String path, String content)',
      'delete': 'Future<bool> delete(String path)',
      'exists': 'Future<bool> exists(String path)',
      'listPrompts': 'Future<DocumentListResult> listPrompts({String? pattern})',
      'readPrompt': 'Future<DocumentContent> readPrompt(String filename)',
      'createPrompt': 'Future<String> createPrompt(String content, {String? filename})',
      'listAnswers': 'Future<DocumentListResult> listAnswers({String? subfolder, String? pattern})',
      'readAnswer': 'Future<DocumentContent> readAnswer(String path)',
      'listTrail': 'Future<TrailListResult> listTrail({String? questId, int? limit, String? since})',
      'getTrailEntry': 'Future<TrailEntry?> getTrailEntry(String entryId)',
      'findTrailByRequestId': 'Future<TrailEntry?> findTrailByRequestId(String requestId)',
      'listGuidelines': 'Future<GuidelineListResult> listGuidelines({String? category})',
      'readGuideline': 'Future<DocumentContent> readGuideline(String name)',
      'listNotes': 'Future<DocumentListResult> listNotes({String? pattern})',
      'readNote': 'Future<DocumentContent> readNote(String filename)',
      'writeNote': 'Future<bool> writeNote(String filename, String content)',
      'listQuestDocuments': 'Future<DocumentListResult> listQuestDocuments(String questId, {String? pattern})',
      'readQuestDocument': 'Future<DocumentContent> readQuestDocument(String questId, String filename)',
      'writeQuestDocument': 'Future<bool> writeQuestDocument(String questId, String filename, String content)',
    },
  );
}

// =============================================================================
// ProjectInfo Bridge
// =============================================================================

BridgedClass _createProjectInfoBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_19.ProjectInfo,
    name: 'ProjectInfo',
    isAssignable: (v) => v is $tom_vscode_scripting_api_19.ProjectInfo,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'ProjectInfo');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ProjectInfo');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'ProjectInfo');
        final relativePath = D4.getRequiredNamedArg<String>(named, 'relativePath', 'ProjectInfo');
        final type = D4.getRequiredNamedArg<$tom_vscode_scripting_api_19.ProjectType>(named, 'type', 'ProjectInfo');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final version = D4.getOptionalNamedArg<String?>(named, 'version');
        final tags = D4.coerceListOrNull<String>(named['tags'], 'tags');
        final repository = D4.getOptionalNamedArg<String?>(named, 'repository');
        final isSubWorkspace = D4.getNamedArgWithDefault<bool>(named, 'isSubWorkspace', false);
        return $tom_vscode_scripting_api_19.ProjectInfo(id: id, name: name, path: path, relativePath: relativePath, type: type, description: description, version: version, tags: tags, repository: repository, isSubWorkspace: isSubWorkspace);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ProjectInfo');
        if (positional.isEmpty) {
          throw ArgumentError('ProjectInfo: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_19.ProjectInfo.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').id,
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').name,
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').path,
      'relativePath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').relativePath,
      'type': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').type,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').description,
      'version': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').version,
      'tags': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').tags,
      'repository': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').repository,
      'isSubWorkspace': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectInfo>(target, 'ProjectInfo').isSubWorkspace,
    },
    constructorSignatures: {
      '': 'ProjectInfo({required String id, required String name, required String path, required String relativePath, required ProjectType type, String? description, String? version, List<String>? tags, String? repository, bool isSubWorkspace = false})',
      'fromJson': 'factory ProjectInfo.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'id': 'String get id',
      'name': 'String get name',
      'path': 'String get path',
      'relativePath': 'String get relativePath',
      'type': 'ProjectType get type',
      'description': 'String? get description',
      'version': 'String? get version',
      'tags': 'List<String>? get tags',
      'repository': 'String? get repository',
      'isSubWorkspace': 'bool get isSubWorkspace',
    },
  );
}

// =============================================================================
// ProjectListResult Bridge
// =============================================================================

BridgedClass _createProjectListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_19.ProjectListResult,
    name: 'ProjectListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_19.ProjectListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('projects') || named['projects'] == null) {
          throw ArgumentError('ProjectListResult: Missing required named argument "projects"');
        }
        final projects = D4.coerceList<$tom_vscode_scripting_api_19.ProjectInfo>(named['projects'], 'projects');
        final totalCount = D4.getRequiredNamedArg<int>(named, 'totalCount', 'ProjectListResult');
        return $tom_vscode_scripting_api_19.ProjectListResult(projects: projects, totalCount: totalCount);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ProjectListResult');
        if (positional.isEmpty) {
          throw ArgumentError('ProjectListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_19.ProjectListResult.fromJson(json);
      },
    },
    getters: {
      'projects': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectListResult>(target, 'ProjectListResult').projects,
      'totalCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ProjectListResult>(target, 'ProjectListResult').totalCount,
    },
    constructorSignatures: {
      '': 'ProjectListResult({required List<ProjectInfo> projects, required int totalCount})',
      'fromJson': 'factory ProjectListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'projects': 'List<ProjectInfo> get projects',
      'totalCount': 'int get totalCount',
    },
  );
}

// =============================================================================
// QuestInfo Bridge
// =============================================================================

BridgedClass _createQuestInfoBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_19.QuestInfo,
    name: 'QuestInfo',
    isAssignable: (v) => v is $tom_vscode_scripting_api_19.QuestInfo,
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'QuestInfo');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'QuestInfo');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'QuestInfo');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final status = D4.getOptionalNamedArg<String?>(named, 'status');
        final hasOverview = D4.getNamedArgWithDefault<bool>(named, 'hasOverview', false);
        final hasTodos = D4.getNamedArgWithDefault<bool>(named, 'hasTodos', false);
        final todoCount = D4.getOptionalNamedArg<int?>(named, 'todoCount');
        final completedTodoCount = D4.getOptionalNamedArg<int?>(named, 'completedTodoCount');
        return $tom_vscode_scripting_api_19.QuestInfo(id: id, name: name, path: path, description: description, status: status, hasOverview: hasOverview, hasTodos: hasTodos, todoCount: todoCount, completedTodoCount: completedTodoCount);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'QuestInfo');
        if (positional.isEmpty) {
          throw ArgumentError('QuestInfo: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_19.QuestInfo.fromJson(json);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').id,
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').name,
      'path': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').path,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').description,
      'status': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').status,
      'hasOverview': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').hasOverview,
      'hasTodos': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').hasTodos,
      'todoCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').todoCount,
      'completedTodoCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestInfo>(target, 'QuestInfo').completedTodoCount,
    },
    constructorSignatures: {
      '': 'QuestInfo({required String id, required String name, required String path, String? description, String? status, bool hasOverview = false, bool hasTodos = false, int? todoCount, int? completedTodoCount})',
      'fromJson': 'factory QuestInfo.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'id': 'String get id',
      'name': 'String get name',
      'path': 'String get path',
      'description': 'String? get description',
      'status': 'String? get status',
      'hasOverview': 'bool get hasOverview',
      'hasTodos': 'bool get hasTodos',
      'todoCount': 'int? get todoCount',
      'completedTodoCount': 'int? get completedTodoCount',
    },
  );
}

// =============================================================================
// QuestListResult Bridge
// =============================================================================

BridgedClass _createQuestListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_19.QuestListResult,
    name: 'QuestListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_19.QuestListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('quests') || named['quests'] == null) {
          throw ArgumentError('QuestListResult: Missing required named argument "quests"');
        }
        final quests = D4.coerceList<$tom_vscode_scripting_api_19.QuestInfo>(named['quests'], 'quests');
        final totalCount = D4.getRequiredNamedArg<int>(named, 'totalCount', 'QuestListResult');
        final activeQuestId = D4.getOptionalNamedArg<String?>(named, 'activeQuestId');
        return $tom_vscode_scripting_api_19.QuestListResult(quests: quests, totalCount: totalCount, activeQuestId: activeQuestId);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'QuestListResult');
        if (positional.isEmpty) {
          throw ArgumentError('QuestListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_19.QuestListResult.fromJson(json);
      },
    },
    getters: {
      'quests': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestListResult>(target, 'QuestListResult').quests,
      'totalCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestListResult>(target, 'QuestListResult').totalCount,
      'activeQuestId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.QuestListResult>(target, 'QuestListResult').activeQuestId,
    },
    constructorSignatures: {
      '': 'QuestListResult({required List<QuestInfo> quests, required int totalCount, String? activeQuestId})',
      'fromJson': 'factory QuestListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'quests': 'List<QuestInfo> get quests',
      'totalCount': 'int get totalCount',
      'activeQuestId': 'String? get activeQuestId',
    },
  );
}

// =============================================================================
// WorkspaceInfo Bridge
// =============================================================================

BridgedClass _createWorkspaceInfoBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_19.WorkspaceInfo,
    name: 'WorkspaceInfo',
    isAssignable: (v) => v is $tom_vscode_scripting_api_19.WorkspaceInfo,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'WorkspaceInfo');
        final rootPath = D4.getRequiredNamedArg<String>(named, 'rootPath', 'WorkspaceInfo');
        final workspaceFile = D4.getOptionalNamedArg<String?>(named, 'workspaceFile');
        final projectCount = D4.getRequiredNamedArg<int>(named, 'projectCount', 'WorkspaceInfo');
        final questCount = D4.getRequiredNamedArg<int>(named, 'questCount', 'WorkspaceInfo');
        final activeQuestId = D4.getOptionalNamedArg<String?>(named, 'activeQuestId');
        final windowId = D4.getOptionalNamedArg<String?>(named, 'windowId');
        final metadata = D4.coerceMapOrNull<String, dynamic>(named['metadata'], 'metadata');
        return $tom_vscode_scripting_api_19.WorkspaceInfo(name: name, rootPath: rootPath, workspaceFile: workspaceFile, projectCount: projectCount, questCount: questCount, activeQuestId: activeQuestId, windowId: windowId, metadata: metadata);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WorkspaceInfo');
        if (positional.isEmpty) {
          throw ArgumentError('WorkspaceInfo: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_19.WorkspaceInfo.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.WorkspaceInfo>(target, 'WorkspaceInfo').name,
      'rootPath': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.WorkspaceInfo>(target, 'WorkspaceInfo').rootPath,
      'workspaceFile': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.WorkspaceInfo>(target, 'WorkspaceInfo').workspaceFile,
      'projectCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.WorkspaceInfo>(target, 'WorkspaceInfo').projectCount,
      'questCount': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.WorkspaceInfo>(target, 'WorkspaceInfo').questCount,
      'activeQuestId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.WorkspaceInfo>(target, 'WorkspaceInfo').activeQuestId,
      'windowId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.WorkspaceInfo>(target, 'WorkspaceInfo').windowId,
      'metadata': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.WorkspaceInfo>(target, 'WorkspaceInfo').metadata,
    },
    constructorSignatures: {
      '': 'WorkspaceInfo({required String name, required String rootPath, String? workspaceFile, required int projectCount, required int questCount, String? activeQuestId, String? windowId, Map<String, dynamic>? metadata})',
      'fromJson': 'factory WorkspaceInfo.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'name': 'String get name',
      'rootPath': 'String get rootPath',
      'workspaceFile': 'String? get workspaceFile',
      'projectCount': 'int get projectCount',
      'questCount': 'int get questCount',
      'activeQuestId': 'String? get activeQuestId',
      'windowId': 'String? get windowId',
      'metadata': 'Map<String, dynamic>? get metadata',
    },
  );
}

// =============================================================================
// ChatVariable Bridge
// =============================================================================

BridgedClass _createChatVariableBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_19.ChatVariable,
    name: 'ChatVariable',
    isAssignable: (v) => v is $tom_vscode_scripting_api_19.ChatVariable,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ChatVariable');
        final value = D4.getOptionalNamedArg<String?>(named, 'value');
        final source = D4.getOptionalNamedArg<String?>(named, 'source');
        return $tom_vscode_scripting_api_19.ChatVariable(name: name, value: value, source: source);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatVariable');
        if (positional.isEmpty) {
          throw ArgumentError('ChatVariable: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_19.ChatVariable.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ChatVariable>(target, 'ChatVariable').name,
      'value': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ChatVariable>(target, 'ChatVariable').value,
      'source': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ChatVariable>(target, 'ChatVariable').source,
    },
    constructorSignatures: {
      '': 'ChatVariable({required String name, String? value, String? source})',
      'fromJson': 'factory ChatVariable.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'name': 'String get name',
      'value': 'String? get value',
      'source': 'String? get source',
    },
  );
}

// =============================================================================
// ChatVariableListResult Bridge
// =============================================================================

BridgedClass _createChatVariableListResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_19.ChatVariableListResult,
    name: 'ChatVariableListResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_19.ChatVariableListResult,
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('variables') || named['variables'] == null) {
          throw ArgumentError('ChatVariableListResult: Missing required named argument "variables"');
        }
        final variables = D4.coerceList<$tom_vscode_scripting_api_19.ChatVariable>(named['variables'], 'variables');
        final activeQuestId = D4.getOptionalNamedArg<String?>(named, 'activeQuestId');
        return $tom_vscode_scripting_api_19.ChatVariableListResult(variables: variables, activeQuestId: activeQuestId);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ChatVariableListResult');
        if (positional.isEmpty) {
          throw ArgumentError('ChatVariableListResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_19.ChatVariableListResult.fromJson(json);
      },
    },
    getters: {
      'variables': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ChatVariableListResult>(target, 'ChatVariableListResult').variables,
      'activeQuestId': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_19.ChatVariableListResult>(target, 'ChatVariableListResult').activeQuestId,
    },
    constructorSignatures: {
      '': 'ChatVariableListResult({required List<ChatVariable> variables, String? activeQuestId})',
      'fromJson': 'factory ChatVariableListResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'variables': 'List<ChatVariable> get variables',
      'activeQuestId': 'String? get activeQuestId',
    },
  );
}

// =============================================================================
// TomWorkspaceApi Bridge
// =============================================================================

BridgedClass _createTomWorkspaceApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_19.TomWorkspaceApi,
    name: 'TomWorkspaceApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_19.TomWorkspaceApi,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'setAdapter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAdapter');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'setAdapter');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.setAdapter(adapter);
      },
      'getInfo': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.getInfo();
      },
      'getRootPath': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.getRootPath();
      },
      'getWindowId': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.getWindowId();
      },
      'listProjects': (visitor, positional, named, typeArgs) {
        final type = D4.getOptionalNamedArg<$tom_vscode_scripting_api_19.ProjectType?>(named, 'type');
        final includeSubWorkspaces = D4.getNamedArgWithDefault<bool>(named, 'includeSubWorkspaces', true);
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.listProjects(type: type, includeSubWorkspaces: includeSubWorkspaces);
      },
      'getProject': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getProject');
        final projectId = D4.getRequiredArg<String>(positional, 0, 'projectId', 'getProject');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.getProject(projectId);
      },
      'findProjects': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findProjects');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'findProjects');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.findProjects(pattern);
      },
      'listQuests': (visitor, positional, named, typeArgs) {
        final includeTodoCounts = D4.getNamedArgWithDefault<bool>(named, 'includeTodoCounts', false);
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.listQuests(includeTodoCounts: includeTodoCounts);
      },
      'getQuest': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getQuest');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'getQuest');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.getQuest(questId);
      },
      'getActiveQuest': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.getActiveQuest();
      },
      'setActiveQuest': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setActiveQuest');
        final questId = D4.getRequiredArg<String>(positional, 0, 'questId', 'setActiveQuest');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.setActiveQuest(questId);
      },
      'listChatVariables': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.listChatVariables();
      },
      'getChatVariable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getChatVariable');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getChatVariable');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.getChatVariable(name);
      },
      'setChatVariable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setChatVariable');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'setChatVariable');
        final value = D4.getRequiredArg<String>(positional, 1, 'value', 'setChatVariable');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.setChatVariable(name, value);
      },
      'getConfig': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getConfig');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'getConfig');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.getConfig(section);
      },
      'updateConfig': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'updateConfig');
        final section = D4.getRequiredArg<String>(positional, 0, 'section', 'updateConfig');
        if (positional.length <= 1) {
          throw ArgumentError('updateConfig: Missing required argument "values" at position 1');
        }
        final values = D4.coerceMap<String, dynamic>(positional[1], 'values');
        return $tom_vscode_scripting_api_19.TomWorkspaceApi.updateConfig(section, values);
      },
    },
    staticMethodSignatures: {
      'setAdapter': 'void setAdapter(VSCodeAdapter adapter)',
      'getInfo': 'Future<WorkspaceInfo> getInfo()',
      'getRootPath': 'Future<String> getRootPath()',
      'getWindowId': 'Future<String?> getWindowId()',
      'listProjects': 'Future<ProjectListResult> listProjects({ProjectType? type, bool includeSubWorkspaces = true})',
      'getProject': 'Future<ProjectInfo?> getProject(String projectId)',
      'findProjects': 'Future<ProjectListResult> findProjects(String pattern)',
      'listQuests': 'Future<QuestListResult> listQuests({bool includeTodoCounts = false})',
      'getQuest': 'Future<QuestInfo?> getQuest(String questId)',
      'getActiveQuest': 'Future<QuestInfo?> getActiveQuest()',
      'setActiveQuest': 'Future<bool> setActiveQuest(String questId)',
      'listChatVariables': 'Future<ChatVariableListResult> listChatVariables()',
      'getChatVariable': 'Future<ChatVariable?> getChatVariable(String name)',
      'setChatVariable': 'Future<bool> setChatVariable(String name, String value)',
      'getConfig': 'Future<Map<String, dynamic>> getConfig(String section)',
      'updateConfig': 'Future<bool> updateConfig(String section, Map<String, dynamic> values)',
    },
  );
}

// =============================================================================
// ToolDefinitionJson Bridge
// =============================================================================

BridgedClass _createToolDefinitionJsonBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_18.ToolDefinitionJson,
    name: 'ToolDefinitionJson',
    isAssignable: (v) => v is $tom_vscode_scripting_api_18.ToolDefinitionJson,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ToolDefinitionJson');
        final description = D4.getRequiredNamedArg<String>(named, 'description', 'ToolDefinitionJson');
        if (!named.containsKey('inputSchema') || named['inputSchema'] == null) {
          throw ArgumentError('ToolDefinitionJson: Missing required named argument "inputSchema"');
        }
        final inputSchema = D4.coerceMap<String, dynamic>(named['inputSchema'], 'inputSchema');
        return $tom_vscode_scripting_api_18.ToolDefinitionJson(name: name, description: description, inputSchema: inputSchema);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ToolDefinitionJson');
        if (positional.isEmpty) {
          throw ArgumentError('ToolDefinitionJson: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_18.ToolDefinitionJson.fromJson(json);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_18.ToolDefinitionJson>(target, 'ToolDefinitionJson').name,
      'description': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_18.ToolDefinitionJson>(target, 'ToolDefinitionJson').description,
      'inputSchema': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_18.ToolDefinitionJson>(target, 'ToolDefinitionJson').inputSchema,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_vscode_scripting_api_18.ToolDefinitionJson>(target, 'ToolDefinitionJson');
        return t.toJson();
      },
    },
    constructorSignatures: {
      '': 'ToolDefinitionJson({required String name, required String description, required Map<String, dynamic> inputSchema})',
      'fromJson': 'factory ToolDefinitionJson.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String get description',
      'inputSchema': 'Map<String, dynamic> get inputSchema',
    },
  );
}

// =============================================================================
// TomToolsApi Bridge
// =============================================================================

BridgedClass _createTomToolsApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_18.TomToolsApi,
    name: 'TomToolsApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_18.TomToolsApi,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'setAdapter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAdapter');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'setAdapter');
        return $tom_vscode_scripting_api_18.TomToolsApi.setAdapter(adapter);
      },
      'invokeTool': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'invokeTool');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeTool');
        final arguments = positional.length > 1 && positional[1] != null
            ? D4.coerceMap<String, dynamic>(positional[1], 'arguments')
            : const <String, dynamic>{};
        return $tom_vscode_scripting_api_18.TomToolsApi.invokeTool(name, arguments);
      },
      'getToolsJson': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_18.TomToolsApi.getToolsJson();
      },
      'listAllowedToolNames': (visitor, positional, named, typeArgs) {
        return $tom_vscode_scripting_api_18.TomToolsApi.listAllowedToolNames();
      },
    },
    staticMethodSignatures: {
      'setAdapter': 'void setAdapter(VSCodeAdapter adapter)',
      'invokeTool': 'Future<String> invokeTool(String name, [Map<String, dynamic> arguments = const {}])',
      'getToolsJson': 'Future<List<ToolDefinitionJson>> getToolsJson()',
      'listAllowedToolNames': 'Future<List<String>> listAllowedToolNames()',
    },
  );
}

// =============================================================================
// SendToChatResult Bridge
// =============================================================================

BridgedClass _createSendToChatResultBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_13.SendToChatResult,
    name: 'SendToChatResult',
    isAssignable: (v) => v is $tom_vscode_scripting_api_13.SendToChatResult,
    constructors: {
      '': (visitor, positional, named) {
        final target_ = D4.getRequiredNamedArg<String>(named, 'target', 'SendToChatResult');
        final success = D4.getRequiredNamedArg<bool>(named, 'success', 'SendToChatResult');
        final answer = D4.getRequiredNamedArg<String>(named, 'answer', 'SendToChatResult');
        final rejected = D4.getRequiredNamedArg<bool>(named, 'rejected', 'SendToChatResult');
        final error = D4.getRequiredNamedArg<String>(named, 'error', 'SendToChatResult');
        return $tom_vscode_scripting_api_13.SendToChatResult(target: target_, success: success, answer: answer, rejected: rejected, error: error);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SendToChatResult');
        if (positional.isEmpty) {
          throw ArgumentError('SendToChatResult: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_vscode_scripting_api_13.SendToChatResult.fromJson(json);
      },
    },
    getters: {
      'target': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_13.SendToChatResult>(target, 'SendToChatResult').target,
      'success': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_13.SendToChatResult>(target, 'SendToChatResult').success,
      'answer': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_13.SendToChatResult>(target, 'SendToChatResult').answer,
      'rejected': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_13.SendToChatResult>(target, 'SendToChatResult').rejected,
      'error': (visitor, target) => D4.validateTarget<$tom_vscode_scripting_api_13.SendToChatResult>(target, 'SendToChatResult').error,
    },
    constructorSignatures: {
      '': 'SendToChatResult({required String target, required bool success, required String answer, required bool rejected, required String error})',
      'fromJson': 'factory SendToChatResult.fromJson(Map<String, dynamic> json)',
    },
    getterSignatures: {
      'target': 'String get target',
      'success': 'bool get success',
      'answer': 'String get answer',
      'rejected': 'bool get rejected',
      'error': 'String get error',
    },
  );
}

// =============================================================================
// TomChatApi Bridge
// =============================================================================

BridgedClass _createTomChatApiBridge() {
  return BridgedClass(
    nativeType: $tom_vscode_scripting_api_13.TomChatApi,
    name: 'TomChatApi',
    isAssignable: (v) => v is $tom_vscode_scripting_api_13.TomChatApi,
    isAbstract: true,
    constructors: {
    },
    staticMethods: {
      'setAdapter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'setAdapter');
        final adapter = D4.getRequiredArg<$tom_vscode_scripting_api_21.VSCodeAdapter>(positional, 0, 'adapter', 'setAdapter');
        return $tom_vscode_scripting_api_13.TomChatApi.setAdapter(adapter);
      },
      'sendToChat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sendToChat');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'sendToChat');
        return $tom_vscode_scripting_api_13.TomChatApi.sendToChat(prompt);
      },
    },
    staticMethodSignatures: {
      'setAdapter': 'void setAdapter(VSCodeAdapter adapter)',
      'sendToChat': 'Future<SendToChatResult> sendToChat(String prompt)',
    },
  );
}


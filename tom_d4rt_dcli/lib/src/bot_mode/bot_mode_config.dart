/// Bot Mode Configuration
///
/// Configuration classes for Telegram bot mode in D4rt REPL tools.
library;

import 'dart:io';
import 'package:yaml/yaml.dart';

/// Main configuration for bot mode.
class BotModeConfig {
  /// Bot configurations
  final List<BotConfig> bots;

  /// Global security settings
  final SecurityConfig security;

  /// Output formatting settings
  final OutputConfig output;

  /// Polling settings
  final PollingConfig polling;

  /// File transfer settings
  final FileTransferConfig files;

  BotModeConfig({
    required this.bots,
    required this.security,
    required this.output,
    required this.polling,
    required this.files,
  });

  /// Load configuration from a YAML file.
  static Future<BotModeConfig> loadFromFile(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw FileSystemException('Bot config file not found', path);
    }

    final content = await file.readAsString();
    final yaml = loadYaml(content) as YamlMap;

    return BotModeConfig.fromYaml(yaml);
  }

  /// Create configuration from YAML map.
  factory BotModeConfig.fromYaml(YamlMap yaml) {
    final botsYaml = yaml['bots'] as YamlList? ?? [];
    final bots = botsYaml.map((b) => BotConfig.fromYaml(b as YamlMap)).toList();

    final securityYaml = yaml['security'] as YamlMap? ?? YamlMap();
    final security = SecurityConfig.fromYaml(securityYaml);

    final outputYaml = yaml['output'] as YamlMap? ?? YamlMap();
    final output = OutputConfig.fromYaml(outputYaml);

    final pollingYaml = yaml['polling'] as YamlMap? ?? YamlMap();
    final polling = PollingConfig.fromYaml(pollingYaml);

    final filesYaml = yaml['files'] as YamlMap? ?? YamlMap();
    final files = FileTransferConfig.fromYaml(filesYaml);

    return BotModeConfig(
      bots: bots,
      security: security,
      output: output,
      polling: polling,
      files: files,
    );
  }

  /// Create a minimal default configuration.
  factory BotModeConfig.defaults() {
    return BotModeConfig(
      bots: [],
      security: SecurityConfig.defaults(),
      output: OutputConfig.defaults(),
      polling: PollingConfig.defaults(),
      files: FileTransferConfig.defaults(),
    );
  }
}

/// Configuration for a single bot.
class BotConfig {
  /// Bot name (for display)
  final String name;

  /// Environment variable containing the bot token
  final String tokenEnv;

  /// Allowed Telegram user IDs
  final List<int> allowedUsers;

  /// VS Code connection settings (optional)
  final VSCodeConfig? vscode;

  /// Bot-specific security overrides
  final SecurityConfig? security;

  BotConfig({
    required this.name,
    required this.tokenEnv,
    required this.allowedUsers,
    this.vscode,
    this.security,
  });

  factory BotConfig.fromYaml(YamlMap yaml) {
    final allowedUsersYaml = yaml['allowed-users'] as YamlList? ?? [];
    final allowedUsers = allowedUsersYaml.map((u) => u as int).toList();

    VSCodeConfig? vscode;
    if (yaml.containsKey('vscode')) {
      vscode = VSCodeConfig.fromYaml(yaml['vscode'] as YamlMap);
    }

    SecurityConfig? security;
    if (yaml.containsKey('security')) {
      security = SecurityConfig.fromYaml(yaml['security'] as YamlMap);
    }

    return BotConfig(
      name: yaml['name'] as String? ?? 'default',
      tokenEnv: yaml['token-env'] as String? ?? 'TELEGRAM_BOT_TOKEN',
      allowedUsers: allowedUsers,
      vscode: vscode,
      security: security,
    );
  }
}

/// VS Code connection configuration.
class VSCodeConfig {
  final String host;
  final int port;

  VSCodeConfig({
    required this.host,
    required this.port,
  });

  factory VSCodeConfig.fromYaml(YamlMap yaml) {
    return VSCodeConfig(
      host: yaml['host'] as String? ?? '127.0.0.1',
      port: yaml['port'] as int? ?? 19900,
    );
  }
}

/// Security configuration.
class SecurityConfig {
  /// Command restrictions
  final CommandsConfig commands;

  /// Directory restrictions
  final DirectoriesConfig directories;

  /// Execution limits
  final LimitsConfig limits;

  SecurityConfig({
    required this.commands,
    required this.directories,
    required this.limits,
  });

  factory SecurityConfig.fromYaml(YamlMap yaml) {
    final commandsYaml = yaml['commands'] as YamlMap? ?? YamlMap();
    final directoriesYaml = yaml['directories'] as YamlMap? ?? YamlMap();
    final limitsYaml = yaml['limits'] as YamlMap? ?? YamlMap();

    return SecurityConfig(
      commands: CommandsConfig.fromYaml(commandsYaml),
      directories: DirectoriesConfig.fromYaml(directoriesYaml),
      limits: LimitsConfig.fromYaml(limitsYaml),
    );
  }

  factory SecurityConfig.defaults() {
    return SecurityConfig(
      commands: CommandsConfig.defaults(),
      directories: DirectoriesConfig.defaults(),
      limits: LimitsConfig.defaults(),
    );
  }

  /// Merge with another config (for bot-specific overrides).
  SecurityConfig merge(SecurityConfig? other) {
    if (other == null) return this;
    return SecurityConfig(
      commands: commands.merge(other.commands),
      directories: directories.merge(other.directories),
      limits: limits.merge(other.limits),
    );
  }
}

/// Command restriction configuration.
class CommandsConfig {
  /// 'whitelist' or 'blacklist'
  final String mode;

  /// Allowed commands (for whitelist mode)
  final List<String> allowed;

  /// Blocked commands (for blacklist mode or additional blocks)
  final List<String> blocked;

  CommandsConfig({
    required this.mode,
    required this.allowed,
    required this.blocked,
  });

  factory CommandsConfig.fromYaml(YamlMap yaml) {
    final allowedYaml = yaml['allowed'] as YamlList? ?? [];
    final blockedYaml = yaml['blocked'] as YamlList? ?? [];

    return CommandsConfig(
      mode: yaml['mode'] as String? ?? 'whitelist',
      allowed: allowedYaml.map((c) => c as String).toList(),
      blocked: blockedYaml.map((c) => c as String).toList(),
    );
  }

  factory CommandsConfig.defaults() {
    return CommandsConfig(
      mode: 'whitelist',
      allowed: [
        'help',
        'info',
        'classes',
        'version',
        'status',
        '.load',
        '.replay',
        '.history',
        'print',
        'clear',
      ],
      blocked: [
        'Process.run',
        'Process.start',
        'File.delete',
        'Directory.delete',
        'exit',
        'quit',
      ],
    );
  }

  CommandsConfig merge(CommandsConfig other) {
    return CommandsConfig(
      mode: other.mode,
      allowed: {...allowed, ...other.allowed}.toList(),
      blocked: {...blocked, ...other.blocked}.toList(),
    );
  }
}

/// Directory restriction configuration.
class DirectoriesConfig {
  /// 'whitelist' or 'blacklist'
  final String mode;

  /// Allowed directories
  final List<String> allowed;

  /// Blocked directories
  final List<String> blocked;

  DirectoriesConfig({
    required this.mode,
    required this.allowed,
    required this.blocked,
  });

  factory DirectoriesConfig.fromYaml(YamlMap yaml) {
    final allowedYaml = yaml['allowed'] as YamlList? ?? [];
    final blockedYaml = yaml['blocked'] as YamlList? ?? [];

    return DirectoriesConfig(
      mode: yaml['mode'] as String? ?? 'whitelist',
      allowed: allowedYaml.map((d) => d as String).toList(),
      blocked: blockedYaml.map((d) => d as String).toList(),
    );
  }

  factory DirectoriesConfig.defaults() {
    return DirectoriesConfig(
      mode: 'whitelist',
      allowed: [
        '~/scripts',
        '~/notes',
        '~/.tom',
        '/tmp/telegram-files',
      ],
      blocked: [
        '~/.ssh',
        '~/.gnupg',
        '~/.config/secrets',
        '~/.aws',
      ],
    );
  }

  DirectoriesConfig merge(DirectoriesConfig other) {
    return DirectoriesConfig(
      mode: other.mode,
      allowed: {...allowed, ...other.allowed}.toList(),
      blocked: {...blocked, ...other.blocked}.toList(),
    );
  }
}

/// Execution limits configuration.
class LimitsConfig {
  /// Maximum execution time
  final Duration maxExecutionTime;

  /// Maximum output characters
  final int maxOutputChars;

  /// Maximum file size for transfers
  final int maxFileSize;

  /// Minimum interval between messages
  final Duration minMessageInterval;

  LimitsConfig({
    required this.maxExecutionTime,
    required this.maxOutputChars,
    required this.maxFileSize,
    required this.minMessageInterval,
  });

  factory LimitsConfig.fromYaml(YamlMap yaml) {
    return LimitsConfig(
      maxExecutionTime: _parseDuration(yaml['max-execution-time'] as String? ?? '30s'),
      maxOutputChars: yaml['max-output-chars'] as int? ?? 4000,
      maxFileSize: _parseFileSize(yaml['max-file-size'] as String? ?? '20MB'),
      minMessageInterval: _parseDuration(yaml['min-message-interval'] as String? ?? '100ms'),
    );
  }

  factory LimitsConfig.defaults() {
    return LimitsConfig(
      maxExecutionTime: const Duration(seconds: 30),
      maxOutputChars: 4000,
      maxFileSize: 20 * 1024 * 1024, // 20MB
      minMessageInterval: const Duration(milliseconds: 100),
    );
  }

  LimitsConfig merge(LimitsConfig other) {
    return other; // Take the override values
  }

  static Duration _parseDuration(String value) {
    if (value.endsWith('ms')) {
      return Duration(milliseconds: int.parse(value.replaceAll('ms', '')));
    } else if (value.endsWith('s')) {
      return Duration(seconds: int.parse(value.replaceAll('s', '')));
    } else if (value.endsWith('m')) {
      return Duration(minutes: int.parse(value.replaceAll('m', '')));
    }
    return Duration(seconds: int.tryParse(value) ?? 30);
  }

  static int _parseFileSize(String value) {
    final upper = value.toUpperCase();
    if (upper.endsWith('MB')) {
      return int.parse(upper.replaceAll('MB', '')) * 1024 * 1024;
    } else if (upper.endsWith('KB')) {
      return int.parse(upper.replaceAll('KB', '')) * 1024;
    } else if (upper.endsWith('GB')) {
      return int.parse(upper.replaceAll('GB', '')) * 1024 * 1024 * 1024;
    }
    return int.tryParse(value) ?? (20 * 1024 * 1024);
  }
}

/// Output formatting configuration.
class OutputConfig {
  /// Wrap output in monospace blocks
  final bool useMonospace;

  /// Strip ANSI color codes
  final bool stripAnsi;

  /// Convert markdown to Telegram format
  final bool convertMarkdown;

  /// Maximum output characters before truncation
  final int maxOutputChars;

  /// Attach full output as file when truncated
  final bool attachFullOutput;

  /// Truncation suffix
  final String truncationSuffix;
  
  /// Auto-attach files from Copilot Chat requestedAttachments
  final bool autoAttachCopilotFiles;
  
  /// Bypass all formatting and pass raw output with Markdown parse mode.
  /// When true, skips all processing and sends output directly.
  final bool rawPassthrough;

  OutputConfig({
    required this.useMonospace,
    required this.stripAnsi,
    required this.convertMarkdown,
    required this.maxOutputChars,
    required this.attachFullOutput,
    required this.truncationSuffix,
    this.autoAttachCopilotFiles = true,
    this.rawPassthrough = false,
  });

  factory OutputConfig.fromYaml(YamlMap yaml) {
    return OutputConfig(
      useMonospace: yaml['use-monospace'] as bool? ?? true,
      stripAnsi: yaml['strip-ansi'] as bool? ?? true,
      convertMarkdown: yaml['convert-markdown'] as bool? ?? true,
      maxOutputChars: yaml['long-output-attach-result-limit'] as int? ?? 4000,
      attachFullOutput: yaml['attach-full-output'] as bool? ?? true,
      truncationSuffix: yaml['truncation-suffix'] as String? ?? 
          '\n... (output truncated, {remaining} more chars)',
      autoAttachCopilotFiles: yaml['auto-attach-copilot-files'] as bool? ?? true,
      rawPassthrough: yaml['raw-passthrough'] as bool? ?? false,
    );
  }

  factory OutputConfig.defaults() {
    return OutputConfig(
      useMonospace: true,
      stripAnsi: true,
      convertMarkdown: true,
      maxOutputChars: 4000,
      attachFullOutput: true,
      truncationSuffix: '\n... (output truncated, {remaining} more chars)',
      autoAttachCopilotFiles: true,
      rawPassthrough: true,  // Enable by default for testing
    );
  }
}

/// Polling configuration.
class PollingConfig {
  /// Polling interval
  final Duration interval;

  /// Long-polling timeout
  final Duration timeout;

  /// Retry delay on error
  final Duration retryDelay;

  /// Maximum retries
  final int maxRetries;

  PollingConfig({
    required this.interval,
    required this.timeout,
    required this.retryDelay,
    required this.maxRetries,
  });

  factory PollingConfig.fromYaml(YamlMap yaml) {
    return PollingConfig(
      interval: LimitsConfig._parseDuration(yaml['interval'] as String? ?? '2s'),
      timeout: LimitsConfig._parseDuration(yaml['timeout'] as String? ?? '30s'),
      retryDelay: LimitsConfig._parseDuration(yaml['retry-delay'] as String? ?? '5s'),
      maxRetries: yaml['max-retries'] as int? ?? 3,
    );
  }

  factory PollingConfig.defaults() {
    return PollingConfig(
      interval: const Duration(seconds: 2),
      timeout: const Duration(seconds: 30),
      retryDelay: const Duration(seconds: 5),
      maxRetries: 3,
    );
  }
}

/// File transfer configuration.
class FileTransferConfig {
  /// Temporary directory for file transfers
  final String tempDirectory;

  /// Cleanup duration
  final Duration cleanupAfter;

  /// Allowed file extensions
  final List<String> allowedExtensions;

  /// Blocked file extensions
  final List<String> blockedExtensions;

  FileTransferConfig({
    required this.tempDirectory,
    required this.cleanupAfter,
    required this.allowedExtensions,
    required this.blockedExtensions,
  });

  factory FileTransferConfig.fromYaml(YamlMap yaml) {
    final allowedYaml = yaml['allowed-extensions'] as YamlList? ?? [];
    final blockedYaml = yaml['blocked-extensions'] as YamlList? ?? [];

    return FileTransferConfig(
      tempDirectory: yaml['temp-directory'] as String? ?? '/tmp/telegram-files',
      cleanupAfter: LimitsConfig._parseDuration(yaml['cleanup-after'] as String? ?? '1h'),
      allowedExtensions: allowedYaml.map((e) => e as String).toList(),
      blockedExtensions: blockedYaml.map((e) => e as String).toList(),
    );
  }

  factory FileTransferConfig.defaults() {
    return FileTransferConfig(
      tempDirectory: '/tmp/telegram-files',
      cleanupAfter: const Duration(hours: 1),
      allowedExtensions: [
        '.dart',
        '.yaml',
        '.json',
        '.md',
        '.txt',
        '.log',
        '.d4rt',
        '.dcli',
        '.tom',
      ],
      blockedExtensions: [
        '.exe',
        '.sh',
        '.bash',
        '.zsh',
        '.key',
        '.pem',
      ],
    );
  }
}

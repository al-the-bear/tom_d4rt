/// Security Manager for Bot Mode
///
/// Validates commands and file paths against security configuration.
library;

import 'dart:io';

import 'bot_mode_config.dart';

/// Result of a permission check.
class PermissionResult {
  /// Whether the action is permitted.
  final bool permitted;

  /// Reason for denial (if not permitted).
  final String? reason;

  PermissionResult._(this.permitted, this.reason);

  /// Create an allowed result.
  factory PermissionResult.allowed() => PermissionResult._(true, null);

  /// Create a denied result with reason.
  factory PermissionResult.denied(String reason) =>
      PermissionResult._(false, reason);
}

/// Security manager that validates commands and paths.
class SecurityManager {
  final SecurityConfig config;

  /// Commands that are always allowed (safety commands).
  static const alwaysAllowed = [
    'help',
    'info',
    'classes',
    'methods',
    'variables',
    'enums',
    'version',
    'status',
    'ping',
  ];

  SecurityManager(this.config);

  /// Create a new security manager with overrides.
  SecurityManager withOverrides(SecurityConfig? overrides) {
    if (overrides == null) return this;
    return SecurityManager(config.merge(overrides));
  }

  /// Check if a command is allowed.
  PermissionResult isCommandAllowed(String command) {
    final cmdName = _extractCommandName(command);

    // Always allow safe commands
    if (alwaysAllowed.contains(cmdName)) {
      return PermissionResult.allowed();
    }

    // Check blocked list first (applies in both modes)
    if (_matchesPatterns(cmdName, config.commands.blocked) ||
        _matchesPatterns(command, config.commands.blocked)) {
      return PermissionResult.denied('Command is blocked');
    }

    // Check whitelist/blacklist mode
    if (config.commands.mode == 'whitelist') {
      if (!_matchesPatterns(cmdName, config.commands.allowed) &&
          !_matchesPatterns(command, config.commands.allowed)) {
        return PermissionResult.denied('Command not in whitelist');
      }
    }

    return PermissionResult.allowed();
  }

  /// Check if a file path is allowed.
  PermissionResult isPathAllowed(String path) {
    final normalized = _normalizePath(path);

    // Check blocked directories first
    for (final blocked in config.directories.blocked) {
      final expandedBlocked = _expandPath(blocked);
      if (normalized.startsWith(expandedBlocked)) {
        return PermissionResult.denied('Path is in blocked directory: $blocked');
      }
    }

    // Check allowed directories in whitelist mode
    if (config.directories.mode == 'whitelist') {
      var allowed = false;
      for (final dir in config.directories.allowed) {
        final expandedDir = _expandPath(dir);
        if (normalized.startsWith(expandedDir)) {
          allowed = true;
          break;
        }
      }
      if (!allowed) {
        return PermissionResult.denied('Path not in allowed directories');
      }
    }

    return PermissionResult.allowed();
  }

  /// Check if a user is allowed for a specific bot.
  bool isUserAllowed(int userId, List<int> allowedUsers) {
    return allowedUsers.contains(userId);
  }

  /// Extract the command name from a full command line.
  String _extractCommandName(String command) {
    final trimmed = command.trim();

    // Handle dot commands
    if (trimmed.startsWith('.')) {
      final parts = trimmed.split(RegExp(r'\s+'));
      return parts.first;
    }

    // Handle colon commands (tom CLI)
    if (trimmed.startsWith(':')) {
      final parts = trimmed.split(RegExp(r'\s+'));
      return parts.first;
    }

    // Handle regular commands - extract function call
    final match = RegExp(r'^([a-zA-Z_][a-zA-Z0-9_]*(?:\.[a-zA-Z_][a-zA-Z0-9_]*)*)').firstMatch(trimmed);
    if (match != null) {
      return match.group(1)!;
    }

    return trimmed;
  }

  /// Check if a value matches any of the patterns.
  bool _matchesPatterns(String value, List<String> patterns) {
    for (final pattern in patterns) {
      if (_matchPattern(value, pattern)) {
        return true;
      }
    }
    return false;
  }

  /// Match a value against a pattern (supports * wildcard and : prefix).
  bool _matchPattern(String value, String pattern) {
    // Handle :* pattern (matches any colon command)
    if (pattern == ':*') {
      return value.startsWith(':');
    }

    // Handle wildcard patterns
    if (pattern.contains('*')) {
      final regexPattern = pattern
          .replaceAll('.', r'\.')
          .replaceAll('*', '.*');
      return RegExp('^$regexPattern\$').hasMatch(value);
    }

    // Exact match
    return value == pattern;
  }

  /// Normalize a path for comparison.
  String _normalizePath(String path) {
    var normalized = path;

    // Expand ~ to home directory
    if (normalized.startsWith('~/')) {
      final home = Platform.environment['HOME'] ?? '';
      normalized = normalized.replaceFirst('~', home);
    }

    // Expand ~~ to workspace root (handled by caller)
    // This just normalizes the path structure

    // Resolve to absolute path
    return File(normalized).absolute.path;
  }

  /// Expand a path pattern for comparison.
  String _expandPath(String path) {
    var expanded = path;

    // Expand ~ to home directory
    if (expanded.startsWith('~/')) {
      final home = Platform.environment['HOME'] ?? '';
      expanded = expanded.replaceFirst('~', home);
    }

    return expanded;
  }
}

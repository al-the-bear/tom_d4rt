import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';

// =============================================================================
// Bundle Format Configuration
// =============================================================================

/// Configuration constants for the [AstBundle] file format.
///
/// Centralizes all format-defining values to avoid hardcoded literals
/// throughout the codebase. These constants define:
/// - File format version and extensions
/// - Archive entry naming conventions
/// - JSON key names for serialization
/// - Magic byte sequences for format detection
abstract final class AstBundleFormat {
  /// Current bundle format version identifier.
  ///
  /// Increment when making breaking changes to the serialization format.
  static const String version = '1.0';

  /// Default file extension for bundle archives.
  static const String bundleExtension = '.ast';

  /// File extension suffix for AST JSON entries within the archive.
  static const String astJsonSuffix = '.ast.json';

  /// Name of the manifest file within the ZIP archive.
  static const String manifestFileName = 'manifest.json';

  // ── JSON Key Names ──

  /// Key for the format version field.
  static const String keyVersion = 'version';

  /// Key for the entry point URI field.
  static const String keyEntryPoint = 'entryPoint';

  /// Key for the file-to-URI mapping in the manifest.
  static const String keyFiles = 'files';

  /// Key for the modules map in the JSON serialization.
  static const String keyModules = 'modules';

  // ── Magic Bytes for Format Detection ──

  /// ZIP file signature bytes (`PK\x03\x04`).
  static const List<int> zipMagicBytes = [0x50, 0x4B, 0x03, 0x04];

  /// Gzip file signature bytes (`\x1f\x8b`).
  static const List<int> gzipMagicBytes = [0x1F, 0x8B];
}

// =============================================================================
// Bundle Manifest
// =============================================================================

/// Describes the contents of an [AstBundle] ZIP archive.
///
/// The manifest maps archive file names to module URIs and identifies
/// the entry point. It is stored as plain JSON at
/// [AstBundleFormat.manifestFileName] within the ZIP archive.
///
/// ## Example manifest.json
/// ```json
/// {
///   "version": "1.0",
///   "entryPoint": "bin/main.dart",
///   "files": {
///     "0.ast.json": "bin/main.dart",
///     "1.ast.json": "lib/utils.dart"
///   }
/// }
/// ```
class AstBundleManifest {
  /// Format version of this manifest.
  final String version;

  /// URI of the entry point module (e.g. `bin/main.dart`).
  final String entryPoint;

  /// Mapping from archive file name (e.g. `0.ast.json`) to module URI.
  final Map<String, String> files;

  const AstBundleManifest({
    required this.version,
    required this.entryPoint,
    required this.files,
  });

  /// Serializes this manifest to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    AstBundleFormat.keyVersion: version,
    AstBundleFormat.keyEntryPoint: entryPoint,
    AstBundleFormat.keyFiles: files,
  };

  /// Deserializes a manifest from a JSON map.
  ///
  /// Throws [ArgumentD4rtException] if required fields are missing
  /// or have invalid types.
  factory AstBundleManifest.fromJson(Map<String, dynamic> json) {
    final version = json[AstBundleFormat.keyVersion] as String?;
    if (version == null) {
      throw ArgumentD4rtException(
        'Invalid bundle manifest: '
        'missing "${AstBundleFormat.keyVersion}"',
      );
    }

    final entryPoint = json[AstBundleFormat.keyEntryPoint] as String?;
    if (entryPoint == null) {
      throw ArgumentD4rtException(
        'Invalid bundle manifest: '
        'missing "${AstBundleFormat.keyEntryPoint}"',
      );
    }

    final filesJson = json[AstBundleFormat.keyFiles];
    if (filesJson is! Map<String, dynamic>) {
      throw ArgumentD4rtException(
        'Invalid bundle manifest: '
        '"${AstBundleFormat.keyFiles}" must be a JSON object',
      );
    }

    return AstBundleManifest(
      version: version,
      entryPoint: entryPoint,
      files: filesJson.map((k, v) => MapEntry(k, v.toString())),
    );
  }

  @override
  String toString() =>
      'AstBundleManifest(version: $version, '
      'entryPoint: $entryPoint, '
      'files: ${files.length})';
}

// =============================================================================
// AstBundle
// =============================================================================

/// A transportable unit containing an entry point and all required modules.
///
/// [AstBundle] is the primary distribution format for pre-parsed D4rt scripts.
/// It encapsulates one or more [SCompilationUnit] modules that can be executed
/// by `D4rtRunner` without requiring the Dart analyzer.
///
/// ## Serialization Formats
///
/// | Format | Methods | Use Case |
/// |--------|---------|----------|
/// | JSON   | [toJson] / [fromJson] | Debugging, tool integration |
/// | Bytes  | [toBytes] / [fromBytes] | Network transfer, in-memory |
/// | ZIP    | [toZip] / [fromZip] | File distribution (`.ast`) |
/// | File   | [saveToFile] / [fromFile] | Disk I/O with auto-detection |
///
/// ## Example
///
/// ```dart
/// // Create and save a bundle
/// final bundle = AstBundle(
///   entryPointUri: 'bin/main.dart',
///   modules: {'bin/main.dart': mainAst, 'lib/utils.dart': utilsAst},
/// );
/// bundle.saveToFile('my_script.ast');
///
/// // Load and execute
/// final loaded = AstBundle.fromFile('my_script.ast');
/// final runner = D4rtRunner();
/// runner.execute(ast: loaded.entryPoint);
/// ```
class AstBundle {
  /// URI identifying the entry point module.
  final String entryPointUri;

  /// All modules in this bundle, keyed by their URI.
  final Map<String, SCompilationUnit> modules;

  /// Creates an [AstBundle] with the given entry point and modules.
  ///
  /// Throws [ArgumentD4rtException] if [entryPointUri] is not present
  /// in [modules].
  AstBundle({required this.entryPointUri, required this.modules}) {
    if (!modules.containsKey(entryPointUri)) {
      throw ArgumentD4rtException(
        'Entry point "$entryPointUri" not found in modules. '
        'Available: ${modules.keys.join(", ")}',
      );
    }
  }

  /// The entry point [SCompilationUnit].
  SCompilationUnit get entryPoint => modules[entryPointUri]!;

  /// Number of modules in this bundle.
  int get moduleCount => modules.length;

  /// Whether this bundle contains only the entry point module.
  bool get isSingleModule => modules.length == 1;

  // ===========================================================================
  // JSON Serialization
  // ===========================================================================

  /// Serializes this bundle to a JSON-compatible map.
  ///
  /// The resulting map includes format version, entry point URI,
  /// and all module ASTs keyed by their URI.
  Map<String, dynamic> toJson() => {
    AstBundleFormat.keyVersion: AstBundleFormat.version,
    AstBundleFormat.keyEntryPoint: entryPointUri,
    AstBundleFormat.keyModules: modules.map(
      (uri, cu) => MapEntry(uri, cu.toJson()),
    ),
  };

  /// Deserializes a bundle from a JSON map.
  ///
  /// Throws [ArgumentD4rtException] if required fields are missing
  /// or module data is invalid.
  factory AstBundle.fromJson(Map<String, dynamic> json) {
    _requireString(json, AstBundleFormat.keyVersion, 'bundle JSON');
    final entryPointUri = _requireString(
      json,
      AstBundleFormat.keyEntryPoint,
      'bundle JSON',
    );

    final modulesJson = json[AstBundleFormat.keyModules];
    if (modulesJson is! Map<String, dynamic>) {
      throw ArgumentD4rtException(
        'Invalid bundle JSON: '
        '"${AstBundleFormat.keyModules}" must be a JSON object',
      );
    }

    final modules = <String, SCompilationUnit>{};
    for (final entry in modulesJson.entries) {
      if (entry.value is! Map<String, dynamic>) {
        throw ArgumentD4rtException(
          'Invalid bundle JSON: '
          'module "${entry.key}" is not a valid AST object',
        );
      }
      modules[entry.key] = SCompilationUnit.fromJson(
        entry.value as Map<String, dynamic>,
      );
    }

    return AstBundle(entryPointUri: entryPointUri, modules: modules);
  }

  // ===========================================================================
  // Binary Serialization (gzip-compressed JSON)
  // ===========================================================================

  /// Serializes this bundle as gzip-compressed JSON bytes.
  ///
  /// Compact format suitable for network transfer and in-memory storage.
  /// For file distribution, prefer [toZip] / [saveToFile].
  List<int> toBytes() {
    final jsonString = jsonEncode(toJson());
    return gzip.encode(utf8.encode(jsonString));
  }

  /// Deserializes a bundle from gzip-compressed JSON bytes.
  ///
  /// Throws [ArgumentD4rtException] if decompression or parsing fails.
  factory AstBundle.fromBytes(List<int> bytes) {
    try {
      final decompressed = gzip.decode(bytes);
      final jsonString = utf8.decode(decompressed);
      final json = jsonDecode(jsonString);
      if (json is! Map<String, dynamic>) {
        throw ArgumentD4rtException(
          'Invalid bundle bytes: decoded JSON is not an object',
        );
      }
      return AstBundle.fromJson(json);
    } on FormatException catch (e) {
      throw ArgumentD4rtException('Invalid bundle bytes: ${e.message}');
    }
  }

  // ===========================================================================
  // ZIP Archive Serialization
  // ===========================================================================

  /// Serializes this bundle as a ZIP archive.
  ///
  /// The archive follows the `.ast` bundle specification:
  /// - `manifest.json` — plain JSON with metadata and file-to-URI mapping
  /// - `N.ast.json` — gzip-compressed JSON for each module
  ///
  /// Module entries are pre-compressed with gzip and stored without
  /// additional ZIP-level compression, allowing individual modules
  /// to be extracted and used standalone.
  List<int> toZip() {
    final archive = Archive();

    // Assign sequential file names to each module
    final fileToUri = <String, String>{};
    final uriToFileName = <String, String>{};
    var index = 0;
    for (final uri in modules.keys) {
      final fileName = '$index${AstBundleFormat.astJsonSuffix}';
      fileToUri[fileName] = uri;
      uriToFileName[uri] = fileName;
      index++;
    }

    // Write manifest (uncompressed, human-readable)
    final manifest = AstBundleManifest(
      version: AstBundleFormat.version,
      entryPoint: entryPointUri,
      files: fileToUri,
    );
    final manifestJson = const JsonEncoder.withIndent('  ').convert(
      manifest.toJson(),
    );
    archive.addFile(
      ArchiveFile.string(AstBundleFormat.manifestFileName, manifestJson),
    );

    // Write each module as gzip-compressed JSON
    for (final entry in modules.entries) {
      final fileName = uriToFileName[entry.key]!;
      final moduleJson = jsonEncode(entry.value.toJson());
      final compressed = gzip.encode(utf8.encode(moduleJson));
      // Use noCompress: content is already gzip-compressed
      archive.addFile(
        ArchiveFile.noCompress(fileName, compressed.length, compressed),
      );
    }

    return ZipEncoder().encode(archive);
  }

  /// Deserializes a bundle from ZIP archive bytes.
  ///
  /// Reads the manifest to discover module URIs, then loads and
  /// decompresses each referenced module file.
  ///
  /// Throws [ArgumentD4rtException] if the archive is invalid,
  /// the manifest is missing, or referenced module files are absent.
  factory AstBundle.fromZip(List<int> bytes) {
    final Archive archive;
    try {
      archive = ZipDecoder().decodeBytes(bytes);
    } catch (e) {
      throw ArgumentD4rtException('Invalid ZIP archive: $e');
    }

    // Parse manifest
    final manifestFile = archive.findFile(AstBundleFormat.manifestFileName);
    if (manifestFile == null) {
      throw ArgumentD4rtException(
        'Invalid bundle archive: '
        'missing "${AstBundleFormat.manifestFileName}"',
      );
    }

    final manifestJson = jsonDecode(utf8.decode(manifestFile.content));
    if (manifestJson is! Map<String, dynamic>) {
      throw ArgumentD4rtException(
        'Invalid bundle archive: manifest is not a valid JSON object',
      );
    }
    final manifest = AstBundleManifest.fromJson(manifestJson);

    // Load each module referenced by the manifest
    final modules = <String, SCompilationUnit>{};
    for (final entry in manifest.files.entries) {
      final fileName = entry.key;
      final uri = entry.value;

      final file = archive.findFile(fileName);
      if (file == null) {
        throw ArgumentD4rtException(
          'Invalid bundle archive: '
          'module file "$fileName" referenced in manifest not found',
        );
      }

      final moduleJson = _decodeModuleContent(file.content, uri, fileName);
      modules[uri] = SCompilationUnit.fromJson(moduleJson);
    }

    return AstBundle(entryPointUri: manifest.entryPoint, modules: modules);
  }

  // ===========================================================================
  // File I/O
  // ===========================================================================

  /// Saves this bundle to a file in ZIP archive format.
  ///
  /// Creates parent directories if they don't exist.
  void saveToFile(String path) {
    final file = File(path);
    file.parent.createSync(recursive: true);
    file.writeAsBytesSync(toZip());
  }

  /// Loads a bundle from a file.
  ///
  /// Auto-detects the format based on file content magic bytes:
  /// - ZIP archive (standard `.ast` files)
  /// - Gzip-compressed JSON
  /// - Plain JSON (fallback)
  ///
  /// Throws [ArgumentD4rtException] if the file doesn't exist,
  /// is empty, or has an unrecognized format.
  factory AstBundle.fromFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      throw ArgumentD4rtException('Bundle file not found: $path');
    }

    final bytes = file.readAsBytesSync();
    if (bytes.isEmpty) {
      throw ArgumentD4rtException('Bundle file is empty: $path');
    }

    // Auto-detect format from magic bytes
    if (_startsWith(bytes, AstBundleFormat.zipMagicBytes)) {
      return AstBundle.fromZip(bytes);
    }
    if (_startsWith(bytes, AstBundleFormat.gzipMagicBytes)) {
      return AstBundle.fromBytes(bytes);
    }

    // Fallback: try plain JSON
    try {
      final json = jsonDecode(utf8.decode(bytes));
      if (json is Map<String, dynamic>) {
        return AstBundle.fromJson(json);
      }
    } catch (_) {
      // Fall through to error
    }

    throw ArgumentD4rtException(
      'Unrecognized bundle format in file: $path',
    );
  }

  // ===========================================================================
  // Private Helpers
  // ===========================================================================

  /// Decodes module content bytes, handling optional gzip compression.
  static Map<String, dynamic> _decodeModuleContent(
    List<int> content,
    String uri,
    String fileName,
  ) {
    var bytes = content;
    if (_startsWith(bytes, AstBundleFormat.gzipMagicBytes)) {
      bytes = gzip.decode(bytes);
    }

    final decoded = jsonDecode(utf8.decode(bytes));
    if (decoded is! Map<String, dynamic>) {
      throw ArgumentD4rtException(
        'Invalid bundle archive: '
        'module "$uri" ($fileName) is not a valid AST JSON object',
      );
    }
    return decoded;
  }

  /// Extracts a required string field from a JSON map.
  static String _requireString(
    Map<String, dynamic> json,
    String key,
    String context,
  ) {
    final value = json[key] as String?;
    if (value == null) {
      throw ArgumentD4rtException(
        'Invalid $context: missing "$key"',
      );
    }
    return value;
  }

  /// Checks whether [bytes] starts with the given [prefix].
  static bool _startsWith(List<int> bytes, List<int> prefix) {
    if (bytes.length < prefix.length) return false;
    for (var i = 0; i < prefix.length; i++) {
      if (bytes[i] != prefix[i]) return false;
    }
    return true;
  }

  @override
  String toString() =>
      'AstBundle(entryPoint: $entryPointUri, modules: $moduleCount)';
}

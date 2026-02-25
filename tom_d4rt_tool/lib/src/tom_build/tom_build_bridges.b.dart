// D4rt Bridge - Generated file, do not edit
// Sources: 41 files
// Generated: 2026-02-15T00:34:36.427920

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:io';

import 'package:htmltopdfwidgets/src/htmltagstyles.dart' as $htmltopdfwidgets_1;
import 'package:pdf/src/pdf/page_format.dart' as $pdf_1;
import 'package:pdf/src/widgets/geometry.dart' as $pdf_2;
import 'package:pdf/src/widgets/widget.dart' as $pdf_3;
import 'package:tom_build/src/analyzer/workspace_analyzer.dart' as $tom_build_1;
import 'package:tom_build/src/doc_scanner/doc_scanner.dart' as $tom_build_2;
import 'package:tom_build/src/doc_scanner/doc_scanner_factory.dart' as $tom_build_3;
import 'package:tom_build/src/doc_scanner/markdown_parser.dart' as $tom_build_4;
import 'package:tom_build/src/doc_scanner/models/document.dart' as $tom_build_5;
import 'package:tom_build/src/doc_scanner/models/document_folder.dart' as $tom_build_6;
import 'package:tom_build/src/doc_scanner/models/section.dart' as $tom_build_7;
import 'package:tom_build/src/doc_specs/doc_specs.dart' as $tom_build_8;
import 'package:tom_build/src/doc_specs/doc_specs_factory.dart' as $tom_build_9;
import 'package:tom_build/src/doc_specs/models/schema/doc_spec_schema.dart' as $tom_build_10;
import 'package:tom_build/src/doc_specs/models/schema/document_structure.dart' as $tom_build_11;
import 'package:tom_build/src/doc_specs/models/schema/form_type_def.dart' as $tom_build_12;
import 'package:tom_build/src/doc_specs/models/schema/schema_info.dart' as $tom_build_13;
import 'package:tom_build/src/doc_specs/models/schema/section_type_def.dart' as $tom_build_14;
import 'package:tom_build/src/doc_specs/models/spec_doc.dart' as $tom_build_15;
import 'package:tom_build/src/doc_specs/models/spec_section.dart' as $tom_build_16;
import 'package:tom_build/src/doc_specs/models/spec_section_type.dart' as $tom_build_17;
import 'package:tom_build/src/doc_specs/schema/schema_loader.dart' as $tom_build_18;
import 'package:tom_build/src/doc_specs/validation/validation_error.dart' as $tom_build_19;
import 'package:tom_build/src/doc_specs/validation/validator.dart' as $tom_build_20;
import 'package:tom_build/src/md_latex_converter/latex_macros.dart' as $tom_build_21;
import 'package:tom_build/src/md_latex_converter/markdown_parser.dart' as $tom_build_22;
import 'package:tom_build/src/md_latex_converter/md_latex_converter.dart' as $tom_build_23;
import 'package:tom_build/src/md_pdf_converter/md_pdf_converter.dart' as $tom_build_24;
import 'package:tom_build/src/md_pdf_converter/pdf_options_wrapper.dart' as $tom_build_25;
import 'package:tom_build/src/reflection_generator/reflection_generator.dart' as $tom_build_26;
import 'package:tom_build/src/scripting/env.dart' as $tom_build_27;
import 'package:tom_build/src/scripting/fs.dart' as $tom_build_28;
import 'package:tom_build/src/scripting/glob.dart' as $tom_build_29;
import 'package:tom_build/src/scripting/maps.dart' as $tom_build_30;
import 'package:tom_build/src/scripting/path.dart' as $tom_build_31;
import 'package:tom_build/src/scripting/shell.dart' as $tom_build_32;
import 'package:tom_build/src/scripting/text.dart' as $tom_build_33;
import 'package:tom_build/src/scripting/workspace.dart' as $tom_build_34;
import 'package:tom_build/src/scripting/yaml.dart' as $tom_build_35;
import 'package:tom_build/src/scripting/zone.dart' as $tom_build_36;
import 'package:tom_build/src/tom/file_object_model/file_object_model.dart' as $tom_build_37;
import 'package:tom_build/src/tom/file_object_model/workspace_parser.dart' as $tom_build_38;
import 'package:tom_build/src/tom/tom_context.dart' as $tom_build_39;
import 'package:tom_build/src/tools/tool_context.dart' as $tom_build_40;
import 'package:tom_build/src/tools/workspace_info.dart' as $tom_build_41;
import 'package:yaml/src/yaml_node.dart' as $yaml_1;

/// Bridge class for tom_build module.
class TomBuildBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createAnalyzerOptionsBridge(),
      _createWorkspaceAnalyzerBridge(),
      _createProjectInfoBridge(),
      _createPartInfoBridge(),
      _createModuleInfoBridge(),
      _createDocScannerBridge(),
      _createDocScannerFactoryBridge(),
      _createParsedHeadlineBridge(),
      _createMarkdownParserBridge(),
      _createDocumentBridge(),
      _createDocumentFolderBridge(),
      _createSectionBridge(),
      _createDocSpecsBridge(),
      _createDocSpecsFactoryBridge(),
      _createDocSpecSchemaBridge(),
      _createForEachDefBridge(),
      _createSectionDefBridge(),
      _createSubsectionDefBridge(),
      _createDocumentStructureBridge(),
      _createFormFieldDefBridge(),
      _createFormTypeDefBridge(),
      _createSchemaInfoBridge(),
      _createPatternCheckDefBridge(),
      _createSubsectionConstraintBridge(),
      _createSectionTypeDefBridge(),
      _createSpecDocBridge(),
      _createSpecSectionBridge(),
      _createSpecSectionTypeBridge(),
      _createSchemaFilenameParserBridge(),
      _createSchemaLoaderBridge(),
      _createSchemaResolverBridge(),
      _createSchemaDiscoveryBridge(),
      _createValidationErrorBridge(),
      _createDocSpecsValidatorBridge(),
      _createLatexMacrosBridge(),
      _createMarkdownParserOptionsBridge(),
      _createParsedMarkdownBridge(),
      _createMarkdownElementBridge(),
      _createHeadingElementBridge(),
      _createParagraphElementBridge(),
      _createCodeBlockElementBridge(),
      _createInlineCodeElementBridge(),
      _createTableElementBridge(),
      _createUnorderedListElementBridge(),
      _createOrderedListElementBridge(),
      _createBlockQuoteElementBridge(),
      _createHorizontalRuleElementBridge(),
      _createLinkElementBridge(),
      _createImageElementBridge(),
      _createRawTextElementBridge(),
      _createMdLatexConverterBridge(),
      _createMdLatexConverterOptionsBridge(),
      _createMdLatexConverterResultBridge(),
      _createConvertedFileBridge(),
      _createConversionErrorBridge(),
      _createMdPdfConverterBridge(),
      _createMdPdfConverterOptionsBridge(),
      _createMdPdfConverterResultBridge(),
      _createPdfConvertedFileBridge(),
      _createPdfConversionErrorBridge(),
      _createPageMarginsBridge(),
      _createPdfConverterOptionsWrapperBridge(),
      _createReflectionGeneratorRunnerBridge(),
      _createReflectionGeneratorRunnerOptionsBridge(),
      _createReflectionGeneratorRunnerResultBridge(),
      _createTomEnvBridge(),
      _createTomEnvironmentExceptionBridge(),
      _createTomFsBridge(),
      _createTomGlobBridge(),
      _createTomMapsBridge(),
      _createTomPthBridge(),
      _createTomShellBridge(),
      _createTomShellExceptionBridge(),
      _createTomTextBridge(),
      _createWorkspaceInfoBridge(),
      _createMetadataModesBridge(),
      _createMetadataModeBridge(),
      _createWorkspaceGroupBridge(),
      _createWorkspaceProjectBridge(),
      _createPlatformInfoBridge(),
      _createToolContextBridge(),
      _createToolContextExceptionBridge(),
      _createModeValidationResultBridge(),
      _createTomWsBridge(),
      _createScriptYamlBridge(),
      _createTomZonedBridge(),
      _createTomWorkspaceBridge(),
      _createTomMasterBridge(),
      _createTomProjectBridge(),
      _createWorkspaceModesBridge(),
      _createSupportedModeBridge(),
      _createModeTypeConfigBridge(),
      _createModeEntryBridge(),
      _createActionModeConfigurationBridge(),
      _createActionModeEntryBridge(),
      _createModeDefinitionsBridge(),
      _createModeDefBridge(),
      _createActionDefBridge(),
      _createActionConfigBridge(),
      _createGroupDefBridge(),
      _createProjectTypeDefBridge(),
      _createFeaturesBridge(),
      _createCrossCompilationBridge(),
      _createBuildOnTargetBridge(),
      _createPipelineBridge(),
      _createPipelineProjectBridge(),
      _createPipelineActionBridge(),
      _createProjectEntryBridge(),
      _createVersionSettingsBridge(),
      _createPackageModuleBridge(),
      _createPartBridge(),
      _createModuleBridge(),
      _createExecutableDefBridge(),
      _createWorkspaceParserBridge(),
      _createTomContextBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'AnalyzerOptions': 'package:tom_build/src/analyzer/workspace_analyzer.dart',
      'WorkspaceAnalyzer': 'package:tom_build/src/analyzer/workspace_analyzer.dart',
      'ProjectInfo': 'package:tom_build/src/analyzer/workspace_analyzer.dart',
      'PartInfo': 'package:tom_build/src/analyzer/workspace_analyzer.dart',
      'ModuleInfo': 'package:tom_build/src/analyzer/workspace_analyzer.dart',
      'DocScanner': 'package:tom_build/src/doc_scanner/doc_scanner.dart',
      'DocScannerFactory': 'package:tom_build/src/doc_scanner/doc_scanner_factory.dart',
      'ParsedHeadline': 'package:tom_build/src/doc_scanner/markdown_parser.dart',
      'MarkdownParser': 'package:tom_build/src/doc_scanner/markdown_parser.dart',
      'Document': 'package:tom_build/src/doc_scanner/models/document.dart',
      'DocumentFolder': 'package:tom_build/src/doc_scanner/models/document_folder.dart',
      'Section': 'package:tom_build/src/doc_scanner/models/section.dart',
      'DocSpecs': 'package:tom_build/src/doc_specs/doc_specs.dart',
      'DocSpecsFactory': 'package:tom_build/src/doc_specs/doc_specs_factory.dart',
      'DocSpecSchema': 'package:tom_build/src/doc_specs/models/schema/doc_spec_schema.dart',
      'ForEachDef': 'package:tom_build/src/doc_specs/models/schema/document_structure.dart',
      'SectionDef': 'package:tom_build/src/doc_specs/models/schema/document_structure.dart',
      'SubsectionDef': 'package:tom_build/src/doc_specs/models/schema/document_structure.dart',
      'DocumentStructure': 'package:tom_build/src/doc_specs/models/schema/document_structure.dart',
      'FormFieldDef': 'package:tom_build/src/doc_specs/models/schema/form_type_def.dart',
      'FormTypeDef': 'package:tom_build/src/doc_specs/models/schema/form_type_def.dart',
      'SchemaInfo': 'package:tom_build/src/doc_specs/models/schema/schema_info.dart',
      'PatternCheckDef': 'package:tom_build/src/doc_specs/models/schema/section_type_def.dart',
      'SubsectionConstraint': 'package:tom_build/src/doc_specs/models/schema/section_type_def.dart',
      'SectionTypeDef': 'package:tom_build/src/doc_specs/models/schema/section_type_def.dart',
      'SpecDoc': 'package:tom_build/src/doc_specs/models/spec_doc.dart',
      'SpecSection': 'package:tom_build/src/doc_specs/models/spec_section.dart',
      'SpecSectionType': 'package:tom_build/src/doc_specs/models/spec_section_type.dart',
      'SchemaFilenameParser': 'package:tom_build/src/doc_specs/schema/schema_loader.dart',
      'SchemaLoader': 'package:tom_build/src/doc_specs/schema/schema_loader.dart',
      'SchemaResolver': 'package:tom_build/src/doc_specs/schema/schema_loader.dart',
      'SchemaDiscovery': 'package:tom_build/src/doc_specs/schema/schema_loader.dart',
      'ValidationError': 'package:tom_build/src/doc_specs/validation/validation_error.dart',
      'DocSpecsValidator': 'package:tom_build/src/doc_specs/validation/validator.dart',
      'LatexMacros': 'package:tom_build/src/md_latex_converter/latex_macros.dart',
      'MarkdownParserOptions': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'ParsedMarkdown': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'MarkdownElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'HeadingElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'ParagraphElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'CodeBlockElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'InlineCodeElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'TableElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'UnorderedListElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'OrderedListElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'BlockQuoteElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'HorizontalRuleElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'LinkElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'ImageElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'RawTextElement': 'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'MdLatexConverter': 'package:tom_build/src/md_latex_converter/md_latex_converter.dart',
      'MdLatexConverterOptions': 'package:tom_build/src/md_latex_converter/md_latex_converter.dart',
      'MdLatexConverterResult': 'package:tom_build/src/md_latex_converter/md_latex_converter.dart',
      'ConvertedFile': 'package:tom_build/src/md_latex_converter/md_latex_converter.dart',
      'ConversionError': 'package:tom_build/src/md_latex_converter/md_latex_converter.dart',
      'MdPdfConverter': 'package:tom_build/src/md_pdf_converter/md_pdf_converter.dart',
      'MdPdfConverterOptions': 'package:tom_build/src/md_pdf_converter/md_pdf_converter.dart',
      'MdPdfConverterResult': 'package:tom_build/src/md_pdf_converter/md_pdf_converter.dart',
      'PdfConvertedFile': 'package:tom_build/src/md_pdf_converter/md_pdf_converter.dart',
      'PdfConversionError': 'package:tom_build/src/md_pdf_converter/md_pdf_converter.dart',
      'PageMargins': 'package:tom_build/src/md_pdf_converter/pdf_options_wrapper.dart',
      'PdfConverterOptionsWrapper': 'package:tom_build/src/md_pdf_converter/pdf_options_wrapper.dart',
      'ReflectionGeneratorRunner': 'package:tom_build/src/reflection_generator/reflection_generator.dart',
      'ReflectionGeneratorRunnerOptions': 'package:tom_build/src/reflection_generator/reflection_generator.dart',
      'ReflectionGeneratorRunnerResult': 'package:tom_build/src/reflection_generator/reflection_generator.dart',
      'TomEnv': 'package:tom_build/src/scripting/env.dart',
      'TomEnvironmentException': 'package:tom_build/src/scripting/env.dart',
      'TomFs': 'package:tom_build/src/scripting/fs.dart',
      'TomGlob': 'package:tom_build/src/scripting/glob.dart',
      'TomMaps': 'package:tom_build/src/scripting/maps.dart',
      'TomPth': 'package:tom_build/src/scripting/path.dart',
      'TomShell': 'package:tom_build/src/scripting/shell.dart',
      'TomShellException': 'package:tom_build/src/scripting/shell.dart',
      'TomText': 'package:tom_build/src/scripting/text.dart',
      'WorkspaceInfo': 'package:tom_build/src/tools/workspace_info.dart',
      'MetadataModes': 'package:tom_build/src/tools/workspace_info.dart',
      'MetadataMode': 'package:tom_build/src/tools/workspace_info.dart',
      'WorkspaceGroup': 'package:tom_build/src/tools/workspace_info.dart',
      'WorkspaceProject': 'package:tom_build/src/tools/workspace_info.dart',
      'PlatformInfo': 'package:tom_build/src/tools/tool_context.dart',
      'ToolContext': 'package:tom_build/src/tools/tool_context.dart',
      'ToolContextException': 'package:tom_build/src/tools/tool_context.dart',
      'ModeValidationResult': 'package:tom_build/src/tools/tool_context.dart',
      'TomWs': 'package:tom_build/src/scripting/workspace.dart',
      'ScriptYaml': 'package:tom_build/src/scripting/yaml.dart',
      'TomZoned': 'package:tom_build/src/scripting/zone.dart',
      'TomWorkspace': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'TomMaster': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'TomProject': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'WorkspaceModes': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'SupportedMode': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ModeTypeConfig': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ModeEntry': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ActionModeConfiguration': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ActionModeEntry': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ModeDefinitions': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ModeDef': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ActionDef': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ActionConfig': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'GroupDef': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ProjectTypeDef': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'Features': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'CrossCompilation': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'BuildOnTarget': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'Pipeline': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'PipelineProject': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'PipelineAction': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ProjectEntry': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'VersionSettings': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'PackageModule': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'Part': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'Module': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'ExecutableDef': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'WorkspaceParser': 'package:tom_build/src/tom/file_object_model/workspace_parser.dart',
      'TomContext': 'package:tom_build/src/tom/tom_context.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$tom_build_13.SchemaSource>(
        name: 'SchemaSource',
        values: $tom_build_13.SchemaSource.values,
      ),
      BridgedEnumDefinition<$tom_build_19.ValidationErrorCategory>(
        name: 'ValidationErrorCategory',
        values: $tom_build_19.ValidationErrorCategory.values,
      ),
      BridgedEnumDefinition<$tom_build_25.PageFormat>(
        name: 'PageFormat',
        values: $tom_build_25.PageFormat.values,
        methods: {
          'toPdfPageFormat': (visitor, target, positional, named, typeArgs) {
            final t = target as $tom_build_25.PageFormat;
            return Function.apply(t.toPdfPageFormat, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_build_40.CpuArchitecture>(
        name: 'CpuArchitecture',
        values: $tom_build_40.CpuArchitecture.values,
        methods: {
          'toString': (visitor, target, positional, named, typeArgs) {
            final t = target as $tom_build_40.CpuArchitecture;
            return Function.apply(t.toString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedEnumDefinition<$tom_build_40.OperatingSystem>(
        name: 'OperatingSystem',
        values: $tom_build_40.OperatingSystem.values,
        methods: {
          'toString': (visitor, target, positional, named, typeArgs) {
            final t = target as $tom_build_40.OperatingSystem;
            return Function.apply(t.toString, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
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
      'SchemaSource': 'package:tom_build/src/doc_specs/models/schema/schema_info.dart',
      'ValidationErrorCategory': 'package:tom_build/src/doc_specs/validation/validation_error.dart',
      'PageFormat': 'package:tom_build/src/md_pdf_converter/pdf_options_wrapper.dart',
      'CpuArchitecture': 'package:tom_build/src/tools/tool_context.dart',
      'OperatingSystem': 'package:tom_build/src/tools/tool_context.dart',
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

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }

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
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('tom', $tom_build_39.tom, importPath, sourceUri: 'package:tom_build/src/tom/tom_context.dart');
    } catch (e) {
      errors.add('Failed to register variable "tom": $e');
    }

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (tom_build):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'loadYamlFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadYamlFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadYamlFile');
        return $tom_build_37.loadYamlFile(path);
      },
      'makeCleanMap': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'makeCleanMap');
        final data = D4.getRequiredArg<dynamic>(positional, 0, 'data', 'makeCleanMap');
        return $tom_build_37.makeCleanMap(data);
      },
      'toYamlString': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'toYamlString');
        final data = D4.getRequiredArg<Map<String, dynamic>>(positional, 0, 'data', 'toYamlString');
        final indent = D4.getNamedArgWithDefault<int>(named, 'indent', 0);
        return $tom_build_37.toYamlString(data, indent: indent);
      },
      'initializeTomContext': (visitor, positional, named, typeArgs) {
        final workspace = D4.getRequiredNamedArg<$tom_build_37.TomWorkspace>(named, 'workspace', 'initializeTomContext');
        final workspaceContext = D4.getOptionalNamedArg<Object?>(named, 'workspaceContext');
        final currentProject = D4.getOptionalNamedArg<$tom_build_37.TomProject?>(named, 'currentProject');
        final workspacePath = D4.getOptionalNamedArg<String?>(named, 'workspacePath');
        return $tom_build_39.initializeTomContext(workspace: workspace, workspaceContext: workspaceContext, currentProject: currentProject, workspacePath: workspacePath);
      },
      'resetTomContext': (visitor, positional, named, typeArgs) {
        return $tom_build_39.resetTomContext();
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'loadYamlFile': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'makeCleanMap': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'toYamlString': 'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'initializeTomContext': 'package:tom_build/src/tom/tom_context.dart',
      'resetTomContext': 'package:tom_build/src/tom/tom_context.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'loadYamlFile': 'Map<String, dynamic> loadYamlFile(String path)',
      'makeCleanMap': 'Map<String, dynamic> makeCleanMap(dynamic data)',
      'toYamlString': 'String toYamlString(Map<String, dynamic> data, {int indent = 0})',
      'initializeTomContext': 'void initializeTomContext({required TomWorkspace workspace, Object? workspaceContext, TomProject? currentProject, String? workspacePath})',
      'resetTomContext': 'void resetTomContext()',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:tom_build/src/analyzer/workspace_analyzer.dart',
      'package:tom_build/src/doc_scanner/doc_scanner.dart',
      'package:tom_build/src/doc_scanner/doc_scanner_factory.dart',
      'package:tom_build/src/doc_scanner/markdown_parser.dart',
      'package:tom_build/src/doc_scanner/models/document.dart',
      'package:tom_build/src/doc_scanner/models/document_folder.dart',
      'package:tom_build/src/doc_scanner/models/section.dart',
      'package:tom_build/src/doc_specs/doc_specs.dart',
      'package:tom_build/src/doc_specs/doc_specs_factory.dart',
      'package:tom_build/src/doc_specs/models/schema/doc_spec_schema.dart',
      'package:tom_build/src/doc_specs/models/schema/document_structure.dart',
      'package:tom_build/src/doc_specs/models/schema/form_type_def.dart',
      'package:tom_build/src/doc_specs/models/schema/schema_info.dart',
      'package:tom_build/src/doc_specs/models/schema/section_type_def.dart',
      'package:tom_build/src/doc_specs/models/spec_doc.dart',
      'package:tom_build/src/doc_specs/models/spec_section.dart',
      'package:tom_build/src/doc_specs/models/spec_section_type.dart',
      'package:tom_build/src/doc_specs/schema/schema_loader.dart',
      'package:tom_build/src/doc_specs/validation/validation_error.dart',
      'package:tom_build/src/doc_specs/validation/validator.dart',
      'package:tom_build/src/md_latex_converter/latex_macros.dart',
      'package:tom_build/src/md_latex_converter/markdown_parser.dart',
      'package:tom_build/src/md_latex_converter/md_latex_converter.dart',
      'package:tom_build/src/md_pdf_converter/md_pdf_converter.dart',
      'package:tom_build/src/md_pdf_converter/pdf_options_wrapper.dart',
      'package:tom_build/src/reflection_generator/reflection_generator.dart',
      'package:tom_build/src/scripting/env.dart',
      'package:tom_build/src/scripting/fs.dart',
      'package:tom_build/src/scripting/glob.dart',
      'package:tom_build/src/scripting/maps.dart',
      'package:tom_build/src/scripting/path.dart',
      'package:tom_build/src/scripting/shell.dart',
      'package:tom_build/src/scripting/text.dart',
      'package:tom_build/src/scripting/workspace.dart',
      'package:tom_build/src/scripting/yaml.dart',
      'package:tom_build/src/scripting/zone.dart',
      'package:tom_build/src/tom/file_object_model/file_object_model.dart',
      'package:tom_build/src/tom/file_object_model/workspace_parser.dart',
      'package:tom_build/src/tom/tom_context.dart',
      'package:tom_build/src/tools/tool_context.dart',
      'package:tom_build/src/tools/workspace_info.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:tom_build/tom_build.dart';";
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
    'SchemaSource',
    'ValidationErrorCategory',
    'PageFormat',
    'CpuArchitecture',
    'OperatingSystem',
  ];

}

// =============================================================================
// AnalyzerOptions Bridge
// =============================================================================

BridgedClass _createAnalyzerOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_build_1.AnalyzerOptions,
    name: 'AnalyzerOptions',
    constructors: {
      '': (visitor, positional, named) {
        final includeTestProjects = D4.getNamedArgWithDefault<bool>(named, 'includeTestProjects', false);
        return $tom_build_1.AnalyzerOptions(includeTestProjects: includeTestProjects);
      },
    },
    getters: {
      'includeTestProjects': (visitor, target) => D4.validateTarget<$tom_build_1.AnalyzerOptions>(target, 'AnalyzerOptions').includeTestProjects,
    },
    staticGetters: {
      'all': (visitor) => $tom_build_1.AnalyzerOptions.all,
      'production': (visitor) => $tom_build_1.AnalyzerOptions.production,
    },
    constructorSignatures: {
      '': 'const AnalyzerOptions({bool includeTestProjects = false})',
    },
    getterSignatures: {
      'includeTestProjects': 'bool get includeTestProjects',
    },
    staticGetterSignatures: {
      'all': 'dynamic get all',
      'production': 'dynamic get production',
    },
  );
}

// =============================================================================
// WorkspaceAnalyzer Bridge
// =============================================================================

BridgedClass _createWorkspaceAnalyzerBridge() {
  return BridgedClass(
    nativeType: $tom_build_1.WorkspaceAnalyzer,
    name: 'WorkspaceAnalyzer',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WorkspaceAnalyzer');
        final workspaceRoot = D4.getRequiredArg<String>(positional, 0, 'workspaceRoot', 'WorkspaceAnalyzer');
        if (!named.containsKey('options')) {
          return $tom_build_1.WorkspaceAnalyzer(workspaceRoot);
        }
        if (named.containsKey('options')) {
          final options = D4.getRequiredNamedArg<$tom_build_1.AnalyzerOptions>(named, 'options', 'WorkspaceAnalyzer');
          return $tom_build_1.WorkspaceAnalyzer(workspaceRoot, options: options);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'workspaceRoot': (visitor, target) => D4.validateTarget<$tom_build_1.WorkspaceAnalyzer>(target, 'WorkspaceAnalyzer').workspaceRoot,
      'options': (visitor, target) => D4.validateTarget<$tom_build_1.WorkspaceAnalyzer>(target, 'WorkspaceAnalyzer').options,
      'projects': (visitor, target) => D4.validateTarget<$tom_build_1.WorkspaceAnalyzer>(target, 'WorkspaceAnalyzer').projects,
      'workspaceSettings': (visitor, target) => D4.validateTarget<$tom_build_1.WorkspaceAnalyzer>(target, 'WorkspaceAnalyzer').workspaceSettings,
      'buildOrder': (visitor, target) => D4.validateTarget<$tom_build_1.WorkspaceAnalyzer>(target, 'WorkspaceAnalyzer').buildOrder,
    },
    setters: {
      'workspaceSettings': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.WorkspaceAnalyzer>(target, 'WorkspaceAnalyzer').workspaceSettings = (value as Map).cast<String, dynamic>(),
      'buildOrder': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.WorkspaceAnalyzer>(target, 'WorkspaceAnalyzer').buildOrder = (value as List).cast<String>().toList(),
    },
    methods: {
      'analyze': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_1.WorkspaceAnalyzer>(target, 'WorkspaceAnalyzer');
        return t.analyze();
      },
    },
    staticGetters: {
      'defaultWorkspaceSettings': (visitor) => $tom_build_1.WorkspaceAnalyzer.defaultWorkspaceSettings,
      'defaultBuildConfig': (visitor) => $tom_build_1.WorkspaceAnalyzer.defaultBuildConfig,
      'defaultRunConfig': (visitor) => $tom_build_1.WorkspaceAnalyzer.defaultRunConfig,
      'defaultDeployConfig': (visitor) => $tom_build_1.WorkspaceAnalyzer.defaultDeployConfig,
    },
    constructorSignatures: {
      '': 'WorkspaceAnalyzer(String workspaceRoot, {AnalyzerOptions options = const AnalyzerOptions()})',
    },
    methodSignatures: {
      'analyze': 'Future<void> analyze()',
    },
    getterSignatures: {
      'workspaceRoot': 'String get workspaceRoot',
      'options': 'AnalyzerOptions get options',
      'projects': 'List<ProjectInfo> get projects',
      'workspaceSettings': 'Map<String, dynamic> get workspaceSettings',
      'buildOrder': 'List<String> get buildOrder',
    },
    setterSignatures: {
      'workspaceSettings': 'set workspaceSettings(dynamic value)',
      'buildOrder': 'set buildOrder(dynamic value)',
    },
    staticGetterSignatures: {
      'defaultWorkspaceSettings': 'dynamic get defaultWorkspaceSettings',
      'defaultBuildConfig': 'dynamic get defaultBuildConfig',
      'defaultRunConfig': 'dynamic get defaultRunConfig',
      'defaultDeployConfig': 'dynamic get defaultDeployConfig',
    },
  );
}

// =============================================================================
// ProjectInfo Bridge
// =============================================================================

BridgedClass _createProjectInfoBridge() {
  return BridgedClass(
    nativeType: $tom_build_1.ProjectInfo,
    name: 'ProjectInfo',
    constructors: {
      '': (visitor, positional, named) {
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'ProjectInfo');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ProjectInfo');
        final displayName = D4.getRequiredNamedArg<String>(named, 'displayName', 'ProjectInfo');
        final projectName = D4.getOptionalNamedArg<String?>(named, 'projectName');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final type = D4.getRequiredNamedArg<String>(named, 'type', 'ProjectInfo');
        final projectFolder = D4.getOptionalNamedArg<String?>(named, 'projectFolder');
        return $tom_build_1.ProjectInfo(path: path, name: name, displayName: displayName, projectName: projectName, description: description, type: type, projectFolder: projectFolder);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').path,
      'name': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').name,
      'displayName': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').displayName,
      'projectName': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').projectName,
      'description': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').description,
      'type': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').type,
      'projectFolder': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').projectFolder,
      'packageModule': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').packageModule,
      'appModule': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').appModule,
      'parts': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').parts,
      'copilotGuidelines': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').copilotGuidelines,
      'docs': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').docs,
      'tests': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').tests,
      'examples': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').examples,
      'localIndexEntries': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').localIndexEntries,
      'buildAfter': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').buildAfter,
      'features': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').features,
      'pubspec': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').pubspec,
      'packageJson': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').packageJson,
      'pyproject': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').pyproject,
      'buildConfig': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').buildConfig,
      'runConfig': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').runConfig,
      'deployConfig': (visitor, target) => D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').deployConfig,
    },
    setters: {
      'packageModule': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').packageModule = value as $tom_build_1.ModuleInfo?,
      'appModule': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').appModule = value as $tom_build_1.ModuleInfo?,
      'copilotGuidelines': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').copilotGuidelines = (value as List).cast<String>().toList(),
      'docs': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').docs = (value as List).cast<String>().toList(),
      'tests': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').tests = (value as List).cast<String>().toList(),
      'examples': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').examples = (value as List).cast<String>().toList(),
      'localIndexEntries': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').localIndexEntries = (value as Map).cast<String, dynamic>(),
      'buildAfter': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').buildAfter = (value as List).cast<String>().toList(),
      'features': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').features = (value as Map).cast<String, bool>(),
      'pubspec': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').pubspec = (value as Map).cast<String, dynamic>(),
      'packageJson': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').packageJson = (value as Map).cast<String, dynamic>(),
      'pyproject': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').pyproject = (value as Map).cast<String, dynamic>(),
      'buildConfig': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').buildConfig = (value as Map).cast<String, dynamic>(),
      'runConfig': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').runConfig = (value as Map).cast<String, dynamic>(),
      'deployConfig': (visitor, target, value) => 
        D4.validateTarget<$tom_build_1.ProjectInfo>(target, 'ProjectInfo').deployConfig = (value as Map).cast<String, dynamic>(),
    },
    constructorSignatures: {
      '': 'ProjectInfo({required String path, required String name, required String displayName, String? projectName, String? description, required String type, String? projectFolder})',
    },
    getterSignatures: {
      'path': 'String get path',
      'name': 'String get name',
      'displayName': 'String get displayName',
      'projectName': 'String? get projectName',
      'description': 'String? get description',
      'type': 'String get type',
      'projectFolder': 'String? get projectFolder',
      'packageModule': 'ModuleInfo? get packageModule',
      'appModule': 'ModuleInfo? get appModule',
      'parts': 'List<PartInfo> get parts',
      'copilotGuidelines': 'List<String> get copilotGuidelines',
      'docs': 'List<String> get docs',
      'tests': 'List<String> get tests',
      'examples': 'List<String> get examples',
      'localIndexEntries': 'Map<String, dynamic> get localIndexEntries',
      'buildAfter': 'List<String> get buildAfter',
      'features': 'Map<String, bool> get features',
      'pubspec': 'Map<String, dynamic> get pubspec',
      'packageJson': 'Map<String, dynamic> get packageJson',
      'pyproject': 'Map<String, dynamic> get pyproject',
      'buildConfig': 'Map<String, dynamic> get buildConfig',
      'runConfig': 'Map<String, dynamic> get runConfig',
      'deployConfig': 'Map<String, dynamic> get deployConfig',
    },
    setterSignatures: {
      'packageModule': 'set packageModule(dynamic value)',
      'appModule': 'set appModule(dynamic value)',
      'copilotGuidelines': 'set copilotGuidelines(dynamic value)',
      'docs': 'set docs(dynamic value)',
      'tests': 'set tests(dynamic value)',
      'examples': 'set examples(dynamic value)',
      'localIndexEntries': 'set localIndexEntries(dynamic value)',
      'buildAfter': 'set buildAfter(dynamic value)',
      'features': 'set features(dynamic value)',
      'pubspec': 'set pubspec(dynamic value)',
      'packageJson': 'set packageJson(dynamic value)',
      'pyproject': 'set pyproject(dynamic value)',
      'buildConfig': 'set buildConfig(dynamic value)',
      'runConfig': 'set runConfig(dynamic value)',
      'deployConfig': 'set deployConfig(dynamic value)',
    },
  );
}

// =============================================================================
// PartInfo Bridge
// =============================================================================

BridgedClass _createPartInfoBridge() {
  return BridgedClass(
    nativeType: $tom_build_1.PartInfo,
    name: 'PartInfo',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'PartInfo');
        final displayName = D4.getRequiredNamedArg<String>(named, 'displayName', 'PartInfo');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final sources = D4.coerceListOrNull<String>(named['sources'], 'sources');
        return $tom_build_1.PartInfo(name: name, displayName: displayName, description: description, sources: sources);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_1.PartInfo>(target, 'PartInfo').name,
      'displayName': (visitor, target) => D4.validateTarget<$tom_build_1.PartInfo>(target, 'PartInfo').displayName,
      'description': (visitor, target) => D4.validateTarget<$tom_build_1.PartInfo>(target, 'PartInfo').description,
      'sources': (visitor, target) => D4.validateTarget<$tom_build_1.PartInfo>(target, 'PartInfo').sources,
      'modules': (visitor, target) => D4.validateTarget<$tom_build_1.PartInfo>(target, 'PartInfo').modules,
    },
    constructorSignatures: {
      '': 'PartInfo({required String name, required String displayName, String? description, List<String>? sources})',
    },
    getterSignatures: {
      'name': 'String get name',
      'displayName': 'String get displayName',
      'description': 'String? get description',
      'sources': 'List<String> get sources',
      'modules': 'List<ModuleInfo> get modules',
    },
  );
}

// =============================================================================
// ModuleInfo Bridge
// =============================================================================

BridgedClass _createModuleInfoBridge() {
  return BridgedClass(
    nativeType: $tom_build_1.ModuleInfo,
    name: 'ModuleInfo',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ModuleInfo');
        final displayName = D4.getRequiredNamedArg<String>(named, 'displayName', 'ModuleInfo');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final sources = D4.coerceListOrNull<String>(named['sources'], 'sources');
        final subfolders = D4.coerceListOrNull<$tom_build_1.ModuleInfo>(named['subfolders'], 'subfolders');
        return $tom_build_1.ModuleInfo(name: name, displayName: displayName, description: description, sources: sources, subfolders: subfolders);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_1.ModuleInfo>(target, 'ModuleInfo').name,
      'displayName': (visitor, target) => D4.validateTarget<$tom_build_1.ModuleInfo>(target, 'ModuleInfo').displayName,
      'description': (visitor, target) => D4.validateTarget<$tom_build_1.ModuleInfo>(target, 'ModuleInfo').description,
      'sources': (visitor, target) => D4.validateTarget<$tom_build_1.ModuleInfo>(target, 'ModuleInfo').sources,
      'subfolders': (visitor, target) => D4.validateTarget<$tom_build_1.ModuleInfo>(target, 'ModuleInfo').subfolders,
    },
    constructorSignatures: {
      '': 'ModuleInfo({required String name, required String displayName, String? description, List<String>? sources, List<ModuleInfo>? subfolders})',
    },
    getterSignatures: {
      'name': 'String get name',
      'displayName': 'String get displayName',
      'description': 'String? get description',
      'sources': 'List<String> get sources',
      'subfolders': 'List<ModuleInfo> get subfolders',
    },
  );
}

// =============================================================================
// DocScanner Bridge
// =============================================================================

BridgedClass _createDocScannerBridge() {
  return BridgedClass(
    nativeType: $tom_build_2.DocScanner,
    name: 'DocScanner',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_2.DocScanner();
      },
    },
    staticMethods: {
      'scanTree': (visitor, positional, named, typeArgs) {
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'scanTree');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        final factory = D4.getOptionalNamedArg<$tom_build_3.DocScannerFactory?>(named, 'factory');
        return $tom_build_2.DocScanner.scanTree(path: path, workspaceRoot: workspaceRoot, factory: factory);
      },
      'scanTreeSync': (visitor, positional, named, typeArgs) {
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'scanTreeSync');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        final factory = D4.getOptionalNamedArg<$tom_build_3.DocScannerFactory?>(named, 'factory');
        return $tom_build_2.DocScanner.scanTreeSync(path: path, workspaceRoot: workspaceRoot, factory: factory);
      },
      'scanDocuments': (visitor, positional, named, typeArgs) {
        if (!named.containsKey('filepaths') || named['filepaths'] == null) {
          throw ArgumentError('scanDocuments: Missing required named argument "filepaths"');
        }
        final filepaths = D4.coerceList<String>(named['filepaths'], 'filepaths');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        final factory = D4.getOptionalNamedArg<$tom_build_3.DocScannerFactory?>(named, 'factory');
        return $tom_build_2.DocScanner.scanDocuments(filepaths: filepaths, workspaceRoot: workspaceRoot, factory: factory);
      },
      'scanDocumentsSync': (visitor, positional, named, typeArgs) {
        if (!named.containsKey('filepaths') || named['filepaths'] == null) {
          throw ArgumentError('scanDocumentsSync: Missing required named argument "filepaths"');
        }
        final filepaths = D4.coerceList<String>(named['filepaths'], 'filepaths');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        final factory = D4.getOptionalNamedArg<$tom_build_3.DocScannerFactory?>(named, 'factory');
        return $tom_build_2.DocScanner.scanDocumentsSync(filepaths: filepaths, workspaceRoot: workspaceRoot, factory: factory);
      },
      'scanDocument': (visitor, positional, named, typeArgs) {
        final filepath = D4.getRequiredNamedArg<String>(named, 'filepath', 'scanDocument');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        final factory = D4.getOptionalNamedArg<$tom_build_3.DocScannerFactory?>(named, 'factory');
        return $tom_build_2.DocScanner.scanDocument(filepath: filepath, workspaceRoot: workspaceRoot, factory: factory);
      },
      'scanDocumentSync': (visitor, positional, named, typeArgs) {
        final filepath = D4.getRequiredNamedArg<String>(named, 'filepath', 'scanDocumentSync');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        final factory = D4.getOptionalNamedArg<$tom_build_3.DocScannerFactory?>(named, 'factory');
        return $tom_build_2.DocScanner.scanDocumentSync(filepath: filepath, workspaceRoot: workspaceRoot, factory: factory);
      },
    },
    constructorSignatures: {
      '': 'DocScanner()',
    },
    staticMethodSignatures: {
      'scanTree': 'Future<DocumentFolder> scanTree({required String path, String? workspaceRoot, DocScannerFactory? factory})',
      'scanTreeSync': 'DocumentFolder scanTreeSync({required String path, String? workspaceRoot, DocScannerFactory? factory})',
      'scanDocuments': 'Future<List<Document>> scanDocuments({required List<String> filepaths, String? workspaceRoot, DocScannerFactory? factory})',
      'scanDocumentsSync': 'List<Document> scanDocumentsSync({required List<String> filepaths, String? workspaceRoot, DocScannerFactory? factory})',
      'scanDocument': 'Future<Document> scanDocument({required String filepath, String? workspaceRoot, DocScannerFactory? factory})',
      'scanDocumentSync': 'Document scanDocumentSync({required String filepath, String? workspaceRoot, DocScannerFactory? factory})',
    },
  );
}

// =============================================================================
// DocScannerFactory Bridge
// =============================================================================

BridgedClass _createDocScannerFactoryBridge() {
  return BridgedClass(
    nativeType: $tom_build_3.DocScannerFactory,
    name: 'DocScannerFactory',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_3.DocScannerFactory();
      },
    },
    methods: {
      'createSection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_3.DocScannerFactory>(target, 'DocScannerFactory');
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'createSection');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'createSection');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'createSection');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'createSection');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'createSection');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'createSection');
        if (!named.containsKey('fields') || named['fields'] == null) {
          throw ArgumentError('createSection: Missing required named argument "fields"');
        }
        final fields = D4.coerceMap<String, String>(named['fields'], 'fields');
        final sections = D4.coerceListOrNull<$tom_build_7.Section>(named['sections'], 'sections');
        return t.createSection(index: index, lineNumber: lineNumber, rawHeadline: rawHeadline, name: name, id: id, text: text, fields: fields, sections: sections);
      },
      'createDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_3.DocScannerFactory>(target, 'DocScannerFactory');
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'createDocument');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'createDocument');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'createDocument');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'createDocument');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'createDocument');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'createDocument');
        if (!named.containsKey('fields') || named['fields'] == null) {
          throw ArgumentError('createDocument: Missing required named argument "fields"');
        }
        final fields = D4.coerceMap<String, String>(named['fields'], 'fields');
        final sections = D4.coerceListOrNull<$tom_build_7.Section>(named['sections'], 'sections');
        final filenameWithPath = D4.getRequiredNamedArg<String>(named, 'filenameWithPath', 'createDocument');
        final loadTimestamp = D4.getRequiredNamedArg<String>(named, 'loadTimestamp', 'createDocument');
        final filename = D4.getRequiredNamedArg<String>(named, 'filename', 'createDocument');
        final fullPath = D4.getRequiredNamedArg<String>(named, 'fullPath', 'createDocument');
        final workspacePath = D4.getRequiredNamedArg<String>(named, 'workspacePath', 'createDocument');
        final project = D4.getRequiredNamedArg<String>(named, 'project', 'createDocument');
        final projectPath = D4.getRequiredNamedArg<String>(named, 'projectPath', 'createDocument');
        final workspaceRoot = D4.getRequiredNamedArg<String>(named, 'workspaceRoot', 'createDocument');
        final projectRoot = D4.getRequiredNamedArg<String>(named, 'projectRoot', 'createDocument');
        final hierarchyDepth = D4.getRequiredNamedArg<int>(named, 'hierarchyDepth', 'createDocument');
        return t.createDocument(index: index, lineNumber: lineNumber, rawHeadline: rawHeadline, name: name, id: id, text: text, fields: fields, sections: sections, filenameWithPath: filenameWithPath, loadTimestamp: loadTimestamp, filename: filename, fullPath: fullPath, workspacePath: workspacePath, project: project, projectPath: projectPath, workspaceRoot: workspaceRoot, projectRoot: projectRoot, hierarchyDepth: hierarchyDepth);
      },
    },
    constructorSignatures: {
      '': 'const DocScannerFactory()',
    },
    methodSignatures: {
      'createSection': 'Section createSection({required int index, required int lineNumber, required String rawHeadline, required String name, required String id, required String text, required Map<String, String> fields, List<Section>? sections})',
      'createDocument': 'Document createDocument({required int index, required int lineNumber, required String rawHeadline, required String name, required String id, required String text, required Map<String, String> fields, List<Section>? sections, required String filenameWithPath, required String loadTimestamp, required String filename, required String fullPath, required String workspacePath, required String project, required String projectPath, required String workspaceRoot, required String projectRoot, required int hierarchyDepth})',
    },
  );
}

// =============================================================================
// ParsedHeadline Bridge
// =============================================================================

BridgedClass _createParsedHeadlineBridge() {
  return BridgedClass(
    nativeType: $tom_build_4.ParsedHeadline,
    name: 'ParsedHeadline',
    constructors: {
      '': (visitor, positional, named) {
        final level = D4.getRequiredNamedArg<int>(named, 'level', 'ParsedHeadline');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'ParsedHeadline');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'ParsedHeadline');
        final explicitId = D4.getOptionalNamedArg<String?>(named, 'explicitId');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'ParsedHeadline');
        final fields = named.containsKey('fields') && named['fields'] != null
            ? D4.coerceMap<String, String>(named['fields'], 'fields')
            : const <String, String>{};
        return $tom_build_4.ParsedHeadline(level: level, lineNumber: lineNumber, rawHeadline: rawHeadline, explicitId: explicitId, text: text, fields: fields);
      },
    },
    getters: {
      'level': (visitor, target) => D4.validateTarget<$tom_build_4.ParsedHeadline>(target, 'ParsedHeadline').level,
      'lineNumber': (visitor, target) => D4.validateTarget<$tom_build_4.ParsedHeadline>(target, 'ParsedHeadline').lineNumber,
      'rawHeadline': (visitor, target) => D4.validateTarget<$tom_build_4.ParsedHeadline>(target, 'ParsedHeadline').rawHeadline,
      'explicitId': (visitor, target) => D4.validateTarget<$tom_build_4.ParsedHeadline>(target, 'ParsedHeadline').explicitId,
      'text': (visitor, target) => D4.validateTarget<$tom_build_4.ParsedHeadline>(target, 'ParsedHeadline').text,
      'fields': (visitor, target) => D4.validateTarget<$tom_build_4.ParsedHeadline>(target, 'ParsedHeadline').fields,
    },
    constructorSignatures: {
      '': 'const ParsedHeadline({required int level, required int lineNumber, required String rawHeadline, String? explicitId, required String text, Map<String, String> fields = const {}})',
    },
    getterSignatures: {
      'level': 'int get level',
      'lineNumber': 'int get lineNumber',
      'rawHeadline': 'String get rawHeadline',
      'explicitId': 'String? get explicitId',
      'text': 'String get text',
      'fields': 'Map<String, String> get fields',
    },
  );
}

// =============================================================================
// MarkdownParser Bridge
// =============================================================================

BridgedClass _createMarkdownParserBridge() {
  return BridgedClass(
    nativeType: $tom_build_4.MarkdownParser,
    name: 'MarkdownParser',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_4.MarkdownParser();
      },
    },
    staticMethods: {
      'parseHeadlines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parseHeadlines');
        final content = D4.getRequiredArg<String>(positional, 0, 'content', 'parseHeadlines');
        return $tom_build_4.MarkdownParser.parseHeadlines(content);
      },
      'extractText': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'extractText');
        final content = D4.getRequiredArg<String>(positional, 0, 'content', 'extractText');
        final startLine = D4.getRequiredArg<int>(positional, 1, 'startLine', 'extractText');
        final endLine = D4.getRequiredArg<int>(positional, 2, 'endLine', 'extractText');
        return $tom_build_4.MarkdownParser.extractText(content, startLine, endLine);
      },
      'generateId': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'generateId');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'generateId');
        final parentId = D4.getRequiredArg<String?>(positional, 1, 'parentId', 'generateId');
        final index = D4.getRequiredArg<int>(positional, 2, 'index', 'generateId');
        return $tom_build_4.MarkdownParser.generateId(text, parentId, index);
      },
      'calculateMaxDepth': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'calculateMaxDepth');
        if (positional.isEmpty) {
          throw ArgumentError('calculateMaxDepth: Missing required argument "headlines" at position 0');
        }
        final headlines = D4.coerceList<($tom_build_4.ParsedHeadline, int startLine, int endLine)>(positional[0], 'headlines');
        return $tom_build_4.MarkdownParser.calculateMaxDepth(headlines);
      },
    },
    constructorSignatures: {
      '': 'MarkdownParser()',
    },
    staticMethodSignatures: {
      'parseHeadlines': 'List<(ParsedHeadline, int startLine, int endLine)> parseHeadlines(String content)',
      'extractText': 'String extractText(String content, int startLine, int endLine)',
      'generateId': 'String generateId(String text, String? parentId, int index)',
      'calculateMaxDepth': 'int calculateMaxDepth(List<(ParsedHeadline, int startLine, int endLine)> headlines)',
    },
  );
}

// =============================================================================
// Document Bridge
// =============================================================================

BridgedClass _createDocumentBridge() {
  return BridgedClass(
    nativeType: $tom_build_5.Document,
    name: 'Document',
    constructors: {
      '': (visitor, positional, named) {
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'Document');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'Document');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'Document');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'Document');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'Document');
        if (!named.containsKey('fields') || named['fields'] == null) {
          throw ArgumentError('Document: Missing required named argument "fields"');
        }
        final fields = D4.coerceMap<String, String>(named['fields'], 'fields');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'Document');
        final sections = D4.coerceListOrNull<$tom_build_7.Section>(named['sections'], 'sections');
        final filenameWithPath = D4.getRequiredNamedArg<String>(named, 'filenameWithPath', 'Document');
        final loadTimestamp = D4.getRequiredNamedArg<String>(named, 'loadTimestamp', 'Document');
        final filename = D4.getRequiredNamedArg<String>(named, 'filename', 'Document');
        final fullPath = D4.getRequiredNamedArg<String>(named, 'fullPath', 'Document');
        final workspacePath = D4.getRequiredNamedArg<String>(named, 'workspacePath', 'Document');
        final project = D4.getRequiredNamedArg<String>(named, 'project', 'Document');
        final projectPath = D4.getRequiredNamedArg<String>(named, 'projectPath', 'Document');
        final workspaceRoot = D4.getRequiredNamedArg<String>(named, 'workspaceRoot', 'Document');
        final projectRoot = D4.getRequiredNamedArg<String>(named, 'projectRoot', 'Document');
        final hierarchyDepth = D4.getRequiredNamedArg<int>(named, 'hierarchyDepth', 'Document');
        return $tom_build_5.Document(index: index, lineNumber: lineNumber, name: name, id: id, rawHeadline: rawHeadline, fields: fields, text: text, sections: sections, filenameWithPath: filenameWithPath, loadTimestamp: loadTimestamp, filename: filename, fullPath: fullPath, workspacePath: workspacePath, project: project, projectPath: projectPath, workspaceRoot: workspaceRoot, projectRoot: projectRoot, hierarchyDepth: hierarchyDepth);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Document');
        if (positional.isEmpty) {
          throw ArgumentError('Document: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_build_5.Document.fromJson(json);
      },
    },
    getters: {
      'index': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').index,
      'lineNumber': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').lineNumber,
      'rawHeadline': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').rawHeadline,
      'name': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').name,
      'id': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').id,
      'text': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').text,
      'fields': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').fields,
      'sections': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').sections,
      'filenameWithPath': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').filenameWithPath,
      'loadTimestamp': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').loadTimestamp,
      'filename': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').filename,
      'fullPath': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').fullPath,
      'workspacePath': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').workspacePath,
      'project': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').project,
      'projectPath': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').projectPath,
      'workspaceRoot': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').workspaceRoot,
      'projectRoot': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').projectRoot,
      'hierarchyDepth': (visitor, target) => D4.validateTarget<$tom_build_5.Document>(target, 'Document').hierarchyDepth,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_5.Document>(target, 'Document');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_5.Document>(target, 'Document');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Document({required int index, required int lineNumber, required String name, required String id, required String rawHeadline, required Map<String, String> fields, required String text, List<Section>? sections, required String filenameWithPath, required String loadTimestamp, required String filename, required String fullPath, required String workspacePath, required String project, required String projectPath, required String workspaceRoot, required String projectRoot, required int hierarchyDepth})',
      'fromJson': 'factory Document.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'index': 'int get index',
      'lineNumber': 'int get lineNumber',
      'rawHeadline': 'String get rawHeadline',
      'name': 'String get name',
      'id': 'String get id',
      'text': 'String get text',
      'fields': 'Map<String, String> get fields',
      'sections': 'List<Section>? get sections',
      'filenameWithPath': 'String get filenameWithPath',
      'loadTimestamp': 'String get loadTimestamp',
      'filename': 'String get filename',
      'fullPath': 'String get fullPath',
      'workspacePath': 'String get workspacePath',
      'project': 'String get project',
      'projectPath': 'String get projectPath',
      'workspaceRoot': 'String get workspaceRoot',
      'projectRoot': 'String get projectRoot',
      'hierarchyDepth': 'int get hierarchyDepth',
    },
  );
}

// =============================================================================
// DocumentFolder Bridge
// =============================================================================

BridgedClass _createDocumentFolderBridge() {
  return BridgedClass(
    nativeType: $tom_build_6.DocumentFolder,
    name: 'DocumentFolder',
    constructors: {
      '': (visitor, positional, named) {
        final foldername = D4.getRequiredNamedArg<String>(named, 'foldername', 'DocumentFolder');
        final workspaceFolderPath = D4.getRequiredNamedArg<String>(named, 'workspaceFolderPath', 'DocumentFolder');
        final absoluteFolderPath = D4.getRequiredNamedArg<String>(named, 'absoluteFolderPath', 'DocumentFolder');
        if (!named.containsKey('documents') || named['documents'] == null) {
          throw ArgumentError('DocumentFolder: Missing required named argument "documents"');
        }
        final documents = D4.coerceList<$tom_build_5.Document>(named['documents'], 'documents');
        if (!named.containsKey('folders') || named['folders'] == null) {
          throw ArgumentError('DocumentFolder: Missing required named argument "folders"');
        }
        final folders = D4.coerceList<$tom_build_6.DocumentFolder>(named['folders'], 'folders');
        return $tom_build_6.DocumentFolder(foldername: foldername, workspaceFolderPath: workspaceFolderPath, absoluteFolderPath: absoluteFolderPath, documents: documents, folders: folders);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentFolder');
        if (positional.isEmpty) {
          throw ArgumentError('DocumentFolder: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_build_6.DocumentFolder.fromJson(json);
      },
    },
    getters: {
      'foldername': (visitor, target) => D4.validateTarget<$tom_build_6.DocumentFolder>(target, 'DocumentFolder').foldername,
      'workspaceFolderPath': (visitor, target) => D4.validateTarget<$tom_build_6.DocumentFolder>(target, 'DocumentFolder').workspaceFolderPath,
      'absoluteFolderPath': (visitor, target) => D4.validateTarget<$tom_build_6.DocumentFolder>(target, 'DocumentFolder').absoluteFolderPath,
      'documents': (visitor, target) => D4.validateTarget<$tom_build_6.DocumentFolder>(target, 'DocumentFolder').documents,
      'folders': (visitor, target) => D4.validateTarget<$tom_build_6.DocumentFolder>(target, 'DocumentFolder').folders,
      'allDocuments': (visitor, target) => D4.validateTarget<$tom_build_6.DocumentFolder>(target, 'DocumentFolder').allDocuments,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_6.DocumentFolder>(target, 'DocumentFolder');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_6.DocumentFolder>(target, 'DocumentFolder');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const DocumentFolder({required String foldername, required String workspaceFolderPath, required String absoluteFolderPath, required List<Document> documents, required List<DocumentFolder> folders})',
      'fromJson': 'factory DocumentFolder.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'foldername': 'String get foldername',
      'workspaceFolderPath': 'String get workspaceFolderPath',
      'absoluteFolderPath': 'String get absoluteFolderPath',
      'documents': 'List<Document> get documents',
      'folders': 'List<DocumentFolder> get folders',
      'allDocuments': 'List<Document> get allDocuments',
    },
  );
}

// =============================================================================
// Section Bridge
// =============================================================================

BridgedClass _createSectionBridge() {
  return BridgedClass(
    nativeType: $tom_build_7.Section,
    name: 'Section',
    constructors: {
      '': (visitor, positional, named) {
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'Section');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'Section');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'Section');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'Section');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'Section');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'Section');
        final fields = named.containsKey('fields') && named['fields'] != null
            ? D4.coerceMap<String, String>(named['fields'], 'fields')
            : const <String, String>{};
        final sections = D4.coerceListOrNull<$tom_build_7.Section>(named['sections'], 'sections');
        return $tom_build_7.Section(index: index, lineNumber: lineNumber, rawHeadline: rawHeadline, name: name, id: id, text: text, fields: fields, sections: sections);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Section');
        if (positional.isEmpty) {
          throw ArgumentError('Section: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_build_7.Section.fromJson(json);
      },
    },
    getters: {
      'index': (visitor, target) => D4.validateTarget<$tom_build_7.Section>(target, 'Section').index,
      'lineNumber': (visitor, target) => D4.validateTarget<$tom_build_7.Section>(target, 'Section').lineNumber,
      'rawHeadline': (visitor, target) => D4.validateTarget<$tom_build_7.Section>(target, 'Section').rawHeadline,
      'name': (visitor, target) => D4.validateTarget<$tom_build_7.Section>(target, 'Section').name,
      'id': (visitor, target) => D4.validateTarget<$tom_build_7.Section>(target, 'Section').id,
      'text': (visitor, target) => D4.validateTarget<$tom_build_7.Section>(target, 'Section').text,
      'fields': (visitor, target) => D4.validateTarget<$tom_build_7.Section>(target, 'Section').fields,
      'sections': (visitor, target) => D4.validateTarget<$tom_build_7.Section>(target, 'Section').sections,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_7.Section>(target, 'Section');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_7.Section>(target, 'Section');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const Section({required int index, required int lineNumber, required String rawHeadline, required String name, required String id, required String text, Map<String, String> fields = const {}, List<Section>? sections})',
      'fromJson': 'factory Section.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'index': 'int get index',
      'lineNumber': 'int get lineNumber',
      'rawHeadline': 'String get rawHeadline',
      'name': 'String get name',
      'id': 'String get id',
      'text': 'String get text',
      'fields': 'Map<String, String> get fields',
      'sections': 'List<Section>? get sections',
    },
  );
}

// =============================================================================
// DocSpecs Bridge
// =============================================================================

BridgedClass _createDocSpecsBridge() {
  return BridgedClass(
    nativeType: $tom_build_8.DocSpecs,
    name: 'DocSpecs',
    constructors: {
    },
    staticMethods: {
      'scanDocument': (visitor, positional, named, typeArgs) {
        final filePath = D4.getRequiredNamedArg<String>(named, 'filePath', 'scanDocument');
        final schemaId = D4.getOptionalNamedArg<String?>(named, 'schemaId');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.scanDocument(filePath: filePath, schemaId: schemaId, workspaceRoot: workspaceRoot);
      },
      'scanDocumentSync': (visitor, positional, named, typeArgs) {
        final filePath = D4.getRequiredNamedArg<String>(named, 'filePath', 'scanDocumentSync');
        final schemaId = D4.getOptionalNamedArg<String?>(named, 'schemaId');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.scanDocumentSync(filePath: filePath, schemaId: schemaId, workspaceRoot: workspaceRoot);
      },
      'scanDocuments': (visitor, positional, named, typeArgs) {
        if (!named.containsKey('filePaths') || named['filePaths'] == null) {
          throw ArgumentError('scanDocuments: Missing required named argument "filePaths"');
        }
        final filePaths = D4.coerceList<String>(named['filePaths'], 'filePaths');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.scanDocuments(filePaths: filePaths, workspaceRoot: workspaceRoot);
      },
      'scanDocumentsSync': (visitor, positional, named, typeArgs) {
        if (!named.containsKey('filePaths') || named['filePaths'] == null) {
          throw ArgumentError('scanDocumentsSync: Missing required named argument "filePaths"');
        }
        final filePaths = D4.coerceList<String>(named['filePaths'], 'filePaths');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.scanDocumentsSync(filePaths: filePaths, workspaceRoot: workspaceRoot);
      },
      'scanTree': (visitor, positional, named, typeArgs) {
        final dirPath = D4.getRequiredNamedArg<String>(named, 'dirPath', 'scanTree');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.scanTree(dirPath: dirPath, workspaceRoot: workspaceRoot);
      },
      'scanTreeSync': (visitor, positional, named, typeArgs) {
        final dirPath = D4.getRequiredNamedArg<String>(named, 'dirPath', 'scanTreeSync');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.scanTreeSync(dirPath: dirPath, workspaceRoot: workspaceRoot);
      },
      'loadSchema': (visitor, positional, named, typeArgs) {
        final schemaId = D4.getRequiredNamedArg<String>(named, 'schemaId', 'loadSchema');
        final documentPath = D4.getOptionalNamedArg<String?>(named, 'documentPath');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.loadSchema(schemaId: schemaId, documentPath: documentPath, workspaceRoot: workspaceRoot);
      },
      'loadSchemaSync': (visitor, positional, named, typeArgs) {
        final schemaId = D4.getRequiredNamedArg<String>(named, 'schemaId', 'loadSchemaSync');
        final documentPath = D4.getOptionalNamedArg<String?>(named, 'documentPath');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.loadSchemaSync(schemaId: schemaId, documentPath: documentPath, workspaceRoot: workspaceRoot);
      },
      'validate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'validate');
        final doc = D4.getRequiredArg<$tom_build_15.SpecDoc>(positional, 0, 'doc', 'validate');
        final schema = D4.getOptionalNamedArg<$tom_build_10.DocSpecSchema?>(named, 'schema');
        return $tom_build_8.DocSpecs.validate(doc, schema: schema);
      },
      'listSchemas': (visitor, positional, named, typeArgs) {
        final documentPath = D4.getOptionalNamedArg<String?>(named, 'documentPath');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.listSchemas(documentPath: documentPath, workspaceRoot: workspaceRoot);
      },
      'listSchemasSync': (visitor, positional, named, typeArgs) {
        final documentPath = D4.getOptionalNamedArg<String?>(named, 'documentPath');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_8.DocSpecs.listSchemasSync(documentPath: documentPath, workspaceRoot: workspaceRoot);
      },
      'listSchemasIn': (visitor, positional, named, typeArgs) {
        final dirPath = D4.getRequiredNamedArg<String>(named, 'dirPath', 'listSchemasIn');
        return $tom_build_8.DocSpecs.listSchemasIn(dirPath: dirPath);
      },
      'listSchemasInSync': (visitor, positional, named, typeArgs) {
        final dirPath = D4.getRequiredNamedArg<String>(named, 'dirPath', 'listSchemasInSync');
        return $tom_build_8.DocSpecs.listSchemasInSync(dirPath: dirPath);
      },
    },
    staticMethodSignatures: {
      'scanDocument': 'Future<SpecDoc> scanDocument({required String filePath, String? schemaId, String? workspaceRoot})',
      'scanDocumentSync': 'SpecDoc scanDocumentSync({required String filePath, String? schemaId, String? workspaceRoot})',
      'scanDocuments': 'Future<List<SpecDoc>> scanDocuments({required List<String> filePaths, String? workspaceRoot})',
      'scanDocumentsSync': 'List<SpecDoc> scanDocumentsSync({required List<String> filePaths, String? workspaceRoot})',
      'scanTree': 'Future<DocumentFolder> scanTree({required String dirPath, String? workspaceRoot})',
      'scanTreeSync': 'DocumentFolder scanTreeSync({required String dirPath, String? workspaceRoot})',
      'loadSchema': 'Future<DocSpecSchema> loadSchema({required String schemaId, String? documentPath, String? workspaceRoot})',
      'loadSchemaSync': 'DocSpecSchema loadSchemaSync({required String schemaId, String? documentPath, String? workspaceRoot})',
      'validate': 'List<String> validate(SpecDoc doc, {DocSpecSchema? schema})',
      'listSchemas': 'Future<List<SchemaInfo>> listSchemas({String? documentPath, String? workspaceRoot})',
      'listSchemasSync': 'List<SchemaInfo> listSchemasSync({String? documentPath, String? workspaceRoot})',
      'listSchemasIn': 'Future<List<SchemaInfo>> listSchemasIn({required String dirPath})',
      'listSchemasInSync': 'List<SchemaInfo> listSchemasInSync({required String dirPath})',
    },
  );
}

// =============================================================================
// DocSpecsFactory Bridge
// =============================================================================

BridgedClass _createDocSpecsFactoryBridge() {
  return BridgedClass(
    nativeType: $tom_build_9.DocSpecsFactory,
    name: 'DocSpecsFactory',
    constructors: {
      '': (visitor, positional, named) {
        final schema = D4.getOptionalNamedArg<$tom_build_10.DocSpecSchema?>(named, 'schema');
        return $tom_build_9.DocSpecsFactory(schema: schema);
      },
    },
    getters: {
      'schema': (visitor, target) => D4.validateTarget<$tom_build_9.DocSpecsFactory>(target, 'DocSpecsFactory').schema,
    },
    methods: {
      'createSection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_9.DocSpecsFactory>(target, 'DocSpecsFactory');
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'createSection');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'createSection');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'createSection');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'createSection');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'createSection');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'createSection');
        if (!named.containsKey('fields') || named['fields'] == null) {
          throw ArgumentError('createSection: Missing required named argument "fields"');
        }
        final fields = D4.coerceMap<String, String>(named['fields'], 'fields');
        final sections = D4.coerceListOrNull<$tom_build_7.Section>(named['sections'], 'sections');
        return t.createSection(index: index, lineNumber: lineNumber, rawHeadline: rawHeadline, name: name, id: id, text: text, fields: fields, sections: sections);
      },
      'createDocument': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_9.DocSpecsFactory>(target, 'DocSpecsFactory');
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'createDocument');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'createDocument');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'createDocument');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'createDocument');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'createDocument');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'createDocument');
        if (!named.containsKey('fields') || named['fields'] == null) {
          throw ArgumentError('createDocument: Missing required named argument "fields"');
        }
        final fields = D4.coerceMap<String, String>(named['fields'], 'fields');
        final sections = D4.coerceListOrNull<$tom_build_7.Section>(named['sections'], 'sections');
        final filenameWithPath = D4.getRequiredNamedArg<String>(named, 'filenameWithPath', 'createDocument');
        final loadTimestamp = D4.getRequiredNamedArg<String>(named, 'loadTimestamp', 'createDocument');
        final filename = D4.getRequiredNamedArg<String>(named, 'filename', 'createDocument');
        final fullPath = D4.getRequiredNamedArg<String>(named, 'fullPath', 'createDocument');
        final workspacePath = D4.getRequiredNamedArg<String>(named, 'workspacePath', 'createDocument');
        final project = D4.getRequiredNamedArg<String>(named, 'project', 'createDocument');
        final projectPath = D4.getRequiredNamedArg<String>(named, 'projectPath', 'createDocument');
        final workspaceRoot = D4.getRequiredNamedArg<String>(named, 'workspaceRoot', 'createDocument');
        final projectRoot = D4.getRequiredNamedArg<String>(named, 'projectRoot', 'createDocument');
        final hierarchyDepth = D4.getRequiredNamedArg<int>(named, 'hierarchyDepth', 'createDocument');
        return t.createDocument(index: index, lineNumber: lineNumber, rawHeadline: rawHeadline, name: name, id: id, text: text, fields: fields, sections: sections, filenameWithPath: filenameWithPath, loadTimestamp: loadTimestamp, filename: filename, fullPath: fullPath, workspacePath: workspacePath, project: project, projectPath: projectPath, workspaceRoot: workspaceRoot, projectRoot: projectRoot, hierarchyDepth: hierarchyDepth);
      },
    },
    constructorSignatures: {
      '': 'DocSpecsFactory({DocSpecSchema? schema})',
    },
    methodSignatures: {
      'createSection': 'Section createSection({required int index, required int lineNumber, required String rawHeadline, required String name, required String id, required String text, required Map<String, String> fields, List<Section>? sections})',
      'createDocument': 'Document createDocument({required int index, required int lineNumber, required String rawHeadline, required String name, required String id, required String text, required Map<String, String> fields, List<Section>? sections, required String filenameWithPath, required String loadTimestamp, required String filename, required String fullPath, required String workspacePath, required String project, required String projectPath, required String workspaceRoot, required String projectRoot, required int hierarchyDepth})',
    },
    getterSignatures: {
      'schema': 'DocSpecSchema? get schema',
    },
  );
}

// =============================================================================
// DocSpecSchema Bridge
// =============================================================================

BridgedClass _createDocSpecSchemaBridge() {
  return BridgedClass(
    nativeType: $tom_build_10.DocSpecSchema,
    name: 'DocSpecSchema',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'DocSpecSchema');
        final version = D4.getRequiredNamedArg<String>(named, 'version', 'DocSpecSchema');
        if (!named.containsKey('sectionTypes') || named['sectionTypes'] == null) {
          throw ArgumentError('DocSpecSchema: Missing required named argument "sectionTypes"');
        }
        final sectionTypes = D4.coerceMap<String, $tom_build_14.SectionTypeDef>(named['sectionTypes'], 'sectionTypes');
        final document = D4.getRequiredNamedArg<$tom_build_11.DocumentStructure>(named, 'document', 'DocSpecSchema');
        final formTypes = D4.coerceMapOrNull<String, $tom_build_12.FormTypeDef>(named['formTypes'], 'formTypes');
        final subsectionDeclarations = D4.coerceMapOrNull<String, Map<String, $tom_build_11.SubsectionDef>>(named['subsectionDeclarations'], 'subsectionDeclarations');
        final customTags = named.containsKey('customTags') && named['customTags'] != null
            ? D4.coerceMap<String, dynamic>(named['customTags'], 'customTags')
            : const <String, dynamic>{};
        return $tom_build_10.DocSpecSchema(id: id, version: version, sectionTypes: sectionTypes, document: document, formTypes: formTypes, subsectionDeclarations: subsectionDeclarations, customTags: customTags);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocSpecSchema');
        if (positional.isEmpty) {
          throw ArgumentError('DocSpecSchema: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'DocSpecSchema');
        final version = D4.getRequiredNamedArg<String>(named, 'version', 'DocSpecSchema');
        return $tom_build_10.DocSpecSchema.fromYaml(yaml, id: id, version: version);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').id,
      'version': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').version,
      'sectionTypes': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').sectionTypes,
      'document': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').document,
      'formTypes': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').formTypes,
      'subsectionDeclarations': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').subsectionDeclarations,
      'customTags': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').customTags,
      'fullId': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').fullId,
      'filenameId': (visitor, target) => D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema').filenameId,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema');
        return t.toYaml();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_10.DocSpecSchema>(target, 'DocSpecSchema');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const DocSpecSchema({required String id, required String version, required Map<String, SectionTypeDef> sectionTypes, required DocumentStructure document, Map<String, FormTypeDef>? formTypes, Map<String, Map<String, SubsectionDef>>? subsectionDeclarations, Map<String, dynamic> customTags = const {}})',
      'fromYaml': 'factory DocSpecSchema.fromYaml(Map<String, dynamic> yaml, {required String id, required String version})',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'String get id',
      'version': 'String get version',
      'sectionTypes': 'Map<String, SectionTypeDef> get sectionTypes',
      'document': 'DocumentStructure get document',
      'formTypes': 'Map<String, FormTypeDef>? get formTypes',
      'subsectionDeclarations': 'Map<String, Map<String, SubsectionDef>>? get subsectionDeclarations',
      'customTags': 'Map<String, dynamic> get customTags',
      'fullId': 'String get fullId',
      'filenameId': 'String get filenameId',
    },
  );
}

// =============================================================================
// ForEachDef Bridge
// =============================================================================

BridgedClass _createForEachDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_11.ForEachDef,
    name: 'ForEachDef',
    constructors: {
      '': (visitor, positional, named) {
        final sectionType = D4.getRequiredNamedArg<String>(named, 'sectionType', 'ForEachDef');
        final key = D4.getRequiredNamedArg<String>(named, 'key', 'ForEachDef');
        return $tom_build_11.ForEachDef(sectionType: sectionType, key: key);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ForEachDef');
        if (positional.isEmpty) {
          throw ArgumentError('ForEachDef: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_11.ForEachDef.fromYaml(yaml);
      },
    },
    getters: {
      'sectionType': (visitor, target) => D4.validateTarget<$tom_build_11.ForEachDef>(target, 'ForEachDef').sectionType,
      'key': (visitor, target) => D4.validateTarget<$tom_build_11.ForEachDef>(target, 'ForEachDef').key,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_11.ForEachDef>(target, 'ForEachDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const ForEachDef({required String sectionType, required String key})',
      'fromYaml': 'factory ForEachDef.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'sectionType': 'String get sectionType',
      'key': 'String get key',
    },
  );
}

// =============================================================================
// SectionDef Bridge
// =============================================================================

BridgedClass _createSectionDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_11.SectionDef,
    name: 'SectionDef',
    constructors: {
      '': (visitor, positional, named) {
        final sectionType = D4.getRequiredNamedArg<String>(named, 'sectionType', 'SectionDef');
        final accessKey = D4.getOptionalNamedArg<String?>(named, 'accessKey');
        final optional = D4.getOptionalNamedArg<bool?>(named, 'optional');
        final validationPrompt = D4.getOptionalNamedArg<String?>(named, 'validationPrompt');
        final subsectionValidationPrompt = D4.getOptionalNamedArg<String?>(named, 'subsectionValidationPrompt');
        final forEach = D4.getOptionalNamedArg<$tom_build_11.ForEachDef?>(named, 'forEach');
        return $tom_build_11.SectionDef(sectionType: sectionType, accessKey: accessKey, optional: optional, validationPrompt: validationPrompt, subsectionValidationPrompt: subsectionValidationPrompt, forEach: forEach);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SectionDef');
        if (positional.isEmpty) {
          throw ArgumentError('SectionDef: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_11.SectionDef.fromYaml(yaml);
      },
    },
    getters: {
      'sectionType': (visitor, target) => D4.validateTarget<$tom_build_11.SectionDef>(target, 'SectionDef').sectionType,
      'accessKey': (visitor, target) => D4.validateTarget<$tom_build_11.SectionDef>(target, 'SectionDef').accessKey,
      'optional': (visitor, target) => D4.validateTarget<$tom_build_11.SectionDef>(target, 'SectionDef').optional,
      'validationPrompt': (visitor, target) => D4.validateTarget<$tom_build_11.SectionDef>(target, 'SectionDef').validationPrompt,
      'subsectionValidationPrompt': (visitor, target) => D4.validateTarget<$tom_build_11.SectionDef>(target, 'SectionDef').subsectionValidationPrompt,
      'forEach': (visitor, target) => D4.validateTarget<$tom_build_11.SectionDef>(target, 'SectionDef').forEach,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_11.SectionDef>(target, 'SectionDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const SectionDef({required String sectionType, String? accessKey, bool? optional, String? validationPrompt, String? subsectionValidationPrompt, ForEachDef? forEach})',
      'fromYaml': 'factory SectionDef.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'sectionType': 'String get sectionType',
      'accessKey': 'String? get accessKey',
      'optional': 'bool? get optional',
      'validationPrompt': 'String? get validationPrompt',
      'subsectionValidationPrompt': 'String? get subsectionValidationPrompt',
      'forEach': 'ForEachDef? get forEach',
    },
  );
}

// =============================================================================
// SubsectionDef Bridge
// =============================================================================

BridgedClass _createSubsectionDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_11.SubsectionDef,
    name: 'SubsectionDef',
    constructors: {
      '': (visitor, positional, named) {
        final sectionType = D4.getRequiredNamedArg<String>(named, 'sectionType', 'SubsectionDef');
        final required = D4.getOptionalNamedArg<bool?>(named, 'required');
        final position = D4.getOptionalNamedArg<String?>(named, 'position');
        return $tom_build_11.SubsectionDef(sectionType: sectionType, required: required, position: position);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SubsectionDef');
        if (positional.isEmpty) {
          throw ArgumentError('SubsectionDef: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_11.SubsectionDef.fromYaml(yaml);
      },
    },
    getters: {
      'sectionType': (visitor, target) => D4.validateTarget<$tom_build_11.SubsectionDef>(target, 'SubsectionDef').sectionType,
      'required': (visitor, target) => D4.validateTarget<$tom_build_11.SubsectionDef>(target, 'SubsectionDef').required,
      'position': (visitor, target) => D4.validateTarget<$tom_build_11.SubsectionDef>(target, 'SubsectionDef').position,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_11.SubsectionDef>(target, 'SubsectionDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const SubsectionDef({required String sectionType, bool? required, String? position})',
      'fromYaml': 'factory SubsectionDef.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'sectionType': 'String get sectionType',
      'required': 'bool? get required',
      'position': 'String? get position',
    },
  );
}

// =============================================================================
// DocumentStructure Bridge
// =============================================================================

BridgedClass _createDocumentStructureBridge() {
  return BridgedClass(
    nativeType: $tom_build_11.DocumentStructure,
    name: 'DocumentStructure',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('sections') || named['sections'] == null) {
          throw ArgumentError('DocumentStructure: Missing required named argument "sections"');
        }
        final sections = D4.coerceMap<String, $tom_build_11.SectionDef>(named['sections'], 'sections');
        return $tom_build_11.DocumentStructure(sections: sections);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DocumentStructure');
        if (positional.isEmpty) {
          throw ArgumentError('DocumentStructure: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_11.DocumentStructure.fromYaml(yaml);
      },
    },
    getters: {
      'sections': (visitor, target) => D4.validateTarget<$tom_build_11.DocumentStructure>(target, 'DocumentStructure').sections,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_11.DocumentStructure>(target, 'DocumentStructure');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const DocumentStructure({required Map<String, SectionDef> sections})',
      'fromYaml': 'factory DocumentStructure.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'sections': 'Map<String, SectionDef> get sections',
    },
  );
}

// =============================================================================
// FormFieldDef Bridge
// =============================================================================

BridgedClass _createFormFieldDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_12.FormFieldDef,
    name: 'FormFieldDef',
    constructors: {
      '': (visitor, positional, named) {
        final fieldname = D4.getRequiredNamedArg<String>(named, 'fieldname', 'FormFieldDef');
        final required = D4.getOptionalNamedArg<bool?>(named, 'required');
        final patternCheck = D4.getOptionalNamedArg<$tom_build_14.PatternCheckDef?>(named, 'patternCheck');
        return $tom_build_12.FormFieldDef(fieldname: fieldname, required: required, patternCheck: patternCheck);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FormFieldDef');
        if (positional.isEmpty) {
          throw ArgumentError('FormFieldDef: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_12.FormFieldDef.fromYaml(yaml);
      },
    },
    getters: {
      'fieldname': (visitor, target) => D4.validateTarget<$tom_build_12.FormFieldDef>(target, 'FormFieldDef').fieldname,
      'required': (visitor, target) => D4.validateTarget<$tom_build_12.FormFieldDef>(target, 'FormFieldDef').required,
      'patternCheck': (visitor, target) => D4.validateTarget<$tom_build_12.FormFieldDef>(target, 'FormFieldDef').patternCheck,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_12.FormFieldDef>(target, 'FormFieldDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const FormFieldDef({required String fieldname, bool? required, PatternCheckDef? patternCheck})',
      'fromYaml': 'factory FormFieldDef.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'fieldname': 'String get fieldname',
      'required': 'bool? get required',
      'patternCheck': 'PatternCheckDef? get patternCheck',
    },
  );
}

// =============================================================================
// FormTypeDef Bridge
// =============================================================================

BridgedClass _createFormTypeDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_12.FormTypeDef,
    name: 'FormTypeDef',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'FormTypeDef');
        if (!named.containsKey('fields') || named['fields'] == null) {
          throw ArgumentError('FormTypeDef: Missing required named argument "fields"');
        }
        final fields = D4.coerceList<$tom_build_12.FormFieldDef>(named['fields'], 'fields');
        return $tom_build_12.FormTypeDef(name: name, fields: fields);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FormTypeDef');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'FormTypeDef');
        if (positional.length <= 1) {
          throw ArgumentError('FormTypeDef: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_12.FormTypeDef.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_12.FormTypeDef>(target, 'FormTypeDef').name,
      'fields': (visitor, target) => D4.validateTarget<$tom_build_12.FormTypeDef>(target, 'FormTypeDef').fields,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_12.FormTypeDef>(target, 'FormTypeDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const FormTypeDef({required String name, required List<FormFieldDef> fields})',
      'fromYaml': 'factory FormTypeDef.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'fields': 'List<FormFieldDef> get fields',
    },
  );
}

// =============================================================================
// SchemaInfo Bridge
// =============================================================================

BridgedClass _createSchemaInfoBridge() {
  return BridgedClass(
    nativeType: $tom_build_13.SchemaInfo,
    name: 'SchemaInfo',
    constructors: {
      '': (visitor, positional, named) {
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'SchemaInfo');
        final version = D4.getRequiredNamedArg<String>(named, 'version', 'SchemaInfo');
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'SchemaInfo');
        final source = D4.getRequiredNamedArg<$tom_build_13.SchemaSource>(named, 'source', 'SchemaInfo');
        return $tom_build_13.SchemaInfo(id: id, version: version, path: path, source: source);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo').id,
      'version': (visitor, target) => D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo').version,
      'path': (visitor, target) => D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo').path,
      'source': (visitor, target) => D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo').source,
      'fullId': (visitor, target) => D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo').fullId,
      'filenameId': (visitor, target) => D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo').filenameId,
      'hashCode': (visitor, target) => D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_13.SchemaInfo>(target, 'SchemaInfo');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'const SchemaInfo({required String id, required String version, required String path, required SchemaSource source})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'id': 'String get id',
      'version': 'String get version',
      'path': 'String get path',
      'source': 'SchemaSource get source',
      'fullId': 'String get fullId',
      'filenameId': 'String get filenameId',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// PatternCheckDef Bridge
// =============================================================================

BridgedClass _createPatternCheckDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_14.PatternCheckDef,
    name: 'PatternCheckDef',
    constructors: {
      '': (visitor, positional, named) {
        final pattern = D4.getRequiredNamedArg<String>(named, 'pattern', 'PatternCheckDef');
        final errorMessage = D4.getRequiredNamedArg<String>(named, 'errorMessage', 'PatternCheckDef');
        return $tom_build_14.PatternCheckDef(pattern: pattern, errorMessage: errorMessage);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PatternCheckDef');
        if (positional.isEmpty) {
          throw ArgumentError('PatternCheckDef: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_14.PatternCheckDef.fromYaml(yaml);
      },
    },
    getters: {
      'pattern': (visitor, target) => D4.validateTarget<$tom_build_14.PatternCheckDef>(target, 'PatternCheckDef').pattern,
      'errorMessage': (visitor, target) => D4.validateTarget<$tom_build_14.PatternCheckDef>(target, 'PatternCheckDef').errorMessage,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_14.PatternCheckDef>(target, 'PatternCheckDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const PatternCheckDef({required String pattern, required String errorMessage})',
      'fromYaml': 'factory PatternCheckDef.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'pattern': 'String get pattern',
      'errorMessage': 'String get errorMessage',
    },
  );
}

// =============================================================================
// SubsectionConstraint Bridge
// =============================================================================

BridgedClass _createSubsectionConstraintBridge() {
  return BridgedClass(
    nativeType: $tom_build_14.SubsectionConstraint,
    name: 'SubsectionConstraint',
    constructors: {
      '': (visitor, positional, named) {
        final typeName = D4.getRequiredNamedArg<String>(named, 'typeName', 'SubsectionConstraint');
        final maxCount = D4.getOptionalNamedArg<int?>(named, 'maxCount');
        final minCount = D4.getOptionalNamedArg<int?>(named, 'minCount');
        final required = D4.getOptionalNamedArg<bool?>(named, 'required');
        return $tom_build_14.SubsectionConstraint(typeName: typeName, maxCount: maxCount, minCount: minCount, required: required);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SubsectionConstraint');
        final typeName = D4.getRequiredArg<String>(positional, 0, 'typeName', 'SubsectionConstraint');
        if (positional.length <= 1) {
          throw ArgumentError('SubsectionConstraint: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_14.SubsectionConstraint.fromYaml(typeName, yaml);
      },
    },
    getters: {
      'typeName': (visitor, target) => D4.validateTarget<$tom_build_14.SubsectionConstraint>(target, 'SubsectionConstraint').typeName,
      'maxCount': (visitor, target) => D4.validateTarget<$tom_build_14.SubsectionConstraint>(target, 'SubsectionConstraint').maxCount,
      'minCount': (visitor, target) => D4.validateTarget<$tom_build_14.SubsectionConstraint>(target, 'SubsectionConstraint').minCount,
      'required': (visitor, target) => D4.validateTarget<$tom_build_14.SubsectionConstraint>(target, 'SubsectionConstraint').required,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_14.SubsectionConstraint>(target, 'SubsectionConstraint');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const SubsectionConstraint({required String typeName, int? maxCount, int? minCount, bool? required})',
      'fromYaml': 'factory SubsectionConstraint.fromYaml(String typeName, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'typeName': 'String get typeName',
      'maxCount': 'int? get maxCount',
      'minCount': 'int? get minCount',
      'required': 'bool? get required',
    },
  );
}

// =============================================================================
// SectionTypeDef Bridge
// =============================================================================

BridgedClass _createSectionTypeDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_14.SectionTypeDef,
    name: 'SectionTypeDef',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'SectionTypeDef');
        final prefix = D4.getOptionalNamedArg<String?>(named, 'prefix');
        final maxCountInDocument = D4.getOptionalNamedArg<int?>(named, 'maxCountInDocument');
        final maxSubsectionLevels = D4.getOptionalNamedArg<int?>(named, 'maxSubsectionLevels');
        final subsectionTypes = D4.coerceMapOrNull<String, $tom_build_14.SubsectionConstraint>(named['subsectionTypes'], 'subsectionTypes');
        final patternCheckId = D4.getOptionalNamedArg<$tom_build_14.PatternCheckDef?>(named, 'patternCheckId');
        final patternCheckText = D4.getOptionalNamedArg<$tom_build_14.PatternCheckDef?>(named, 'patternCheckText');
        final format = D4.getOptionalNamedArg<String?>(named, 'format');
        final textRequired = D4.getOptionalNamedArg<bool?>(named, 'textRequired');
        final minTextLength = D4.getOptionalNamedArg<int?>(named, 'minTextLength');
        final maxTextLength = D4.getOptionalNamedArg<int?>(named, 'maxTextLength');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final allowedTags = D4.coerceListOrNull<String>(named['allowedTags'], 'allowedTags');
        final validationPrompt = D4.getOptionalNamedArg<String?>(named, 'validationPrompt');
        final requiredFields = D4.coerceListOrNull<String>(named['requiredFields'], 'requiredFields');
        return $tom_build_14.SectionTypeDef(name: name, prefix: prefix, maxCountInDocument: maxCountInDocument, maxSubsectionLevels: maxSubsectionLevels, subsectionTypes: subsectionTypes, patternCheckId: patternCheckId, patternCheckText: patternCheckText, format: format, textRequired: textRequired, minTextLength: minTextLength, maxTextLength: maxTextLength, description: description, allowedTags: allowedTags, validationPrompt: validationPrompt, requiredFields: requiredFields);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'SectionTypeDef');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'SectionTypeDef');
        if (positional.length <= 1) {
          throw ArgumentError('SectionTypeDef: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_14.SectionTypeDef.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').name,
      'prefix': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').prefix,
      'maxCountInDocument': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').maxCountInDocument,
      'maxSubsectionLevels': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').maxSubsectionLevels,
      'subsectionTypes': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').subsectionTypes,
      'patternCheckId': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').patternCheckId,
      'patternCheckText': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').patternCheckText,
      'format': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').format,
      'textRequired': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').textRequired,
      'minTextLength': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').minTextLength,
      'maxTextLength': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').maxTextLength,
      'description': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').description,
      'allowedTags': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').allowedTags,
      'validationPrompt': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').validationPrompt,
      'requiredFields': (visitor, target) => D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef').requiredFields,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_14.SectionTypeDef>(target, 'SectionTypeDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'const SectionTypeDef({required String name, String? prefix, int? maxCountInDocument, int? maxSubsectionLevels, Map<String, SubsectionConstraint>? subsectionTypes, PatternCheckDef? patternCheckId, PatternCheckDef? patternCheckText, String? format, bool? textRequired, int? minTextLength, int? maxTextLength, String? description, List<String>? allowedTags, String? validationPrompt, List<String>? requiredFields})',
      'fromYaml': 'factory SectionTypeDef.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'prefix': 'String? get prefix',
      'maxCountInDocument': 'int? get maxCountInDocument',
      'maxSubsectionLevels': 'int? get maxSubsectionLevels',
      'subsectionTypes': 'Map<String, SubsectionConstraint>? get subsectionTypes',
      'patternCheckId': 'PatternCheckDef? get patternCheckId',
      'patternCheckText': 'PatternCheckDef? get patternCheckText',
      'format': 'String? get format',
      'textRequired': 'bool? get textRequired',
      'minTextLength': 'int? get minTextLength',
      'maxTextLength': 'int? get maxTextLength',
      'description': 'String? get description',
      'allowedTags': 'List<String>? get allowedTags',
      'validationPrompt': 'String? get validationPrompt',
      'requiredFields': 'List<String>? get requiredFields',
    },
  );
}

// =============================================================================
// SpecDoc Bridge
// =============================================================================

BridgedClass _createSpecDocBridge() {
  return BridgedClass(
    nativeType: $tom_build_15.SpecDoc,
    name: 'SpecDoc',
    constructors: {
      '': (visitor, positional, named) {
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'SpecDoc');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'SpecDoc');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'SpecDoc');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'SpecDoc');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'SpecDoc');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'SpecDoc');
        final fields = named.containsKey('fields') && named['fields'] != null
            ? D4.coerceMap<String, String>(named['fields'], 'fields')
            : const <String, String>{};
        final sections = D4.coerceListOrNull<$tom_build_7.Section>(named['sections'], 'sections');
        final filenameWithPath = D4.getRequiredNamedArg<String>(named, 'filenameWithPath', 'SpecDoc');
        final loadTimestamp = D4.getRequiredNamedArg<String>(named, 'loadTimestamp', 'SpecDoc');
        final filename = D4.getRequiredNamedArg<String>(named, 'filename', 'SpecDoc');
        final fullPath = D4.getRequiredNamedArg<String>(named, 'fullPath', 'SpecDoc');
        final workspacePath = D4.getRequiredNamedArg<String>(named, 'workspacePath', 'SpecDoc');
        final project = D4.getRequiredNamedArg<String>(named, 'project', 'SpecDoc');
        final projectPath = D4.getRequiredNamedArg<String>(named, 'projectPath', 'SpecDoc');
        final workspaceRoot = D4.getRequiredNamedArg<String>(named, 'workspaceRoot', 'SpecDoc');
        final projectRoot = D4.getRequiredNamedArg<String>(named, 'projectRoot', 'SpecDoc');
        final hierarchyDepth = D4.getRequiredNamedArg<int>(named, 'hierarchyDepth', 'SpecDoc');
        final schemaId = D4.getNamedArgWithDefault<String>(named, 'schemaId', '');
        final validationErrors = D4.coerceListOrNull<String>(named['validationErrors'], 'validationErrors');
        final accessKeys = D4.coerceMapOrNull<String, String>(named['accessKeys'], 'accessKeys');
        return $tom_build_15.SpecDoc(index: index, lineNumber: lineNumber, rawHeadline: rawHeadline, name: name, id: id, text: text, fields: fields, sections: sections, filenameWithPath: filenameWithPath, loadTimestamp: loadTimestamp, filename: filename, fullPath: fullPath, workspacePath: workspacePath, project: project, projectPath: projectPath, workspaceRoot: workspaceRoot, projectRoot: projectRoot, hierarchyDepth: hierarchyDepth, schemaId: schemaId, validationErrors: validationErrors, accessKeys: accessKeys);
      },
      'fromDocument': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SpecDoc');
        final document = D4.getRequiredArg<$tom_build_5.Document>(positional, 0, 'document', 'SpecDoc');
        final schemaId = D4.getNamedArgWithDefault<String>(named, 'schemaId', '');
        final validationErrors = D4.coerceListOrNull<String>(named['validationErrors'], 'validationErrors');
        final accessKeys = D4.coerceMapOrNull<String, String>(named['accessKeys'], 'accessKeys');
        return $tom_build_15.SpecDoc.fromDocument(document, schemaId: schemaId, validationErrors: validationErrors, accessKeys: accessKeys);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SpecDoc');
        if (positional.isEmpty) {
          throw ArgumentError('SpecDoc: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_build_15.SpecDoc.fromJson(json);
      },
    },
    getters: {
      'index': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').index,
      'lineNumber': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').lineNumber,
      'rawHeadline': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').rawHeadline,
      'name': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').name,
      'id': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').id,
      'text': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').text,
      'fields': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').fields,
      'sections': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').sections,
      'filenameWithPath': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').filenameWithPath,
      'loadTimestamp': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').loadTimestamp,
      'filename': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').filename,
      'fullPath': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').fullPath,
      'workspacePath': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').workspacePath,
      'project': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').project,
      'projectPath': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').projectPath,
      'workspaceRoot': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').workspaceRoot,
      'projectRoot': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').projectRoot,
      'hierarchyDepth': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').hierarchyDepth,
      'schemaId': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').schemaId,
      'validationErrors': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').validationErrors,
      'isValid': (visitor, target) => D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc').isValid,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc');
        return t.toString();
      },
      'getSection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc');
        D4.requireMinArgs(positional, 1, 'getSection');
        final sectionName = D4.getRequiredArg<String>(positional, 0, 'sectionName', 'getSection');
        return t.getSection(sectionName);
      },
      'getSpecSectionType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc');
        D4.requireMinArgs(positional, 1, 'getSpecSectionType');
        final typeName = D4.getRequiredArg<String>(positional, 0, 'typeName', 'getSpecSectionType');
        return t.getSpecSectionType(typeName);
      },
      'getSectionsByTag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc');
        D4.requireMinArgs(positional, 1, 'getSectionsByTag');
        final tag = D4.getRequiredArg<String>(positional, 0, 'tag', 'getSectionsByTag');
        final typeName = D4.getOptionalArg<String?>(positional, 1, 'typeName');
        return t.getSectionsByTag(tag, typeName);
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_15.SpecDoc>(target, 'SpecDoc');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
    },
    constructorSignatures: {
      '': 'SpecDoc({required int index, required int lineNumber, required String rawHeadline, required String name, required String id, required String text, Map<String, String> fields = const {}, List<Section>? sections, required String filenameWithPath, required String loadTimestamp, required String filename, required String fullPath, required String workspacePath, required String project, required String projectPath, required String workspaceRoot, required String projectRoot, required int hierarchyDepth, String schemaId = \'\', List<String>? validationErrors, Map<String, String>? accessKeys})',
      'fromDocument': 'factory SpecDoc.fromDocument(Document document, {String schemaId = \'\', List<String>? validationErrors, Map<String, String>? accessKeys})',
      'fromJson': 'factory SpecDoc.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
      'getSection': 'SpecSection? getSection(String sectionName)',
      'getSpecSectionType': 'SpecSectionType getSpecSectionType(String typeName)',
      'getSectionsByTag': 'List<SpecSection> getSectionsByTag(String tag, [String? typeName])',
    },
    getterSignatures: {
      'index': 'int get index',
      'lineNumber': 'int get lineNumber',
      'rawHeadline': 'String get rawHeadline',
      'name': 'String get name',
      'id': 'String get id',
      'text': 'String get text',
      'fields': 'Map<String, String> get fields',
      'sections': 'List<Section>? get sections',
      'filenameWithPath': 'String get filenameWithPath',
      'loadTimestamp': 'String get loadTimestamp',
      'filename': 'String get filename',
      'fullPath': 'String get fullPath',
      'workspacePath': 'String get workspacePath',
      'project': 'String get project',
      'projectPath': 'String get projectPath',
      'workspaceRoot': 'String get workspaceRoot',
      'projectRoot': 'String get projectRoot',
      'hierarchyDepth': 'int get hierarchyDepth',
      'schemaId': 'String get schemaId',
      'validationErrors': 'List<String> get validationErrors',
      'isValid': 'bool get isValid',
    },
  );
}

// =============================================================================
// SpecSection Bridge
// =============================================================================

BridgedClass _createSpecSectionBridge() {
  return BridgedClass(
    nativeType: $tom_build_16.SpecSection,
    name: 'SpecSection',
    constructors: {
      '': (visitor, positional, named) {
        final index = D4.getRequiredNamedArg<int>(named, 'index', 'SpecSection');
        final lineNumber = D4.getRequiredNamedArg<int>(named, 'lineNumber', 'SpecSection');
        final rawHeadline = D4.getRequiredNamedArg<String>(named, 'rawHeadline', 'SpecSection');
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'SpecSection');
        final id = D4.getRequiredNamedArg<String>(named, 'id', 'SpecSection');
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'SpecSection');
        final fields = named.containsKey('fields') && named['fields'] != null
            ? D4.coerceMap<String, String>(named['fields'], 'fields')
            : const <String, String>{};
        final sections = D4.coerceListOrNull<$tom_build_7.Section>(named['sections'], 'sections');
        final type = D4.getOptionalNamedArg<String?>(named, 'type');
        final tags = D4.coerceListOrNull<String>(named['tags'], 'tags');
        final format = D4.getOptionalNamedArg<String?>(named, 'format');
        return $tom_build_16.SpecSection(index: index, lineNumber: lineNumber, rawHeadline: rawHeadline, name: name, id: id, text: text, fields: fields, sections: sections, type: type, tags: tags, format: format);
      },
      'fromSection': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SpecSection');
        final section = D4.getRequiredArg<$tom_build_7.Section>(positional, 0, 'section', 'SpecSection');
        final type = D4.getOptionalNamedArg<String?>(named, 'type');
        final tags = D4.coerceListOrNull<String>(named['tags'], 'tags');
        final format = D4.getOptionalNamedArg<String?>(named, 'format');
        return $tom_build_16.SpecSection.fromSection(section, type: type, tags: tags, format: format);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SpecSection');
        if (positional.isEmpty) {
          throw ArgumentError('SpecSection: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $tom_build_16.SpecSection.fromJson(json);
      },
    },
    getters: {
      'index': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').index,
      'lineNumber': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').lineNumber,
      'rawHeadline': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').rawHeadline,
      'name': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').name,
      'id': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').id,
      'text': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').text,
      'fields': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').fields,
      'sections': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').sections,
      'type': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').type,
      'tags': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').tags,
      'format': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').format,
      'preamble': (visitor, target) => D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection').preamble,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection');
        return t.toJson();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection');
        return t.toString();
      },
      'getFormField': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection');
        D4.requireMinArgs(positional, 1, 'getFormField');
        final fieldname = D4.getRequiredArg<String>(positional, 0, 'fieldname', 'getFormField');
        return t.getFormField(fieldname);
      },
      'getSubsectionsByType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection');
        D4.requireMinArgs(positional, 1, 'getSubsectionsByType');
        final typeName = D4.getRequiredArg<String>(positional, 0, 'typeName', 'getSubsectionsByType');
        return t.getSubsectionsByType(typeName);
      },
      'getSubsections': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_16.SpecSection>(target, 'SpecSection');
        return t.getSubsections();
      },
    },
    constructorSignatures: {
      '': 'SpecSection({required int index, required int lineNumber, required String rawHeadline, required String name, required String id, required String text, Map<String, String> fields = const {}, List<Section>? sections, String? type, List<String>? tags, String? format})',
      'fromSection': 'factory SpecSection.fromSection(Section section, {String? type, List<String>? tags, String? format})',
      'fromJson': 'factory SpecSection.fromJson(Map<String, dynamic> json)',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'toString': 'String toString()',
      'getFormField': 'String? getFormField(String fieldname)',
      'getSubsectionsByType': 'List<SpecSection> getSubsectionsByType(String typeName)',
      'getSubsections': 'List<SpecSection> getSubsections()',
    },
    getterSignatures: {
      'index': 'int get index',
      'lineNumber': 'int get lineNumber',
      'rawHeadline': 'String get rawHeadline',
      'name': 'String get name',
      'id': 'String get id',
      'text': 'String get text',
      'fields': 'Map<String, String> get fields',
      'sections': 'List<Section>? get sections',
      'type': 'String? get type',
      'tags': 'List<String> get tags',
      'format': 'String? get format',
      'preamble': 'String? get preamble',
    },
  );
}

// =============================================================================
// SpecSectionType Bridge
// =============================================================================

BridgedClass _createSpecSectionTypeBridge() {
  return BridgedClass(
    nativeType: $tom_build_17.SpecSectionType,
    name: 'SpecSectionType',
    constructors: {
      '': (visitor, positional, named) {
        final type = D4.getRequiredNamedArg<String>(named, 'type', 'SpecSectionType');
        if (!named.containsKey('sections') || named['sections'] == null) {
          throw ArgumentError('SpecSectionType: Missing required named argument "sections"');
        }
        final sections = D4.coerceMap<$tom_build_16.SpecSection, List<$tom_build_16.SpecSection>>(named['sections'], 'sections');
        return $tom_build_17.SpecSectionType(type: type, sections: sections);
      },
      'empty': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SpecSectionType');
        final type = D4.getRequiredArg<String>(positional, 0, 'type', 'SpecSectionType');
        return $tom_build_17.SpecSectionType.empty(type);
      },
    },
    getters: {
      'type': (visitor, target) => D4.validateTarget<$tom_build_17.SpecSectionType>(target, 'SpecSectionType').type,
      'sections': (visitor, target) => D4.validateTarget<$tom_build_17.SpecSectionType>(target, 'SpecSectionType').sections,
      'sources': (visitor, target) => D4.validateTarget<$tom_build_17.SpecSectionType>(target, 'SpecSectionType').sources,
      'isEmpty': (visitor, target) => D4.validateTarget<$tom_build_17.SpecSectionType>(target, 'SpecSectionType').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$tom_build_17.SpecSectionType>(target, 'SpecSectionType').isNotEmpty,
      'length': (visitor, target) => D4.validateTarget<$tom_build_17.SpecSectionType>(target, 'SpecSectionType').length,
    },
    methods: {
      'getAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_17.SpecSectionType>(target, 'SpecSectionType');
        return t.getAll();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_17.SpecSectionType>(target, 'SpecSectionType');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const SpecSectionType({required String type, required Map<SpecSection, List<SpecSection>> sections})',
      'empty': 'factory SpecSectionType.empty(String type)',
    },
    methodSignatures: {
      'getAll': 'List<SpecSection> getAll()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'type': 'String get type',
      'sections': 'Map<SpecSection, List<SpecSection>> get sections',
      'sources': 'List<SpecSection> get sources',
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'length': 'int get length',
    },
  );
}

// =============================================================================
// SchemaFilenameParser Bridge
// =============================================================================

BridgedClass _createSchemaFilenameParserBridge() {
  return BridgedClass(
    nativeType: $tom_build_18.SchemaFilenameParser,
    name: 'SchemaFilenameParser',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_18.SchemaFilenameParser();
      },
    },
    staticMethods: {
      'parse': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parse');
        final filename = D4.getRequiredArg<String>(positional, 0, 'filename', 'parse');
        return $tom_build_18.SchemaFilenameParser.parse(filename);
      },
    },
    constructorSignatures: {
      '': 'SchemaFilenameParser()',
    },
    staticMethodSignatures: {
      'parse': '({String id, String version})? parse(String filename)',
    },
  );
}

// =============================================================================
// SchemaLoader Bridge
// =============================================================================

BridgedClass _createSchemaLoaderBridge() {
  return BridgedClass(
    nativeType: $tom_build_18.SchemaLoader,
    name: 'SchemaLoader',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_18.SchemaLoader();
      },
    },
    staticMethods: {
      'load': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'load');
        final filePath = D4.getRequiredArg<String>(positional, 0, 'filePath', 'load');
        return $tom_build_18.SchemaLoader.load(filePath);
      },
      'loadSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadSync');
        final filePath = D4.getRequiredArg<String>(positional, 0, 'filePath', 'loadSync');
        return $tom_build_18.SchemaLoader.loadSync(filePath);
      },
    },
    constructorSignatures: {
      '': 'SchemaLoader()',
    },
    staticMethodSignatures: {
      'load': 'Future<DocSpecSchema> load(String filePath)',
      'loadSync': 'DocSpecSchema loadSync(String filePath)',
    },
  );
}

// =============================================================================
// SchemaResolver Bridge
// =============================================================================

BridgedClass _createSchemaResolverBridge() {
  return BridgedClass(
    nativeType: $tom_build_18.SchemaResolver,
    name: 'SchemaResolver',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_18.SchemaResolver();
      },
    },
    staticGetters: {
      'schemaExtensions': (visitor) => $tom_build_18.SchemaResolver.schemaExtensions,
    },
    staticMethods: {
      'resolve': (visitor, positional, named, typeArgs) {
        final schemaId = D4.getRequiredNamedArg<String>(named, 'schemaId', 'resolve');
        final documentPath = D4.getOptionalNamedArg<String?>(named, 'documentPath');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_18.SchemaResolver.resolve(schemaId: schemaId, documentPath: documentPath, workspaceRoot: workspaceRoot);
      },
      'resolveSync': (visitor, positional, named, typeArgs) {
        final schemaId = D4.getRequiredNamedArg<String>(named, 'schemaId', 'resolveSync');
        final documentPath = D4.getOptionalNamedArg<String?>(named, 'documentPath');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_18.SchemaResolver.resolveSync(schemaId: schemaId, documentPath: documentPath, workspaceRoot: workspaceRoot);
      },
    },
    constructorSignatures: {
      '': 'SchemaResolver()',
    },
    staticMethodSignatures: {
      'resolve': 'Future<DocSpecSchema?> resolve({required String schemaId, String? documentPath, String? workspaceRoot})',
      'resolveSync': 'DocSpecSchema? resolveSync({required String schemaId, String? documentPath, String? workspaceRoot})',
    },
    staticGetterSignatures: {
      'schemaExtensions': 'dynamic get schemaExtensions',
    },
  );
}

// =============================================================================
// SchemaDiscovery Bridge
// =============================================================================

BridgedClass _createSchemaDiscoveryBridge() {
  return BridgedClass(
    nativeType: $tom_build_18.SchemaDiscovery,
    name: 'SchemaDiscovery',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_18.SchemaDiscovery();
      },
    },
    staticMethods: {
      'listSchemas': (visitor, positional, named, typeArgs) {
        final documentPath = D4.getOptionalNamedArg<String?>(named, 'documentPath');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_18.SchemaDiscovery.listSchemas(documentPath: documentPath, workspaceRoot: workspaceRoot);
      },
      'listSchemasSync': (visitor, positional, named, typeArgs) {
        final documentPath = D4.getOptionalNamedArg<String?>(named, 'documentPath');
        final workspaceRoot = D4.getOptionalNamedArg<String?>(named, 'workspaceRoot');
        return $tom_build_18.SchemaDiscovery.listSchemasSync(documentPath: documentPath, workspaceRoot: workspaceRoot);
      },
      'listSchemasIn': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'listSchemasIn');
        final folderPath = D4.getRequiredArg<String>(positional, 0, 'folderPath', 'listSchemasIn');
        return $tom_build_18.SchemaDiscovery.listSchemasIn(folderPath);
      },
      'listSchemasInSync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'listSchemasInSync');
        final folderPath = D4.getRequiredArg<String>(positional, 0, 'folderPath', 'listSchemasInSync');
        return $tom_build_18.SchemaDiscovery.listSchemasInSync(folderPath);
      },
    },
    constructorSignatures: {
      '': 'SchemaDiscovery()',
    },
    staticMethodSignatures: {
      'listSchemas': 'Future<List<SchemaInfo>> listSchemas({String? documentPath, String? workspaceRoot})',
      'listSchemasSync': 'List<SchemaInfo> listSchemasSync({String? documentPath, String? workspaceRoot})',
      'listSchemasIn': 'Future<List<SchemaInfo>> listSchemasIn(String folderPath)',
      'listSchemasInSync': 'List<SchemaInfo> listSchemasInSync(String folderPath)',
    },
  );
}

// =============================================================================
// ValidationError Bridge
// =============================================================================

BridgedClass _createValidationErrorBridge() {
  return BridgedClass(
    nativeType: $tom_build_19.ValidationError,
    name: 'ValidationError',
    constructors: {
      '': (visitor, positional, named) {
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'ValidationError');
        final lineNumber = D4.getOptionalNamedArg<int?>(named, 'lineNumber');
        final sectionId = D4.getOptionalNamedArg<String?>(named, 'sectionId');
        final category = D4.getNamedArgWithDefault<$tom_build_19.ValidationErrorCategory>(named, 'category', $tom_build_19.ValidationErrorCategory.general);
        return $tom_build_19.ValidationError(message: message, lineNumber: lineNumber, sectionId: sectionId, category: category);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$tom_build_19.ValidationError>(target, 'ValidationError').message,
      'lineNumber': (visitor, target) => D4.validateTarget<$tom_build_19.ValidationError>(target, 'ValidationError').lineNumber,
      'sectionId': (visitor, target) => D4.validateTarget<$tom_build_19.ValidationError>(target, 'ValidationError').sectionId,
      'category': (visitor, target) => D4.validateTarget<$tom_build_19.ValidationError>(target, 'ValidationError').category,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_19.ValidationError>(target, 'ValidationError');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ValidationError({required String message, int? lineNumber, String? sectionId, ValidationErrorCategory category = ValidationErrorCategory.general})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'lineNumber': 'int? get lineNumber',
      'sectionId': 'String? get sectionId',
      'category': 'ValidationErrorCategory get category',
    },
  );
}

// =============================================================================
// DocSpecsValidator Bridge
// =============================================================================

BridgedClass _createDocSpecsValidatorBridge() {
  return BridgedClass(
    nativeType: $tom_build_20.DocSpecsValidator,
    name: 'DocSpecsValidator',
    constructors: {
      '': (visitor, positional, named) {
        final schema = D4.getRequiredNamedArg<$tom_build_10.DocSpecSchema>(named, 'schema', 'DocSpecsValidator');
        return $tom_build_20.DocSpecsValidator(schema: schema);
      },
    },
    getters: {
      'schema': (visitor, target) => D4.validateTarget<$tom_build_20.DocSpecsValidator>(target, 'DocSpecsValidator').schema,
    },
    methods: {
      'validate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_20.DocSpecsValidator>(target, 'DocSpecsValidator');
        D4.requireMinArgs(positional, 1, 'validate');
        final doc = D4.getRequiredArg<$tom_build_5.Document>(positional, 0, 'doc', 'validate');
        return t.validate(doc);
      },
    },
    constructorSignatures: {
      '': 'const DocSpecsValidator({required DocSpecSchema schema})',
    },
    methodSignatures: {
      'validate': 'List<ValidationError> validate(Document doc)',
    },
    getterSignatures: {
      'schema': 'DocSpecSchema get schema',
    },
  );
}

// =============================================================================
// LatexMacros Bridge
// =============================================================================

BridgedClass _createLatexMacrosBridge() {
  return BridgedClass(
    nativeType: $tom_build_21.LatexMacros,
    name: 'LatexMacros',
    constructors: {
    },
    staticMethods: {
      'preamble': (visitor, positional, named, typeArgs) {
        final documentClass = D4.getNamedArgWithDefault<String>(named, 'documentClass', 'article');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final author = D4.getOptionalNamedArg<String?>(named, 'author');
        final date = D4.getOptionalNamedArg<String?>(named, 'date');
        final tocDepth = D4.getNamedArgWithDefault<int>(named, 'tocDepth', 3);
        return $tom_build_21.LatexMacros.preamble(documentClass: documentClass, title: title, author: author, date: date, tocDepth: tocDepth);
      },
      'beginDocument': (visitor, positional, named, typeArgs) {
        return $tom_build_21.LatexMacros.beginDocument();
      },
      'endDocument': (visitor, positional, named, typeArgs) {
        return $tom_build_21.LatexMacros.endDocument();
      },
      'makeTitle': (visitor, positional, named, typeArgs) {
        return $tom_build_21.LatexMacros.makeTitle();
      },
      'textToSlug': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'textToSlug');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'textToSlug');
        return $tom_build_21.LatexMacros.textToSlug(text);
      },
      'heading': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'heading');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'heading');
        final level = D4.getRequiredArg<int>(positional, 1, 'level', 'heading');
        final label = D4.getOptionalNamedArg<String?>(named, 'label');
        final numbered = D4.getNamedArgWithDefault<bool>(named, 'numbered', true);
        return $tom_build_21.LatexMacros.heading(text, level, label: label, numbered: numbered);
      },
      'paragraph': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'paragraph');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'paragraph');
        return $tom_build_21.LatexMacros.paragraph(text);
      },
      'bold': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'bold');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'bold');
        return $tom_build_21.LatexMacros.bold(text);
      },
      'italic': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'italic');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'italic');
        return $tom_build_21.LatexMacros.italic(text);
      },
      'inlineCode': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'inlineCode');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'inlineCode');
        return $tom_build_21.LatexMacros.inlineCode(code);
      },
      'codeBlock': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'codeBlock');
        final code = D4.getRequiredArg<String>(positional, 0, 'code', 'codeBlock');
        final language = D4.getOptionalNamedArg<String?>(named, 'language');
        return $tom_build_21.LatexMacros.codeBlock(code, language: language);
      },
      'asciiDiagram': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'asciiDiagram');
        final diagram = D4.getRequiredArg<String>(positional, 0, 'diagram', 'asciiDiagram');
        return $tom_build_21.LatexMacros.asciiDiagram(diagram);
      },
      'table': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'table');
        if (positional.isEmpty) {
          throw ArgumentError('table: Missing required argument "headers" at position 0');
        }
        final headers = D4.coerceList<String>(positional[0], 'headers');
        if (positional.length <= 1) {
          throw ArgumentError('table: Missing required argument "rows" at position 1');
        }
        final rows = D4.coerceList<List<String>>(positional[1], 'rows');
        if (positional.length <= 2) {
          throw ArgumentError('table: Missing required argument "alignments" at position 2');
        }
        final alignments = D4.coerceList<String>(positional[2], 'alignments');
        return $tom_build_21.LatexMacros.table(headers, rows, alignments);
      },
      'unorderedList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'unorderedList');
        if (positional.isEmpty) {
          throw ArgumentError('unorderedList: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<String>(positional[0], 'items');
        return $tom_build_21.LatexMacros.unorderedList(items);
      },
      'orderedList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'orderedList');
        if (positional.isEmpty) {
          throw ArgumentError('orderedList: Missing required argument "items" at position 0');
        }
        final items = D4.coerceList<String>(positional[0], 'items');
        return $tom_build_21.LatexMacros.orderedList(items);
      },
      'blockQuote': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'blockQuote');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'blockQuote');
        return $tom_build_21.LatexMacros.blockQuote(text);
      },
      'horizontalRule': (visitor, positional, named, typeArgs) {
        return $tom_build_21.LatexMacros.horizontalRule();
      },
      'link': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'link');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'link');
        final url = D4.getRequiredArg<String>(positional, 1, 'url', 'link');
        return $tom_build_21.LatexMacros.link(text, url);
      },
      'image': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'image');
        final altText = D4.getRequiredArg<String>(positional, 0, 'altText', 'image');
        final url = D4.getRequiredArg<String>(positional, 1, 'url', 'image');
        return $tom_build_21.LatexMacros.image(altText, url);
      },
      'escapeText': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'escapeText');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'escapeText');
        return $tom_build_21.LatexMacros.escapeText(text);
      },
    },
    staticMethodSignatures: {
      'preamble': 'String preamble({String documentClass = \'article\', String? title, String? author, String? date, int tocDepth = 3})',
      'beginDocument': 'String beginDocument()',
      'endDocument': 'String endDocument()',
      'makeTitle': 'String makeTitle()',
      'textToSlug': 'String textToSlug(String text)',
      'heading': 'String heading(String text, int level, {String? label, bool numbered = true})',
      'paragraph': 'String paragraph(String text)',
      'bold': 'String bold(String text)',
      'italic': 'String italic(String text)',
      'inlineCode': 'String inlineCode(String code)',
      'codeBlock': 'String codeBlock(String code, {String? language})',
      'asciiDiagram': 'String asciiDiagram(String diagram)',
      'table': 'String table(List<String> headers, List<List<String>> rows, List<String> alignments)',
      'unorderedList': 'String unorderedList(List<String> items)',
      'orderedList': 'String orderedList(List<String> items)',
      'blockQuote': 'String blockQuote(String text)',
      'horizontalRule': 'String horizontalRule()',
      'link': 'String link(String text, String url)',
      'image': 'String image(String altText, String url)',
      'escapeText': 'String escapeText(String text)',
    },
  );
}

// =============================================================================
// MarkdownParserOptions Bridge
// =============================================================================

BridgedClass _createMarkdownParserOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.MarkdownParserOptions,
    name: 'MarkdownParserOptions',
    constructors: {
      '': (visitor, positional, named) {
        final detectAsciiDiagrams = D4.getNamedArgWithDefault<bool>(named, 'detectAsciiDiagrams', true);
        final asciiDiagramPatterns = named.containsKey('asciiDiagramPatterns') && named['asciiDiagramPatterns'] != null
            ? D4.coerceList<String>(named['asciiDiagramPatterns'], 'asciiDiagramPatterns')
            : const ['├', '└', '│', '─', '┬', '┴', '┼', '┤', '┌', '┐', '┘', '┐', '+--', '|--', '\\--', '+-', '|-', '/---', '\\---', '[', ']'];
        return $tom_build_22.MarkdownParserOptions(detectAsciiDiagrams: detectAsciiDiagrams, asciiDiagramPatterns: asciiDiagramPatterns);
      },
    },
    getters: {
      'detectAsciiDiagrams': (visitor, target) => D4.validateTarget<$tom_build_22.MarkdownParserOptions>(target, 'MarkdownParserOptions').detectAsciiDiagrams,
      'asciiDiagramPatterns': (visitor, target) => D4.validateTarget<$tom_build_22.MarkdownParserOptions>(target, 'MarkdownParserOptions').asciiDiagramPatterns,
    },
    constructorSignatures: {
      '': 'const MarkdownParserOptions({bool detectAsciiDiagrams = true, List<String> asciiDiagramPatterns = const [\'├\', \'└\', \'│\', \'─\', \'┬\', \'┴\', \'┼\', \'┤\', \'┌\', \'┐\', \'┘\', \'┐\', \'+--\', \'|--\', \'\\\\--\', \'+-\', \'|-\', \'/---\', \'\\\\---\', \'[\', \']\']})',
    },
    getterSignatures: {
      'detectAsciiDiagrams': 'bool get detectAsciiDiagrams',
      'asciiDiagramPatterns': 'List<String> get asciiDiagramPatterns',
    },
  );
}

// =============================================================================
// ParsedMarkdown Bridge
// =============================================================================

BridgedClass _createParsedMarkdownBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.ParsedMarkdown,
    name: 'ParsedMarkdown',
    constructors: {
      '': (visitor, positional, named) {
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final author = D4.getOptionalNamedArg<String?>(named, 'author');
        final date = D4.getOptionalNamedArg<String?>(named, 'date');
        final generateToc = D4.getNamedArgWithDefault<bool>(named, 'generateToc', false);
        final tocDepth = D4.getOptionalNamedArg<int?>(named, 'tocDepth');
        if (!named.containsKey('elements') || named['elements'] == null) {
          throw ArgumentError('ParsedMarkdown: Missing required named argument "elements"');
        }
        final elements = D4.coerceList<$tom_build_22.MarkdownElement>(named['elements'], 'elements');
        return $tom_build_22.ParsedMarkdown(title: title, author: author, date: date, generateToc: generateToc, tocDepth: tocDepth, elements: elements);
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$tom_build_22.ParsedMarkdown>(target, 'ParsedMarkdown').title,
      'author': (visitor, target) => D4.validateTarget<$tom_build_22.ParsedMarkdown>(target, 'ParsedMarkdown').author,
      'date': (visitor, target) => D4.validateTarget<$tom_build_22.ParsedMarkdown>(target, 'ParsedMarkdown').date,
      'generateToc': (visitor, target) => D4.validateTarget<$tom_build_22.ParsedMarkdown>(target, 'ParsedMarkdown').generateToc,
      'tocDepth': (visitor, target) => D4.validateTarget<$tom_build_22.ParsedMarkdown>(target, 'ParsedMarkdown').tocDepth,
      'elements': (visitor, target) => D4.validateTarget<$tom_build_22.ParsedMarkdown>(target, 'ParsedMarkdown').elements,
    },
    constructorSignatures: {
      '': 'const ParsedMarkdown({String? title, String? author, String? date, bool generateToc = false, int? tocDepth, required List<MarkdownElement> elements})',
    },
    getterSignatures: {
      'title': 'String? get title',
      'author': 'String? get author',
      'date': 'String? get date',
      'generateToc': 'bool get generateToc',
      'tocDepth': 'int? get tocDepth',
      'elements': 'List<MarkdownElement> get elements',
    },
  );
}

// =============================================================================
// MarkdownElement Bridge
// =============================================================================

BridgedClass _createMarkdownElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.MarkdownElement,
    name: 'MarkdownElement',
    constructors: {
    },
    constructorSignatures: {
      '': 'MarkdownElement()',
    },
  );
}

// =============================================================================
// HeadingElement Bridge
// =============================================================================

BridgedClass _createHeadingElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.HeadingElement,
    name: 'HeadingElement',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'HeadingElement');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'HeadingElement');
        final level = D4.getRequiredArg<int>(positional, 1, 'level', 'HeadingElement');
        return $tom_build_22.HeadingElement(text, level);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_build_22.HeadingElement>(target, 'HeadingElement').text,
      'level': (visitor, target) => D4.validateTarget<$tom_build_22.HeadingElement>(target, 'HeadingElement').level,
    },
    constructorSignatures: {
      '': 'HeadingElement(String text, int level)',
    },
    getterSignatures: {
      'text': 'String get text',
      'level': 'int get level',
    },
  );
}

// =============================================================================
// ParagraphElement Bridge
// =============================================================================

BridgedClass _createParagraphElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.ParagraphElement,
    name: 'ParagraphElement',
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'ParagraphElement');
        return $tom_build_22.ParagraphElement(text: text);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_build_22.ParagraphElement>(target, 'ParagraphElement').text,
    },
    constructorSignatures: {
      '': 'ParagraphElement({required String text})',
    },
    getterSignatures: {
      'text': 'String get text',
    },
  );
}

// =============================================================================
// CodeBlockElement Bridge
// =============================================================================

BridgedClass _createCodeBlockElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.CodeBlockElement,
    name: 'CodeBlockElement',
    constructors: {
      '': (visitor, positional, named) {
        final code = D4.getRequiredNamedArg<String>(named, 'code', 'CodeBlockElement');
        final language = D4.getOptionalNamedArg<String?>(named, 'language');
        final isAsciiDiagram = D4.getNamedArgWithDefault<bool>(named, 'isAsciiDiagram', false);
        return $tom_build_22.CodeBlockElement(code: code, language: language, isAsciiDiagram: isAsciiDiagram);
      },
    },
    getters: {
      'code': (visitor, target) => D4.validateTarget<$tom_build_22.CodeBlockElement>(target, 'CodeBlockElement').code,
      'language': (visitor, target) => D4.validateTarget<$tom_build_22.CodeBlockElement>(target, 'CodeBlockElement').language,
      'isAsciiDiagram': (visitor, target) => D4.validateTarget<$tom_build_22.CodeBlockElement>(target, 'CodeBlockElement').isAsciiDiagram,
    },
    constructorSignatures: {
      '': 'CodeBlockElement({required String code, String? language, bool isAsciiDiagram = false})',
    },
    getterSignatures: {
      'code': 'String get code',
      'language': 'String? get language',
      'isAsciiDiagram': 'bool get isAsciiDiagram',
    },
  );
}

// =============================================================================
// InlineCodeElement Bridge
// =============================================================================

BridgedClass _createInlineCodeElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.InlineCodeElement,
    name: 'InlineCodeElement',
    constructors: {
      '': (visitor, positional, named) {
        final code = D4.getRequiredNamedArg<String>(named, 'code', 'InlineCodeElement');
        return $tom_build_22.InlineCodeElement(code: code);
      },
    },
    getters: {
      'code': (visitor, target) => D4.validateTarget<$tom_build_22.InlineCodeElement>(target, 'InlineCodeElement').code,
    },
    constructorSignatures: {
      '': 'InlineCodeElement({required String code})',
    },
    getterSignatures: {
      'code': 'String get code',
    },
  );
}

// =============================================================================
// TableElement Bridge
// =============================================================================

BridgedClass _createTableElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.TableElement,
    name: 'TableElement',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('headers') || named['headers'] == null) {
          throw ArgumentError('TableElement: Missing required named argument "headers"');
        }
        final headers = D4.coerceList<String>(named['headers'], 'headers');
        if (!named.containsKey('rows') || named['rows'] == null) {
          throw ArgumentError('TableElement: Missing required named argument "rows"');
        }
        final rows = D4.coerceList<List<String>>(named['rows'], 'rows');
        if (!named.containsKey('alignments') || named['alignments'] == null) {
          throw ArgumentError('TableElement: Missing required named argument "alignments"');
        }
        final alignments = D4.coerceList<String>(named['alignments'], 'alignments');
        return $tom_build_22.TableElement(headers: headers, rows: rows, alignments: alignments);
      },
    },
    getters: {
      'headers': (visitor, target) => D4.validateTarget<$tom_build_22.TableElement>(target, 'TableElement').headers,
      'rows': (visitor, target) => D4.validateTarget<$tom_build_22.TableElement>(target, 'TableElement').rows,
      'alignments': (visitor, target) => D4.validateTarget<$tom_build_22.TableElement>(target, 'TableElement').alignments,
    },
    constructorSignatures: {
      '': 'TableElement({required List<String> headers, required List<List<String>> rows, required List<String> alignments})',
    },
    getterSignatures: {
      'headers': 'List<String> get headers',
      'rows': 'List<List<String>> get rows',
      'alignments': 'List<String> get alignments',
    },
  );
}

// =============================================================================
// UnorderedListElement Bridge
// =============================================================================

BridgedClass _createUnorderedListElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.UnorderedListElement,
    name: 'UnorderedListElement',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('items') || named['items'] == null) {
          throw ArgumentError('UnorderedListElement: Missing required named argument "items"');
        }
        final items = D4.coerceList<String>(named['items'], 'items');
        return $tom_build_22.UnorderedListElement(items: items);
      },
    },
    getters: {
      'items': (visitor, target) => D4.validateTarget<$tom_build_22.UnorderedListElement>(target, 'UnorderedListElement').items,
    },
    constructorSignatures: {
      '': 'UnorderedListElement({required List<String> items})',
    },
    getterSignatures: {
      'items': 'List<String> get items',
    },
  );
}

// =============================================================================
// OrderedListElement Bridge
// =============================================================================

BridgedClass _createOrderedListElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.OrderedListElement,
    name: 'OrderedListElement',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('items') || named['items'] == null) {
          throw ArgumentError('OrderedListElement: Missing required named argument "items"');
        }
        final items = D4.coerceList<String>(named['items'], 'items');
        return $tom_build_22.OrderedListElement(items: items);
      },
    },
    getters: {
      'items': (visitor, target) => D4.validateTarget<$tom_build_22.OrderedListElement>(target, 'OrderedListElement').items,
    },
    constructorSignatures: {
      '': 'OrderedListElement({required List<String> items})',
    },
    getterSignatures: {
      'items': 'List<String> get items',
    },
  );
}

// =============================================================================
// BlockQuoteElement Bridge
// =============================================================================

BridgedClass _createBlockQuoteElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.BlockQuoteElement,
    name: 'BlockQuoteElement',
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'BlockQuoteElement');
        return $tom_build_22.BlockQuoteElement(text: text);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_build_22.BlockQuoteElement>(target, 'BlockQuoteElement').text,
    },
    constructorSignatures: {
      '': 'BlockQuoteElement({required String text})',
    },
    getterSignatures: {
      'text': 'String get text',
    },
  );
}

// =============================================================================
// HorizontalRuleElement Bridge
// =============================================================================

BridgedClass _createHorizontalRuleElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.HorizontalRuleElement,
    name: 'HorizontalRuleElement',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_22.HorizontalRuleElement();
      },
    },
    constructorSignatures: {
      '': 'HorizontalRuleElement()',
    },
  );
}

// =============================================================================
// LinkElement Bridge
// =============================================================================

BridgedClass _createLinkElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.LinkElement,
    name: 'LinkElement',
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'LinkElement');
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'LinkElement');
        return $tom_build_22.LinkElement(text: text, url: url);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_build_22.LinkElement>(target, 'LinkElement').text,
      'url': (visitor, target) => D4.validateTarget<$tom_build_22.LinkElement>(target, 'LinkElement').url,
    },
    constructorSignatures: {
      '': 'LinkElement({required String text, required String url})',
    },
    getterSignatures: {
      'text': 'String get text',
      'url': 'String get url',
    },
  );
}

// =============================================================================
// ImageElement Bridge
// =============================================================================

BridgedClass _createImageElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.ImageElement,
    name: 'ImageElement',
    constructors: {
      '': (visitor, positional, named) {
        final altText = D4.getRequiredNamedArg<String>(named, 'altText', 'ImageElement');
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'ImageElement');
        return $tom_build_22.ImageElement(altText: altText, url: url);
      },
    },
    getters: {
      'altText': (visitor, target) => D4.validateTarget<$tom_build_22.ImageElement>(target, 'ImageElement').altText,
      'url': (visitor, target) => D4.validateTarget<$tom_build_22.ImageElement>(target, 'ImageElement').url,
    },
    constructorSignatures: {
      '': 'ImageElement({required String altText, required String url})',
    },
    getterSignatures: {
      'altText': 'String get altText',
      'url': 'String get url',
    },
  );
}

// =============================================================================
// RawTextElement Bridge
// =============================================================================

BridgedClass _createRawTextElementBridge() {
  return BridgedClass(
    nativeType: $tom_build_22.RawTextElement,
    name: 'RawTextElement',
    constructors: {
      '': (visitor, positional, named) {
        final text = D4.getRequiredNamedArg<String>(named, 'text', 'RawTextElement');
        return $tom_build_22.RawTextElement(text: text);
      },
    },
    getters: {
      'text': (visitor, target) => D4.validateTarget<$tom_build_22.RawTextElement>(target, 'RawTextElement').text,
    },
    constructorSignatures: {
      '': 'RawTextElement({required String text})',
    },
    getterSignatures: {
      'text': 'String get text',
    },
  );
}

// =============================================================================
// MdLatexConverter Bridge
// =============================================================================

BridgedClass _createMdLatexConverterBridge() {
  return BridgedClass(
    nativeType: $tom_build_23.MdLatexConverter,
    name: 'MdLatexConverter',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MdLatexConverter');
        final sourcePath = D4.getRequiredArg<String>(positional, 0, 'sourcePath', 'MdLatexConverter');
        final options = D4.getOptionalNamedArg<$tom_build_23.MdLatexConverterOptions?>(named, 'options');
        return $tom_build_23.MdLatexConverter(sourcePath, options: options);
      },
    },
    getters: {
      'sourcePath': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverter>(target, 'MdLatexConverter').sourcePath,
      'options': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverter>(target, 'MdLatexConverter').options,
    },
    methods: {
      'findMarkdownFiles': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_23.MdLatexConverter>(target, 'MdLatexConverter');
        return t.findMarkdownFiles();
      },
      'convertAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_23.MdLatexConverter>(target, 'MdLatexConverter');
        final outputDir = D4.getRequiredNamedArg<String>(named, 'outputDir', 'convertAll');
        return t.convertAll(outputDir: outputDir);
      },
      'convertFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_23.MdLatexConverter>(target, 'MdLatexConverter');
        D4.requireMinArgs(positional, 1, 'convertFile');
        final file = D4.getRequiredArg<File>(positional, 0, 'file', 'convertFile');
        final outputDir = D4.getRequiredNamedArg<String>(named, 'outputDir', 'convertFile');
        return t.convertFile(file, outputDir: outputDir);
      },
      'convert': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_23.MdLatexConverter>(target, 'MdLatexConverter');
        D4.requireMinArgs(positional, 1, 'convert');
        final markdownContent = D4.getRequiredArg<String>(positional, 0, 'markdownContent', 'convert');
        return t.convert(markdownContent);
      },
    },
    constructorSignatures: {
      '': 'MdLatexConverter(String sourcePath, {MdLatexConverterOptions? options})',
    },
    methodSignatures: {
      'findMarkdownFiles': 'Future<List<File>> findMarkdownFiles()',
      'convertAll': 'Future<MdLatexConverterResult> convertAll({required String outputDir})',
      'convertFile': 'Future<ConvertedFile> convertFile(File file, {required String outputDir})',
      'convert': 'String convert(String markdownContent)',
    },
    getterSignatures: {
      'sourcePath': 'String get sourcePath',
      'options': 'MdLatexConverterOptions get options',
    },
  );
}

// =============================================================================
// MdLatexConverterOptions Bridge
// =============================================================================

BridgedClass _createMdLatexConverterOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_build_23.MdLatexConverterOptions,
    name: 'MdLatexConverterOptions',
    constructors: {
      '': (visitor, positional, named) {
        final excludePatterns = named.containsKey('excludePatterns') && named['excludePatterns'] != null
            ? D4.coerceList<String>(named['excludePatterns'], 'excludePatterns')
            : const ['.git', 'node_modules', '.dart_tool'];
        final generatePreamble = D4.getNamedArgWithDefault<bool>(named, 'generatePreamble', true);
        final documentClass = D4.getNamedArgWithDefault<String>(named, 'documentClass', 'article');
        final author = D4.getOptionalNamedArg<String?>(named, 'author');
        final generateToc = D4.getNamedArgWithDefault<bool>(named, 'generateToc', true);
        final tocDepth = D4.getNamedArgWithDefault<int>(named, 'tocDepth', 3);
        if (!named.containsKey('parserOptions')) {
          return $tom_build_23.MdLatexConverterOptions(excludePatterns: excludePatterns, generatePreamble: generatePreamble, documentClass: documentClass, author: author, generateToc: generateToc, tocDepth: tocDepth);
        }
        if (named.containsKey('parserOptions')) {
          final parserOptions = D4.getRequiredNamedArg<$tom_build_22.MarkdownParserOptions>(named, 'parserOptions', 'MdLatexConverterOptions');
          return $tom_build_23.MdLatexConverterOptions(excludePatterns: excludePatterns, generatePreamble: generatePreamble, documentClass: documentClass, author: author, generateToc: generateToc, tocDepth: tocDepth, parserOptions: parserOptions);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'excludePatterns': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterOptions>(target, 'MdLatexConverterOptions').excludePatterns,
      'generatePreamble': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterOptions>(target, 'MdLatexConverterOptions').generatePreamble,
      'documentClass': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterOptions>(target, 'MdLatexConverterOptions').documentClass,
      'author': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterOptions>(target, 'MdLatexConverterOptions').author,
      'generateToc': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterOptions>(target, 'MdLatexConverterOptions').generateToc,
      'tocDepth': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterOptions>(target, 'MdLatexConverterOptions').tocDepth,
      'parserOptions': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterOptions>(target, 'MdLatexConverterOptions').parserOptions,
    },
    constructorSignatures: {
      '': 'const MdLatexConverterOptions({List<String> excludePatterns = const [\'.git\', \'node_modules\', \'.dart_tool\'], bool generatePreamble = true, String documentClass = \'article\', String? author, bool generateToc = true, int tocDepth = 3, MarkdownParserOptions parserOptions = const MarkdownParserOptions()})',
    },
    getterSignatures: {
      'excludePatterns': 'List<String> get excludePatterns',
      'generatePreamble': 'bool get generatePreamble',
      'documentClass': 'String get documentClass',
      'author': 'String? get author',
      'generateToc': 'bool get generateToc',
      'tocDepth': 'int get tocDepth',
      'parserOptions': 'MarkdownParserOptions get parserOptions',
    },
  );
}

// =============================================================================
// MdLatexConverterResult Bridge
// =============================================================================

BridgedClass _createMdLatexConverterResultBridge() {
  return BridgedClass(
    nativeType: $tom_build_23.MdLatexConverterResult,
    name: 'MdLatexConverterResult',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_23.MdLatexConverterResult();
      },
    },
    getters: {
      'converted': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterResult>(target, 'MdLatexConverterResult').converted,
      'errors': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterResult>(target, 'MdLatexConverterResult').errors,
      'isSuccess': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterResult>(target, 'MdLatexConverterResult').isSuccess,
      'totalProcessed': (visitor, target) => D4.validateTarget<$tom_build_23.MdLatexConverterResult>(target, 'MdLatexConverterResult').totalProcessed,
    },
    constructorSignatures: {
      '': 'MdLatexConverterResult()',
    },
    getterSignatures: {
      'converted': 'List<ConvertedFile> get converted',
      'errors': 'List<ConversionError> get errors',
      'isSuccess': 'bool get isSuccess',
      'totalProcessed': 'int get totalProcessed',
    },
  );
}

// =============================================================================
// ConvertedFile Bridge
// =============================================================================

BridgedClass _createConvertedFileBridge() {
  return BridgedClass(
    nativeType: $tom_build_23.ConvertedFile,
    name: 'ConvertedFile',
    constructors: {
      '': (visitor, positional, named) {
        final sourcePath = D4.getRequiredNamedArg<String>(named, 'sourcePath', 'ConvertedFile');
        final outputPath = D4.getRequiredNamedArg<String>(named, 'outputPath', 'ConvertedFile');
        final parsed = D4.getRequiredNamedArg<$tom_build_22.ParsedMarkdown>(named, 'parsed', 'ConvertedFile');
        return $tom_build_23.ConvertedFile(sourcePath: sourcePath, outputPath: outputPath, parsed: parsed);
      },
    },
    getters: {
      'sourcePath': (visitor, target) => D4.validateTarget<$tom_build_23.ConvertedFile>(target, 'ConvertedFile').sourcePath,
      'outputPath': (visitor, target) => D4.validateTarget<$tom_build_23.ConvertedFile>(target, 'ConvertedFile').outputPath,
      'parsed': (visitor, target) => D4.validateTarget<$tom_build_23.ConvertedFile>(target, 'ConvertedFile').parsed,
    },
    constructorSignatures: {
      '': 'const ConvertedFile({required String sourcePath, required String outputPath, required ParsedMarkdown parsed})',
    },
    getterSignatures: {
      'sourcePath': 'String get sourcePath',
      'outputPath': 'String get outputPath',
      'parsed': 'ParsedMarkdown get parsed',
    },
  );
}

// =============================================================================
// ConversionError Bridge
// =============================================================================

BridgedClass _createConversionErrorBridge() {
  return BridgedClass(
    nativeType: $tom_build_23.ConversionError,
    name: 'ConversionError',
    constructors: {
      '': (visitor, positional, named) {
        final sourcePath = D4.getRequiredNamedArg<String>(named, 'sourcePath', 'ConversionError');
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'ConversionError');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return $tom_build_23.ConversionError(sourcePath: sourcePath, message: message, stackTrace: stackTrace);
      },
    },
    getters: {
      'sourcePath': (visitor, target) => D4.validateTarget<$tom_build_23.ConversionError>(target, 'ConversionError').sourcePath,
      'message': (visitor, target) => D4.validateTarget<$tom_build_23.ConversionError>(target, 'ConversionError').message,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_build_23.ConversionError>(target, 'ConversionError').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_23.ConversionError>(target, 'ConversionError');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ConversionError({required String sourcePath, required String message, StackTrace? stackTrace})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'sourcePath': 'String get sourcePath',
      'message': 'String get message',
      'stackTrace': 'StackTrace? get stackTrace',
    },
  );
}

// =============================================================================
// MdPdfConverter Bridge
// =============================================================================

BridgedClass _createMdPdfConverterBridge() {
  return BridgedClass(
    nativeType: $tom_build_24.MdPdfConverter,
    name: 'MdPdfConverter',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MdPdfConverter');
        final sourcePath = D4.getRequiredArg<String>(positional, 0, 'sourcePath', 'MdPdfConverter');
        final options = D4.getOptionalNamedArg<$tom_build_24.MdPdfConverterOptions?>(named, 'options');
        return $tom_build_24.MdPdfConverter(sourcePath, options: options);
      },
    },
    getters: {
      'sourcePath': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverter>(target, 'MdPdfConverter').sourcePath,
      'options': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverter>(target, 'MdPdfConverter').options,
    },
    methods: {
      'findMarkdownFiles': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_24.MdPdfConverter>(target, 'MdPdfConverter');
        return t.findMarkdownFiles();
      },
      'convertAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_24.MdPdfConverter>(target, 'MdPdfConverter');
        final outputDir = D4.getOptionalNamedArg<String?>(named, 'outputDir');
        return t.convertAll(outputDir: outputDir);
      },
      'convertFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_24.MdPdfConverter>(target, 'MdPdfConverter');
        D4.requireMinArgs(positional, 1, 'convertFile');
        final file = D4.getRequiredArg<File>(positional, 0, 'file', 'convertFile');
        final outputDir = D4.getOptionalNamedArg<String?>(named, 'outputDir');
        return t.convertFile(file, outputDir: outputDir);
      },
      'convertString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_24.MdPdfConverter>(target, 'MdPdfConverter');
        D4.requireMinArgs(positional, 1, 'convertString');
        final markdown = D4.getRequiredArg<String>(positional, 0, 'markdown', 'convertString');
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        return t.convertString(markdown, title: title);
      },
    },
    constructorSignatures: {
      '': 'MdPdfConverter(String sourcePath, {MdPdfConverterOptions? options})',
    },
    methodSignatures: {
      'findMarkdownFiles': 'Future<List<File>> findMarkdownFiles()',
      'convertAll': 'Future<MdPdfConverterResult> convertAll({String? outputDir})',
      'convertFile': 'Future<PdfConvertedFile> convertFile(File file, {String? outputDir})',
      'convertString': 'Future<List<int>> convertString(String markdown, {String? title})',
    },
    getterSignatures: {
      'sourcePath': 'String get sourcePath',
      'options': 'MdPdfConverterOptions get options',
    },
  );
}

// =============================================================================
// MdPdfConverterOptions Bridge
// =============================================================================

BridgedClass _createMdPdfConverterOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_build_24.MdPdfConverterOptions,
    name: 'MdPdfConverterOptions',
    constructors: {
      '': (visitor, positional, named) {
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final author = D4.getOptionalNamedArg<String?>(named, 'author');
        final pageFormat = D4.getNamedArgWithDefault<$pdf_1.PdfPageFormat>(named, 'pageFormat', $pdf_1.PdfPageFormat.a4);
        final fontSize = D4.getNamedArgWithDefault<double>(named, 'fontSize', 12.0);
        final fontFamily = D4.getNamedArgWithDefault<String>(named, 'fontFamily', 'Roboto');
        final excludePatterns = named.containsKey('excludePatterns') && named['excludePatterns'] != null
            ? D4.coerceList<String>(named['excludePatterns'], 'excludePatterns')
            : const ['node_modules', '.git', 'build'];
        final headerBuilderRaw = named['headerBuilder'];
        final footerBuilderRaw = named['footerBuilder'];
        if (!named.containsKey('margin') && !named.containsKey('tagStyle')) {
          return $tom_build_24.MdPdfConverterOptions(title: title, author: author, pageFormat: pageFormat, fontSize: fontSize, fontFamily: fontFamily, excludePatterns: excludePatterns, headerBuilder: headerBuilderRaw == null ? null : ($pdf_3.Context p0) { return D4.callInterpreterCallback(visitor, headerBuilderRaw, [p0]) as $pdf_3.Widget; }, footerBuilder: footerBuilderRaw == null ? null : ($pdf_3.Context p0) { return D4.callInterpreterCallback(visitor, footerBuilderRaw, [p0]) as $pdf_3.Widget; });
        }
        if (named.containsKey('margin') && !named.containsKey('tagStyle')) {
          final margin = D4.getRequiredNamedArg<$pdf_2.EdgeInsets>(named, 'margin', 'MdPdfConverterOptions');
          return $tom_build_24.MdPdfConverterOptions(title: title, author: author, pageFormat: pageFormat, fontSize: fontSize, fontFamily: fontFamily, excludePatterns: excludePatterns, headerBuilder: headerBuilderRaw == null ? null : ($pdf_3.Context p0) { return D4.callInterpreterCallback(visitor, headerBuilderRaw, [p0]) as $pdf_3.Widget; }, footerBuilder: footerBuilderRaw == null ? null : ($pdf_3.Context p0) { return D4.callInterpreterCallback(visitor, footerBuilderRaw, [p0]) as $pdf_3.Widget; }, margin: margin);
        }
        if (!named.containsKey('margin') && named.containsKey('tagStyle')) {
          final tagStyle = D4.getRequiredNamedArg<$htmltopdfwidgets_1.HtmlTagStyle>(named, 'tagStyle', 'MdPdfConverterOptions');
          return $tom_build_24.MdPdfConverterOptions(title: title, author: author, pageFormat: pageFormat, fontSize: fontSize, fontFamily: fontFamily, excludePatterns: excludePatterns, headerBuilder: headerBuilderRaw == null ? null : ($pdf_3.Context p0) { return D4.callInterpreterCallback(visitor, headerBuilderRaw, [p0]) as $pdf_3.Widget; }, footerBuilder: footerBuilderRaw == null ? null : ($pdf_3.Context p0) { return D4.callInterpreterCallback(visitor, footerBuilderRaw, [p0]) as $pdf_3.Widget; }, tagStyle: tagStyle);
        }
        if (named.containsKey('margin') && named.containsKey('tagStyle')) {
          final margin = D4.getRequiredNamedArg<$pdf_2.EdgeInsets>(named, 'margin', 'MdPdfConverterOptions');
          final tagStyle = D4.getRequiredNamedArg<$htmltopdfwidgets_1.HtmlTagStyle>(named, 'tagStyle', 'MdPdfConverterOptions');
          return $tom_build_24.MdPdfConverterOptions(title: title, author: author, pageFormat: pageFormat, fontSize: fontSize, fontFamily: fontFamily, excludePatterns: excludePatterns, headerBuilder: headerBuilderRaw == null ? null : ($pdf_3.Context p0) { return D4.callInterpreterCallback(visitor, headerBuilderRaw, [p0]) as $pdf_3.Widget; }, footerBuilder: footerBuilderRaw == null ? null : ($pdf_3.Context p0) { return D4.callInterpreterCallback(visitor, footerBuilderRaw, [p0]) as $pdf_3.Widget; }, margin: margin, tagStyle: tagStyle);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').title,
      'author': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').author,
      'pageFormat': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').pageFormat,
      'margin': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').margin,
      'fontSize': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').fontSize,
      'fontFamily': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').fontFamily,
      'tagStyle': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').tagStyle,
      'excludePatterns': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').excludePatterns,
      'headerBuilder': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').headerBuilder,
      'footerBuilder': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterOptions>(target, 'MdPdfConverterOptions').footerBuilder,
    },
    constructorSignatures: {
      '': 'MdPdfConverterOptions({String? title, String? author, PdfPageFormat pageFormat = PdfPageFormat.a4, EdgeInsets margin = const pw.EdgeInsets.all(72), double fontSize = 12.0, String fontFamily = \'Roboto\', HtmlTagStyle tagStyle = const HtmlTagStyle(), List<String> excludePatterns = const [\'node_modules\', \'.git\', \'build\'], Widget Function(Context)? headerBuilder, Widget Function(Context)? footerBuilder})',
    },
    getterSignatures: {
      'title': 'String? get title',
      'author': 'String? get author',
      'pageFormat': 'PdfPageFormat get pageFormat',
      'margin': 'pw.EdgeInsets get margin',
      'fontSize': 'double get fontSize',
      'fontFamily': 'String get fontFamily',
      'tagStyle': 'HtmlTagStyle get tagStyle',
      'excludePatterns': 'List<String> get excludePatterns',
      'headerBuilder': 'pw.Widget Function(pw.Context)? get headerBuilder',
      'footerBuilder': 'pw.Widget Function(pw.Context)? get footerBuilder',
    },
  );
}

// =============================================================================
// MdPdfConverterResult Bridge
// =============================================================================

BridgedClass _createMdPdfConverterResultBridge() {
  return BridgedClass(
    nativeType: $tom_build_24.MdPdfConverterResult,
    name: 'MdPdfConverterResult',
    constructors: {
      '': (visitor, positional, named) {
        return $tom_build_24.MdPdfConverterResult();
      },
    },
    getters: {
      'converted': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterResult>(target, 'MdPdfConverterResult').converted,
      'errors': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterResult>(target, 'MdPdfConverterResult').errors,
      'isSuccess': (visitor, target) => D4.validateTarget<$tom_build_24.MdPdfConverterResult>(target, 'MdPdfConverterResult').isSuccess,
    },
    constructorSignatures: {
      '': 'MdPdfConverterResult()',
    },
    getterSignatures: {
      'converted': 'List<PdfConvertedFile> get converted',
      'errors': 'List<PdfConversionError> get errors',
      'isSuccess': 'bool get isSuccess',
    },
  );
}

// =============================================================================
// PdfConvertedFile Bridge
// =============================================================================

BridgedClass _createPdfConvertedFileBridge() {
  return BridgedClass(
    nativeType: $tom_build_24.PdfConvertedFile,
    name: 'PdfConvertedFile',
    constructors: {
      '': (visitor, positional, named) {
        final sourcePath = D4.getRequiredNamedArg<String>(named, 'sourcePath', 'PdfConvertedFile');
        final outputPath = D4.getRequiredNamedArg<String>(named, 'outputPath', 'PdfConvertedFile');
        return $tom_build_24.PdfConvertedFile(sourcePath: sourcePath, outputPath: outputPath);
      },
    },
    getters: {
      'sourcePath': (visitor, target) => D4.validateTarget<$tom_build_24.PdfConvertedFile>(target, 'PdfConvertedFile').sourcePath,
      'outputPath': (visitor, target) => D4.validateTarget<$tom_build_24.PdfConvertedFile>(target, 'PdfConvertedFile').outputPath,
    },
    constructorSignatures: {
      '': 'PdfConvertedFile({required String sourcePath, required String outputPath})',
    },
    getterSignatures: {
      'sourcePath': 'String get sourcePath',
      'outputPath': 'String get outputPath',
    },
  );
}

// =============================================================================
// PdfConversionError Bridge
// =============================================================================

BridgedClass _createPdfConversionErrorBridge() {
  return BridgedClass(
    nativeType: $tom_build_24.PdfConversionError,
    name: 'PdfConversionError',
    constructors: {
      '': (visitor, positional, named) {
        final sourcePath = D4.getRequiredNamedArg<String>(named, 'sourcePath', 'PdfConversionError');
        final message = D4.getRequiredNamedArg<String>(named, 'message', 'PdfConversionError');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return $tom_build_24.PdfConversionError(sourcePath: sourcePath, message: message, stackTrace: stackTrace);
      },
    },
    getters: {
      'sourcePath': (visitor, target) => D4.validateTarget<$tom_build_24.PdfConversionError>(target, 'PdfConversionError').sourcePath,
      'message': (visitor, target) => D4.validateTarget<$tom_build_24.PdfConversionError>(target, 'PdfConversionError').message,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_build_24.PdfConversionError>(target, 'PdfConversionError').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_24.PdfConversionError>(target, 'PdfConversionError');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'PdfConversionError({required String sourcePath, required String message, StackTrace? stackTrace})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'sourcePath': 'String get sourcePath',
      'message': 'String get message',
      'stackTrace': 'StackTrace? get stackTrace',
    },
  );
}

// =============================================================================
// PageMargins Bridge
// =============================================================================

BridgedClass _createPageMarginsBridge() {
  return BridgedClass(
    nativeType: $tom_build_25.PageMargins,
    name: 'PageMargins',
    constructors: {
      '': (visitor, positional, named) {
        final top = D4.getNamedArgWithDefault<double>(named, 'top', 72.0);
        final right = D4.getNamedArgWithDefault<double>(named, 'right', 72.0);
        final bottom = D4.getNamedArgWithDefault<double>(named, 'bottom', 72.0);
        final left = D4.getNamedArgWithDefault<double>(named, 'left', 72.0);
        return $tom_build_25.PageMargins(top: top, right: right, bottom: bottom, left: left);
      },
      'all': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PageMargins');
        final value = D4.getRequiredArg<double>(positional, 0, 'value', 'PageMargins');
        return $tom_build_25.PageMargins.all(value);
      },
      'symmetric': (visitor, positional, named) {
        final horizontal = D4.getNamedArgWithDefault<double>(named, 'horizontal', 72.0);
        final vertical = D4.getNamedArgWithDefault<double>(named, 'vertical', 72.0);
        return $tom_build_25.PageMargins.symmetric(horizontal: horizontal, vertical: vertical);
      },
    },
    getters: {
      'top': (visitor, target) => D4.validateTarget<$tom_build_25.PageMargins>(target, 'PageMargins').top,
      'right': (visitor, target) => D4.validateTarget<$tom_build_25.PageMargins>(target, 'PageMargins').right,
      'bottom': (visitor, target) => D4.validateTarget<$tom_build_25.PageMargins>(target, 'PageMargins').bottom,
      'left': (visitor, target) => D4.validateTarget<$tom_build_25.PageMargins>(target, 'PageMargins').left,
    },
    methods: {
      'toEdgeInsets': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_25.PageMargins>(target, 'PageMargins');
        return t.toEdgeInsets();
      },
    },
    constructorSignatures: {
      '': 'const PageMargins({double top = 72.0, double right = 72.0, double bottom = 72.0, double left = 72.0})',
      'all': 'const PageMargins.all(double value)',
      'symmetric': 'const PageMargins.symmetric({double horizontal = 72.0, double vertical = 72.0})',
    },
    methodSignatures: {
      'toEdgeInsets': 'pw.EdgeInsets toEdgeInsets()',
    },
    getterSignatures: {
      'top': 'double get top',
      'right': 'double get right',
      'bottom': 'double get bottom',
      'left': 'double get left',
    },
  );
}

// =============================================================================
// PdfConverterOptionsWrapper Bridge
// =============================================================================

BridgedClass _createPdfConverterOptionsWrapperBridge() {
  return BridgedClass(
    nativeType: $tom_build_25.PdfConverterOptionsWrapper,
    name: 'PdfConverterOptionsWrapper',
    constructors: {
      '': (visitor, positional, named) {
        final title = D4.getOptionalNamedArg<String?>(named, 'title');
        final author = D4.getOptionalNamedArg<String?>(named, 'author');
        final pageFormat = D4.getNamedArgWithDefault<String>(named, 'pageFormat', 'a4');
        final fontSize = D4.getNamedArgWithDefault<double>(named, 'fontSize', 12.0);
        final fontFamily = D4.getNamedArgWithDefault<String>(named, 'fontFamily', 'Roboto');
        final excludePatterns = named.containsKey('excludePatterns') && named['excludePatterns'] != null
            ? D4.coerceList<String>(named['excludePatterns'], 'excludePatterns')
            : const ['node_modules', '.git', 'build'];
        if (!named.containsKey('margins')) {
          return $tom_build_25.PdfConverterOptionsWrapper(title: title, author: author, pageFormat: pageFormat, fontSize: fontSize, fontFamily: fontFamily, excludePatterns: excludePatterns);
        }
        if (named.containsKey('margins')) {
          final margins = D4.getRequiredNamedArg<$tom_build_25.PageMargins>(named, 'margins', 'PdfConverterOptionsWrapper');
          return $tom_build_25.PdfConverterOptionsWrapper(title: title, author: author, pageFormat: pageFormat, fontSize: fontSize, fontFamily: fontFamily, excludePatterns: excludePatterns, margins: margins);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'title': (visitor, target) => D4.validateTarget<$tom_build_25.PdfConverterOptionsWrapper>(target, 'PdfConverterOptionsWrapper').title,
      'author': (visitor, target) => D4.validateTarget<$tom_build_25.PdfConverterOptionsWrapper>(target, 'PdfConverterOptionsWrapper').author,
      'pageFormat': (visitor, target) => D4.validateTarget<$tom_build_25.PdfConverterOptionsWrapper>(target, 'PdfConverterOptionsWrapper').pageFormat,
      'margins': (visitor, target) => D4.validateTarget<$tom_build_25.PdfConverterOptionsWrapper>(target, 'PdfConverterOptionsWrapper').margins,
      'fontSize': (visitor, target) => D4.validateTarget<$tom_build_25.PdfConverterOptionsWrapper>(target, 'PdfConverterOptionsWrapper').fontSize,
      'fontFamily': (visitor, target) => D4.validateTarget<$tom_build_25.PdfConverterOptionsWrapper>(target, 'PdfConverterOptionsWrapper').fontFamily,
      'excludePatterns': (visitor, target) => D4.validateTarget<$tom_build_25.PdfConverterOptionsWrapper>(target, 'PdfConverterOptionsWrapper').excludePatterns,
    },
    methods: {
      'toOptions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_25.PdfConverterOptionsWrapper>(target, 'PdfConverterOptionsWrapper');
        return t.toOptions();
      },
    },
    constructorSignatures: {
      '': 'PdfConverterOptionsWrapper({String? title, String? author, String pageFormat = \'a4\', PageMargins margins = const PageMargins.all(72), double fontSize = 12.0, String fontFamily = \'Roboto\', List<String> excludePatterns = const [\'node_modules\', \'.git\', \'build\']})',
    },
    methodSignatures: {
      'toOptions': 'MdPdfConverterOptions toOptions()',
    },
    getterSignatures: {
      'title': 'String? get title',
      'author': 'String? get author',
      'pageFormat': 'String get pageFormat',
      'margins': 'PageMargins get margins',
      'fontSize': 'double get fontSize',
      'fontFamily': 'String get fontFamily',
      'excludePatterns': 'List<String> get excludePatterns',
    },
  );
}

// =============================================================================
// ReflectionGeneratorRunner Bridge
// =============================================================================

BridgedClass _createReflectionGeneratorRunnerBridge() {
  return BridgedClass(
    nativeType: $tom_build_26.ReflectionGeneratorRunner,
    name: 'ReflectionGeneratorRunner',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReflectionGeneratorRunner');
        final projectPath = D4.getRequiredArg<String>(positional, 0, 'projectPath', 'ReflectionGeneratorRunner');
        final options = D4.getOptionalNamedArg<$tom_build_26.ReflectionGeneratorRunnerOptions?>(named, 'options');
        final workspacePath = D4.getOptionalNamedArg<String?>(named, 'workspacePath');
        return $tom_build_26.ReflectionGeneratorRunner(projectPath, options: options, workspacePath: workspacePath);
      },
    },
    getters: {
      'projectPath': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunner>(target, 'ReflectionGeneratorRunner').projectPath,
      'options': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunner>(target, 'ReflectionGeneratorRunner').options,
      'workspacePath': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunner>(target, 'ReflectionGeneratorRunner').workspacePath,
    },
    methods: {
      'generate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_26.ReflectionGeneratorRunner>(target, 'ReflectionGeneratorRunner');
        final target_ = D4.getNamedArgWithDefault<String>(named, 'target', 'lib/');
        final all = D4.getNamedArgWithDefault<bool>(named, 'all', false);
        return t.generate(target: target_, all: all);
      },
      'build': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_26.ReflectionGeneratorRunner>(target, 'ReflectionGeneratorRunner');
        final configFile = D4.getOptionalNamedArg<String?>(named, 'configFile');
        return t.build(configFile: configFile);
      },
    },
    constructorSignatures: {
      '': 'ReflectionGeneratorRunner(String projectPath, {ReflectionGeneratorRunnerOptions? options, String? workspacePath})',
    },
    methodSignatures: {
      'generate': 'Future<ReflectionGeneratorRunnerResult> generate({String target = \'lib/\', bool all = false})',
      'build': 'Future<ReflectionGeneratorRunnerResult> build({String? configFile})',
    },
    getterSignatures: {
      'projectPath': 'String get projectPath',
      'options': 'ReflectionGeneratorRunnerOptions get options',
      'workspacePath': 'String? get workspacePath',
    },
  );
}

// =============================================================================
// ReflectionGeneratorRunnerOptions Bridge
// =============================================================================

BridgedClass _createReflectionGeneratorRunnerOptionsBridge() {
  return BridgedClass(
    nativeType: $tom_build_26.ReflectionGeneratorRunnerOptions,
    name: 'ReflectionGeneratorRunnerOptions',
    constructors: {
      '': (visitor, positional, named) {
        final verbose = D4.getNamedArgWithDefault<bool>(named, 'verbose', false);
        final packageName = D4.getOptionalNamedArg<String?>(named, 'packageName');
        final extension = D4.getOptionalNamedArg<String?>(named, 'extension');
        return $tom_build_26.ReflectionGeneratorRunnerOptions(verbose: verbose, packageName: packageName, extension: extension);
      },
    },
    getters: {
      'verbose': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerOptions>(target, 'ReflectionGeneratorRunnerOptions').verbose,
      'packageName': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerOptions>(target, 'ReflectionGeneratorRunnerOptions').packageName,
      'extension': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerOptions>(target, 'ReflectionGeneratorRunnerOptions').extension,
    },
    constructorSignatures: {
      '': 'const ReflectionGeneratorRunnerOptions({bool verbose = false, String? packageName, String? extension})',
    },
    getterSignatures: {
      'verbose': 'bool get verbose',
      'packageName': 'String? get packageName',
      'extension': 'String? get extension',
    },
  );
}

// =============================================================================
// ReflectionGeneratorRunnerResult Bridge
// =============================================================================

BridgedClass _createReflectionGeneratorRunnerResultBridge() {
  return BridgedClass(
    nativeType: $tom_build_26.ReflectionGeneratorRunnerResult,
    name: 'ReflectionGeneratorRunnerResult',
    constructors: {
      '': (visitor, positional, named) {
        final success = D4.getRequiredNamedArg<bool>(named, 'success', 'ReflectionGeneratorRunnerResult');
        final projectPath = D4.getRequiredNamedArg<String>(named, 'projectPath', 'ReflectionGeneratorRunnerResult');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return $tom_build_26.ReflectionGeneratorRunnerResult(success: success, projectPath: projectPath, message: message, error: error, stackTrace: stackTrace);
      },
    },
    getters: {
      'success': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerResult>(target, 'ReflectionGeneratorRunnerResult').success,
      'projectPath': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerResult>(target, 'ReflectionGeneratorRunnerResult').projectPath,
      'message': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerResult>(target, 'ReflectionGeneratorRunnerResult').message,
      'error': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerResult>(target, 'ReflectionGeneratorRunnerResult').error,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerResult>(target, 'ReflectionGeneratorRunnerResult').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_26.ReflectionGeneratorRunnerResult>(target, 'ReflectionGeneratorRunnerResult');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ReflectionGeneratorRunnerResult({required bool success, required String projectPath, String? message, String? error, StackTrace? stackTrace})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'success': 'bool get success',
      'projectPath': 'String get projectPath',
      'message': 'String? get message',
      'error': 'String? get error',
      'stackTrace': 'StackTrace? get stackTrace',
    },
  );
}

// =============================================================================
// TomEnv Bridge
// =============================================================================

BridgedClass _createTomEnvBridge() {
  return BridgedClass(
    nativeType: $tom_build_27.TomEnv,
    name: 'TomEnv',
    constructors: {
    },
    staticGetters: {
      'home': (visitor) => $tom_build_27.TomEnv.home,
      'path': (visitor) => $tom_build_27.TomEnv.path,
      'shell': (visitor) => $tom_build_27.TomEnv.shell,
      'user': (visitor) => $tom_build_27.TomEnv.user,
      'temp': (visitor) => $tom_build_27.TomEnv.temp,
      'cwd': (visitor) => $tom_build_27.TomEnv.cwd,
      'isCI': (visitor) => $tom_build_27.TomEnv.isCI,
      'isDev': (visitor) => $tom_build_27.TomEnv.isDev,
      'isProd': (visitor) => $tom_build_27.TomEnv.isProd,
      'os': (visitor) => $tom_build_27.TomEnv.os,
      'osVersion': (visitor) => $tom_build_27.TomEnv.osVersion,
      'processors': (visitor) => $tom_build_27.TomEnv.processors,
      'dartVersion': (visitor) => $tom_build_27.TomEnv.dartVersion,
      'hostname': (visitor) => $tom_build_27.TomEnv.hostname,
      'isMacOS': (visitor) => $tom_build_27.TomEnv.isMacOS,
      'isLinux': (visitor) => $tom_build_27.TomEnv.isLinux,
      'isWindows': (visitor) => $tom_build_27.TomEnv.isWindows,
    },
    staticMethods: {
      'load': (visitor, positional, named, typeArgs) {
        final directory = D4.getOptionalArg<String?>(positional, 0, 'directory');
        return $tom_build_27.TomEnv.load(directory);
      },
      'reload': (visitor, positional, named, typeArgs) {
        final directory = D4.getOptionalArg<String?>(positional, 0, 'directory');
        return $tom_build_27.TomEnv.reload(directory);
      },
      'loadFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadFile');
        return $tom_build_27.TomEnv.loadFile(path);
      },
      'resolve': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'resolve');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'resolve');
        final workingDir = D4.getOptionalNamedArg<String?>(named, 'workingDir');
        return $tom_build_27.TomEnv.resolve(text, workingDir: workingDir);
      },
      'resolveWith': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'resolveWith');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'resolveWith');
        if (positional.length <= 1) {
          throw ArgumentError('resolveWith: Missing required argument "environment" at position 1');
        }
        final environment = D4.coerceMap<String, String>(positional[1], 'environment');
        return $tom_build_27.TomEnv.resolveWith(text, environment);
      },
      'resolveMap': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'resolveMap');
        if (positional.isEmpty) {
          throw ArgumentError('resolveMap: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        final workingDir = D4.getOptionalNamedArg<String?>(named, 'workingDir');
        return $tom_build_27.TomEnv.resolveMap(map, workingDir: workingDir);
      },
      'resolveMapWith': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'resolveMapWith');
        if (positional.isEmpty) {
          throw ArgumentError('resolveMapWith: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        if (positional.length <= 1) {
          throw ArgumentError('resolveMapWith: Missing required argument "environment" at position 1');
        }
        final environment = D4.coerceMap<String, String>(positional[1], 'environment');
        return $tom_build_27.TomEnv.resolveMapWith(map, environment);
      },
      'get': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'get');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'get');
        final defaultValue = D4.getOptionalArg<String?>(positional, 1, 'defaultValue');
        return $tom_build_27.TomEnv.get(name, defaultValue);
      },
      'require': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'require');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'require');
        final message = D4.getOptionalNamedArg<String?>(named, 'message');
        return $tom_build_27.TomEnv.require(name, message: message);
      },
      'has': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'has');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'has');
        return $tom_build_27.TomEnv.has(name);
      },
      'isSet': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isSet');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'isSet');
        return $tom_build_27.TomEnv.isSet(name);
      },
      'all': (visitor, positional, named, typeArgs) {
        return $tom_build_27.TomEnv.all();
      },
      'withPrefix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withPrefix');
        final prefix = D4.getRequiredArg<String>(positional, 0, 'prefix', 'withPrefix');
        final strip = D4.getNamedArgWithDefault<bool>(named, 'strip', false);
        return $tom_build_27.TomEnv.withPrefix(prefix, strip: strip);
      },
      'getInt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getInt');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getInt');
        final defaultValue = D4.getOptionalArg<int?>(positional, 1, 'defaultValue');
        return $tom_build_27.TomEnv.getInt(name, defaultValue);
      },
      'getBool': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getBool');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getBool');
        final defaultValue = D4.getOptionalArgWithDefault<bool>(positional, 1, 'defaultValue', false);
        return $tom_build_27.TomEnv.getBool(name, defaultValue);
      },
      'getList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getList');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getList');
        final separator = D4.getOptionalNamedArg<String?>(named, 'separator');
        return $tom_build_27.TomEnv.getList(name, separator: separator);
      },
      'expand': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'expand');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'expand');
        return $tom_build_27.TomEnv.expand(text);
      },
      'expandWithDefaults': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'expandWithDefaults');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'expandWithDefaults');
        return $tom_build_27.TomEnv.expandWithDefaults(text);
      },
    },
    staticMethodSignatures: {
      'load': 'Map<String, String> load([String? directory])',
      'reload': 'Map<String, String> reload([String? directory])',
      'loadFile': 'Map<String, String> loadFile(String path)',
      'resolve': 'String resolve(String text, {String? workingDir})',
      'resolveWith': 'String resolveWith(String text, Map<String, String> environment)',
      'resolveMap': 'Map<String, dynamic> resolveMap(Map<String, dynamic> map, {String? workingDir})',
      'resolveMapWith': 'Map<String, dynamic> resolveMapWith(Map<String, dynamic> map, Map<String, String> environment)',
      'get': 'String? get(String name, [String? defaultValue])',
      'require': 'String require(String name, {String? message})',
      'has': 'bool has(String name)',
      'isSet': 'bool isSet(String name)',
      'all': 'Map<String, String> all()',
      'withPrefix': 'Map<String, String> withPrefix(String prefix, {bool strip = false})',
      'getInt': 'int? getInt(String name, [int? defaultValue])',
      'getBool': 'bool getBool(String name, [bool defaultValue = false])',
      'getList': 'List<String> getList(String name, {String? separator})',
      'expand': 'String expand(String text)',
      'expandWithDefaults': 'String expandWithDefaults(String text)',
    },
    staticGetterSignatures: {
      'home': 'String? get home',
      'path': 'List<String> get path',
      'shell': 'String? get shell',
      'user': 'String? get user',
      'temp': 'String? get temp',
      'cwd': 'String get cwd',
      'isCI': 'bool get isCI',
      'isDev': 'bool get isDev',
      'isProd': 'bool get isProd',
      'os': 'String get os',
      'osVersion': 'String get osVersion',
      'processors': 'int get processors',
      'dartVersion': 'String get dartVersion',
      'hostname': 'String get hostname',
      'isMacOS': 'bool get isMacOS',
      'isLinux': 'bool get isLinux',
      'isWindows': 'bool get isWindows',
    },
  );
}

// =============================================================================
// TomEnvironmentException Bridge
// =============================================================================

BridgedClass _createTomEnvironmentExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_build_27.TomEnvironmentException,
    name: 'TomEnvironmentException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomEnvironmentException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'TomEnvironmentException');
        return $tom_build_27.TomEnvironmentException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$tom_build_27.TomEnvironmentException>(target, 'TomEnvironmentException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_27.TomEnvironmentException>(target, 'TomEnvironmentException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const TomEnvironmentException(String message)',
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
// TomFs Bridge
// =============================================================================

BridgedClass _createTomFsBridge() {
  return BridgedClass(
    nativeType: $tom_build_28.TomFs,
    name: 'TomFs',
    constructors: {
    },
    staticMethods: {
      'read': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'read');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'read');
        return $tom_build_28.TomFs.read(path);
      },
      'readBytes': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'readBytes');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'readBytes');
        return $tom_build_28.TomFs.readBytes(path);
      },
      'readLines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'readLines');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'readLines');
        return $tom_build_28.TomFs.readLines(path);
      },
      'tryRead': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'tryRead');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'tryRead');
        return $tom_build_28.TomFs.tryRead(path);
      },
      'write': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'write');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'write');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'write');
        return $tom_build_28.TomFs.write(path, content);
      },
      'writeBytes': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'writeBytes');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'writeBytes');
        if (positional.length <= 1) {
          throw ArgumentError('writeBytes: Missing required argument "bytes" at position 1');
        }
        final bytes = D4.coerceList<int>(positional[1], 'bytes');
        return $tom_build_28.TomFs.writeBytes(path, bytes);
      },
      'append': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'append');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'append');
        final content = D4.getRequiredArg<String>(positional, 1, 'content', 'append');
        return $tom_build_28.TomFs.append(path, content);
      },
      'appendLine': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'appendLine');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'appendLine');
        final line = D4.getRequiredArg<String>(positional, 1, 'line', 'appendLine');
        return $tom_build_28.TomFs.appendLine(path, line);
      },
      'exists': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'exists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'exists');
        return $tom_build_28.TomFs.exists(path);
      },
      'isFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isFile');
        return $tom_build_28.TomFs.isFile(path);
      },
      'isDir': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isDir');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isDir');
        return $tom_build_28.TomFs.isDir(path);
      },
      'isEmpty': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isEmpty');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isEmpty');
        return $tom_build_28.TomFs.isEmpty(path);
      },
      'copy': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'copy');
        final from = D4.getRequiredArg<String>(positional, 0, 'from', 'copy');
        final to = D4.getRequiredArg<String>(positional, 1, 'to', 'copy');
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', true);
        return $tom_build_28.TomFs.copy(from, to, overwrite: overwrite);
      },
      'move': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'move');
        final from = D4.getRequiredArg<String>(positional, 0, 'from', 'move');
        final to = D4.getRequiredArg<String>(positional, 1, 'to', 'move');
        return $tom_build_28.TomFs.move(from, to);
      },
      'delete': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'delete');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'delete');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', false);
        return $tom_build_28.TomFs.delete(path, recursive: recursive);
      },
      'deleteIfExists': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'deleteIfExists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'deleteIfExists');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', false);
        return $tom_build_28.TomFs.deleteIfExists(path, recursive: recursive);
      },
      'mkdir': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'mkdir');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'mkdir');
        return $tom_build_28.TomFs.mkdir(path);
      },
      'ls': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'ls');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'ls');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', false);
        final filesOnly = D4.getNamedArgWithDefault<bool>(named, 'filesOnly', false);
        final dirsOnly = D4.getNamedArgWithDefault<bool>(named, 'dirsOnly', false);
        return $tom_build_28.TomFs.ls(path, recursive: recursive, filesOnly: filesOnly, dirsOnly: dirsOnly);
      },
      'files': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'files');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'files');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', false);
        return $tom_build_28.TomFs.files(path, recursive: recursive);
      },
      'dirs': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dirs');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'dirs');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', false);
        return $tom_build_28.TomFs.dirs(path, recursive: recursive);
      },
      'size': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'size');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'size');
        return $tom_build_28.TomFs.size(path);
      },
      'mtime': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'mtime');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'mtime');
        return $tom_build_28.TomFs.mtime(path);
      },
      'atime': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'atime');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'atime');
        return $tom_build_28.TomFs.atime(path);
      },
      'touch': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'touch');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'touch');
        final time = D4.getOptionalArg<DateTime?>(positional, 1, 'time');
        return $tom_build_28.TomFs.touch(path, time);
      },
      'temp': (visitor, positional, named, typeArgs) {
        final prefix = D4.getOptionalNamedArg<String?>(named, 'prefix');
        final suffix = D4.getOptionalNamedArg<String?>(named, 'suffix');
        final content = D4.getOptionalNamedArg<String?>(named, 'content');
        return $tom_build_28.TomFs.temp(prefix: prefix, suffix: suffix, content: content);
      },
      'tempDir': (visitor, positional, named, typeArgs) {
        final prefix = D4.getOptionalNamedArg<String?>(named, 'prefix');
        return $tom_build_28.TomFs.tempDir(prefix: prefix);
      },
    },
    staticMethodSignatures: {
      'read': 'String read(String path)',
      'readBytes': 'List<int> readBytes(String path)',
      'readLines': 'List<String> readLines(String path)',
      'tryRead': 'String? tryRead(String path)',
      'write': 'void write(String path, String content)',
      'writeBytes': 'void writeBytes(String path, List<int> bytes)',
      'append': 'void append(String path, String content)',
      'appendLine': 'void appendLine(String path, String line)',
      'exists': 'bool exists(String path)',
      'isFile': 'bool isFile(String path)',
      'isDir': 'bool isDir(String path)',
      'isEmpty': 'bool isEmpty(String path)',
      'copy': 'void copy(String from, String to, {bool overwrite = true})',
      'move': 'void move(String from, String to)',
      'delete': 'void delete(String path, {bool recursive = false})',
      'deleteIfExists': 'void deleteIfExists(String path, {bool recursive = false})',
      'mkdir': 'void mkdir(String path)',
      'ls': 'List<String> ls(String path, {bool recursive = false, bool filesOnly = false, bool dirsOnly = false})',
      'files': 'List<String> files(String path, {bool recursive = false})',
      'dirs': 'List<String> dirs(String path, {bool recursive = false})',
      'size': 'int size(String path)',
      'mtime': 'DateTime mtime(String path)',
      'atime': 'DateTime atime(String path)',
      'touch': 'void touch(String path, [DateTime? time])',
      'temp': 'String temp({String? prefix, String? suffix, String? content})',
      'tempDir': 'String tempDir({String? prefix})',
    },
  );
}

// =============================================================================
// TomGlob Bridge
// =============================================================================

BridgedClass _createTomGlobBridge() {
  return BridgedClass(
    nativeType: $tom_build_29.TomGlob,
    name: 'TomGlob',
    constructors: {
    },
    staticMethods: {
      'find': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'find');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'find');
        final root = D4.getOptionalNamedArg<String?>(named, 'root');
        final followLinks = D4.getNamedArgWithDefault<bool>(named, 'followLinks', true);
        return $tom_build_29.TomGlob.find(pattern, root: root, followLinks: followLinks);
      },
      'findAny': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findAny');
        if (positional.isEmpty) {
          throw ArgumentError('findAny: Missing required argument "patterns" at position 0');
        }
        final patterns = D4.coerceList<String>(positional[0], 'patterns');
        final root = D4.getOptionalNamedArg<String?>(named, 'root');
        final followLinks = D4.getNamedArgWithDefault<bool>(named, 'followLinks', true);
        return $tom_build_29.TomGlob.findAny(patterns, root: root, followLinks: followLinks);
      },
      'findFiles': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findFiles');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'findFiles');
        final root = D4.getOptionalNamedArg<String?>(named, 'root');
        return $tom_build_29.TomGlob.findFiles(pattern, root: root);
      },
      'findDirs': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findDirs');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'findDirs');
        final root = D4.getOptionalNamedArg<String?>(named, 'root');
        return $tom_build_29.TomGlob.findDirs(pattern, root: root);
      },
      'matches': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'matches');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'matches');
        final pattern = D4.getRequiredArg<String>(positional, 1, 'pattern', 'matches');
        return $tom_build_29.TomGlob.matches(path, pattern);
      },
      'matchesAny': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'matchesAny');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'matchesAny');
        if (positional.length <= 1) {
          throw ArgumentError('matchesAny: Missing required argument "patterns" at position 1');
        }
        final patterns = D4.coerceList<String>(positional[1], 'patterns');
        return $tom_build_29.TomGlob.matchesAny(path, patterns);
      },
      'filter': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'filter');
        if (positional.isEmpty) {
          throw ArgumentError('filter: Missing required argument "paths" at position 0');
        }
        final paths = D4.coerceList<String>(positional[0], 'paths');
        final pattern = D4.getRequiredArg<String>(positional, 1, 'pattern', 'filter');
        return $tom_build_29.TomGlob.filter(paths, pattern);
      },
      'exclude': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'exclude');
        if (positional.isEmpty) {
          throw ArgumentError('exclude: Missing required argument "paths" at position 0');
        }
        final paths = D4.coerceList<String>(positional[0], 'paths');
        final pattern = D4.getRequiredArg<String>(positional, 1, 'pattern', 'exclude');
        return $tom_build_29.TomGlob.exclude(paths, pattern);
      },
    },
    staticMethodSignatures: {
      'find': 'List<String> find(String pattern, {String? root, bool followLinks = true})',
      'findAny': 'List<String> findAny(List<String> patterns, {String? root, bool followLinks = true})',
      'findFiles': 'List<String> findFiles(String pattern, {String? root})',
      'findDirs': 'List<String> findDirs(String pattern, {String? root})',
      'matches': 'bool matches(String path, String pattern)',
      'matchesAny': 'bool matchesAny(String path, List<String> patterns)',
      'filter': 'List<String> filter(List<String> paths, String pattern)',
      'exclude': 'List<String> exclude(List<String> paths, String pattern)',
    },
  );
}

// =============================================================================
// TomMaps Bridge
// =============================================================================

BridgedClass _createTomMapsBridge() {
  return BridgedClass(
    nativeType: $tom_build_30.TomMaps,
    name: 'TomMaps',
    constructors: {
    },
    staticMethods: {
      'mergeOneSided': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mergeOneSided');
        if (positional.isEmpty) {
          throw ArgumentError('mergeOneSided: Missing required argument "target" at position 0');
        }
        final target_ = D4.coerceMap<String, dynamic>(positional[0], 'target');
        if (positional.length <= 1) {
          throw ArgumentError('mergeOneSided: Missing required argument "source" at position 1');
        }
        final source = D4.coerceMap<String, dynamic>(positional[1], 'source');
        return $tom_build_30.TomMaps.mergeOneSided(target_, source);
      },
      'merge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'merge');
        if (positional.isEmpty) {
          throw ArgumentError('merge: Missing required argument "base" at position 0');
        }
        final base = D4.coerceMap<String, dynamic>(positional[0], 'base');
        if (positional.length <= 1) {
          throw ArgumentError('merge: Missing required argument "overrides" at position 1');
        }
        final overrides = D4.coerceMap<String, dynamic>(positional[1], 'overrides');
        return $tom_build_30.TomMaps.merge(base, overrides);
      },
      'mergeAll': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'mergeAll');
        if (positional.isEmpty) {
          throw ArgumentError('mergeAll: Missing required argument "maps" at position 0');
        }
        final maps = D4.coerceList<Map<String, dynamic>>(positional[0], 'maps');
        return $tom_build_30.TomMaps.mergeAll(maps);
      },
      'traverse': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'traverse');
        if (positional.isEmpty) {
          throw ArgumentError('traverse: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        if (positional.length <= 1) {
          throw ArgumentError('traverse: Missing required argument "processor" at position 1');
        }
        final processorRaw = positional[1];
        final processor = (String p0, dynamic p1) { return D4.callInterpreterCallback(visitor, processorRaw, [p0, p1]) as dynamic; };
        final prefix = D4.getNamedArgWithDefault<String>(named, 'prefix', '');
        return $tom_build_30.TomMaps.traverse(map, processor, prefix: prefix);
      },
      'flatten': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'flatten');
        if (positional.isEmpty) {
          throw ArgumentError('flatten: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return $tom_build_30.TomMaps.flatten(map);
      },
      'unflatten': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'unflatten');
        if (positional.isEmpty) {
          throw ArgumentError('unflatten: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return $tom_build_30.TomMaps.unflatten(map);
      },
      'get': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'get');
        if (positional.isEmpty) {
          throw ArgumentError('get: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'get');
        return $tom_build_30.TomMaps.get(map, path);
      },
      'getOr': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'getOr');
        if (positional.isEmpty) {
          throw ArgumentError('getOr: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'getOr');
        final defaultValue = D4.getRequiredArg<dynamic>(positional, 2, 'defaultValue', 'getOr');
        return $tom_build_30.TomMaps.getOr(map, path, defaultValue);
      },
      'set': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'set');
        if (positional.isEmpty) {
          throw ArgumentError('set: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'set');
        final value = D4.getRequiredArg<dynamic>(positional, 2, 'value', 'set');
        return $tom_build_30.TomMaps.set(map, path, value);
      },
      'has': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'has');
        if (positional.isEmpty) {
          throw ArgumentError('has: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'has');
        return $tom_build_30.TomMaps.has(map, path);
      },
      'remove': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'remove');
        if (positional.isEmpty) {
          throw ArgumentError('remove: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'remove');
        return $tom_build_30.TomMaps.remove(map, path);
      },
      'copy': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'copy');
        if (positional.isEmpty) {
          throw ArgumentError('copy: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return $tom_build_30.TomMaps.copy(map);
      },
      'clean': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'clean');
        if (positional.isEmpty) {
          throw ArgumentError('clean: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<dynamic, dynamic>(positional[0], 'map');
        return $tom_build_30.TomMaps.clean(map);
      },
      'pick': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'pick');
        if (positional.isEmpty) {
          throw ArgumentError('pick: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        if (positional.length <= 1) {
          throw ArgumentError('pick: Missing required argument "keys" at position 1');
        }
        final keys = D4.coerceList<String>(positional[1], 'keys');
        return $tom_build_30.TomMaps.pick(map, keys);
      },
      'omit': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'omit');
        if (positional.isEmpty) {
          throw ArgumentError('omit: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        if (positional.length <= 1) {
          throw ArgumentError('omit: Missing required argument "keys" at position 1');
        }
        final keys = D4.coerceList<String>(positional[1], 'keys');
        return $tom_build_30.TomMaps.omit(map, keys);
      },
    },
    staticMethodSignatures: {
      'mergeOneSided': 'Map<String, dynamic> mergeOneSided(Map<String, dynamic> target, Map<String, dynamic> source)',
      'merge': 'Map<String, dynamic> merge(Map<String, dynamic> base, Map<String, dynamic> overrides)',
      'mergeAll': 'Map<String, dynamic> mergeAll(List<Map<String, dynamic>> maps)',
      'traverse': 'Map<String, dynamic> traverse(Map<String, dynamic> map, dynamic Function(String key, dynamic value) processor, {String prefix = \'\'})',
      'flatten': 'Map<String, dynamic> flatten(Map<String, dynamic> map)',
      'unflatten': 'Map<String, dynamic> unflatten(Map<String, dynamic> map)',
      'get': 'T? get(Map<String, dynamic> map, String path)',
      'getOr': 'T getOr(Map<String, dynamic> map, String path, T defaultValue)',
      'set': 'void set(Map<String, dynamic> map, String path, dynamic value)',
      'has': 'bool has(Map<String, dynamic> map, String path)',
      'remove': 'dynamic remove(Map<String, dynamic> map, String path)',
      'copy': 'Map<String, dynamic> copy(Map<String, dynamic> map)',
      'clean': 'Map<String, dynamic> clean(Map<dynamic, dynamic> map)',
      'pick': 'Map<String, dynamic> pick(Map<String, dynamic> map, List<String> keys)',
      'omit': 'Map<String, dynamic> omit(Map<String, dynamic> map, List<String> keys)',
    },
  );
}

// =============================================================================
// TomPth Bridge
// =============================================================================

BridgedClass _createTomPthBridge() {
  return BridgedClass(
    nativeType: $tom_build_31.TomPth,
    name: 'TomPth',
    constructors: {
    },
    staticGetters: {
      'cwd': (visitor) => $tom_build_31.TomPth.cwd,
      'home': (visitor) => $tom_build_31.TomPth.home,
      'temp': (visitor) => $tom_build_31.TomPth.temp,
      'separator': (visitor) => $tom_build_31.TomPth.separator,
    },
    staticMethods: {
      'join': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'join');
        final part1 = D4.getRequiredArg<String>(positional, 0, 'part1', 'join');
        final part2 = D4.getOptionalArg<String?>(positional, 1, 'part2');
        final part3 = D4.getOptionalArg<String?>(positional, 2, 'part3');
        final part4 = D4.getOptionalArg<String?>(positional, 3, 'part4');
        final part5 = D4.getOptionalArg<String?>(positional, 4, 'part5');
        final part6 = D4.getOptionalArg<String?>(positional, 5, 'part6');
        return $tom_build_31.TomPth.join(part1, part2, part3, part4, part5, part6);
      },
      'joinAll': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'joinAll');
        if (positional.isEmpty) {
          throw ArgumentError('joinAll: Missing required argument "parts" at position 0');
        }
        final parts = D4.coerceList<String>(positional[0], 'parts');
        return $tom_build_31.TomPth.joinAll(parts);
      },
      'dirname': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dirname');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'dirname');
        return $tom_build_31.TomPth.dirname(path);
      },
      'basename': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'basename');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'basename');
        return $tom_build_31.TomPth.basename(path);
      },
      'basenameNoExt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'basenameNoExt');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'basenameNoExt');
        return $tom_build_31.TomPth.basenameNoExt(path);
      },
      'extension': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'extension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'extension');
        return $tom_build_31.TomPth.extension(path);
      },
      'split': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'split');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'split');
        return $tom_build_31.TomPth.split(path);
      },
      'absolute': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'absolute');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'absolute');
        return $tom_build_31.TomPth.absolute(path);
      },
      'relative': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'relative');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'relative');
        final from = D4.getOptionalNamedArg<String?>(named, 'from');
        return $tom_build_31.TomPth.relative(path, from: from);
      },
      'normalize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'normalize');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'normalize');
        return $tom_build_31.TomPth.normalize(path);
      },
      'canonical': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'canonical');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'canonical');
        return $tom_build_31.TomPth.canonical(path);
      },
      'setExtension': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setExtension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'setExtension');
        final extension = D4.getRequiredArg<String>(positional, 1, 'extension', 'setExtension');
        return $tom_build_31.TomPth.setExtension(path, extension);
      },
      'withoutExtension': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withoutExtension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'withoutExtension');
        return $tom_build_31.TomPth.withoutExtension(path);
      },
      'isAbsolute': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isAbsolute');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isAbsolute');
        return $tom_build_31.TomPth.isAbsolute(path);
      },
      'isRelative': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isRelative');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isRelative');
        return $tom_build_31.TomPth.isRelative(path);
      },
      'isWithin': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'isWithin');
        final parent = D4.getRequiredArg<String>(positional, 0, 'parent', 'isWithin');
        final child = D4.getRequiredArg<String>(positional, 1, 'child', 'isWithin');
        return $tom_build_31.TomPth.isWithin(parent, child);
      },
      'equals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'equals');
        final path1 = D4.getRequiredArg<String>(positional, 0, 'path1', 'equals');
        final path2 = D4.getRequiredArg<String>(positional, 1, 'path2', 'equals');
        return $tom_build_31.TomPth.equals(path1, path2);
      },
      'expandHome': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'expandHome');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'expandHome');
        return $tom_build_31.TomPth.expandHome(path);
      },
    },
    staticMethodSignatures: {
      'join': 'String join(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6])',
      'joinAll': 'String joinAll(List<String> parts)',
      'dirname': 'String dirname(String path)',
      'basename': 'String basename(String path)',
      'basenameNoExt': 'String basenameNoExt(String path)',
      'extension': 'String extension(String path)',
      'split': 'List<String> split(String path)',
      'absolute': 'String absolute(String path)',
      'relative': 'String relative(String path, {String? from})',
      'normalize': 'String normalize(String path)',
      'canonical': 'String canonical(String path)',
      'setExtension': 'String setExtension(String path, String extension)',
      'withoutExtension': 'String withoutExtension(String path)',
      'isAbsolute': 'bool isAbsolute(String path)',
      'isRelative': 'bool isRelative(String path)',
      'isWithin': 'bool isWithin(String parent, String child)',
      'equals': 'bool equals(String path1, String path2)',
      'expandHome': 'String expandHome(String path)',
    },
    staticGetterSignatures: {
      'cwd': 'String get cwd',
      'home': 'String get home',
      'temp': 'String get temp',
      'separator': 'String get separator',
    },
  );
}

// =============================================================================
// TomShell Bridge
// =============================================================================

BridgedClass _createTomShellBridge() {
  return BridgedClass(
    nativeType: $tom_build_32.TomShell,
    name: 'TomShell',
    constructors: {
    },
    staticMethods: {
      'run': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'run');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'run');
        final workingDir = D4.getOptionalNamedArg<String?>(named, 'workingDir');
        final quiet = D4.getNamedArgWithDefault<bool>(named, 'quiet', false);
        final env = D4.coerceMapOrNull<String, String>(named['env'], 'env');
        final resolveEnv = D4.getNamedArgWithDefault<bool>(named, 'resolveEnv', true);
        return $tom_build_32.TomShell.run(command, workingDir: workingDir, quiet: quiet, env: env, resolveEnv: resolveEnv);
      },
      'exec': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'exec');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'exec');
        final workingDir = D4.getOptionalNamedArg<String?>(named, 'workingDir');
        final env = D4.coerceMapOrNull<String, String>(named['env'], 'env');
        final resolveEnv = D4.getNamedArgWithDefault<bool>(named, 'resolveEnv', true);
        return $tom_build_32.TomShell.exec(command, workingDir: workingDir, env: env, resolveEnv: resolveEnv);
      },
      'capture': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'capture');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'capture');
        final workingDir = D4.getOptionalNamedArg<String?>(named, 'workingDir');
        final env = D4.coerceMapOrNull<String, String>(named['env'], 'env');
        final resolveEnv = D4.getNamedArgWithDefault<bool>(named, 'resolveEnv', true);
        return $tom_build_32.TomShell.capture(command, workingDir: workingDir, env: env, resolveEnv: resolveEnv);
      },
      'runAll': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'runAll');
        if (positional.isEmpty) {
          throw ArgumentError('runAll: Missing required argument "commands" at position 0');
        }
        final commands = D4.coerceList<String>(positional[0], 'commands');
        final workingDir = D4.getOptionalNamedArg<String?>(named, 'workingDir');
        final stopOnError = D4.getNamedArgWithDefault<bool>(named, 'stopOnError', true);
        final resolveEnv = D4.getNamedArgWithDefault<bool>(named, 'resolveEnv', true);
        return $tom_build_32.TomShell.runAll(commands, workingDir: workingDir, stopOnError: stopOnError, resolveEnv: resolveEnv);
      },
      'pipe': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'pipe');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'pipe');
        final input = D4.getRequiredArg<String>(positional, 1, 'input', 'pipe');
        final workingDir = D4.getOptionalNamedArg<String?>(named, 'workingDir');
        final resolveEnv = D4.getNamedArgWithDefault<bool>(named, 'resolveEnv', true);
        return $tom_build_32.TomShell.pipe(command, input, workingDir: workingDir, resolveEnv: resolveEnv);
      },
      'hasCommand': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'hasCommand');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'hasCommand');
        return $tom_build_32.TomShell.hasCommand(command);
      },
      'which': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'which');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'which');
        return $tom_build_32.TomShell.which(command);
      },
    },
    staticMethodSignatures: {
      'run': 'String run(String command, {String? workingDir, bool quiet = false, Map<String, String>? env, bool resolveEnv = true})',
      'exec': 'int exec(String command, {String? workingDir, Map<String, String>? env, bool resolveEnv = true})',
      'capture': 'String capture(String command, {String? workingDir, Map<String, String>? env, bool resolveEnv = true})',
      'runAll': 'List<String> runAll(List<String> commands, {String? workingDir, bool stopOnError = true, bool resolveEnv = true})',
      'pipe': 'String pipe(String command, String input, {String? workingDir, bool resolveEnv = true})',
      'hasCommand': 'bool hasCommand(String command)',
      'which': 'String? which(String command)',
    },
  );
}

// =============================================================================
// TomShellException Bridge
// =============================================================================

BridgedClass _createTomShellExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_build_32.TomShellException,
    name: 'TomShellException',
    constructors: {
      '': (visitor, positional, named) {
        final command = D4.getRequiredNamedArg<String>(named, 'command', 'TomShellException');
        final exitCode = D4.getRequiredNamedArg<int>(named, 'exitCode', 'TomShellException');
        final stderr = D4.getRequiredNamedArg<String>(named, 'stderr', 'TomShellException');
        final stdout = D4.getRequiredNamedArg<String>(named, 'stdout', 'TomShellException');
        return $tom_build_32.TomShellException(command: command, exitCode: exitCode, stderr: stderr, stdout: stdout);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$tom_build_32.TomShellException>(target, 'TomShellException').command,
      'exitCode': (visitor, target) => D4.validateTarget<$tom_build_32.TomShellException>(target, 'TomShellException').exitCode,
      'stderr': (visitor, target) => D4.validateTarget<$tom_build_32.TomShellException>(target, 'TomShellException').stderr,
      'stdout': (visitor, target) => D4.validateTarget<$tom_build_32.TomShellException>(target, 'TomShellException').stdout,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_32.TomShellException>(target, 'TomShellException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'TomShellException({required String command, required int exitCode, required String stderr, required String stdout})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'command': 'String get command',
      'exitCode': 'int get exitCode',
      'stderr': 'String get stderr',
      'stdout': 'String get stdout',
    },
  );
}

// =============================================================================
// TomText Bridge
// =============================================================================

BridgedClass _createTomTextBridge() {
  return BridgedClass(
    nativeType: $tom_build_33.TomText,
    name: 'TomText',
    constructors: {
    },
    staticMethods: {
      'template': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'template');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'template');
        if (positional.length <= 1) {
          throw ArgumentError('template: Missing required argument "values" at position 1');
        }
        final values = D4.coerceMap<String, dynamic>(positional[1], 'values');
        final open = D4.getNamedArgWithDefault<String>(named, 'open', '{{');
        final close = D4.getNamedArgWithDefault<String>(named, 'close', '}}');
        return $tom_build_33.TomText.template(text, values, open: open, close: close);
      },
      'indent': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'indent');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'indent');
        final spaces = D4.getRequiredArg<int>(positional, 1, 'spaces', 'indent');
        final char = D4.getNamedArgWithDefault<String>(named, 'char', ' ');
        return $tom_build_33.TomText.indent(text, spaces, char: char);
      },
      'dedent': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dedent');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'dedent');
        return $tom_build_33.TomText.dedent(text);
      },
      'wrap': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'wrap');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'wrap');
        final width = D4.getRequiredArg<int>(positional, 1, 'width', 'wrap');
        final lineBreak = D4.getNamedArgWithDefault<String>(named, 'lineBreak', '\n');
        return $tom_build_33.TomText.wrap(text, width, lineBreak: lineBreak);
      },
      'truncate': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'truncate');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'truncate');
        final maxLength = D4.getRequiredArg<int>(positional, 1, 'maxLength', 'truncate');
        final suffix = D4.getNamedArgWithDefault<String>(named, 'suffix', '...');
        return $tom_build_33.TomText.truncate(text, maxLength, suffix: suffix);
      },
      'lines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'lines');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'lines');
        return $tom_build_33.TomText.lines(text);
      },
      'joinLines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'joinLines');
        if (positional.isEmpty) {
          throw ArgumentError('joinLines: Missing required argument "lines" at position 0');
        }
        final lines = D4.coerceList<String>(positional[0], 'lines');
        final separator = D4.getNamedArgWithDefault<String>(named, 'separator', '\n');
        return $tom_build_33.TomText.joinLines(lines, separator: separator);
      },
      'filterLines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'filterLines');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'filterLines');
        if (positional.length <= 1) {
          throw ArgumentError('filterLines: Missing required argument "predicate" at position 1');
        }
        final predicateRaw = positional[1];
        final predicate = (String p0) { return D4.callInterpreterCallback(visitor, predicateRaw, [p0]) as bool; };
        return $tom_build_33.TomText.filterLines(text, predicate);
      },
      'mapLines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'mapLines');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'mapLines');
        if (positional.length <= 1) {
          throw ArgumentError('mapLines: Missing required argument "mapper" at position 1');
        }
        final mapperRaw = positional[1];
        final mapper = (String p0) { return D4.callInterpreterCallback(visitor, mapperRaw, [p0]) as String; };
        return $tom_build_33.TomText.mapLines(text, mapper);
      },
      'head': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'head');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'head');
        final n = D4.getRequiredArg<int>(positional, 1, 'n', 'head');
        return $tom_build_33.TomText.head(text, n);
      },
      'tail': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'tail');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'tail');
        final n = D4.getRequiredArg<int>(positional, 1, 'n', 'tail');
        return $tom_build_33.TomText.tail(text, n);
      },
      'lineCount': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'lineCount');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'lineCount');
        return $tom_build_33.TomText.lineCount(text);
      },
      'wordCount': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'wordCount');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'wordCount');
        return $tom_build_33.TomText.wordCount(text);
      },
      'charCount': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'charCount');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'charCount');
        final excludeWhitespace = D4.getNamedArgWithDefault<bool>(named, 'excludeWhitespace', true);
        return $tom_build_33.TomText.charCount(text, excludeWhitespace: excludeWhitespace);
      },
      'between': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'between');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'between');
        final start = D4.getRequiredArg<String>(positional, 1, 'start', 'between');
        final end = D4.getRequiredArg<String>(positional, 2, 'end', 'between');
        return $tom_build_33.TomText.between(text, start, end);
      },
      'allBetween': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'allBetween');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'allBetween');
        final start = D4.getRequiredArg<String>(positional, 1, 'start', 'allBetween');
        final end = D4.getRequiredArg<String>(positional, 2, 'end', 'allBetween');
        return $tom_build_33.TomText.allBetween(text, start, end);
      },
      'slug': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'slug');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'slug');
        return $tom_build_33.TomText.slug(text);
      },
      'camelCase': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'camelCase');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'camelCase');
        return $tom_build_33.TomText.camelCase(text);
      },
      'pascalCase': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'pascalCase');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'pascalCase');
        return $tom_build_33.TomText.pascalCase(text);
      },
      'snakeCase': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'snakeCase');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'snakeCase');
        return $tom_build_33.TomText.snakeCase(text);
      },
      'kebabCase': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'kebabCase');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'kebabCase');
        return $tom_build_33.TomText.kebabCase(text);
      },
      'titleCase': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'titleCase');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'titleCase');
        return $tom_build_33.TomText.titleCase(text);
      },
      'padLeft': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'padLeft');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'padLeft');
        final width = D4.getRequiredArg<int>(positional, 1, 'width', 'padLeft');
        final char = D4.getNamedArgWithDefault<String>(named, 'char', ' ');
        return $tom_build_33.TomText.padLeft(text, width, char: char);
      },
      'padRight': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'padRight');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'padRight');
        final width = D4.getRequiredArg<int>(positional, 1, 'width', 'padRight');
        final char = D4.getNamedArgWithDefault<String>(named, 'char', ' ');
        return $tom_build_33.TomText.padRight(text, width, char: char);
      },
      'center': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'center');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'center');
        final width = D4.getRequiredArg<int>(positional, 1, 'width', 'center');
        final char = D4.getNamedArgWithDefault<String>(named, 'char', ' ');
        return $tom_build_33.TomText.center(text, width, char: char);
      },
      'removeBlankLines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'removeBlankLines');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'removeBlankLines');
        return $tom_build_33.TomText.removeBlankLines(text);
      },
      'collapseBlankLines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'collapseBlankLines');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'collapseBlankLines');
        return $tom_build_33.TomText.collapseBlankLines(text);
      },
      'trimLines': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'trimLines');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'trimLines');
        return $tom_build_33.TomText.trimLines(text);
      },
      'containsAll': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'containsAll');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'containsAll');
        if (positional.length <= 1) {
          throw ArgumentError('containsAll: Missing required argument "patterns" at position 1');
        }
        final patterns = D4.coerceList<String>(positional[1], 'patterns');
        return $tom_build_33.TomText.containsAll(text, patterns);
      },
      'containsAny': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'containsAny');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'containsAny');
        if (positional.length <= 1) {
          throw ArgumentError('containsAny: Missing required argument "patterns" at position 1');
        }
        final patterns = D4.coerceList<String>(positional[1], 'patterns');
        return $tom_build_33.TomText.containsAny(text, patterns);
      },
      'replaceAll': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'replaceAll');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'replaceAll');
        if (positional.length <= 1) {
          throw ArgumentError('replaceAll: Missing required argument "replacements" at position 1');
        }
        final replacements = D4.coerceMap<String, String>(positional[1], 'replacements');
        return $tom_build_33.TomText.replaceAll(text, replacements);
      },
      'escapeHtml': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'escapeHtml');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'escapeHtml');
        return $tom_build_33.TomText.escapeHtml(text);
      },
      'unescapeHtml': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'unescapeHtml');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'unescapeHtml');
        return $tom_build_33.TomText.unescapeHtml(text);
      },
      'escapeJson': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'escapeJson');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'escapeJson');
        return $tom_build_33.TomText.escapeJson(text);
      },
      'escapeRegex': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'escapeRegex');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'escapeRegex');
        return $tom_build_33.TomText.escapeRegex(text);
      },
      'escapeShell': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'escapeShell');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'escapeShell');
        return $tom_build_33.TomText.escapeShell(text);
      },
    },
    staticMethodSignatures: {
      'template': 'String template(String text, Map<String, dynamic> values, {String open = \'{{\', String close = \'}}\'})',
      'indent': 'String indent(String text, int spaces, {String char = \' \'})',
      'dedent': 'String dedent(String text)',
      'wrap': 'String wrap(String text, int width, {String lineBreak = \'\\n\'})',
      'truncate': 'String truncate(String text, int maxLength, {String suffix = \'...\'})',
      'lines': 'List<String> lines(String text)',
      'joinLines': 'String joinLines(List<String> lines, {String separator = \'\\n\'})',
      'filterLines': 'String filterLines(String text, bool Function(String) predicate)',
      'mapLines': 'String mapLines(String text, String Function(String) mapper)',
      'head': 'String head(String text, int n)',
      'tail': 'String tail(String text, int n)',
      'lineCount': 'int lineCount(String text)',
      'wordCount': 'int wordCount(String text)',
      'charCount': 'int charCount(String text, {bool excludeWhitespace = true})',
      'between': 'String? between(String text, String start, String end)',
      'allBetween': 'List<String> allBetween(String text, String start, String end)',
      'slug': 'String slug(String text)',
      'camelCase': 'String camelCase(String text)',
      'pascalCase': 'String pascalCase(String text)',
      'snakeCase': 'String snakeCase(String text)',
      'kebabCase': 'String kebabCase(String text)',
      'titleCase': 'String titleCase(String text)',
      'padLeft': 'String padLeft(String text, int width, {String char = \' \'})',
      'padRight': 'String padRight(String text, int width, {String char = \' \'})',
      'center': 'String center(String text, int width, {String char = \' \'})',
      'removeBlankLines': 'String removeBlankLines(String text)',
      'collapseBlankLines': 'String collapseBlankLines(String text)',
      'trimLines': 'String trimLines(String text)',
      'containsAll': 'bool containsAll(String text, List<String> patterns)',
      'containsAny': 'bool containsAny(String text, List<String> patterns)',
      'replaceAll': 'String replaceAll(String text, Map<String, String> replacements)',
      'escapeHtml': 'String escapeHtml(String text)',
      'unescapeHtml': 'String unescapeHtml(String text)',
      'escapeJson': 'String escapeJson(String text)',
      'escapeRegex': 'String escapeRegex(String text)',
      'escapeShell': 'String escapeShell(String text)',
    },
  );
}

// =============================================================================
// WorkspaceInfo Bridge
// =============================================================================

BridgedClass _createWorkspaceInfoBridge() {
  return BridgedClass(
    nativeType: $tom_build_41.WorkspaceInfo,
    name: 'WorkspaceInfo',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final settings = named.containsKey('settings') && named['settings'] != null
            ? D4.coerceMap<String, dynamic>(named['settings'], 'settings')
            : const <String, dynamic>{};
        final workspaceModes = D4.getOptionalNamedArg<$tom_build_41.MetadataModes?>(named, 'workspaceModes');
        final groups = named.containsKey('groups') && named['groups'] != null
            ? D4.coerceMap<String, $tom_build_41.WorkspaceGroup>(named['groups'], 'groups')
            : const <String, $tom_build_41.WorkspaceGroup>{};
        final buildOrder = named.containsKey('buildOrder') && named['buildOrder'] != null
            ? D4.coerceList<String>(named['buildOrder'], 'buildOrder')
            : const <String>[];
        final projects = named.containsKey('projects') && named['projects'] != null
            ? D4.coerceMap<String, $tom_build_41.WorkspaceProject>(named['projects'], 'projects')
            : const <String, $tom_build_41.WorkspaceProject>{};
        return $tom_build_41.WorkspaceInfo(name: name, settings: settings, workspaceModes: workspaceModes, groups: groups, buildOrder: buildOrder, projects: projects);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WorkspaceInfo');
        final yaml = D4.getRequiredArg<$yaml_1.YamlMap>(positional, 0, 'yaml', 'WorkspaceInfo');
        return $tom_build_41.WorkspaceInfo.fromYaml(yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceInfo>(target, 'WorkspaceInfo').name,
      'settings': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceInfo>(target, 'WorkspaceInfo').settings,
      'workspaceModes': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceInfo>(target, 'WorkspaceInfo').workspaceModes,
      'groups': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceInfo>(target, 'WorkspaceInfo').groups,
      'buildOrder': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceInfo>(target, 'WorkspaceInfo').buildOrder,
      'projects': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceInfo>(target, 'WorkspaceInfo').projects,
    },
    constructorSignatures: {
      '': 'WorkspaceInfo({String? name, Map<String, dynamic> settings = const {}, MetadataModes? workspaceModes, Map<String, WorkspaceGroup> groups = const {}, List<String> buildOrder = const [], Map<String, WorkspaceProject> projects = const {}})',
      'fromYaml': 'factory WorkspaceInfo.fromYaml(YamlMap yaml)',
    },
    getterSignatures: {
      'name': 'String? get name',
      'settings': 'Map<String, dynamic> get settings',
      'workspaceModes': 'MetadataModes? get workspaceModes',
      'groups': 'Map<String, WorkspaceGroup> get groups',
      'buildOrder': 'List<String> get buildOrder',
      'projects': 'Map<String, WorkspaceProject> get projects',
    },
  );
}

// =============================================================================
// MetadataModes Bridge
// =============================================================================

BridgedClass _createMetadataModesBridge() {
  return BridgedClass(
    nativeType: $tom_build_41.MetadataModes,
    name: 'MetadataModes',
    constructors: {
      '': (visitor, positional, named) {
        final supportedModes = named.containsKey('supportedModes') && named['supportedModes'] != null
            ? D4.coerceList<$tom_build_41.MetadataMode>(named['supportedModes'], 'supportedModes')
            : const <$tom_build_41.MetadataMode>[];
        final defaultMode = D4.getOptionalNamedArg<String?>(named, 'defaultMode');
        return $tom_build_41.MetadataModes(supportedModes: supportedModes, defaultMode: defaultMode);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MetadataModes');
        final yaml = D4.getRequiredArg<$yaml_1.YamlMap>(positional, 0, 'yaml', 'MetadataModes');
        return $tom_build_41.MetadataModes.fromYaml(yaml);
      },
    },
    getters: {
      'supportedModes': (visitor, target) => D4.validateTarget<$tom_build_41.MetadataModes>(target, 'MetadataModes').supportedModes,
      'defaultMode': (visitor, target) => D4.validateTarget<$tom_build_41.MetadataModes>(target, 'MetadataModes').defaultMode,
    },
    constructorSignatures: {
      '': 'MetadataModes({List<MetadataMode> supportedModes = const [], String? defaultMode})',
      'fromYaml': 'factory MetadataModes.fromYaml(YamlMap yaml)',
    },
    getterSignatures: {
      'supportedModes': 'List<MetadataMode> get supportedModes',
      'defaultMode': 'String? get defaultMode',
    },
  );
}

// =============================================================================
// MetadataMode Bridge
// =============================================================================

BridgedClass _createMetadataModeBridge() {
  return BridgedClass(
    nativeType: $tom_build_41.MetadataMode,
    name: 'MetadataMode',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'MetadataMode');
        final implies = named.containsKey('implies') && named['implies'] != null
            ? D4.coerceList<String>(named['implies'], 'implies')
            : const <String>[];
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        return $tom_build_41.MetadataMode(name: name, implies: implies, description: description);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MetadataMode');
        final yaml = D4.getRequiredArg<$yaml_1.YamlMap>(positional, 0, 'yaml', 'MetadataMode');
        return $tom_build_41.MetadataMode.fromYaml(yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_41.MetadataMode>(target, 'MetadataMode').name,
      'implies': (visitor, target) => D4.validateTarget<$tom_build_41.MetadataMode>(target, 'MetadataMode').implies,
      'description': (visitor, target) => D4.validateTarget<$tom_build_41.MetadataMode>(target, 'MetadataMode').description,
    },
    constructorSignatures: {
      '': 'MetadataMode({required String name, List<String> implies = const [], String? description})',
      'fromYaml': 'factory MetadataMode.fromYaml(YamlMap yaml)',
    },
    getterSignatures: {
      'name': 'String get name',
      'implies': 'List<String> get implies',
      'description': 'String? get description',
    },
  );
}

// =============================================================================
// WorkspaceGroup Bridge
// =============================================================================

BridgedClass _createWorkspaceGroupBridge() {
  return BridgedClass(
    nativeType: $tom_build_41.WorkspaceGroup,
    name: 'WorkspaceGroup',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'WorkspaceGroup');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final projects = named.containsKey('projects') && named['projects'] != null
            ? D4.coerceList<String>(named['projects'], 'projects')
            : const <String>[];
        return $tom_build_41.WorkspaceGroup(name: name, description: description, projects: projects);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'WorkspaceGroup');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'WorkspaceGroup');
        final yaml = D4.getRequiredArg<$yaml_1.YamlMap>(positional, 1, 'yaml', 'WorkspaceGroup');
        return $tom_build_41.WorkspaceGroup.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceGroup>(target, 'WorkspaceGroup').name,
      'description': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceGroup>(target, 'WorkspaceGroup').description,
      'projects': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceGroup>(target, 'WorkspaceGroup').projects,
    },
    constructorSignatures: {
      '': 'WorkspaceGroup({required String name, String? description, List<String> projects = const []})',
      'fromYaml': 'factory WorkspaceGroup.fromYaml(String name, YamlMap yaml)',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String? get description',
      'projects': 'List<String> get projects',
    },
  );
}

// =============================================================================
// WorkspaceProject Bridge
// =============================================================================

BridgedClass _createWorkspaceProjectBridge() {
  return BridgedClass(
    nativeType: $tom_build_41.WorkspaceProject,
    name: 'WorkspaceProject',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'WorkspaceProject');
        final displayName = D4.getOptionalNamedArg<String?>(named, 'displayName');
        final projectName = D4.getOptionalNamedArg<String?>(named, 'projectName');
        final type = D4.getOptionalNamedArg<String?>(named, 'type');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final buildAfter = named.containsKey('buildAfter') && named['buildAfter'] != null
            ? D4.coerceList<String>(named['buildAfter'], 'buildAfter')
            : const <String>[];
        final features = named.containsKey('features') && named['features'] != null
            ? D4.coerceMap<String, bool>(named['features'], 'features')
            : const <String, bool>{};
        final build = named.containsKey('build') && named['build'] != null
            ? D4.coerceMap<String, dynamic>(named['build'], 'build')
            : const <String, dynamic>{};
        final run = named.containsKey('run') && named['run'] != null
            ? D4.coerceMap<String, dynamic>(named['run'], 'run')
            : const <String, dynamic>{};
        final deploy = named.containsKey('deploy') && named['deploy'] != null
            ? D4.coerceMap<String, dynamic>(named['deploy'], 'deploy')
            : const <String, dynamic>{};
        final binaries = named.containsKey('binaries') && named['binaries'] != null
            ? D4.coerceList<String>(named['binaries'], 'binaries')
            : const <String>[];
        final docs = named.containsKey('docs') && named['docs'] != null
            ? D4.coerceList<String>(named['docs'], 'docs')
            : const <String>[];
        final tests = named.containsKey('tests') && named['tests'] != null
            ? D4.coerceList<String>(named['tests'], 'tests')
            : const <String>[];
        final examples = named.containsKey('examples') && named['examples'] != null
            ? D4.coerceList<String>(named['examples'], 'examples')
            : const <String>[];
        final copilotGuidelines = named.containsKey('copilotGuidelines') && named['copilotGuidelines'] != null
            ? D4.coerceList<String>(named['copilotGuidelines'], 'copilotGuidelines')
            : const <String>[];
        return $tom_build_41.WorkspaceProject(name: name, displayName: displayName, projectName: projectName, type: type, description: description, buildAfter: buildAfter, features: features, build: build, run: run, deploy: deploy, binaries: binaries, docs: docs, tests: tests, examples: examples, copilotGuidelines: copilotGuidelines);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'WorkspaceProject');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'WorkspaceProject');
        final yaml = D4.getRequiredArg<$yaml_1.YamlMap>(positional, 1, 'yaml', 'WorkspaceProject');
        return $tom_build_41.WorkspaceProject.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').name,
      'displayName': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').displayName,
      'projectName': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').projectName,
      'type': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').type,
      'description': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').description,
      'buildAfter': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').buildAfter,
      'features': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').features,
      'build': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').build,
      'run': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').run,
      'deploy': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').deploy,
      'binaries': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').binaries,
      'docs': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').docs,
      'tests': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').tests,
      'examples': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').examples,
      'copilotGuidelines': (visitor, target) => D4.validateTarget<$tom_build_41.WorkspaceProject>(target, 'WorkspaceProject').copilotGuidelines,
    },
    constructorSignatures: {
      '': 'WorkspaceProject({required String name, String? displayName, String? projectName, String? type, String? description, List<String> buildAfter = const [], Map<String, bool> features = const {}, Map<String, dynamic> build = const {}, Map<String, dynamic> run = const {}, Map<String, dynamic> deploy = const {}, List<String> binaries = const [], List<String> docs = const [], List<String> tests = const [], List<String> examples = const [], List<String> copilotGuidelines = const []})',
      'fromYaml': 'factory WorkspaceProject.fromYaml(String name, YamlMap yaml)',
    },
    getterSignatures: {
      'name': 'String get name',
      'displayName': 'String? get displayName',
      'projectName': 'String? get projectName',
      'type': 'String? get type',
      'description': 'String? get description',
      'buildAfter': 'List<String> get buildAfter',
      'features': 'Map<String, bool> get features',
      'build': 'Map<String, dynamic> get build',
      'run': 'Map<String, dynamic> get run',
      'deploy': 'Map<String, dynamic> get deploy',
      'binaries': 'List<String> get binaries',
      'docs': 'List<String> get docs',
      'tests': 'List<String> get tests',
      'examples': 'List<String> get examples',
      'copilotGuidelines': 'List<String> get copilotGuidelines',
    },
  );
}

// =============================================================================
// PlatformInfo Bridge
// =============================================================================

BridgedClass _createPlatformInfoBridge() {
  return BridgedClass(
    nativeType: $tom_build_40.PlatformInfo,
    name: 'PlatformInfo',
    constructors: {
      'detect': (visitor, positional, named) {
        return $tom_build_40.PlatformInfo.detect();
      },
    },
    getters: {
      'os': (visitor, target) => D4.validateTarget<$tom_build_40.PlatformInfo>(target, 'PlatformInfo').os,
      'architecture': (visitor, target) => D4.validateTarget<$tom_build_40.PlatformInfo>(target, 'PlatformInfo').architecture,
      'platform': (visitor, target) => D4.validateTarget<$tom_build_40.PlatformInfo>(target, 'PlatformInfo').platform,
      'dartTargetPlatforms': (visitor, target) => D4.validateTarget<$tom_build_40.PlatformInfo>(target, 'PlatformInfo').dartTargetPlatforms,
    },
    methods: {
      'canBuildFor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_40.PlatformInfo>(target, 'PlatformInfo');
        D4.requireMinArgs(positional, 1, 'canBuildFor');
        final targetPlatform = D4.getRequiredArg<String>(positional, 0, 'targetPlatform', 'canBuildFor');
        return t.canBuildFor(targetPlatform);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_40.PlatformInfo>(target, 'PlatformInfo');
        return t.toString();
      },
    },
    constructorSignatures: {
      'detect': 'factory PlatformInfo.detect()',
    },
    methodSignatures: {
      'canBuildFor': 'bool canBuildFor(String targetPlatform)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'os': 'OperatingSystem get os',
      'architecture': 'CpuArchitecture get architecture',
      'platform': 'String get platform',
      'dartTargetPlatforms': 'List<String> get dartTargetPlatforms',
    },
  );
}

// =============================================================================
// ToolContext Bridge
// =============================================================================

BridgedClass _createToolContextBridge() {
  return BridgedClass(
    nativeType: $tom_build_40.ToolContext,
    name: 'ToolContext',
    constructors: {
    },
    getters: {
      'workspaceInfo': (visitor, target) => D4.validateTarget<$tom_build_40.ToolContext>(target, 'ToolContext').workspaceInfo,
      'workspacePath': (visitor, target) => D4.validateTarget<$tom_build_40.ToolContext>(target, 'ToolContext').workspacePath,
      'platformInfo': (visitor, target) => D4.validateTarget<$tom_build_40.ToolContext>(target, 'ToolContext').platformInfo,
      'os': (visitor, target) => D4.validateTarget<$tom_build_40.ToolContext>(target, 'ToolContext').os,
      'architecture': (visitor, target) => D4.validateTarget<$tom_build_40.ToolContext>(target, 'ToolContext').architecture,
      'platform': (visitor, target) => D4.validateTarget<$tom_build_40.ToolContext>(target, 'ToolContext').platform,
      'dartTargetPlatforms': (visitor, target) => D4.validateTarget<$tom_build_40.ToolContext>(target, 'ToolContext').dartTargetPlatforms,
    },
    methods: {
      'validateModes': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_40.ToolContext>(target, 'ToolContext');
        D4.requireMinArgs(positional, 1, 'validateModes');
        if (positional.isEmpty) {
          throw ArgumentError('validateModes: Missing required argument "requestedModes" at position 0');
        }
        final requestedModes = D4.coerceList<String>(positional[0], 'requestedModes');
        return t.validateModes(requestedModes);
      },
    },
    staticGetters: {
      'current': (visitor) => $tom_build_40.ToolContext.current,
      'isInitialized': (visitor) => $tom_build_40.ToolContext.isInitialized,
    },
    staticMethods: {
      'load': (visitor, positional, named, typeArgs) {
        final workspacePath = D4.getOptionalNamedArg<String?>(named, 'workspacePath');
        return $tom_build_40.ToolContext.load(workspacePath: workspacePath);
      },
      'reload': (visitor, positional, named, typeArgs) {
        final workspacePath = D4.getOptionalNamedArg<String?>(named, 'workspacePath');
        return $tom_build_40.ToolContext.reload(workspacePath: workspacePath);
      },
      'clear': (visitor, positional, named, typeArgs) {
        return $tom_build_40.ToolContext.clear();
      },
    },
    methodSignatures: {
      'validateModes': 'ModeValidationResult validateModes(List<String> requestedModes)',
    },
    getterSignatures: {
      'workspaceInfo': 'WorkspaceInfo get workspaceInfo',
      'workspacePath': 'String get workspacePath',
      'platformInfo': 'PlatformInfo get platformInfo',
      'os': 'OperatingSystem get os',
      'architecture': 'CpuArchitecture get architecture',
      'platform': 'String get platform',
      'dartTargetPlatforms': 'List<String> get dartTargetPlatforms',
    },
    staticMethodSignatures: {
      'load': 'Future<ToolContext> load({String? workspacePath})',
      'reload': 'Future<ToolContext> reload({String? workspacePath})',
      'clear': 'void clear()',
    },
    staticGetterSignatures: {
      'current': 'ToolContext get current',
      'isInitialized': 'bool get isInitialized',
    },
  );
}

// =============================================================================
// ToolContextException Bridge
// =============================================================================

BridgedClass _createToolContextExceptionBridge() {
  return BridgedClass(
    nativeType: $tom_build_40.ToolContextException,
    name: 'ToolContextException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ToolContextException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ToolContextException');
        return $tom_build_40.ToolContextException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$tom_build_40.ToolContextException>(target, 'ToolContextException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_40.ToolContextException>(target, 'ToolContextException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ToolContextException(String message)',
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
// ModeValidationResult Bridge
// =============================================================================

BridgedClass _createModeValidationResultBridge() {
  return BridgedClass(
    nativeType: $tom_build_40.ModeValidationResult,
    name: 'ModeValidationResult',
    constructors: {
      'success': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ModeValidationResult');
        if (positional.isEmpty) {
          throw ArgumentError('ModeValidationResult: Missing required argument "resolvedModes" at position 0');
        }
        final resolvedModes = D4.coerceList<String>(positional[0], 'resolvedModes');
        return $tom_build_40.ModeValidationResult.success(resolvedModes);
      },
      'error': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ModeValidationResult');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ModeValidationResult');
        return $tom_build_40.ModeValidationResult.error(message);
      },
    },
    getters: {
      'isValid': (visitor, target) => D4.validateTarget<$tom_build_40.ModeValidationResult>(target, 'ModeValidationResult').isValid,
      'errorMessage': (visitor, target) => D4.validateTarget<$tom_build_40.ModeValidationResult>(target, 'ModeValidationResult').errorMessage,
      'resolvedModes': (visitor, target) => D4.validateTarget<$tom_build_40.ModeValidationResult>(target, 'ModeValidationResult').resolvedModes,
    },
    constructorSignatures: {
      'success': 'factory ModeValidationResult.success(List<String> resolvedModes)',
      'error': 'factory ModeValidationResult.error(String message)',
    },
    getterSignatures: {
      'isValid': 'bool get isValid',
      'errorMessage': 'String? get errorMessage',
      'resolvedModes': 'List<String> get resolvedModes',
    },
  );
}

// =============================================================================
// TomWs Bridge
// =============================================================================

BridgedClass _createTomWsBridge() {
  return BridgedClass(
    nativeType: $tom_build_34.TomWs,
    name: 'TomWs',
    constructors: {
    },
    staticGetters: {
      'context': (visitor) => $tom_build_34.TomWs.context,
      'info': (visitor) => $tom_build_34.TomWs.info,
      'path': (visitor) => $tom_build_34.TomWs.path,
      'platform': (visitor) => $tom_build_34.TomWs.platform,
      'projects': (visitor) => $tom_build_34.TomWs.projects,
      'projectsMap': (visitor) => $tom_build_34.TomWs.projectsMap,
      'groups': (visitor) => $tom_build_34.TomWs.groups,
      'groupsMap': (visitor) => $tom_build_34.TomWs.groupsMap,
      'name': (visitor) => $tom_build_34.TomWs.name,
      'buildOrder': (visitor) => $tom_build_34.TomWs.buildOrder,
      'projectNames': (visitor) => $tom_build_34.TomWs.projectNames,
      'groupNames': (visitor) => $tom_build_34.TomWs.groupNames,
      'dartPackages': (visitor) => $tom_build_34.TomWs.dartPackages,
      'flutterApps': (visitor) => $tom_build_34.TomWs.flutterApps,
      'dartServers': (visitor) => $tom_build_34.TomWs.dartServers,
      'vscodeExtensions': (visitor) => $tom_build_34.TomWs.vscodeExtensions,
      'isMacOS': (visitor) => $tom_build_34.TomWs.isMacOS,
      'isLinux': (visitor) => $tom_build_34.TomWs.isLinux,
      'isWindows': (visitor) => $tom_build_34.TomWs.isWindows,
      'osName': (visitor) => $tom_build_34.TomWs.osName,
      'arch': (visitor) => $tom_build_34.TomWs.arch,
      'isLoaded': (visitor) => $tom_build_34.TomWs.isLoaded,
    },
    staticMethods: {
      'project': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'project');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'project');
        return $tom_build_34.TomWs.project(name);
      },
      'hasProject': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'hasProject');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'hasProject');
        return $tom_build_34.TomWs.hasProject(name);
      },
      'projectsInGroup': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'projectsInGroup');
        final groupName = D4.getRequiredArg<String>(positional, 0, 'groupName', 'projectsInGroup');
        return $tom_build_34.TomWs.projectsInGroup(groupName);
      },
      'group': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'group');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'group');
        return $tom_build_34.TomWs.group(name);
      },
      'hasGroup': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'hasGroup');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'hasGroup');
        return $tom_build_34.TomWs.hasGroup(name);
      },
      'where': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final test = ($tom_build_41.WorkspaceProject p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; };
        return $tom_build_34.TomWs.where(test);
      },
      'ofType': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'ofType');
        final type = D4.getRequiredArg<String>(positional, 0, 'type', 'ofType');
        return $tom_build_34.TomWs.ofType(type);
      },
      'reload': (visitor, positional, named, typeArgs) {
        return $tom_build_34.TomWs.reload();
      },
    },
    staticMethodSignatures: {
      'project': 'WorkspaceProject? project(String name)',
      'hasProject': 'bool hasProject(String name)',
      'projectsInGroup': 'List<WorkspaceProject> projectsInGroup(String groupName)',
      'group': 'WorkspaceGroup? group(String name)',
      'hasGroup': 'bool hasGroup(String name)',
      'where': 'List<WorkspaceProject> where(bool Function(WorkspaceProject) test)',
      'ofType': 'List<WorkspaceProject> ofType(String type)',
      'reload': 'Future<void> reload()',
    },
    staticGetterSignatures: {
      'context': 'ToolContext get context',
      'info': 'WorkspaceInfo get info',
      'path': 'String get path',
      'platform': 'PlatformInfo get platform',
      'projects': 'List<WorkspaceProject> get projects',
      'projectsMap': 'Map<String, WorkspaceProject> get projectsMap',
      'groups': 'List<WorkspaceGroup> get groups',
      'groupsMap': 'Map<String, WorkspaceGroup> get groupsMap',
      'name': 'String? get name',
      'buildOrder': 'List<String> get buildOrder',
      'projectNames': 'List<String> get projectNames',
      'groupNames': 'List<String> get groupNames',
      'dartPackages': 'List<WorkspaceProject> get dartPackages',
      'flutterApps': 'List<WorkspaceProject> get flutterApps',
      'dartServers': 'List<WorkspaceProject> get dartServers',
      'vscodeExtensions': 'List<WorkspaceProject> get vscodeExtensions',
      'isMacOS': 'bool get isMacOS',
      'isLinux': 'bool get isLinux',
      'isWindows': 'bool get isWindows',
      'osName': 'String get osName',
      'arch': 'String get arch',
      'isLoaded': 'bool get isLoaded',
    },
  );
}

// =============================================================================
// ScriptYaml Bridge
// =============================================================================

BridgedClass _createScriptYamlBridge() {
  return BridgedClass(
    nativeType: $tom_build_35.ScriptYaml,
    name: 'ScriptYaml',
    constructors: {
    },
    staticMethods: {
      'load': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'load');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'load');
        return $tom_build_35.ScriptYaml.load(path);
      },
      'loadWithEnv': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadWithEnv');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadWithEnv');
        final environment = D4.coerceMapOrNull<String, String>(named['environment'], 'environment');
        return $tom_build_35.ScriptYaml.loadWithEnv(path, environment: environment);
      },
      'parse': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parse');
        final yamlContent = D4.getRequiredArg<String>(positional, 0, 'yamlContent', 'parse');
        return $tom_build_35.ScriptYaml.parse(yamlContent);
      },
      'parseList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parseList');
        final yamlContent = D4.getRequiredArg<String>(positional, 0, 'yamlContent', 'parseList');
        return $tom_build_35.ScriptYaml.parseList(yamlContent);
      },
      'parseAny': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'parseAny');
        final yamlContent = D4.getRequiredArg<String>(positional, 0, 'yamlContent', 'parseAny');
        return $tom_build_35.ScriptYaml.parseAny(yamlContent);
      },
      'loadAny': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadAny');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadAny');
        return $tom_build_35.ScriptYaml.loadAny(path);
      },
      'loadList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadList');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadList');
        return $tom_build_35.ScriptYaml.loadList(path);
      },
      'loadAndMerge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadAndMerge');
        if (positional.isEmpty) {
          throw ArgumentError('loadAndMerge: Missing required argument "paths" at position 0');
        }
        final paths = D4.coerceList<String>(positional[0], 'paths');
        return $tom_build_35.ScriptYaml.loadAndMerge(paths);
      },
      'loadAndMergeWithEnv': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'loadAndMergeWithEnv');
        if (positional.isEmpty) {
          throw ArgumentError('loadAndMergeWithEnv: Missing required argument "paths" at position 0');
        }
        final paths = D4.coerceList<String>(positional[0], 'paths');
        final environment = D4.coerceMapOrNull<String, String>(named['environment'], 'environment');
        return $tom_build_35.ScriptYaml.loadAndMergeWithEnv(paths, environment: environment);
      },
      'isValidFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isValidFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isValidFile');
        return $tom_build_35.ScriptYaml.isValidFile(path);
      },
    },
    staticMethodSignatures: {
      'load': 'Map<String, dynamic> load(String path)',
      'loadWithEnv': 'Map<String, dynamic> loadWithEnv(String path, {Map<String, String>? environment})',
      'parse': 'Map<String, dynamic> parse(String yamlContent)',
      'parseList': 'List<dynamic> parseList(String yamlContent)',
      'parseAny': 'dynamic parseAny(String yamlContent)',
      'loadAny': 'dynamic loadAny(String path)',
      'loadList': 'List<dynamic> loadList(String path)',
      'loadAndMerge': 'Map<String, dynamic> loadAndMerge(List<String> paths)',
      'loadAndMergeWithEnv': 'Map<String, dynamic> loadAndMergeWithEnv(List<String> paths, {Map<String, String>? environment})',
      'isValidFile': 'bool isValidFile(String path)',
    },
  );
}

// =============================================================================
// TomZoned Bridge
// =============================================================================

BridgedClass _createTomZonedBridge() {
  return BridgedClass(
    nativeType: $tom_build_36.TomZoned,
    name: 'TomZoned',
    constructors: {
    },
    staticGetters: {
      'current': (visitor) => $tom_build_36.TomZoned.current,
      'root': (visitor) => $tom_build_36.TomZoned.root,
    },
    staticMethods: {
      'get': (visitor, positional, named, typeArgs) {
        final name = D4.getOptionalArg<String?>(positional, 0, 'name');
        return $tom_build_36.TomZoned.get(name);
      },
      'getByKey': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'getByKey');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'getByKey');
        return $tom_build_36.TomZoned.getByKey(key);
      },
      'run': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'run');
        if (positional.isEmpty) {
          throw ArgumentError('run: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<Object, Object?>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('run: Missing required argument "body" at position 1');
        }
        final bodyRaw = positional[1];
        final body = () { return D4.callInterpreterCallback(visitor, bodyRaw, []) as dynamic; };
        return $tom_build_36.TomZoned.run(values, body);
      },
      'runAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'runAsync');
        if (positional.isEmpty) {
          throw ArgumentError('runAsync: Missing required argument "values" at position 0');
        }
        final values = D4.coerceMap<Object, Object?>(positional[0], 'values');
        if (positional.length <= 1) {
          throw ArgumentError('runAsync: Missing required argument "body" at position 1');
        }
        final bodyRaw = positional[1];
        final body = () { return D4.callInterpreterCallback(visitor, bodyRaw, []) as Future<dynamic>; };
        return $tom_build_36.TomZoned.runAsync(values, body);
      },
      'runGuarded': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'runGuarded');
        if (positional.isEmpty) {
          throw ArgumentError('runGuarded: Missing required argument "body" at position 0');
        }
        final bodyRaw = positional[0];
        final body = () { return D4.callInterpreterCallback(visitor, bodyRaw, []) as dynamic; };
        if (!named.containsKey('onError') || named['onError'] == null) {
          throw ArgumentError('runGuarded: Missing required named argument "onError"');
        }
        final onErrorRaw = named['onError'];
        final onError = (Object p0, StackTrace p1) { D4.callInterpreterCallback(visitor, onErrorRaw, [p0, p1]); };
        final values = D4.coerceMapOrNull<Object, Object?>(named['values'], 'values');
        return $tom_build_36.TomZoned.runGuarded(body, onError: onError, values: values);
      },
      'has': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'has');
        final key = D4.getRequiredArg<Object>(positional, 0, 'key', 'has');
        return $tom_build_36.TomZoned.has(key);
      },
      'hasType': (visitor, positional, named, typeArgs) {
        return $tom_build_36.TomZoned.hasType();
      },
    },
    staticMethodSignatures: {
      'get': 'T? get([String? name])',
      'getByKey': 'Object? getByKey(Object key)',
      'run': 'R run(Map<Object, Object?> values, R Function() body)',
      'runAsync': 'Future<R> runAsync(Map<Object, Object?> values, Future<R> Function() body)',
      'runGuarded': 'R runGuarded(R Function() body, {required void Function(Object error, StackTrace stack) onError, Map<Object, Object?>? values})',
      'has': 'bool has(Object key)',
      'hasType': 'bool hasType()',
    },
    staticGetterSignatures: {
      'current': 'async.Zone get current',
      'root': 'async.Zone get root',
    },
  );
}

// =============================================================================
// TomWorkspace Bridge
// =============================================================================

BridgedClass _createTomWorkspaceBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.TomWorkspace,
    name: 'TomWorkspace',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final binaries = D4.getOptionalNamedArg<String?>(named, 'binaries');
        final operatingSystems = D4.coerceListOrNull<String>(named['operatingSystems'], 'operatingSystems');
        final mobilePlatforms = D4.coerceListOrNull<String>(named['mobilePlatforms'], 'mobilePlatforms');
        final imports = D4.coerceListOrNull<String>(named['imports'], 'imports');
        final workspaceModes = D4.getOptionalNamedArg<$tom_build_37.WorkspaceModes?>(named, 'workspaceModes');
        final crossCompilation = D4.getOptionalNamedArg<$tom_build_37.CrossCompilation?>(named, 'crossCompilation');
        final groups = named.containsKey('groups') && named['groups'] != null
            ? D4.coerceMap<String, $tom_build_37.GroupDef>(named['groups'], 'groups')
            : const <String, $tom_build_37.GroupDef>{};
        final projectTypes = named.containsKey('projectTypes') && named['projectTypes'] != null
            ? D4.coerceMap<String, $tom_build_37.ProjectTypeDef>(named['projectTypes'], 'projectTypes')
            : const <String, $tom_build_37.ProjectTypeDef>{};
        final actions = named.containsKey('actions') && named['actions'] != null
            ? D4.coerceMap<String, $tom_build_37.ActionDef>(named['actions'], 'actions')
            : const <String, $tom_build_37.ActionDef>{};
        final modeDefinitions = named.containsKey('modeDefinitions') && named['modeDefinitions'] != null
            ? D4.coerceMap<String, $tom_build_37.ModeDefinitions>(named['modeDefinitions'], 'modeDefinitions')
            : const <String, $tom_build_37.ModeDefinitions>{};
        final pipelines = named.containsKey('pipelines') && named['pipelines'] != null
            ? D4.coerceMap<String, $tom_build_37.Pipeline>(named['pipelines'], 'pipelines')
            : const <String, $tom_build_37.Pipeline>{};
        final projectInfo = named.containsKey('projectInfo') && named['projectInfo'] != null
            ? D4.coerceMap<String, $tom_build_37.ProjectEntry>(named['projectInfo'], 'projectInfo')
            : const <String, $tom_build_37.ProjectEntry>{};
        final deps = named.containsKey('deps') && named['deps'] != null
            ? D4.coerceMap<String, String>(named['deps'], 'deps')
            : const <String, String>{};
        final depsDev = named.containsKey('depsDev') && named['depsDev'] != null
            ? D4.coerceMap<String, String>(named['depsDev'], 'depsDev')
            : const <String, String>{};
        final versionSettings = D4.getOptionalNamedArg<$tom_build_37.VersionSettings?>(named, 'versionSettings');
        final customTags = named.containsKey('customTags') && named['customTags'] != null
            ? D4.coerceMap<String, dynamic>(named['customTags'], 'customTags')
            : const <String, dynamic>{};
        return $tom_build_37.TomWorkspace(name: name, binaries: binaries, operatingSystems: operatingSystems, mobilePlatforms: mobilePlatforms, imports: imports, workspaceModes: workspaceModes, crossCompilation: crossCompilation, groups: groups, projectTypes: projectTypes, actions: actions, modeDefinitions: modeDefinitions, pipelines: pipelines, projectInfo: projectInfo, deps: deps, depsDev: depsDev, versionSettings: versionSettings, customTags: customTags);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomWorkspace');
        if (positional.isEmpty) {
          throw ArgumentError('TomWorkspace: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.TomWorkspace.fromYaml(yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').name,
      'binaries': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').binaries,
      'operatingSystems': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').operatingSystems,
      'mobilePlatforms': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').mobilePlatforms,
      'imports': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').imports,
      'workspaceModes': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').workspaceModes,
      'crossCompilation': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').crossCompilation,
      'groups': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').groups,
      'projectTypes': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').projectTypes,
      'actions': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').actions,
      'modeDefinitions': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').modeDefinitions,
      'pipelines': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').pipelines,
      'projectInfo': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').projectInfo,
      'deps': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').deps,
      'depsDev': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').depsDev,
      'versionSettings': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').versionSettings,
      'customTags': (visitor, target) => D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace').customTags,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.TomWorkspace>(target, 'TomWorkspace');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'TomWorkspace({String? name, String? binaries, List<String>? operatingSystems, List<String>? mobilePlatforms, List<String>? imports, WorkspaceModes? workspaceModes, CrossCompilation? crossCompilation, Map<String, GroupDef> groups = const {}, Map<String, ProjectTypeDef> projectTypes = const {}, Map<String, ActionDef> actions = const {}, Map<String, ModeDefinitions> modeDefinitions = const {}, Map<String, Pipeline> pipelines = const {}, Map<String, ProjectEntry> projectInfo = const {}, Map<String, String> deps = const {}, Map<String, String> depsDev = const {}, VersionSettings? versionSettings, Map<String, dynamic> customTags = const {}})',
      'fromYaml': 'factory TomWorkspace.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String? get name',
      'binaries': 'String? get binaries',
      'operatingSystems': 'List<String>? get operatingSystems',
      'mobilePlatforms': 'List<String>? get mobilePlatforms',
      'imports': 'List<String>? get imports',
      'workspaceModes': 'WorkspaceModes? get workspaceModes',
      'crossCompilation': 'CrossCompilation? get crossCompilation',
      'groups': 'Map<String, GroupDef> get groups',
      'projectTypes': 'Map<String, ProjectTypeDef> get projectTypes',
      'actions': 'Map<String, ActionDef> get actions',
      'modeDefinitions': 'Map<String, ModeDefinitions> get modeDefinitions',
      'pipelines': 'Map<String, Pipeline> get pipelines',
      'projectInfo': 'Map<String, ProjectEntry> get projectInfo',
      'deps': 'Map<String, String> get deps',
      'depsDev': 'Map<String, String> get depsDev',
      'versionSettings': 'VersionSettings? get versionSettings',
      'customTags': 'Map<String, dynamic> get customTags',
    },
  );
}

// =============================================================================
// TomMaster Bridge
// =============================================================================

BridgedClass _createTomMasterBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.TomMaster,
    name: 'TomMaster',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getOptionalNamedArg<String?>(named, 'name');
        final binaries = D4.getOptionalNamedArg<String?>(named, 'binaries');
        final operatingSystems = D4.coerceListOrNull<String>(named['operatingSystems'], 'operatingSystems');
        final mobilePlatforms = D4.coerceListOrNull<String>(named['mobilePlatforms'], 'mobilePlatforms');
        final imports = D4.coerceListOrNull<String>(named['imports'], 'imports');
        final workspaceModes = D4.getOptionalNamedArg<$tom_build_37.WorkspaceModes?>(named, 'workspaceModes');
        final crossCompilation = D4.getOptionalNamedArg<$tom_build_37.CrossCompilation?>(named, 'crossCompilation');
        final groups = named.containsKey('groups') && named['groups'] != null
            ? D4.coerceMap<String, $tom_build_37.GroupDef>(named['groups'], 'groups')
            : const <String, $tom_build_37.GroupDef>{};
        final projectTypes = named.containsKey('projectTypes') && named['projectTypes'] != null
            ? D4.coerceMap<String, $tom_build_37.ProjectTypeDef>(named['projectTypes'], 'projectTypes')
            : const <String, $tom_build_37.ProjectTypeDef>{};
        final actions = named.containsKey('actions') && named['actions'] != null
            ? D4.coerceMap<String, $tom_build_37.ActionDef>(named['actions'], 'actions')
            : const <String, $tom_build_37.ActionDef>{};
        final modeDefinitions = named.containsKey('modeDefinitions') && named['modeDefinitions'] != null
            ? D4.coerceMap<String, $tom_build_37.ModeDefinitions>(named['modeDefinitions'], 'modeDefinitions')
            : const <String, $tom_build_37.ModeDefinitions>{};
        final pipelines = named.containsKey('pipelines') && named['pipelines'] != null
            ? D4.coerceMap<String, $tom_build_37.Pipeline>(named['pipelines'], 'pipelines')
            : const <String, $tom_build_37.Pipeline>{};
        final projectInfo = named.containsKey('projectInfo') && named['projectInfo'] != null
            ? D4.coerceMap<String, $tom_build_37.ProjectEntry>(named['projectInfo'], 'projectInfo')
            : const <String, $tom_build_37.ProjectEntry>{};
        final deps = named.containsKey('deps') && named['deps'] != null
            ? D4.coerceMap<String, String>(named['deps'], 'deps')
            : const <String, String>{};
        final depsDev = named.containsKey('depsDev') && named['depsDev'] != null
            ? D4.coerceMap<String, String>(named['depsDev'], 'depsDev')
            : const <String, String>{};
        final versionSettings = D4.getOptionalNamedArg<$tom_build_37.VersionSettings?>(named, 'versionSettings');
        final customTags = named.containsKey('customTags') && named['customTags'] != null
            ? D4.coerceMap<String, dynamic>(named['customTags'], 'customTags')
            : const <String, dynamic>{};
        final scanTimestamp = D4.getOptionalNamedArg<String?>(named, 'scanTimestamp');
        final projects = named.containsKey('projects') && named['projects'] != null
            ? D4.coerceMap<String, $tom_build_37.TomProject>(named['projects'], 'projects')
            : const <String, $tom_build_37.TomProject>{};
        final buildOrder = named.containsKey('buildOrder') && named['buildOrder'] != null
            ? D4.coerceList<String>(named['buildOrder'], 'buildOrder')
            : const <String>[];
        final actionOrder = named.containsKey('actionOrder') && named['actionOrder'] != null
            ? D4.coerceMap<String, List<String>>(named['actionOrder'], 'actionOrder')
            : const <String, List<String>>{};
        return $tom_build_37.TomMaster(name: name, binaries: binaries, operatingSystems: operatingSystems, mobilePlatforms: mobilePlatforms, imports: imports, workspaceModes: workspaceModes, crossCompilation: crossCompilation, groups: groups, projectTypes: projectTypes, actions: actions, modeDefinitions: modeDefinitions, pipelines: pipelines, projectInfo: projectInfo, deps: deps, depsDev: depsDev, versionSettings: versionSettings, customTags: customTags, scanTimestamp: scanTimestamp, projects: projects, buildOrder: buildOrder, actionOrder: actionOrder);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TomMaster');
        if (positional.isEmpty) {
          throw ArgumentError('TomMaster: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.TomMaster.fromYaml(yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').name,
      'binaries': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').binaries,
      'operatingSystems': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').operatingSystems,
      'mobilePlatforms': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').mobilePlatforms,
      'imports': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').imports,
      'workspaceModes': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').workspaceModes,
      'crossCompilation': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').crossCompilation,
      'groups': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').groups,
      'projectTypes': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').projectTypes,
      'actions': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').actions,
      'modeDefinitions': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').modeDefinitions,
      'pipelines': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').pipelines,
      'projectInfo': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').projectInfo,
      'deps': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').deps,
      'depsDev': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').depsDev,
      'versionSettings': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').versionSettings,
      'customTags': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').customTags,
      'scanTimestamp': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').scanTimestamp,
      'projects': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').projects,
      'buildOrder': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').buildOrder,
      'actionOrder': (visitor, target) => D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster').actionOrder,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.TomMaster>(target, 'TomMaster');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'TomMaster({String? name, String? binaries, List<String>? operatingSystems, List<String>? mobilePlatforms, List<String>? imports, WorkspaceModes? workspaceModes, CrossCompilation? crossCompilation, Map<String, GroupDef> groups = const {}, Map<String, ProjectTypeDef> projectTypes = const {}, Map<String, ActionDef> actions = const {}, Map<String, ModeDefinitions> modeDefinitions = const {}, Map<String, Pipeline> pipelines = const {}, Map<String, ProjectEntry> projectInfo = const {}, Map<String, String> deps = const {}, Map<String, String> depsDev = const {}, VersionSettings? versionSettings, Map<String, dynamic> customTags = const {}, String? scanTimestamp, Map<String, TomProject> projects = const {}, List<String> buildOrder = const [], Map<String, List<String>> actionOrder = const {}})',
      'fromYaml': 'factory TomMaster.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String? get name',
      'binaries': 'String? get binaries',
      'operatingSystems': 'List<String>? get operatingSystems',
      'mobilePlatforms': 'List<String>? get mobilePlatforms',
      'imports': 'List<String>? get imports',
      'workspaceModes': 'WorkspaceModes? get workspaceModes',
      'crossCompilation': 'CrossCompilation? get crossCompilation',
      'groups': 'Map<String, GroupDef> get groups',
      'projectTypes': 'Map<String, ProjectTypeDef> get projectTypes',
      'actions': 'Map<String, ActionDef> get actions',
      'modeDefinitions': 'Map<String, ModeDefinitions> get modeDefinitions',
      'pipelines': 'Map<String, Pipeline> get pipelines',
      'projectInfo': 'Map<String, ProjectEntry> get projectInfo',
      'deps': 'Map<String, String> get deps',
      'depsDev': 'Map<String, String> get depsDev',
      'versionSettings': 'VersionSettings? get versionSettings',
      'customTags': 'Map<String, dynamic> get customTags',
      'scanTimestamp': 'String? get scanTimestamp',
      'projects': 'Map<String, TomProject> get projects',
      'buildOrder': 'List<String> get buildOrder',
      'actionOrder': 'Map<String, List<String>> get actionOrder',
    },
  );
}

// =============================================================================
// TomProject Bridge
// =============================================================================

BridgedClass _createTomProjectBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.TomProject,
    name: 'TomProject',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'TomProject');
        final type = D4.getOptionalNamedArg<String?>(named, 'type');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final binaries = D4.getOptionalNamedArg<String?>(named, 'binaries');
        final buildAfter = named.containsKey('buildAfter') && named['buildAfter'] != null
            ? D4.coerceList<String>(named['buildAfter'], 'buildAfter')
            : const <String>[];
        final actionOrder = named.containsKey('actionOrder') && named['actionOrder'] != null
            ? D4.coerceMap<String, List<String>>(named['actionOrder'], 'actionOrder')
            : const <String, List<String>>{};
        final features = D4.getOptionalNamedArg<$tom_build_37.Features?>(named, 'features');
        final actions = named.containsKey('actions') && named['actions'] != null
            ? D4.coerceMap<String, $tom_build_37.ActionDef>(named['actions'], 'actions')
            : const <String, $tom_build_37.ActionDef>{};
        final modeDefinitions = named.containsKey('modeDefinitions') && named['modeDefinitions'] != null
            ? D4.coerceMap<String, $tom_build_37.ModeDefinitions>(named['modeDefinitions'], 'modeDefinitions')
            : const <String, $tom_build_37.ModeDefinitions>{};
        final crossCompilation = D4.getOptionalNamedArg<$tom_build_37.CrossCompilation?>(named, 'crossCompilation');
        final packageModule = D4.getOptionalNamedArg<$tom_build_37.PackageModule?>(named, 'packageModule');
        final parts = named.containsKey('parts') && named['parts'] != null
            ? D4.coerceMap<String, $tom_build_37.Part>(named['parts'], 'parts')
            : const <String, $tom_build_37.Part>{};
        final tests = D4.coerceListOrNull<String>(named['tests'], 'tests');
        final examples = D4.coerceListOrNull<String>(named['examples'], 'examples');
        final docs = D4.coerceListOrNull<String>(named['docs'], 'docs');
        final copilotGuidelines = D4.coerceListOrNull<String>(named['copilotGuidelines'], 'copilotGuidelines');
        final binaryFiles = D4.coerceListOrNull<String>(named['binaryFiles'], 'binaryFiles');
        final executables = named.containsKey('executables') && named['executables'] != null
            ? D4.coerceList<$tom_build_37.ExecutableDef>(named['executables'], 'executables')
            : const <$tom_build_37.ExecutableDef>[];
        final metadataFiles = named.containsKey('metadataFiles') && named['metadataFiles'] != null
            ? D4.coerceMap<String, dynamic>(named['metadataFiles'], 'metadataFiles')
            : const <String, dynamic>{};
        final actionModeDefinitions = D4.coerceMapOrNull<String, dynamic>(named['actionModeDefinitions'], 'actionModeDefinitions');
        final customTags = named.containsKey('customTags') && named['customTags'] != null
            ? D4.coerceMap<String, dynamic>(named['customTags'], 'customTags')
            : const <String, dynamic>{};
        return $tom_build_37.TomProject(name: name, type: type, description: description, binaries: binaries, buildAfter: buildAfter, actionOrder: actionOrder, features: features, actions: actions, modeDefinitions: modeDefinitions, crossCompilation: crossCompilation, packageModule: packageModule, parts: parts, tests: tests, examples: examples, docs: docs, copilotGuidelines: copilotGuidelines, binaryFiles: binaryFiles, executables: executables, metadataFiles: metadataFiles, actionModeDefinitions: actionModeDefinitions, customTags: customTags);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'TomProject');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'TomProject');
        if (positional.length <= 1) {
          throw ArgumentError('TomProject: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        final defaultActions = D4.coerceMapOrNull<String, $tom_build_37.ActionDef>(named['defaultActions'], 'defaultActions');
        return $tom_build_37.TomProject.fromYaml(name, yaml, defaultActions: defaultActions);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').name,
      'type': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').type,
      'description': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').description,
      'binaries': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').binaries,
      'buildAfter': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').buildAfter,
      'actionOrder': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').actionOrder,
      'features': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').features,
      'actions': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').actions,
      'modeDefinitions': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').modeDefinitions,
      'crossCompilation': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').crossCompilation,
      'packageModule': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').packageModule,
      'parts': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').parts,
      'tests': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').tests,
      'examples': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').examples,
      'docs': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').docs,
      'copilotGuidelines': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').copilotGuidelines,
      'binaryFiles': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').binaryFiles,
      'executables': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').executables,
      'metadataFiles': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').metadataFiles,
      'actionModeDefinitions': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').actionModeDefinitions,
      'customTags': (visitor, target) => D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject').customTags,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject');
        return t.toYaml();
      },
      'toYamlCompact': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.TomProject>(target, 'TomProject');
        final workspaceCrossCompilation = D4.getOptionalNamedArg<$tom_build_37.CrossCompilation?>(named, 'workspaceCrossCompilation');
        final workspaceModeDefinitions = D4.coerceMapOrNull<String, $tom_build_37.ModeDefinitions>(named['workspaceModeDefinitions'], 'workspaceModeDefinitions');
        final workspaceActions = D4.coerceMapOrNull<String, $tom_build_37.ActionDef>(named['workspaceActions'], 'workspaceActions');
        return t.toYamlCompact(workspaceCrossCompilation: workspaceCrossCompilation, workspaceModeDefinitions: workspaceModeDefinitions, workspaceActions: workspaceActions);
      },
    },
    constructorSignatures: {
      '': 'TomProject({required String name, String? type, String? description, String? binaries, List<String> buildAfter = const [], Map<String, List<String>> actionOrder = const {}, Features? features, Map<String, ActionDef> actions = const {}, Map<String, ModeDefinitions> modeDefinitions = const {}, CrossCompilation? crossCompilation, PackageModule? packageModule, Map<String, Part> parts = const {}, List<String>? tests, List<String>? examples, List<String>? docs, List<String>? copilotGuidelines, List<String>? binaryFiles, List<ExecutableDef> executables = const [], Map<String, dynamic> metadataFiles = const {}, Map<String, dynamic>? actionModeDefinitions, Map<String, dynamic> customTags = const {}})',
      'fromYaml': 'factory TomProject.fromYaml(String name, Map<String, dynamic> yaml, {Map<String, ActionDef>? defaultActions})',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
      'toYamlCompact': 'Map<String, dynamic> toYamlCompact({CrossCompilation? workspaceCrossCompilation, Map<String, ModeDefinitions>? workspaceModeDefinitions, Map<String, ActionDef>? workspaceActions})',
    },
    getterSignatures: {
      'name': 'String get name',
      'type': 'String? get type',
      'description': 'String? get description',
      'binaries': 'String? get binaries',
      'buildAfter': 'List<String> get buildAfter',
      'actionOrder': 'Map<String, List<String>> get actionOrder',
      'features': 'Features? get features',
      'actions': 'Map<String, ActionDef> get actions',
      'modeDefinitions': 'Map<String, ModeDefinitions> get modeDefinitions',
      'crossCompilation': 'CrossCompilation? get crossCompilation',
      'packageModule': 'PackageModule? get packageModule',
      'parts': 'Map<String, Part> get parts',
      'tests': 'List<String>? get tests',
      'examples': 'List<String>? get examples',
      'docs': 'List<String>? get docs',
      'copilotGuidelines': 'List<String>? get copilotGuidelines',
      'binaryFiles': 'List<String>? get binaryFiles',
      'executables': 'List<ExecutableDef> get executables',
      'metadataFiles': 'Map<String, dynamic> get metadataFiles',
      'actionModeDefinitions': 'Map<String, dynamic>? get actionModeDefinitions',
      'customTags': 'Map<String, dynamic> get customTags',
    },
  );
}

// =============================================================================
// WorkspaceModes Bridge
// =============================================================================

BridgedClass _createWorkspaceModesBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.WorkspaceModes,
    name: 'WorkspaceModes',
    constructors: {
      '': (visitor, positional, named) {
        final modeTypes = named.containsKey('modeTypes') && named['modeTypes'] != null
            ? D4.coerceList<String>(named['modeTypes'], 'modeTypes')
            : const <String>[];
        final supported = named.containsKey('supported') && named['supported'] != null
            ? D4.coerceList<$tom_build_37.SupportedMode>(named['supported'], 'supported')
            : const <$tom_build_37.SupportedMode>[];
        final modeTypeConfigs = named.containsKey('modeTypeConfigs') && named['modeTypeConfigs'] != null
            ? D4.coerceMap<String, $tom_build_37.ModeTypeConfig>(named['modeTypeConfigs'], 'modeTypeConfigs')
            : const <String, $tom_build_37.ModeTypeConfig>{};
        final actionModeConfiguration = D4.getOptionalNamedArg<$tom_build_37.ActionModeConfiguration?>(named, 'actionModeConfiguration');
        final defaultMode = D4.getOptionalNamedArg<String?>(named, 'defaultMode');
        return $tom_build_37.WorkspaceModes(modeTypes: modeTypes, supported: supported, modeTypeConfigs: modeTypeConfigs, actionModeConfiguration: actionModeConfiguration, defaultMode: defaultMode);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WorkspaceModes');
        if (positional.isEmpty) {
          throw ArgumentError('WorkspaceModes: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.WorkspaceModes.fromYaml(yaml);
      },
    },
    getters: {
      'modeTypes': (visitor, target) => D4.validateTarget<$tom_build_37.WorkspaceModes>(target, 'WorkspaceModes').modeTypes,
      'supported': (visitor, target) => D4.validateTarget<$tom_build_37.WorkspaceModes>(target, 'WorkspaceModes').supported,
      'modeTypeConfigs': (visitor, target) => D4.validateTarget<$tom_build_37.WorkspaceModes>(target, 'WorkspaceModes').modeTypeConfigs,
      'actionModeConfiguration': (visitor, target) => D4.validateTarget<$tom_build_37.WorkspaceModes>(target, 'WorkspaceModes').actionModeConfiguration,
      'defaultMode': (visitor, target) => D4.validateTarget<$tom_build_37.WorkspaceModes>(target, 'WorkspaceModes').defaultMode,
      'supportedModes': (visitor, target) => D4.validateTarget<$tom_build_37.WorkspaceModes>(target, 'WorkspaceModes').supportedModes,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.WorkspaceModes>(target, 'WorkspaceModes');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'WorkspaceModes({List<String> modeTypes = const [], List<SupportedMode> supported = const [], Map<String, ModeTypeConfig> modeTypeConfigs = const {}, ActionModeConfiguration? actionModeConfiguration, String? defaultMode})',
      'fromYaml': 'factory WorkspaceModes.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'modeTypes': 'List<String> get modeTypes',
      'supported': 'List<SupportedMode> get supported',
      'modeTypeConfigs': 'Map<String, ModeTypeConfig> get modeTypeConfigs',
      'actionModeConfiguration': 'ActionModeConfiguration? get actionModeConfiguration',
      'defaultMode': 'String? get defaultMode',
      'supportedModes': 'List<SupportedMode> get supportedModes',
    },
  );
}

// =============================================================================
// SupportedMode Bridge
// =============================================================================

BridgedClass _createSupportedModeBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.SupportedMode,
    name: 'SupportedMode',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'SupportedMode');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final implies = named.containsKey('implies') && named['implies'] != null
            ? D4.coerceList<String>(named['implies'], 'implies')
            : const <String>[];
        return $tom_build_37.SupportedMode(name: name, description: description, implies: implies);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'SupportedMode');
        if (positional.isEmpty) {
          throw ArgumentError('SupportedMode: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.SupportedMode.fromYaml(yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.SupportedMode>(target, 'SupportedMode').name,
      'description': (visitor, target) => D4.validateTarget<$tom_build_37.SupportedMode>(target, 'SupportedMode').description,
      'implies': (visitor, target) => D4.validateTarget<$tom_build_37.SupportedMode>(target, 'SupportedMode').implies,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.SupportedMode>(target, 'SupportedMode');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'SupportedMode({required String name, String? description, List<String> implies = const []})',
      'fromYaml': 'factory SupportedMode.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String? get description',
      'implies': 'List<String> get implies',
    },
  );
}

// =============================================================================
// ModeTypeConfig Bridge
// =============================================================================

BridgedClass _createModeTypeConfigBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ModeTypeConfig,
    name: 'ModeTypeConfig',
    constructors: {
      '': (visitor, positional, named) {
        final defaultMode = D4.getOptionalNamedArg<String?>(named, 'defaultMode');
        final entries = named.containsKey('entries') && named['entries'] != null
            ? D4.coerceMap<String, $tom_build_37.ModeEntry>(named['entries'], 'entries')
            : const <String, $tom_build_37.ModeEntry>{};
        return $tom_build_37.ModeTypeConfig(defaultMode: defaultMode, entries: entries);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ModeTypeConfig');
        if (positional.isEmpty) {
          throw ArgumentError('ModeTypeConfig: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.ModeTypeConfig.fromYaml(yaml);
      },
    },
    getters: {
      'defaultMode': (visitor, target) => D4.validateTarget<$tom_build_37.ModeTypeConfig>(target, 'ModeTypeConfig').defaultMode,
      'entries': (visitor, target) => D4.validateTarget<$tom_build_37.ModeTypeConfig>(target, 'ModeTypeConfig').entries,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ModeTypeConfig>(target, 'ModeTypeConfig');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ModeTypeConfig({String? defaultMode, Map<String, ModeEntry> entries = const {}})',
      'fromYaml': 'factory ModeTypeConfig.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'defaultMode': 'String? get defaultMode',
      'entries': 'Map<String, ModeEntry> get entries',
    },
  );
}

// =============================================================================
// ModeEntry Bridge
// =============================================================================

BridgedClass _createModeEntryBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ModeEntry,
    name: 'ModeEntry',
    constructors: {
      '': (visitor, positional, named) {
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final modes = named.containsKey('modes') && named['modes'] != null
            ? D4.coerceList<String>(named['modes'], 'modes')
            : const <String>[];
        final properties = named.containsKey('properties') && named['properties'] != null
            ? D4.coerceMap<String, dynamic>(named['properties'], 'properties')
            : const <String, dynamic>{};
        return $tom_build_37.ModeEntry(description: description, modes: modes, properties: properties);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ModeEntry');
        if (positional.isEmpty) {
          throw ArgumentError('ModeEntry: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.ModeEntry.fromYaml(yaml);
      },
    },
    getters: {
      'description': (visitor, target) => D4.validateTarget<$tom_build_37.ModeEntry>(target, 'ModeEntry').description,
      'modes': (visitor, target) => D4.validateTarget<$tom_build_37.ModeEntry>(target, 'ModeEntry').modes,
      'properties': (visitor, target) => D4.validateTarget<$tom_build_37.ModeEntry>(target, 'ModeEntry').properties,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ModeEntry>(target, 'ModeEntry');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ModeEntry({String? description, List<String> modes = const [], Map<String, dynamic> properties = const {}})',
      'fromYaml': 'factory ModeEntry.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'description': 'String? get description',
      'modes': 'List<String> get modes',
      'properties': 'Map<String, dynamic> get properties',
    },
  );
}

// =============================================================================
// ActionModeConfiguration Bridge
// =============================================================================

BridgedClass _createActionModeConfigurationBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ActionModeConfiguration,
    name: 'ActionModeConfiguration',
    constructors: {
      '': (visitor, positional, named) {
        final entries = named.containsKey('entries') && named['entries'] != null
            ? D4.coerceMap<String, $tom_build_37.ActionModeEntry>(named['entries'], 'entries')
            : const <String, $tom_build_37.ActionModeEntry>{};
        return $tom_build_37.ActionModeConfiguration(entries: entries);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ActionModeConfiguration');
        if (positional.isEmpty) {
          throw ArgumentError('ActionModeConfiguration: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.ActionModeConfiguration.fromYaml(yaml);
      },
    },
    getters: {
      'entries': (visitor, target) => D4.validateTarget<$tom_build_37.ActionModeConfiguration>(target, 'ActionModeConfiguration').entries,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ActionModeConfiguration>(target, 'ActionModeConfiguration');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ActionModeConfiguration({Map<String, ActionModeEntry> entries = const {}})',
      'fromYaml': 'factory ActionModeConfiguration.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'entries': 'Map<String, ActionModeEntry> get entries',
    },
  );
}

// =============================================================================
// ActionModeEntry Bridge
// =============================================================================

BridgedClass _createActionModeEntryBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ActionModeEntry,
    name: 'ActionModeEntry',
    constructors: {
      '': (visitor, positional, named) {
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final modes = named.containsKey('modes') && named['modes'] != null
            ? D4.coerceMap<String, String>(named['modes'], 'modes')
            : const <String, String>{};
        return $tom_build_37.ActionModeEntry(description: description, modes: modes);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ActionModeEntry');
        if (positional.isEmpty) {
          throw ArgumentError('ActionModeEntry: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.ActionModeEntry.fromYaml(yaml);
      },
    },
    getters: {
      'description': (visitor, target) => D4.validateTarget<$tom_build_37.ActionModeEntry>(target, 'ActionModeEntry').description,
      'modes': (visitor, target) => D4.validateTarget<$tom_build_37.ActionModeEntry>(target, 'ActionModeEntry').modes,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ActionModeEntry>(target, 'ActionModeEntry');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ActionModeEntry({String? description, Map<String, String> modes = const {}})',
      'fromYaml': 'factory ActionModeEntry.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'description': 'String? get description',
      'modes': 'Map<String, String> get modes',
    },
  );
}

// =============================================================================
// ModeDefinitions Bridge
// =============================================================================

BridgedClass _createModeDefinitionsBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ModeDefinitions,
    name: 'ModeDefinitions',
    constructors: {
      '': (visitor, positional, named) {
        final definitions = named.containsKey('definitions') && named['definitions'] != null
            ? D4.coerceMap<String, $tom_build_37.ModeDef>(named['definitions'], 'definitions')
            : const <String, $tom_build_37.ModeDef>{};
        return $tom_build_37.ModeDefinitions(definitions: definitions);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ModeDefinitions');
        if (positional.isEmpty) {
          throw ArgumentError('ModeDefinitions: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.ModeDefinitions.fromYaml(yaml);
      },
    },
    getters: {
      'definitions': (visitor, target) => D4.validateTarget<$tom_build_37.ModeDefinitions>(target, 'ModeDefinitions').definitions,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ModeDefinitions>(target, 'ModeDefinitions');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ModeDefinitions({Map<String, ModeDef> definitions = const {}})',
      'fromYaml': 'factory ModeDefinitions.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'definitions': 'Map<String, ModeDef> get definitions',
    },
  );
}

// =============================================================================
// ModeDef Bridge
// =============================================================================

BridgedClass _createModeDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ModeDef,
    name: 'ModeDef',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ModeDef');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final properties = named.containsKey('properties') && named['properties'] != null
            ? D4.coerceMap<String, dynamic>(named['properties'], 'properties')
            : const <String, dynamic>{};
        return $tom_build_37.ModeDef(name: name, description: description, properties: properties);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ModeDef');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ModeDef');
        if (positional.length <= 1) {
          throw ArgumentError('ModeDef: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_37.ModeDef.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.ModeDef>(target, 'ModeDef').name,
      'description': (visitor, target) => D4.validateTarget<$tom_build_37.ModeDef>(target, 'ModeDef').description,
      'properties': (visitor, target) => D4.validateTarget<$tom_build_37.ModeDef>(target, 'ModeDef').properties,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ModeDef>(target, 'ModeDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ModeDef({required String name, String? description, Map<String, dynamic> properties = const {}})',
      'fromYaml': 'factory ModeDef.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String? get description',
      'properties': 'Map<String, dynamic> get properties',
    },
  );
}

// =============================================================================
// ActionDef Bridge
// =============================================================================

BridgedClass _createActionDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ActionDef,
    name: 'ActionDef',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ActionDef');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final skipTypes = D4.coerceListOrNull<String>(named['skipTypes'], 'skipTypes');
        final appliesToTypes = D4.coerceListOrNull<String>(named['appliesToTypes'], 'appliesToTypes');
        final defaultConfig = D4.getOptionalNamedArg<$tom_build_37.ActionConfig?>(named, 'defaultConfig');
        final typeConfigs = named.containsKey('typeConfigs') && named['typeConfigs'] != null
            ? D4.coerceMap<String, $tom_build_37.ActionConfig>(named['typeConfigs'], 'typeConfigs')
            : const <String, $tom_build_37.ActionConfig>{};
        return $tom_build_37.ActionDef(name: name, description: description, skipTypes: skipTypes, appliesToTypes: appliesToTypes, defaultConfig: defaultConfig, typeConfigs: typeConfigs);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ActionDef');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ActionDef');
        if (positional.length <= 1) {
          throw ArgumentError('ActionDef: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_37.ActionDef.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.ActionDef>(target, 'ActionDef').name,
      'description': (visitor, target) => D4.validateTarget<$tom_build_37.ActionDef>(target, 'ActionDef').description,
      'skipTypes': (visitor, target) => D4.validateTarget<$tom_build_37.ActionDef>(target, 'ActionDef').skipTypes,
      'appliesToTypes': (visitor, target) => D4.validateTarget<$tom_build_37.ActionDef>(target, 'ActionDef').appliesToTypes,
      'defaultConfig': (visitor, target) => D4.validateTarget<$tom_build_37.ActionDef>(target, 'ActionDef').defaultConfig,
      'typeConfigs': (visitor, target) => D4.validateTarget<$tom_build_37.ActionDef>(target, 'ActionDef').typeConfigs,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ActionDef>(target, 'ActionDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ActionDef({required String name, String? description, List<String>? skipTypes, List<String>? appliesToTypes, ActionConfig? defaultConfig, Map<String, ActionConfig> typeConfigs = const {}})',
      'fromYaml': 'factory ActionDef.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String? get description',
      'skipTypes': 'List<String>? get skipTypes',
      'appliesToTypes': 'List<String>? get appliesToTypes',
      'defaultConfig': 'ActionConfig? get defaultConfig',
      'typeConfigs': 'Map<String, ActionConfig> get typeConfigs',
    },
  );
}

// =============================================================================
// ActionConfig Bridge
// =============================================================================

BridgedClass _createActionConfigBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ActionConfig,
    name: 'ActionConfig',
    constructors: {
      '': (visitor, positional, named) {
        final preCommands = D4.coerceListOrNull<dynamic>(named['preCommands'], 'preCommands');
        final commands = named.containsKey('commands') && named['commands'] != null
            ? D4.coerceList<dynamic>(named['commands'], 'commands')
            : const <dynamic>[];
        final postCommands = D4.coerceListOrNull<dynamic>(named['postCommands'], 'postCommands');
        final customTags = named.containsKey('customTags') && named['customTags'] != null
            ? D4.coerceMap<String, dynamic>(named['customTags'], 'customTags')
            : const <String, dynamic>{};
        return $tom_build_37.ActionConfig(preCommands: preCommands, commands: commands, postCommands: postCommands, customTags: customTags);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ActionConfig');
        if (positional.isEmpty) {
          throw ArgumentError('ActionConfig: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.ActionConfig.fromYaml(yaml);
      },
    },
    getters: {
      'preCommands': (visitor, target) => D4.validateTarget<$tom_build_37.ActionConfig>(target, 'ActionConfig').preCommands,
      'commands': (visitor, target) => D4.validateTarget<$tom_build_37.ActionConfig>(target, 'ActionConfig').commands,
      'postCommands': (visitor, target) => D4.validateTarget<$tom_build_37.ActionConfig>(target, 'ActionConfig').postCommands,
      'customTags': (visitor, target) => D4.validateTarget<$tom_build_37.ActionConfig>(target, 'ActionConfig').customTags,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ActionConfig>(target, 'ActionConfig');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ActionConfig({List<dynamic>? preCommands, List<dynamic> commands = const [], List<dynamic>? postCommands, Map<String, dynamic> customTags = const {}})',
      'fromYaml': 'factory ActionConfig.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'preCommands': 'List<dynamic>? get preCommands',
      'commands': 'List<dynamic> get commands',
      'postCommands': 'List<dynamic>? get postCommands',
      'customTags': 'Map<String, dynamic> get customTags',
    },
  );
}

// =============================================================================
// GroupDef Bridge
// =============================================================================

BridgedClass _createGroupDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.GroupDef,
    name: 'GroupDef',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'GroupDef');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final projects = named.containsKey('projects') && named['projects'] != null
            ? D4.coerceList<String>(named['projects'], 'projects')
            : const <String>[];
        final projectInfoOverrides = D4.coerceMapOrNull<String, dynamic>(named['projectInfoOverrides'], 'projectInfoOverrides');
        return $tom_build_37.GroupDef(name: name, description: description, projects: projects, projectInfoOverrides: projectInfoOverrides);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'GroupDef');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'GroupDef');
        if (positional.length <= 1) {
          throw ArgumentError('GroupDef: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_37.GroupDef.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.GroupDef>(target, 'GroupDef').name,
      'description': (visitor, target) => D4.validateTarget<$tom_build_37.GroupDef>(target, 'GroupDef').description,
      'projects': (visitor, target) => D4.validateTarget<$tom_build_37.GroupDef>(target, 'GroupDef').projects,
      'projectInfoOverrides': (visitor, target) => D4.validateTarget<$tom_build_37.GroupDef>(target, 'GroupDef').projectInfoOverrides,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.GroupDef>(target, 'GroupDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'GroupDef({required String name, String? description, List<String> projects = const [], Map<String, dynamic>? projectInfoOverrides})',
      'fromYaml': 'factory GroupDef.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String? get description',
      'projects': 'List<String> get projects',
      'projectInfoOverrides': 'Map<String, dynamic>? get projectInfoOverrides',
    },
  );
}

// =============================================================================
// ProjectTypeDef Bridge
// =============================================================================

BridgedClass _createProjectTypeDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ProjectTypeDef,
    name: 'ProjectTypeDef',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ProjectTypeDef');
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final metadataFiles = named.containsKey('metadataFiles') && named['metadataFiles'] != null
            ? D4.coerceMap<String, String>(named['metadataFiles'], 'metadataFiles')
            : const <String, String>{};
        final projectInfoOverrides = D4.coerceMapOrNull<String, dynamic>(named['projectInfoOverrides'], 'projectInfoOverrides');
        return $tom_build_37.ProjectTypeDef(name: name, description: description, metadataFiles: metadataFiles, projectInfoOverrides: projectInfoOverrides);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ProjectTypeDef');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'ProjectTypeDef');
        if (positional.length <= 1) {
          throw ArgumentError('ProjectTypeDef: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_37.ProjectTypeDef.fromYaml(key, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.ProjectTypeDef>(target, 'ProjectTypeDef').name,
      'description': (visitor, target) => D4.validateTarget<$tom_build_37.ProjectTypeDef>(target, 'ProjectTypeDef').description,
      'metadataFiles': (visitor, target) => D4.validateTarget<$tom_build_37.ProjectTypeDef>(target, 'ProjectTypeDef').metadataFiles,
      'projectInfoOverrides': (visitor, target) => D4.validateTarget<$tom_build_37.ProjectTypeDef>(target, 'ProjectTypeDef').projectInfoOverrides,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ProjectTypeDef>(target, 'ProjectTypeDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ProjectTypeDef({required String name, String? description, Map<String, String> metadataFiles = const {}, Map<String, dynamic>? projectInfoOverrides})',
      'fromYaml': 'factory ProjectTypeDef.fromYaml(String key, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'description': 'String? get description',
      'metadataFiles': 'Map<String, String> get metadataFiles',
      'projectInfoOverrides': 'Map<String, dynamic>? get projectInfoOverrides',
    },
  );
}

// =============================================================================
// Features Bridge
// =============================================================================

BridgedClass _createFeaturesBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.Features,
    name: 'Features',
    constructors: {
      '': (visitor, positional, named) {
        final flags = named.containsKey('flags') && named['flags'] != null
            ? D4.coerceMap<String, bool>(named['flags'], 'flags')
            : const <String, bool>{};
        return $tom_build_37.Features(flags: flags);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Features');
        if (positional.isEmpty) {
          throw ArgumentError('Features: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.Features.fromYaml(yaml);
      },
    },
    getters: {
      'flags': (visitor, target) => D4.validateTarget<$tom_build_37.Features>(target, 'Features').flags,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.Features>(target, 'Features');
        return t.toYaml();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.Features>(target, 'Features');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
    },
    constructorSignatures: {
      '': 'Features({Map<String, bool> flags = const {}})',
      'fromYaml': 'factory Features.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'flags': 'Map<String, bool> get flags',
    },
  );
}

// =============================================================================
// CrossCompilation Bridge
// =============================================================================

BridgedClass _createCrossCompilationBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.CrossCompilation,
    name: 'CrossCompilation',
    constructors: {
      '': (visitor, positional, named) {
        final allTargets = named.containsKey('allTargets') && named['allTargets'] != null
            ? D4.coerceList<String>(named['allTargets'], 'allTargets')
            : const <String>[];
        final buildOn = named.containsKey('buildOn') && named['buildOn'] != null
            ? D4.coerceMap<String, $tom_build_37.BuildOnTarget>(named['buildOn'], 'buildOn')
            : const <String, $tom_build_37.BuildOnTarget>{};
        return $tom_build_37.CrossCompilation(allTargets: allTargets, buildOn: buildOn);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CrossCompilation');
        if (positional.isEmpty) {
          throw ArgumentError('CrossCompilation: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.CrossCompilation.fromYaml(yaml);
      },
    },
    getters: {
      'allTargets': (visitor, target) => D4.validateTarget<$tom_build_37.CrossCompilation>(target, 'CrossCompilation').allTargets,
      'buildOn': (visitor, target) => D4.validateTarget<$tom_build_37.CrossCompilation>(target, 'CrossCompilation').buildOn,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.CrossCompilation>(target, 'CrossCompilation');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'CrossCompilation({List<String> allTargets = const [], Map<String, BuildOnTarget> buildOn = const {}})',
      'fromYaml': 'factory CrossCompilation.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'allTargets': 'List<String> get allTargets',
      'buildOn': 'Map<String, BuildOnTarget> get buildOn',
    },
  );
}

// =============================================================================
// BuildOnTarget Bridge
// =============================================================================

BridgedClass _createBuildOnTargetBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.BuildOnTarget,
    name: 'BuildOnTarget',
    constructors: {
      '': (visitor, positional, named) {
        final targets = named.containsKey('targets') && named['targets'] != null
            ? D4.coerceList<String>(named['targets'], 'targets')
            : const <String>[];
        return $tom_build_37.BuildOnTarget(targets: targets);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BuildOnTarget');
        if (positional.isEmpty) {
          throw ArgumentError('BuildOnTarget: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.BuildOnTarget.fromYaml(yaml);
      },
    },
    getters: {
      'targets': (visitor, target) => D4.validateTarget<$tom_build_37.BuildOnTarget>(target, 'BuildOnTarget').targets,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.BuildOnTarget>(target, 'BuildOnTarget');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'BuildOnTarget({List<String> targets = const []})',
      'fromYaml': 'factory BuildOnTarget.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'targets': 'List<String> get targets',
    },
  );
}

// =============================================================================
// Pipeline Bridge
// =============================================================================

BridgedClass _createPipelineBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.Pipeline,
    name: 'Pipeline',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'Pipeline');
        final globalParameters = D4.coerceListOrNull<String>(named['globalParameters'], 'globalParameters');
        final projects = named.containsKey('projects') && named['projects'] != null
            ? D4.coerceList<$tom_build_37.PipelineProject>(named['projects'], 'projects')
            : const <$tom_build_37.PipelineProject>[];
        final actions = named.containsKey('actions') && named['actions'] != null
            ? D4.coerceList<$tom_build_37.PipelineAction>(named['actions'], 'actions')
            : const <$tom_build_37.PipelineAction>[];
        return $tom_build_37.Pipeline(name: name, globalParameters: globalParameters, projects: projects, actions: actions);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Pipeline');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Pipeline');
        if (positional.length <= 1) {
          throw ArgumentError('Pipeline: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_37.Pipeline.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.Pipeline>(target, 'Pipeline').name,
      'globalParameters': (visitor, target) => D4.validateTarget<$tom_build_37.Pipeline>(target, 'Pipeline').globalParameters,
      'projects': (visitor, target) => D4.validateTarget<$tom_build_37.Pipeline>(target, 'Pipeline').projects,
      'actions': (visitor, target) => D4.validateTarget<$tom_build_37.Pipeline>(target, 'Pipeline').actions,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.Pipeline>(target, 'Pipeline');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'Pipeline({required String name, List<String>? globalParameters, List<PipelineProject> projects = const [], List<PipelineAction> actions = const []})',
      'fromYaml': 'factory Pipeline.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'globalParameters': 'List<String>? get globalParameters',
      'projects': 'List<PipelineProject> get projects',
      'actions': 'List<PipelineAction> get actions',
    },
  );
}

// =============================================================================
// PipelineProject Bridge
// =============================================================================

BridgedClass _createPipelineProjectBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.PipelineProject,
    name: 'PipelineProject',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'PipelineProject');
        return $tom_build_37.PipelineProject(name: name);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PipelineProject');
        if (positional.isEmpty) {
          throw ArgumentError('PipelineProject: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.PipelineProject.fromYaml(yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.PipelineProject>(target, 'PipelineProject').name,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.PipelineProject>(target, 'PipelineProject');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'PipelineProject({required String name})',
      'fromYaml': 'factory PipelineProject.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
}

// =============================================================================
// PipelineAction Bridge
// =============================================================================

BridgedClass _createPipelineActionBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.PipelineAction,
    name: 'PipelineAction',
    constructors: {
      '': (visitor, positional, named) {
        final action = D4.getRequiredNamedArg<String>(named, 'action', 'PipelineAction');
        return $tom_build_37.PipelineAction(action: action);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PipelineAction');
        if (positional.isEmpty) {
          throw ArgumentError('PipelineAction: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.PipelineAction.fromYaml(yaml);
      },
    },
    getters: {
      'action': (visitor, target) => D4.validateTarget<$tom_build_37.PipelineAction>(target, 'PipelineAction').action,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.PipelineAction>(target, 'PipelineAction');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'PipelineAction({required String action})',
      'fromYaml': 'factory PipelineAction.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'action': 'String get action',
    },
  );
}

// =============================================================================
// ProjectEntry Bridge
// =============================================================================

BridgedClass _createProjectEntryBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ProjectEntry,
    name: 'ProjectEntry',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'ProjectEntry');
        final settings = named.containsKey('settings') && named['settings'] != null
            ? D4.coerceMap<String, dynamic>(named['settings'], 'settings')
            : const <String, dynamic>{};
        return $tom_build_37.ProjectEntry(name: name, settings: settings);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ProjectEntry');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'ProjectEntry');
        if (positional.length <= 1) {
          throw ArgumentError('ProjectEntry: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_37.ProjectEntry.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.ProjectEntry>(target, 'ProjectEntry').name,
      'settings': (visitor, target) => D4.validateTarget<$tom_build_37.ProjectEntry>(target, 'ProjectEntry').settings,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ProjectEntry>(target, 'ProjectEntry');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ProjectEntry({required String name, Map<String, dynamic> settings = const {}})',
      'fromYaml': 'factory ProjectEntry.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'settings': 'Map<String, dynamic> get settings',
    },
  );
}

// =============================================================================
// VersionSettings Bridge
// =============================================================================

BridgedClass _createVersionSettingsBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.VersionSettings,
    name: 'VersionSettings',
    constructors: {
      '': (visitor, positional, named) {
        final prereleaseTag = D4.getOptionalNamedArg<String?>(named, 'prereleaseTag');
        final autoIncrement = D4.getOptionalNamedArg<bool?>(named, 'autoIncrement');
        final minDevBuild = D4.getOptionalNamedArg<int?>(named, 'minDevBuild');
        final actionCounter = D4.getOptionalNamedArg<int?>(named, 'actionCounter');
        return $tom_build_37.VersionSettings(prereleaseTag: prereleaseTag, autoIncrement: autoIncrement, minDevBuild: minDevBuild, actionCounter: actionCounter);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VersionSettings');
        if (positional.isEmpty) {
          throw ArgumentError('VersionSettings: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.VersionSettings.fromYaml(yaml);
      },
    },
    getters: {
      'prereleaseTag': (visitor, target) => D4.validateTarget<$tom_build_37.VersionSettings>(target, 'VersionSettings').prereleaseTag,
      'autoIncrement': (visitor, target) => D4.validateTarget<$tom_build_37.VersionSettings>(target, 'VersionSettings').autoIncrement,
      'minDevBuild': (visitor, target) => D4.validateTarget<$tom_build_37.VersionSettings>(target, 'VersionSettings').minDevBuild,
      'actionCounter': (visitor, target) => D4.validateTarget<$tom_build_37.VersionSettings>(target, 'VersionSettings').actionCounter,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.VersionSettings>(target, 'VersionSettings');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'VersionSettings({String? prereleaseTag, bool? autoIncrement, int? minDevBuild, int? actionCounter})',
      'fromYaml': 'factory VersionSettings.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'prereleaseTag': 'String? get prereleaseTag',
      'autoIncrement': 'bool? get autoIncrement',
      'minDevBuild': 'int? get minDevBuild',
      'actionCounter': 'int? get actionCounter',
    },
  );
}

// =============================================================================
// PackageModule Bridge
// =============================================================================

BridgedClass _createPackageModuleBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.PackageModule,
    name: 'PackageModule',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'PackageModule');
        final libraryFile = D4.getOptionalNamedArg<String?>(named, 'libraryFile');
        final sourceFolders = D4.coerceListOrNull<String>(named['sourceFolders'], 'sourceFolders');
        return $tom_build_37.PackageModule(name: name, libraryFile: libraryFile, sourceFolders: sourceFolders);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PackageModule');
        if (positional.isEmpty) {
          throw ArgumentError('PackageModule: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.PackageModule.fromYaml(yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.PackageModule>(target, 'PackageModule').name,
      'libraryFile': (visitor, target) => D4.validateTarget<$tom_build_37.PackageModule>(target, 'PackageModule').libraryFile,
      'sourceFolders': (visitor, target) => D4.validateTarget<$tom_build_37.PackageModule>(target, 'PackageModule').sourceFolders,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.PackageModule>(target, 'PackageModule');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'PackageModule({required String name, String? libraryFile, List<String>? sourceFolders})',
      'fromYaml': 'factory PackageModule.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'libraryFile': 'String? get libraryFile',
      'sourceFolders': 'List<String>? get sourceFolders',
    },
  );
}

// =============================================================================
// Part Bridge
// =============================================================================

BridgedClass _createPartBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.Part,
    name: 'Part',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'Part');
        final libraryFile = D4.getOptionalNamedArg<String?>(named, 'libraryFile');
        final modules = named.containsKey('modules') && named['modules'] != null
            ? D4.coerceMap<String, $tom_build_37.Module>(named['modules'], 'modules')
            : const <String, $tom_build_37.Module>{};
        return $tom_build_37.Part(name: name, libraryFile: libraryFile, modules: modules);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Part');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Part');
        if (positional.length <= 1) {
          throw ArgumentError('Part: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_37.Part.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.Part>(target, 'Part').name,
      'libraryFile': (visitor, target) => D4.validateTarget<$tom_build_37.Part>(target, 'Part').libraryFile,
      'modules': (visitor, target) => D4.validateTarget<$tom_build_37.Part>(target, 'Part').modules,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.Part>(target, 'Part');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'Part({required String name, String? libraryFile, Map<String, Module> modules = const {}})',
      'fromYaml': 'factory Part.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'libraryFile': 'String? get libraryFile',
      'modules': 'Map<String, Module> get modules',
    },
  );
}

// =============================================================================
// Module Bridge
// =============================================================================

BridgedClass _createModuleBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.Module,
    name: 'Module',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'Module');
        final libraryFile = D4.getOptionalNamedArg<String?>(named, 'libraryFile');
        return $tom_build_37.Module(name: name, libraryFile: libraryFile);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Module');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'Module');
        if (positional.length <= 1) {
          throw ArgumentError('Module: Missing required argument "yaml" at position 1');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[1], 'yaml');
        return $tom_build_37.Module.fromYaml(name, yaml);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_build_37.Module>(target, 'Module').name,
      'libraryFile': (visitor, target) => D4.validateTarget<$tom_build_37.Module>(target, 'Module').libraryFile,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.Module>(target, 'Module');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'Module({required String name, String? libraryFile})',
      'fromYaml': 'factory Module.fromYaml(String name, Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'name': 'String get name',
      'libraryFile': 'String? get libraryFile',
    },
  );
}

// =============================================================================
// ExecutableDef Bridge
// =============================================================================

BridgedClass _createExecutableDefBridge() {
  return BridgedClass(
    nativeType: $tom_build_37.ExecutableDef,
    name: 'ExecutableDef',
    constructors: {
      '': (visitor, positional, named) {
        final source = D4.getRequiredNamedArg<String>(named, 'source', 'ExecutableDef');
        final output = D4.getRequiredNamedArg<String>(named, 'output', 'ExecutableDef');
        return $tom_build_37.ExecutableDef(source: source, output: output);
      },
      'fromYaml': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExecutableDef');
        if (positional.isEmpty) {
          throw ArgumentError('ExecutableDef: Missing required argument "yaml" at position 0');
        }
        final yaml = D4.coerceMap<String, dynamic>(positional[0], 'yaml');
        return $tom_build_37.ExecutableDef.fromYaml(yaml);
      },
    },
    getters: {
      'source': (visitor, target) => D4.validateTarget<$tom_build_37.ExecutableDef>(target, 'ExecutableDef').source,
      'output': (visitor, target) => D4.validateTarget<$tom_build_37.ExecutableDef>(target, 'ExecutableDef').output,
    },
    methods: {
      'toYaml': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_37.ExecutableDef>(target, 'ExecutableDef');
        return t.toYaml();
      },
    },
    constructorSignatures: {
      '': 'ExecutableDef({required String source, required String output})',
      'fromYaml': 'factory ExecutableDef.fromYaml(Map<String, dynamic> yaml)',
    },
    methodSignatures: {
      'toYaml': 'Map<String, dynamic> toYaml()',
    },
    getterSignatures: {
      'source': 'String get source',
      'output': 'String get output',
    },
  );
}

// =============================================================================
// WorkspaceParser Bridge
// =============================================================================

BridgedClass _createWorkspaceParserBridge() {
  return BridgedClass(
    nativeType: $tom_build_38.WorkspaceParser,
    name: 'WorkspaceParser',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WorkspaceParser');
        final workspacePath = D4.getRequiredArg<String>(positional, 0, 'workspacePath', 'WorkspaceParser');
        return $tom_build_38.WorkspaceParser(workspacePath);
      },
    },
    getters: {
      'workspacePath': (visitor, target) => D4.validateTarget<$tom_build_38.WorkspaceParser>(target, 'WorkspaceParser').workspacePath,
    },
    methods: {
      'parse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_38.WorkspaceParser>(target, 'WorkspaceParser');
        return t.parse();
      },
    },
    constructorSignatures: {
      '': 'WorkspaceParser(String workspacePath)',
    },
    methodSignatures: {
      'parse': 'TomMaster parse()',
    },
    getterSignatures: {
      'workspacePath': 'String get workspacePath',
    },
  );
}

// =============================================================================
// TomContext Bridge
// =============================================================================

BridgedClass _createTomContextBridge() {
  return BridgedClass(
    nativeType: $tom_build_39.TomContext,
    name: 'TomContext',
    constructors: {
      '': (visitor, positional, named) {
        final workspace = D4.getRequiredNamedArg<$tom_build_37.TomWorkspace>(named, 'workspace', 'TomContext');
        final workspaceContext = D4.getOptionalNamedArg<Object?>(named, 'workspaceContext');
        final currentProject = D4.getOptionalNamedArg<$tom_build_37.TomProject?>(named, 'currentProject');
        final workspacePath = D4.getOptionalNamedArg<String?>(named, 'workspacePath');
        return $tom_build_39.TomContext(workspace: workspace, workspaceContext: workspaceContext, currentProject: currentProject, workspacePath: workspacePath);
      },
    },
    getters: {
      'isInitialized': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').isInitialized,
      'workspace': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').workspace,
      'workspaceContext': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').workspaceContext,
      'workspacePath': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').workspacePath,
      'cwd': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').cwd,
      'project': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').project,
      'projectInfo': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').projectInfo,
      'groups': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').groups,
      'actions': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').actions,
      'modeDefinitions': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').modeDefinitions,
      'deps': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').deps,
      'depsDev': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').depsDev,
      'workspaceModes': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').workspaceModes,
      'projectTypes': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').projectTypes,
      'pipelines': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').pipelines,
      'customTags': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').customTags,
      'env': (visitor, target) => D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext').env,
    },
    methods: {
      'getProjectInfo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext');
        D4.requireMinArgs(positional, 1, 'getProjectInfo');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getProjectInfo');
        return t.getProjectInfo(name);
      },
      'getGroup': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext');
        D4.requireMinArgs(positional, 1, 'getGroup');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getGroup');
        return t.getGroup(name);
      },
      'getAction': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext');
        D4.requireMinArgs(positional, 1, 'getAction');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getAction');
        return t.getAction(name);
      },
      'getDep': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext');
        D4.requireMinArgs(positional, 1, 'getDep');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getDep');
        return t.getDep(name);
      },
      'getCustomTag': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext');
        D4.requireMinArgs(positional, 1, 'getCustomTag');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'getCustomTag');
        return t.getCustomTag(key);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_build_39.TomContext>(target, 'TomContext');
        return t.toString();
      },
    },
    staticGetters: {
      'current': (visitor) => $tom_build_39.TomContext.current,
    },
    constructorSignatures: {
      '': 'TomContext({required TomWorkspace workspace, Object? workspaceContext, TomProject? currentProject, String? workspacePath})',
    },
    methodSignatures: {
      'getProjectInfo': 'ProjectEntry? getProjectInfo(String name)',
      'getGroup': 'GroupDef? getGroup(String name)',
      'getAction': 'ActionDef? getAction(String name)',
      'getDep': 'String? getDep(String name)',
      'getCustomTag': 'dynamic getCustomTag(String key)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'isInitialized': 'bool get isInitialized',
      'workspace': 'TomWorkspace get workspace',
      'workspaceContext': 'Object? get workspaceContext',
      'workspacePath': 'String get workspacePath',
      'cwd': 'String get cwd',
      'project': 'TomProject? get project',
      'projectInfo': 'Map<String, ProjectEntry> get projectInfo',
      'groups': 'Map<String, GroupDef> get groups',
      'actions': 'Map<String, ActionDef> get actions',
      'modeDefinitions': 'Map<String, ModeDefinitions> get modeDefinitions',
      'deps': 'Map<String, String> get deps',
      'depsDev': 'Map<String, String> get depsDev',
      'workspaceModes': 'WorkspaceModes? get workspaceModes',
      'projectTypes': 'Map<String, ProjectTypeDef> get projectTypes',
      'pipelines': 'Map<String, Pipeline> get pipelines',
      'customTags': 'Map<String, dynamic> get customTags',
      'env': 'Map<String, String> get env',
    },
    staticGetterSignatures: {
      'current': 'TomContext get current',
    },
  );
}


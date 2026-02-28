import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:path/path.dart' as p;

void main() async {
  // Point to the tom_d4rt_flutterm package
  final fluttermPath = p.normalize(p.join(Directory.current.path, '..', 'tom_d4rt_flutterm'));
  print('IncludedPath: $fluttermPath');
  
  final context = AnalysisContextCollection(
    includedPaths: [fluttermPath],
  );
  
  print('Contexts: ${context.contexts.length}');
  
  final anyContext = context.contexts.first;
  final session = anyContext.currentSession;
  
  // Try dart:core for comparison
  final corePath = session.uriConverter.uriToPath(Uri.parse('dart:core'));
  print('dart:core resolved to: $corePath');
  
  // Now try dart:ui
  final path = session.uriConverter.uriToPath(Uri.parse('dart:ui'));
  print('dart:ui resolved to: $path');
}

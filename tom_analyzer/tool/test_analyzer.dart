import 'package:tom_analyzer/tom_analyzer.dart';

void main() async {
  final analyzer = TomAnalyzer();
  final result = await analyzer.analyzeBarrel(
    barrelPath: '/Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_basics/tom_analyzer/lib/tom_analyzer.dart',
  );
  print('Classes: ${result.allClasses.length}');
  print('Functions: ${result.allFunctions.length}');
  print('Variables: ${result.allVariables.length}');
  for (final v in result.allVariables) {
    print('  - ${v.name}');
  }
}

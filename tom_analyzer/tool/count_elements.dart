import 'package:tom_analyzer/tom_analyzer.dart';

void main() async {
  final analyzer = TomAnalyzer();
  final result = await analyzer.analyzeBarrel(
    barrelPath: 'lib/tom_analyzer.dart',
  );
  
  print('=== Static Analyzer Element Counts ===');
  print('Classes: ${result.allClasses.length}');
  print('Enums: ${result.allEnums.length}');
  print('Mixins: ${result.allMixins.length}');
  print('Extensions: ${result.allExtensions.length}');
  print('Functions: ${result.allFunctions.length}');
  
  int methods = 0, getters = 0, setters = 0, fields = 0, constructors = 0;
  for (final cls in result.allClasses) {
    methods = methods + cls.methods.length;
    getters = getters + cls.getters.length;
    setters = setters + cls.setters.length;
    fields = fields + cls.fields.length;
    constructors = constructors + cls.constructors.length;
  }
  
  print('\n=== Class Member Counts ===');
  print('Constructors: $constructors');
  print('Methods: $methods');
  print('Getters: $getters');
  print('Setters: $setters');
  print('Fields: $fields');
  
  final total = result.allClasses.length + 
                result.allEnums.length +
                result.allMixins.length +
                result.allExtensions.length +
                result.allFunctions.length +
                constructors + methods + getters + setters + fields;
  print('\n=== Total Elements ===');
  print('Total: $total');
}

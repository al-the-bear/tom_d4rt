import 'package:tom_analyzer/tom_analyzer.dart';
import 'package:tom_analyzer/src/reflection/reflection_generator.dart' as rg;

void main() async {
  // Test inherited member collection
  final analyzer = TomAnalyzer();
  final result = await analyzer.analyzeBarrel(
    barrelPath: 'test/reflection/fixtures/sample_models.dart',
  );

  print('=== Analyzer Results ===');
  print('Classes: ${result.allClasses.length}');
  print('Mixins: ${result.allMixins.length}');
  print('Extensions: ${result.allExtensions.length}');
  
  // Find TrackedUser which inherits from User and has Trackable mixin
  final trackedUser = result.allClasses.firstWhere(
    (c) => c.name == 'TrackedUser',
    orElse: () => throw 'TrackedUser not found',
  );
  
  print('\n=== TrackedUser ===');
  print('  Name: ${trackedUser.name}');
  print('  Superclass: ${trackedUser.superclass?.qualifiedName}');
  print('  Mixins: ${trackedUser.mixins.map((m) => m.qualifiedName).join(', ')}');
  print('  Own Methods: ${trackedUser.methods.map((m) => m.name).join(', ')}');
  print('  Own Fields: ${trackedUser.fields.map((f) => f.name).join(', ')}');
  print('  Own Getters: ${trackedUser.getters.map((g) => g.name).join(', ')}');

  // Find User to see methods
  final user = result.allClasses.firstWhere(
    (c) => c.name == 'User',
    orElse: () => throw 'User not found',
  );
  
  print('\n=== User (superclass) ===');
  print('  Methods: ${user.methods.map((m) => m.name).join(', ')}');
  print('  Fields: ${user.fields.map((f) => f.name).join(', ')}');
  print('  Getters: ${user.getters.map((g) => g.name).join(', ')}');

  // Find Trackable mixin
  final trackable = result.allMixins.firstWhere(
    (m) => m.name == 'Trackable',
    orElse: () => throw 'Trackable not found',
  );
  
  print('\n=== Trackable (mixin) ===');
  print('  Methods: ${trackable.methods.map((m) => m.name).join(', ')}');
  print('  Fields: ${trackable.fields.map((f) => f.name).join(', ')}');
  
  // Now test reflection generation
  final model = ReflectionModel.fromAnalysis(result);
  final generator = rg.ReflectionGenerator();
  final reflectionCode = generator.generate(model);
  
  // Debug - show first 1000 chars of generated code
  print('\n=== Generated Code (first 1500 chars) ===');
  print(reflectionCode.substring(0, reflectionCode.length > 1500 ? 1500 : reflectionCode.length));
  
  // Check that TrackedUser has inherited methods in the generated code
  // First extract the TrackedUser section
  final trackedUserIdx = reflectionCode.indexOf('TrackedUser');
  if (trackedUserIdx > 0) {
    print('\n=== Context around TrackedUser ===');
    print(reflectionCode.substring(trackedUserIdx - 50, trackedUserIdx + 200));
  }
  
  // Try finding TrackedUser with different patterns
  final patterns = [
    "'sample_models.dart::TrackedUser':",
    "::TrackedUser':",
    ".TrackedUser':",
    "TrackedUser':",
  ];
  
  var trackedUserStart = -1;
  var matchedPattern = '';
  for (final pattern in patterns) {
    trackedUserStart = reflectionCode.indexOf(pattern);
    if (trackedUserStart >= 0) {
      matchedPattern = pattern;
      break;
    }
  }
  
  if (trackedUserStart < 0) {
    print('\n❌ TrackedUser not found in generated code');
    print('Available class keys (first 5):');
    final classMatches = RegExp(r"'[^']+':.*?ta\.ClassDescriptor").allMatches(reflectionCode);
    for (final match in classMatches.take(5)) {
      print('  ${reflectionCode.substring(match.start, match.start + 80)}...');
    }
    return;
  }
  
  print('\nFound TrackedUser with pattern: $matchedPattern');
  
  // Find the end of TrackedUser descriptor
  var depth = 0;
  var started = false;
  var end = trackedUserStart;
  for (var i = trackedUserStart; i < reflectionCode.length; i++) {
    if (reflectionCode[i] == '(') {
      depth++;
      started = true;
    }
    if (reflectionCode[i] == ')') {
      depth--;
      if (started && depth == 0) {
        end = i + 1;
        break;
      }
    }
  }
  
  final trackedUserSection = reflectionCode.substring(trackedUserStart, end);
  
  // Count methods in TrackedUser
  final methodMatches = RegExp(r"'(\w+)': ta\.MethodDescriptor\(").allMatches(trackedUserSection);
  print('\n=== TrackedUser Methods in Generated Code ===');
  for (final match in methodMatches) {
    final methodName = match.group(1);
    // Check if it has declaringClassQualifiedName
    final methodStart = match.start;
    final nextMethodOrEnd = trackedUserSection.indexOf("ta.MethodDescriptor(", methodStart + 10);
    final methodSection = nextMethodOrEnd > 0 
        ? trackedUserSection.substring(methodStart, nextMethodOrEnd)
        : trackedUserSection.substring(methodStart);
    final declaringMatch = RegExp(r"declaringClassQualifiedName: ([^,\n]+)").firstMatch(methodSection);
    final declaringClass = declaringMatch?.group(1) ?? 'null';
    print('  - $methodName (declaringClass: $declaringClass)');
  }
  
  if (trackedUserSection.contains("'isAdult':")) {
    print('\n✅ TrackedUser includes inherited method isAdult from User');
  } else {
    print('\n❌ TrackedUser MISSING inherited method isAdult from User');
  }
  
  if (trackedUserSection.contains("'track':")) {
    print('✅ TrackedUser includes method track from Trackable mixin');
  } else {
    print('❌ TrackedUser MISSING method track from Trackable mixin');
  }
  
  // Print the first 100 lines of TrackedUser section
  print('\n=== TrackedUser Section (first 80 lines) ===');
  print(trackedUserSection.split('\n').take(80).join('\n'));
}

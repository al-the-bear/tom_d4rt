/// D4 Example Package
///
/// This package contains all bridgeable classes for D4rt testing.
/// Due to name conflicts between different example modules, this barrel
/// only exports some modules. For specific modules with conflicts, use
/// direct imports:
///
/// - `package:d4_example/example_project.dart` - example_project classes
/// - `package:d4_example/user_guide.dart` - user_guide classes  
/// - `package:d4_example/user_reference.dart` - user_reference classes
/// - `package:d4_example/userbridge_override.dart` - userbridge_override classes
/// - `package:d4_example/userbridge_user_guide.dart` - userbridge_user_guide classes
/// - `package:d4_example/dart_overview.dart` - dart_overview classes
library;

// Re-export individual module barrels
// Note: These can be imported separately to avoid conflicts
export 'example_project.dart';
export 'test_extensions.dart';

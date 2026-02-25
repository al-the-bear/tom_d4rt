// Simple test script for d4
import 'package:dcli/dcli.dart';

void main() {
  print('Testing d4 with DCli...');
  
  // Test pwd
  print('Current directory: ${pwd}');
  
  // Test exists
  print('Checking if pubspec.yaml exists...');
  if (exists('pubspec.yaml')) {
    print('Found pubspec.yaml');
  } else {
    print('No pubspec.yaml in current dir');
  }
  
  print('Test complete!');
}

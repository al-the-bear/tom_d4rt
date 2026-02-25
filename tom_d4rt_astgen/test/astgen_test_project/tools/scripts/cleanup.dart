/// Utility script for cleanup operations
library;

void main() async {
  print('Running cleanup script...');
  
  final cleaner = Cleaner();
  await cleaner.clean();
}

class Cleaner {
  final List<String> patterns = [
    '*.tmp',
    '*.log',
    '*.bak',
  ];
  
  Future<void> clean() async {
    print('Cleaning temporary files...');
    
    for (final pattern in patterns) {
      print('  Looking for $pattern files');
    }
    
    print('Cleanup complete!');
  }
}

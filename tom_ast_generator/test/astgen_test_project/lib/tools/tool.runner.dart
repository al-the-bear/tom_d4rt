/// Tool runner for data processing
library;

import 'dart:io';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: tool.runner.dart <input-file>');
    exit(1);
  }
  
  final processor = DataProcessor();
  await processor.process(args[0]);
}

class DataProcessor {
  Future<void> process(String filename) async {
    print('Processing file: $filename');
    
    final file = File(filename);
    if (!await file.exists()) {
      throw Exception('File not found: $filename');
    }
    
    final content = await file.readAsString();
    final lines = content.split('\n');
    
    print('Found ${lines.length} lines');
    
    for (var i = 0; i < lines.length; i++) {
      _processLine(i + 1, lines[i]);
    }
  }
  
  void _processLine(int lineNumber, String line) {
    final trimmed = line.trim();
    if (trimmed.isEmpty) return;
    
    print('Line $lineNumber: ${trimmed.length} characters');
  }
}

extension StringExtensions on String {
  bool get isNumeric {
    return double.tryParse(this) != null;
  }
  
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

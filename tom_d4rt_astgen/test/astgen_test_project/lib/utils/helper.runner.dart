/// Helper utilities runner
library;

void main() {
  final helper = StringHelper();
  
  final text = 'hello world';
  print(helper.reverse(text));
  print(helper.wordCount(text));
}

class StringHelper {
  String reverse(String input) {
    return input.split('').reversed.join('');
  }
  
  int wordCount(String input) {
    return input.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
  }
  
  String truncate(String input, int maxLength) {
    if (input.length <= maxLength) return input;
    return '${input.substring(0, maxLength)}...';
  }
}

mixin LoggingMixin {
  void log(String message) {
    print('[${DateTime.now()}] $message');
  }
}

class Logger with LoggingMixin {
  void info(String message) => log('INFO: $message');
  void error(String message) => log('ERROR: $message');
}

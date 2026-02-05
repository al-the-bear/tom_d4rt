import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_log/tom_log.dart';

void main() {
  Logger.setLogLevel(LogLevel.warn);
  const source = '''
extension DateTimeExtension on DateTime {
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
}
void main() {
  var now = DateTime.now();
  print(now.isWeekend);
}
''';
  try {
    execute(source);
    print("SUCCESS");
  } catch (e) {
    print("ERROR: $e");
  }
}

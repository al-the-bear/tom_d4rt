// D4rt test: TOP05 - Interface class
// Verifies interface class and implementors are bridged.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // DataSource is an interface class with default implementation
  var json = JsonDataSource();
  var jsonResult = json.fetch();
  if (jsonResult != 'JSON data from API') {
    errors.add('JsonDataSource.fetch() expected "JSON data from API", got "$jsonResult"');
  }

  var xml = XmlDataSource();
  var xmlResult = xml.fetch();
  if (xmlResult != 'XML data from file') {
    errors.add('XmlDataSource.fetch() expected "XML data from file", got "$xmlResult"');
  }

  if (errors.isEmpty) {
    print('TOP05_PASSED');
  } else {
    print('TOP05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}

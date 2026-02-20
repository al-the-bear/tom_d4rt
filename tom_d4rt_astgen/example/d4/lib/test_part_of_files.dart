/// Test library for GEN-060: Part-of files imported directly bug
/// 
/// This library uses Dart's `part` directive. The generator should import
/// this parent library, NOT the part files directly.
library;

part 'src/part_of_bug/part_callback.dart';
part 'src/part_of_bug/part_data.dart';

/// Main class that uses types from part files.
class PartOfTestService {
  final PartCallback? callback;
  final PartData data;
  
  PartOfTestService({this.callback, required this.data});
  
  void execute() {
    final cb = callback;
    if (cb != null) {
      cb.onData?.call(data);
    }
  }
}

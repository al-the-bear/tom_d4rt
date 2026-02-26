/// Part file for data types - GEN-060 bug reproduction
part of '../../test_part_of_files.dart';

/// Data class defined in a part file.
class PartData {
  final String name;
  final int value;
  
  const PartData(this.name, this.value);
  
  @override
  String toString() => 'PartData($name, $value)';
}

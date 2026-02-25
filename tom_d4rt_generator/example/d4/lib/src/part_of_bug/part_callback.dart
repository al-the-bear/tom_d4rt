/// Part file for callback types - GEN-060 bug reproduction
/// 
/// This file is a `part of` the parent library. The generator MUST NOT
/// generate an import for this file directly.
part of '../../test_part_of_files.dart';

/// Callback class defined in a part file.
class PartCallback {
  final void Function(PartData data)? onData;
  final void Function(String error)? onError;
  
  const PartCallback({this.onData, this.onError});
  
  /// Factory constructor that creates a callback for data only.
  factory PartCallback.dataOnly(void Function(PartData data) handler) {
    return PartCallback(onData: handler);
  }
}

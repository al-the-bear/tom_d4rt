import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'typed_data/bytes_builder.dart';
import 'typed_data/endian.dart';
import 'typed_data/byte_buffer.dart';
import 'typed_data/uint8_list.dart';
import 'typed_data/byte_data.dart';
import 'typed_data/int8_list.dart';
import 'typed_data/int16_list.dart';
import 'typed_data/int32_list.dart';
import 'typed_data/int64_list.dart';
import 'typed_data/uint16_list.dart';
import 'typed_data/uint32_list.dart';
import 'typed_data/uint64_list.dart';
import 'typed_data/uint8_clamped_list.dart';
import 'typed_data/float32_list.dart';
import 'typed_data/float64_list.dart';
import 'typed_data/typed_data.dart';
import 'typed_data/typed_data_hierarchy.dart';

class TypedDataStdlib {
  static void register(Environment environment) {
    environment.defineBridge(TypedDataTypedData.definition);
    environment.defineBridge(BytesBuilderTypedData.definition);
    environment.defineBridge(EndianTypedData.definition);
    environment.defineBridge(ByteBufferTypedData.definition);
    environment.defineBridge(Uint8ListTypedData.definition);
    environment.defineBridge(ByteDataTypedData.definition);
    environment.defineBridge(Int8ListTypedData.definition);
    environment.defineBridge(Int16ListTypedData.definition);
    environment.defineBridge(Int32ListTypedData.definition);
    environment.defineBridge(Int64ListTypedData.definition);
    environment.defineBridge(Uint16ListTypedData.definition);
    environment.defineBridge(Uint32ListTypedData.definition);
    environment.defineBridge(Uint64ListTypedData.definition);
    environment.defineBridge(Uint8ClampedListTypedData.definition);
    environment.defineBridge(Float32ListTypedData.definition);
    environment.defineBridge(Float64ListTypedData.definition);
    // Edges last: the registry keys on name, so every bridge above must be
    // defined before the hierarchy that refers to them. `List` and `Iterable`
    // come from `CoreStdlib`, which `Stdlib.register` runs first.
    TypedDataHierarchyTypedData.register();
  }
}

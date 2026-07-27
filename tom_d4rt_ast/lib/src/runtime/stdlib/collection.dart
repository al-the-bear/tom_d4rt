import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/hash_map.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/hash_set.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/linked_hash_map.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/linked_hash_set.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/linked_list.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/list_queue.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/queue.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/splay_tree_map.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/splay_tree_set.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/unmodifiable_list_view.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/unmodifiable_map_view.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/unmodifiable_set_view.dart';

class CollectionStdlib {
  static void register(Environment environment) {
    environment.defineBridge(HashMapCollection.definition);
    environment.defineBridge(HashSetCollection.definition);
    environment.defineBridge(LinkedHashMapCollection.definition);
    environment.defineBridge(LinkedHashSetCollection.definition);
    environment.defineBridge(LinkedListCollection.definition);
    environment.defineBridge(LinkedListEntryCollection.definition);
    environment.defineBridge(ListQueueCollection.definition);
    environment.defineBridge(QueueCollection.definition);
    environment.defineBridge(SplayTreeMapCollection.definition);
    environment.defineBridge(SplayTreeSetCollection.definition);
    environment.defineBridge(UnmodifiableListViewCollection.definition);
    environment.defineBridge(UnmodifiableMapViewCollection.definition);
    environment.defineBridge(UnmodifiableSetViewCollection.definition);
  }
}

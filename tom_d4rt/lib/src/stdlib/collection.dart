import 'package:tom_d4rt/src/environment.dart';
import 'package:tom_d4rt/src/stdlib/collection/collection_hierarchy.dart';
import 'package:tom_d4rt/src/stdlib/collection/double_linked_queue.dart';
import 'package:tom_d4rt/src/stdlib/collection/hash_map.dart';
import 'package:tom_d4rt/src/stdlib/collection/hash_set.dart';
import 'package:tom_d4rt/src/stdlib/collection/linked_hash_map.dart';
import 'package:tom_d4rt/src/stdlib/collection/linked_hash_set.dart';
import 'package:tom_d4rt/src/stdlib/collection/linked_list.dart';
import 'package:tom_d4rt/src/stdlib/collection/list_queue.dart';
import 'package:tom_d4rt/src/stdlib/collection/queue.dart';
import 'package:tom_d4rt/src/stdlib/collection/splay_tree_map.dart';
import 'package:tom_d4rt/src/stdlib/collection/splay_tree_set.dart';
import 'package:tom_d4rt/src/stdlib/collection/unmodifiable_list_view.dart';
import 'package:tom_d4rt/src/stdlib/collection/unmodifiable_map_view.dart';
import 'package:tom_d4rt/src/stdlib/collection/unmodifiable_set_view.dart';

class CollectionStdlib {
  static void register(Environment environment) {
    environment.defineBridge(DoubleLinkedQueueCollection.definition);
    environment.defineBridge(DoubleLinkedQueueEntryCollection.definition);
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
    // After the bridges: the registry keys on NAME, so the edges are only
    // useful once the classes they name are registered.
    CollectionHierarchyCollection.register();
  }
}

/// D4 Complete Bridge Example
///
/// A complete example demonstrating all D4 helper methods working together
/// in a realistic bridged service. This shows best practices for creating
/// robust bridges that handle edge cases gracefully.
///
/// Run with: dart run example/advanced_bridging/d4_complete_bridge_example.dart
library;

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

// =============================================================================
// Domain Classes
// =============================================================================

/// Task priority levels.
enum Priority { low, medium, high, critical }

/// A task with various field types.
class Task {
  final int id;
  final String title;
  String? description;
  Priority priority;
  bool completed;
  DateTime? dueDate;
  List<String> tags;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.priority = Priority.medium,
    this.completed = false,
    this.dueDate,
    List<String>? tags,
  }) : tags = tags ?? [];

  void complete() {
    completed = true;
  }

  void addTag(String tag) {
    if (!tags.contains(tag)) {
      tags.add(tag);
    }
  }

  bool hasTag(String tag) => tags.contains(tag);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.name,
      'completed': completed,
      'dueDate': dueDate?.toIso8601String(),
      'tags': tags,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      priority: Priority.values.firstWhere(
        (p) => p.name == map['priority'],
        orElse: () => Priority.medium,
      ),
      completed: map['completed'] as bool? ?? false,
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'] as String)
          : null,
      tags: (map['tags'] as List?)?.cast<String>() ?? [],
    );
  }

  @override
  String toString() => 'Task(#$id: $title, ${priority.name}, '
      '${completed ? "✓" : "○"}, tags: $tags)';
}

/// Task manager service.
class TaskManager {
  final List<Task> _tasks = [];
  int _nextId = 1;

  /// Create a new task.
  Task create({
    required String title,
    String? description,
    Priority priority = Priority.medium,
    DateTime? dueDate,
    List<String>? tags,
  }) {
    final task = Task(
      id: _nextId++,
      title: title,
      description: description,
      priority: priority,
      dueDate: dueDate,
      tags: tags,
    );
    _tasks.add(task);
    return task;
  }

  /// Get all tasks.
  List<Task> get all => List.unmodifiable(_tasks);

  /// Get pending tasks.
  List<Task> get pending => _tasks.where((t) => !t.completed).toList();

  /// Get completed tasks.
  List<Task> get completedTasks => _tasks.where((t) => t.completed).toList();

  /// Get tasks by priority.
  List<Task> byPriority(Priority priority) {
    return _tasks.where((t) => t.priority == priority).toList();
  }

  /// Get tasks by tag.
  List<Task> byTag(String tag) {
    return _tasks.where((t) => t.hasTag(tag)).toList();
  }

  /// Find a task by ID.
  Task? findById(int id) {
    try {
      return _tasks.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Complete a task by ID.
  bool completeById(int id) {
    final task = findById(id);
    if (task != null) {
      task.complete();
      return true;
    }
    return false;
  }

  /// Get task count by priority.
  Map<String, int> countByPriority() {
    final counts = <String, int>{};
    for (final p in Priority.values) {
      counts[p.name] = _tasks.where((t) => t.priority == p).length;
    }
    return counts;
  }
}

// =============================================================================
// Bridge Implementation
// =============================================================================

/// Bridge for Priority enum.
BridgedEnumDefinition<Priority> createPriorityBridge() {
  return BridgedEnumDefinition<Priority>(
    name: 'Priority',
    values: Priority.values,
    getters: {
      'name': (visitor, target) => (target as Priority).name,
      'index': (visitor, target) => (target as Priority).index,
    },
  );
}

/// Bridge for Task class.
BridgedClass createTaskBridge() {
  return BridgedClass(
    nativeType: Task,
    name: 'Task',
    constructors: {
      '': (visitor, positional, named) {
        // Required named argument
        final id = D4.getRequiredNamedArg<int>(named, 'id', 'Task');
        final title = D4.getRequiredNamedArg<String>(named, 'title', 'Task');

        // Optional named arguments
        final description = D4.getOptionalNamedArg<String?>(named, 'description');
        final priority = D4.getOptionalNamedArg<Priority?>(named, 'priority');
        final completed = D4.getOptionalNamedArg<bool?>(named, 'completed');
        final dueDate = D4.getOptionalNamedArg<DateTime?>(named, 'dueDate');

        // List parameter - needs coercion
        List<String>? tags;
        if (named.containsKey('tags') && named['tags'] != null) {
          tags = D4.coerceList<String>(named['tags'], 'tags');
        }

        return Task(
          id: id,
          title: title,
          description: description,
          priority: priority ?? Priority.medium,
          completed: completed ?? false,
          dueDate: dueDate,
          tags: tags,
        );
      },
      'fromMap': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Task.fromMap');
        final map = D4.coerceMap<String, dynamic>(positional[0], 'map');
        return Task.fromMap(map);
      },
    },
    getters: {
      'id': (visitor, target) => D4.validateTarget<Task>(target, 'Task').id,
      'title': (visitor, target) =>
          D4.validateTarget<Task>(target, 'Task').title,
      'description': (visitor, target) =>
          D4.validateTarget<Task>(target, 'Task').description,
      'priority': (visitor, target) =>
          D4.validateTarget<Task>(target, 'Task').priority,
      'completed': (visitor, target) =>
          D4.validateTarget<Task>(target, 'Task').completed,
      'dueDate': (visitor, target) =>
          D4.validateTarget<Task>(target, 'Task').dueDate,
      'tags': (visitor, target) => D4.validateTarget<Task>(target, 'Task').tags,
    },
    setters: {
      'description': (visitor, target, value) =>
          D4.validateTarget<Task>(target, 'Task').description = value as String?,
      'priority': (visitor, target, value) =>
          D4.validateTarget<Task>(target, 'Task').priority = value as Priority,
    },
    methods: {
      'complete': (visitor, target, positional, named, typeArgs) {
        D4.validateTarget<Task>(target, 'Task').complete();
        return null;
      },
      'addTag': (visitor, target, positional, named, typeArgs) {
        final task = D4.validateTarget<Task>(target, 'Task');
        final tag = D4.getRequiredArg<String>(positional, 0, 'tag', 'addTag');
        task.addTag(tag);
        return null;
      },
      'hasTag': (visitor, target, positional, named, typeArgs) {
        final task = D4.validateTarget<Task>(target, 'Task');
        final tag = D4.getRequiredArg<String>(positional, 0, 'tag', 'hasTag');
        return task.hasTag(tag);
      },
      'toMap': (visitor, target, positional, named, typeArgs) {
        return D4.validateTarget<Task>(target, 'Task').toMap();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        return D4.validateTarget<Task>(target, 'Task').toString();
      },
    },
    constructorSignatures: {
      '': 'Task({required int id, required String title, String? description, '
          'Priority priority = Priority.medium, bool completed = false, '
          'DateTime? dueDate, List<String>? tags})',
      'fromMap': 'factory Task.fromMap(Map<String, dynamic> map)',
    },
    methodSignatures: {
      'complete': 'void complete()',
      'addTag': 'void addTag(String tag)',
      'hasTag': 'bool hasTag(String tag)',
      'toMap': 'Map<String, dynamic> toMap()',
    },
  );
}

/// Bridge for TaskManager class.
BridgedClass createTaskManagerBridge() {
  return BridgedClass(
    nativeType: TaskManager,
    name: 'TaskManager',
    constructors: {
      '': (visitor, positional, named) => TaskManager(),
    },
    getters: {
      'all': (visitor, target) =>
          D4.validateTarget<TaskManager>(target, 'TaskManager').all,
      'pending': (visitor, target) =>
          D4.validateTarget<TaskManager>(target, 'TaskManager').pending,
      'completedTasks': (visitor, target) =>
          D4.validateTarget<TaskManager>(target, 'TaskManager').completedTasks,
    },
    methods: {
      'create': (visitor, target, positional, named, typeArgs) {
        final manager =
            D4.validateTarget<TaskManager>(target, 'TaskManager');

        // Required named argument
        final title =
            D4.getRequiredNamedArg<String>(named, 'title', 'create');

        // Optional named arguments
        final description =
            D4.getOptionalNamedArg<String?>(named, 'description');
        final priority = D4.getOptionalNamedArg<Priority?>(named, 'priority');
        final dueDate = D4.getOptionalNamedArg<DateTime?>(named, 'dueDate');

        // List parameter - needs coercion if provided
        List<String>? tags;
        if (named.containsKey('tags') && named['tags'] != null) {
          tags = D4.coerceList<String>(named['tags'], 'tags');
        }

        return manager.create(
          title: title,
          description: description,
          priority: priority ?? Priority.medium,
          dueDate: dueDate,
          tags: tags,
        );
      },
      'byPriority': (visitor, target, positional, named, typeArgs) {
        final manager =
            D4.validateTarget<TaskManager>(target, 'TaskManager');
        final priority =
            D4.getRequiredArg<Priority>(positional, 0, 'priority', 'byPriority');
        return manager.byPriority(priority);
      },
      'byTag': (visitor, target, positional, named, typeArgs) {
        final manager =
            D4.validateTarget<TaskManager>(target, 'TaskManager');
        final tag = D4.getRequiredArg<String>(positional, 0, 'tag', 'byTag');
        return manager.byTag(tag);
      },
      'findById': (visitor, target, positional, named, typeArgs) {
        final manager =
            D4.validateTarget<TaskManager>(target, 'TaskManager');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'findById');
        return manager.findById(id);
      },
      'completeById': (visitor, target, positional, named, typeArgs) {
        final manager =
            D4.validateTarget<TaskManager>(target, 'TaskManager');
        final id = D4.getRequiredArg<int>(positional, 0, 'id', 'completeById');
        return manager.completeById(id);
      },
      'countByPriority': (visitor, target, positional, named, typeArgs) {
        return D4
            .validateTarget<TaskManager>(target, 'TaskManager')
            .countByPriority();
      },
    },
    methodSignatures: {
      'create': 'Task create({required String title, String? description, '
          'Priority priority = Priority.medium, DateTime? dueDate, List<String>? tags})',
      'byPriority': 'List<Task> byPriority(Priority priority)',
      'byTag': 'List<Task> byTag(String tag)',
      'findById': 'Task? findById(int id)',
      'completeById': 'bool completeById(int id)',
      'countByPriority': 'Map<String, int> countByPriority()',
    },
  );
}

// =============================================================================
// Demonstration
// =============================================================================

void main() async {
  print('D4 Complete Bridge Example');
  print('=' * 60);

  final d4rt = D4rt();

  // Register all bridges
  d4rt.registerBridgedEnum(createPriorityBridge(), 'package:example/example.dart');
  d4rt.registerBridgedClass(createTaskBridge(), 'package:example/example.dart');
  d4rt.registerBridgedClass(createTaskManagerBridge(), 'package:example/example.dart');

  final script = '''
import 'package:example/example.dart';

void main() {
  final manager = TaskManager();
  
  // Create tasks with various parameters
  print('Creating tasks...');
  
  final task1 = manager.create(
    title: 'Review pull requests',
    priority: Priority.high,
    tags: ['code', 'review'],
  );
  
  final task2 = manager.create(
    title: 'Write documentation',
    description: 'Document the D4 helper class',
    priority: Priority.medium,
    tags: ['docs', 'important'],
  );
  
  final task3 = manager.create(
    title: 'Fix critical bug',
    priority: Priority.critical,
    tags: ['bug', 'urgent'],
  );
  
  final task4 = manager.create(
    title: 'Clean up old code',
    priority: Priority.low,
    tags: ['cleanup', 'code'],
  );
  
  // Display all tasks
  print('\\nAll tasks:');
  for (final task in manager.all) {
    print('  \$task');
  }
  
  // Filter by priority
  print('\\nCritical tasks:');
  for (final task in manager.byPriority(Priority.critical)) {
    print('  \$task');
  }
  
  // Filter by tag
  print('\\nTasks with "code" tag:');
  for (final task in manager.byTag('code')) {
    print('  \$task');
  }
  
  // Complete some tasks
  print('\\nCompleting tasks...');
  manager.completeById(1);
  manager.completeById(3);
  
  print('\\nPending tasks:');
  for (final task in manager.pending) {
    print('  \$task');
  }
  
  print('\\nCompleted tasks:');
  for (final task in manager.completedTasks) {
    print('  \$task');
  }
  
  // Count by priority
  print('\\nTask count by priority:');
  final counts = manager.countByPriority();
  for (final entry in counts.entries) {
    print('  \${entry.key}: \${entry.value}');
  }
  
  // Convert to map
  print('\\nTask as map:');
  final taskMap = task2.toMap();
  print('  \$taskMap');
  
  // Create from map
  print('\\nTask from map:');
  final recreated = Task.fromMap(taskMap);
  print('  \$recreated');
}
''';

  print('\nExecuting script...\n');
  await d4rt.execute(source: script);

  print('\n' + '=' * 60);
  print('Example completed!');
}

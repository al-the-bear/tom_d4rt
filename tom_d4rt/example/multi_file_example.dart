// Example: Multi-File Execution
// From: doc/d4rt_user_guide.md - Multi-File Execution
//
// This example shows how to execute scripts that span multiple files
// using the library and sources parameters.

import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Multi-file execution using library and sources parameters
  print('=== Multi-File Execution ===');
  final result = d4rt.execute(
    library: 'package:my_app/main.dart',
    sources: {
      'package:my_app/main.dart': '''
        import 'package:my_app/utils.dart';
        import 'package:my_app/models.dart';
        
        void main() {
          final user = User('Alice', 30);
          print(greet(user.name));
          print(formatAge(user.age));
        }
        
        String run() {
          final user = User('Bob', 25);
          return greet(user.name);
        }
      ''',
      'package:my_app/utils.dart': '''
        String greet(String name) => "Hello \$name!";
        String formatAge(int age) => "Age: \$age years";
      ''',
      'package:my_app/models.dart': '''
        class User {
          final String name;
          final int age;
          User(this.name, this.age);
        }
      ''',
    },
    name: 'run',
  );
  print('Result: $result'); // Hello Bob!
}

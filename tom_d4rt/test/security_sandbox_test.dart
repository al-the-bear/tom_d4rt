import 'dart:io' as io;
import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

void main() {
  // Cleanup files after each test
  tearDown(() {
    final testFiles = [
      'test.txt',
      'data.txt',
      'test_write.txt',
      'test_read.txt',
      'output.txt',
      'config.json',
      'log.txt',
      'temp_data.txt'
    ];
    for (final fileName in testFiles) {
      final file = io.File(fileName);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  });

  group('Real File Operations - No Permission', () {
    test('I-NET-8: Reading a file fails without permission. [2026-02-10 06:37] (PASS)', () {
      // Create a real file
      io.File('test.txt').writeAsStringSync('secret content');

      final interpreter = D4rt();
      expect(
        () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            var content = File('test.txt').readAsStringSync();
            print(content);
          }
        '''),
        throwsA(isA<RuntimeD4rtException>().having((e) => e.message, 'message',
            contains('dart:io requires FilesystemPermission'))),
      );
    });

    test('I-NET-13: Writing a file fails without permission. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      expect(
        () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            File('test_write.txt').writeAsStringSync('attempting to write');
          }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
      );

      // Verify file was not created
      expect(io.File('test_write.txt').existsSync(), isFalse);
    });

    test('I-NET-20: Deleting a file fails without permission. [2026-02-10 06:37] (PASS)', () {
      io.File('test.txt').writeAsStringSync('to be deleted');

      final interpreter = D4rt();
      expect(
        () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            File('test.txt').deleteSync();
          }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
      );

      // Verify file still exists
      expect(io.File('test.txt').existsSync(), isTrue);
    });
  });

  group('Real File Operations - With Permission', () {
    test('I-NET-29: Reading a file succeeds with read permission. [2026-02-10 06:37] (PASS)', () {
      io.File('test.txt').writeAsStringSync('Hello from file!');

      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.read);

      final result = interpreter.execute(source: '''
        import 'dart:io';
        String main() {
          var content = File('test.txt').readAsStringSync();
          return content;
        }
      ''');

      expect(result, equals('Hello from file!'));
    });

    test('I-NET-30: Writing a file succeeds with write permission. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.write);

      interpreter.execute(source: '''
        import 'dart:io';
        void main() {
          File('output.txt').writeAsStringSync('Generated content');
        }
      ''');

      // Verify file was actually created with correct content
      expect(io.File('output.txt').existsSync(), isTrue);
      expect(io.File('output.txt').readAsStringSync(),
          equals('Generated content'));
    });

    test('I-NET-1: Complex file operations with full permission. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      final result = interpreter.execute(source: '''
        import 'dart:io';
        String main() {
          // Write initial data
          File('data.txt').writeAsStringSync('Line 1\\nLine 2\\nLine 3');
          
          // Read and process
          var content = File('data.txt').readAsStringSync();
          var lines = content.split('\\n');
          var processed = lines.map((l) => l.toUpperCase()).join('\\n');
          
          // Write processed data
          File('data.txt').writeAsStringSync(processed);
          
          // Read final result
          return File('data.txt').readAsStringSync();
        }
      ''');

      expect(result, equals('LINE 1\nLINE 2\nLINE 3'));
    });
  });

  group('Real Directory Operations', () {
    test('I-NET-2: Listing directory contents with permission. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      // Create some test files
      io.File('test1.txt').writeAsStringSync('test1');
      io.File('test2.txt').writeAsStringSync('test2');

      final result = interpreter.execute(source: '''
        import 'dart:io';
        int main() {
          var files = Directory('.').listSync();
          var txtFiles = files.where((f) => f.path.endsWith('.txt')).toList();
          return txtFiles.length;
        }
      ''');

      expect(result, greaterThanOrEqualTo(2));

      // Cleanup
      io.File('test1.txt').deleteSync();
      io.File('test2.txt').deleteSync();
    });

    test('I-NET-3: Directory operations without permission fail. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();

      expect(
        () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            Directory('.').listSync();
          }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });

  group('Real Process Execution', () {
    test('I-NET-4: Running echo command with permission. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(ProcessRunPermission.any);
      interpreter.grant(FilesystemPermission.any);

      final result = interpreter.execute(source: '''
        import 'dart:io';
        String main() {
          var process = Process.runSync('echo', ['Hello Process']);
          return process.stdout.toString().trim();
        }
      ''');

      expect(result, contains('Hello Process'));
    });

    test('I-NET-5: Process execution without permission fails. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any); // IO needed but not process

      expect(
        () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            Process.runSync('echo', ['test']);
          }
        '''),
        throwsA(isA<RuntimeD4rtException>().having(
            (e) => e.message, 'message', contains('ProcessRunPermission'))),
      );
    });
  });

  group('Complex Real-World Scenarios', () {
    test('I-NET-6: Config file processor with read/write permissions. [2026-02-10 06:37] (PASS)', () {
      // Setup: Create a config file
      io.File('config.json')
          .writeAsStringSync('{"setting": "value", "count": 10}');

      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.read);
      interpreter.grant(FilesystemPermission.write);

      final result = interpreter.execute(source: '''
        import 'dart:io';
        import 'dart:convert';
        
        String main() {
          // Read config
          var configContent = File('config.json').readAsStringSync();
          var config = jsonDecode(configContent);
          
          // Modify config
          config['count'] = config['count'] + 1;
          config['lastModified'] = 'test';
          
          // Write back
          File('config.json').writeAsStringSync(jsonEncode(config));
          
          // Verify
          var newContent = File('config.json').readAsStringSync();
          var newConfig = jsonDecode(newContent);
          return 'Count is now: \${newConfig['count']}';
        }
      ''');

      expect(result, equals('Count is now: 11'));

      // Verify the file was actually modified
      final fileContent = io.File('config.json').readAsStringSync();
      expect(fileContent, contains('"count":11'));
      expect(fileContent, contains('lastModified'));
    });

    test('I-NET-7: Log file aggregator - read multiple files, write summary. [2026-02-10 06:37] (PASS)', () {
      // Setup: Create multiple log files
      io.File('log1.txt')
          .writeAsStringSync('ERROR: Connection failed\nINFO: Starting\n');
      io.File('log2.txt')
          .writeAsStringSync('ERROR: Timeout\nWARN: Slow response\n');

      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      final result = interpreter.execute(source: '''
        import 'dart:io';
        
        int main() {
          var log1 = File('log1.txt').readAsStringSync();
          var log2 = File('log2.txt').readAsStringSync();
          
          var allLogs = log1 + log2;
          var errors = allLogs.split('\\n')
                              .where((line) => line.startsWith('ERROR:'))
                              .toList();
          
          var summary = 'Total errors: \${errors.length}\\n';
          summary += errors.join('\\n');
          
          File('error_summary.txt').writeAsStringSync(summary);
          
          return errors.length;
        }
      ''');

      expect(result, equals(2));
      expect(io.File('error_summary.txt').existsSync(), isTrue);

      final summary = io.File('error_summary.txt').readAsStringSync();
      expect(summary, contains('Total errors: 2'));
      expect(summary, contains('Connection failed'));
      expect(summary, contains('Timeout'));

      // Cleanup
      io.File('log1.txt').deleteSync();
      io.File('log2.txt').deleteSync();
      io.File('error_summary.txt').deleteSync();
    });

    test('I-NET-9: Data transformation pipeline. [2026-02-10 06:37] (PASS)', () {
      // Create input data
      io.File('input.txt')
          .writeAsStringSync('apple\nbanana\ncherry\napple\nbanana');

      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      final result = interpreter.execute(source: '''
        import 'dart:io';
        
        Map<String, int> main() {
          var content = File('input.txt').readAsStringSync();
          var words = content.split('\\n').where((w) => w.isNotEmpty).toList();
          
          // Count occurrences
          Map<String, int> counts = {};
          for (var word in words) {
            counts[word] = (counts[word] ?? 0) + 1;
          }
          
          // Write results
          var output = '';
          counts.forEach((word, count) {
            output += '\$word: \$count\\n';
          });
          File('output.txt').writeAsStringSync(output);
          
          return counts;
        }
      ''');

      expect(result, isA<Map>());
      expect(result['apple'], equals(2));
      expect(result['banana'], equals(2));
      expect(result['cherry'], equals(1));

      // Verify output file
      final output = io.File('output.txt').readAsStringSync();
      expect(output, contains('apple: 2'));
      expect(output, contains('banana: 2'));
      expect(output, contains('cherry: 1'));

      // Cleanup
      io.File('input.txt').deleteSync();
    });

    test('I-NET-10: File backup system. [2026-02-10 06:37] (PASS)', () {
      // Create original file
      io.File('important.txt')
          .writeAsStringSync('Important data\nDo not lose!');

      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      interpreter.execute(source: '''
        import 'dart:io';
        
        void main() {
          var original = File('important.txt');
          var content = original.readAsStringSync();
          
          // Create backup
          var backup = File('important.txt.backup');
          backup.writeAsStringSync(content);
          
          // Modify original
          original.writeAsStringSync(content + '\\nModified!');
        }
      ''');

      // Verify both files exist with correct content
      expect(io.File('important.txt').existsSync(), isTrue);
      expect(io.File('important.txt.backup').existsSync(), isTrue);

      final original = io.File('important.txt').readAsStringSync();
      final backup = io.File('important.txt.backup').readAsStringSync();

      expect(original, contains('Modified!'));
      expect(backup, isNot(contains('Modified!')));
      expect(backup, equals('Important data\nDo not lose!'));

      // Cleanup
      io.File('important.txt').deleteSync();
      io.File('important.txt.backup').deleteSync();
    });
  });

  group('Multi-Module Real Scenarios', () {
    test('I-NET-11: Module importing with file operations. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      final result = interpreter.execute(
        sources: {
          'package:app/main.dart': '''
            import 'dart:io';
            import 'package:app/file_utils.dart';
            
            String main() {
              writeData('test.txt', 'Hello from main');
              return readData('test.txt');
            }
          ''',
          'package:app/file_utils.dart': '''
            import 'dart:io';
            
            void writeData(String filename, String content) {
              File(filename).writeAsStringSync(content);
            }
            
            String readData(String filename) {
              return File(filename).readAsStringSync();
            }
          '''
        },
        library: 'package:app/main.dart',
      );

      expect(result, equals('Hello from main'));
      expect(io.File('test.txt').readAsStringSync(), equals('Hello from main'));
    });

    test('I-NET-12: Complex data processing across modules. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      // Setup input data
      io.File('numbers.txt').writeAsStringSync('10\n20\n30\n40\n50');

      final result = interpreter.execute(
        sources: {
          'package:stats/main.dart': '''
            import 'dart:io';
            import 'package:stats/reader.dart';
            import 'package:stats/calculator.dart';
            
            String main() {
              var numbers = readNumbers('numbers.txt');
              var avg = calculateAverage(numbers);
              var sum = calculateSum(numbers);
              
              var report = 'Sum: \$sum, Average: \$avg';
              File('report.txt').writeAsStringSync(report);
              
              return report;
            }
          ''',
          'package:stats/reader.dart': '''
            import 'dart:io';
            
            List<int> readNumbers(String filename) {
              var content = File(filename).readAsStringSync();
              return content.split('\\n')
                           .where((s) => s.isNotEmpty)
                           .map((s) => int.parse(s))
                           .toList();
            }
          ''',
          'package:stats/calculator.dart': '''
            double calculateAverage(List<int> numbers) {
              return calculateSum(numbers) / numbers.length;
            }
            
            int calculateSum(List<int> numbers) {
              return numbers.fold(0, (sum, n) => sum + n);
            }
          '''
        },
        library: 'package:stats/main.dart',
      );

      expect(result, contains('Sum: 150'));
      expect(result, contains('Average: 30.0'));

      final report = io.File('report.txt').readAsStringSync();
      expect(report, equals('Sum: 150, Average: 30.0'));

      // Cleanup
      io.File('numbers.txt').deleteSync();
      io.File('report.txt').deleteSync();
    });
  });

  group('Permission Revocation - Real Impact', () {
    test('I-NET-14: Permission revocation prevents further operations. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      // First operation succeeds
      interpreter.execute(source: '''
        import 'dart:io';
        void main() {
          File('test.txt').writeAsStringSync('first write');
        }
      ''');

      expect(io.File('test.txt').existsSync(), isTrue);

      // Revoke permission
      interpreter.revoke(FilesystemPermission.any);

      // Second operation fails
      expect(
        () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            File('test.txt').writeAsStringSync('second write');
          }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
      );

      // Verify file still has first content
      expect(io.File('test.txt').readAsStringSync(), equals('first write'));
    });
  });

  group('Safe Operations Without Permissions', () {
    test('I-NET-15: Pure computation works without any permissions. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();

      final result = interpreter.execute(source: '''
        int main() {
          List<int> numbers = [1, 2, 3, 4, 5];
          return numbers.fold(0, (sum, n) => sum + n);
        }
      ''');

      expect(result, equals(15));
    });

    test('I-NET-16: String processing works without permissions. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();

      final result = interpreter.execute(source: '''
        String main() {
          var text = 'hello world';
          return text.split(' ').map((w) => w.toUpperCase()).join('-');
        }
      ''');

      expect(result, equals('HELLO-WORLD'));
    });

    test('I-NET-17: Complex data structures work without permissions. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();

      final result = interpreter.execute(source: '''
        Map<String, dynamic> main() {
          var data = {
            'users': [
              {'name': 'Alice', 'age': 30},
              {'name': 'Bob', 'age': 25},
            ]
          };
          
          var users = data['users'] as List;
          var totalAge = users.fold(0, (sum, user) => sum + user['age']);
          
          return {
            'totalUsers': users.length,
            'averageAge': totalAge / users.length,
            'names': users.map((u) => u['name']).toList(),
          };
        }
      ''');

      expect(result['totalUsers'], equals(2));
      expect(result['averageAge'], equals(27.5));
      expect(result['names'], equals(['Alice', 'Bob']));
    });
  });

  group('Network Permission Scenarios', () {
    test('I-NET-18: Network lookup requires permission. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);
      // No network permission

      expect(
        () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            InternetAddress.lookup('localhost');
          }
        '''),
        throwsA(isA<RuntimeD4rtException>().having(
            (e) => e.message, 'message', contains('NetworkPermission'))),
      );
    });
  });

  group('Error Handling in Sandboxed Environment', () {
    group('NetworkPermission - Real Tests', () {
      test('I-NET-19: Network fails without permission. [2026-02-10 06:37] (PASS)', () {
        final interpreter = D4rt();
        interpreter.grant(FilesystemPermission.any);

        expect(
          () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            InternetAddress.lookup('google.com');
          }
        '''),
          throwsA(isA<RuntimeD4rtException>().having(
              (e) => e.message, 'message', contains('NetworkPermission'))),
        );
      });

      test('I-NET-21: Network succeeds with NetworkPermission.any. [2026-02-10 06:37] (PASS)', () async {
        final interpreter = D4rt();
        interpreter.grant(FilesystemPermission.any);
        interpreter.grant(NetworkPermission.any);

        final result = interpreter.execute(source: '''
        import 'dart:io';
        Future<bool> main() async {
          var addresses = await InternetAddress.lookup('localhost');
          return addresses.isNotEmpty;
        }
      ''');

        expect(await result, isTrue);
      });
    });

    group('ProcessRunPermission - Real Tests', () {
      test('I-NET-22: Process fails without permission. [2026-02-10 06:37] (PASS)', () {
        final interpreter = D4rt();
        interpreter.grant(FilesystemPermission.any);

        expect(
          () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            Process.runSync('echo', ['test']);
          }
        '''),
          throwsA(isA<RuntimeD4rtException>().having(
              (e) => e.message, 'message', contains('ProcessRunPermission'))),
        );
      });

      test('I-NET-23: Echo with ProcessRunPermission.any. [2026-02-10 06:37] (PASS)', () {
        final interpreter = D4rt();
        interpreter.grant(FilesystemPermission.any);
        interpreter.grant(ProcessRunPermission.any);

        final result = interpreter.execute(source: '''
        import 'dart:io';
        String main() {
          var proc = Process.runSync('echo', ['Hello', 'World']);
          return proc.stdout.toString().trim();
        }
      ''');

        expect(result, contains('Hello'));
        expect(result, contains('World'));
      });

      test('I-NET-24: Pwd command. [2026-02-10 06:37] (PASS)', () {
        final interpreter = D4rt();
        interpreter.grant(FilesystemPermission.any);
        interpreter.grant(ProcessRunPermission.any);

        final result = interpreter.execute(source: '''
        import 'dart:io';
        String main() {
          var proc = Process.runSync('pwd', []);
          return proc.stdout.toString().trim();
        }
      ''');

        expect(result, isNotEmpty);
        expect(result, contains('/'));
      });
    });

    group('DangerousPermission - Real Tests', () {
      test('I-NET-25: Platform access with DangerousPermission.any. [2026-02-10 06:37] (PASS)', () {
        final interpreter = D4rt();
        interpreter.grant(FilesystemPermission.any);
        interpreter.grant(DangerousPermission.any);

        final result = interpreter.execute(source: '''
        import 'dart:io';
        String main() {
          return Platform.operatingSystem;
        }
      ''');

        expect(result, isIn(['macos', 'linux', 'windows', 'android', 'ios']));
      });

      test('I-NET-26: Environment variables. [2026-02-10 06:37] (PASS)', () {
        final interpreter = D4rt();
        interpreter.grant(FilesystemPermission.any);
        interpreter.grant(DangerousPermission.any);

        final result = interpreter.execute(source: '''
        import 'dart:io';
        int main() {
          var env = Platform.environment;
          return env.length;
        }
      ''');

        expect(result, greaterThan(0));
      });

      test('I-NET-27: Platform numberOfProcessors. [2026-02-10 06:37] (PASS)', () {
        final interpreter = D4rt();
        interpreter.grant(FilesystemPermission.any);
        interpreter.grant(DangerousPermission.any);

        final result = interpreter.execute(source: '''
        import 'dart:io';
        int main() {
          return Platform.numberOfProcessors;
        }
      ''');

        expect(result, greaterThan(0));
      });
    });
    test('I-NET-28: File not found error propagates correctly. [2026-02-10 06:37] (PASS)', () {
      final interpreter = D4rt();
      interpreter.grant(FilesystemPermission.any);

      expect(
        () => interpreter.execute(source: '''
          import 'dart:io';
          void main() {
            File('nonexistent_file.txt').readAsStringSync();
          }
        '''),
        throwsA(anything), // Will throw FileSystemException
      );
    });
  });
}

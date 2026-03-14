// D4rt test script: Tests SelectedContent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectedContent test executing');

  // ========== Basic SelectedContent creation ==========
  print('--- Basic SelectedContent ---');
  final content1 = SelectedContent(plainText: 'Hello World');
  print('  created: ${content1.runtimeType}');
  print('  plainText: ${content1.plainText}');

  // ========== Different text content ==========
  print('--- Different text content ---');
  final emptyContent = SelectedContent(plainText: '');
  final singleChar = SelectedContent(plainText: 'a');
  final multiLine = SelectedContent(plainText: 'Line 1\nLine 2\nLine 3');
  final withSpaces = SelectedContent(plainText: '  text with spaces  ');
  print('  empty plainText length: ${emptyContent.plainText.length}');
  print('  single char: ${singleChar.plainText}');
  print('  multi line lines: ${multiLine.plainText.split('\n').length}');
  print('  with spaces length: ${withSpaces.plainText.length}');

  // ========== Text length ==========
  print('--- Text length ---');
  print('  content1 length: ${content1.plainText.length}');
  print('  emptyContent length: ${emptyContent.plainText.length}');
  print('  singleChar length: ${singleChar.plainText.length}');
  print('  multiLine length: ${multiLine.plainText.length}');

  // ========== Unicode content ==========
  print('--- Unicode content ---');
  final unicodeContent = SelectedContent(plainText: 'Hello World');
  print('  unicode text: ${unicodeContent.plainText}');
  print('  unicode length: ${unicodeContent.plainText.length}');

  // ========== Special characters ==========
  print('--- Special characters ---');
  final specialChars = SelectedContent(plainText: 'Tab:\tNewline:\nEnd');
  final symbolContent = SelectedContent(plainText: '@#\$%^&*()[]{}');
  print(
    '  special chars contains tab: ${specialChars.plainText.contains('\t')}',
  );
  print(
    '  special chars contains newline: ${specialChars.plainText.contains('\n')}',
  );
  print('  symbol content length: ${symbolContent.plainText.length}');

  // ========== Long text content ==========
  print('--- Long text content ---');
  final longText = 'A' * 1000;
  final longContent = SelectedContent(plainText: longText);
  print('  long text length: ${longContent.plainText.length}');
  print('  first 10 chars: ${longContent.plainText.substring(0, 10)}');

  // ========== Multiple SelectedContent instances ==========
  print('--- Multiple instances ---');
  final contents = [
    SelectedContent(plainText: 'First'),
    SelectedContent(plainText: 'Second'),
    SelectedContent(plainText: 'Third'),
    SelectedContent(plainText: 'Fourth'),
  ];
  print('  Created ${contents.length} SelectedContent instances');
  for (var i = 0; i < contents.length; i++) {
    print('  [$i] plainText: ${contents[i].plainText}');
  }

  // ========== Equality behavior ==========
  print('--- Equality behavior ---');
  final contentA = SelectedContent(plainText: 'Test');
  final contentB = SelectedContent(plainText: 'Test');
  final contentC = SelectedContent(plainText: 'Different');
  print('  contentA == contentA: ${contentA == contentA}');
  print('  contentA == contentB: ${contentA == contentB}');
  print('  contentA == contentC: ${contentA == contentC}');
  print(
    '  contentA.plainText == contentB.plainText: ${contentA.plainText == contentB.plainText}',
  );

  // ========== HashCode ==========
  print('--- HashCode ---');
  print('  contentA.hashCode: ${contentA.hashCode}');
  print('  contentB.hashCode: ${contentB.hashCode}');

  // ========== ToString ==========
  print('--- ToString ---');
  print('  content1.toString(): ${content1.toString()}');

  print('SelectedContent test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectedContent Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic plainText: ${content1.plainText}'),
          Text('Empty length: ${emptyContent.plainText.length}'),
          Text('Unicode: ${unicodeContent.plainText}'),
          Text('Long text length: ${longContent.plainText.length}'),
          Text('Contents created: ${contents.length}'),
        ],
      ),
    ),
  );
}

// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:test/test.dart';
import 'package:tom_dcli_exec/src/cli/repl_base.dart';

void main() {
  group('parseSearchFilter', () {
    test('returns null for empty query', () {
      expect(parseSearchFilter(''), isNull);
    });

    test('exact match is case-insensitive by default', () {
      final matcher = parseSearchFilter('tom');
      expect(matcher, isNotNull);
      expect(matcher!('tom'), isTrue);
      expect(matcher('Tom'), isTrue);
      expect(matcher('toms'), isFalse);
      expect(matcher('tombstone'), isFalse);
    });

    test('exact match can be case-sensitive with double quotes', () {
      final matcher = parseSearchFilter('"Tom"');
      expect(matcher, isNotNull);
      expect(matcher!('Tom'), isTrue);
      expect(matcher('tom'), isFalse);
    });

    test('exact match can be case-sensitive with single quotes', () {
      final matcher = parseSearchFilter("'Tom'");
      expect(matcher, isNotNull);
      expect(matcher!('Tom'), isTrue);
      expect(matcher('tom'), isFalse);
    });

    test('startsWith match is case-insensitive with trailing asterisk', () {
      final matcher = parseSearchFilter('tom*');
      expect(matcher, isNotNull);
      expect(matcher!('Tomcat'), isTrue);
      expect(matcher('tomato'), isTrue);
      expect(matcher('atom'), isFalse);
    });

    test('startsWith match can be case-sensitive with quotes', () {
      final matcher = parseSearchFilter('"Tom*"');
      expect(matcher, isNotNull);
      expect(matcher!('Tomcat'), isTrue);
      expect(matcher('tomcat'), isFalse);
    });

    test('contains match is case-insensitive with surrounding asterisks', () {
      final matcher = parseSearchFilter('*om*');
      expect(matcher, isNotNull);
      expect(matcher!('Tom'), isTrue);
      expect(matcher('tombstone'), isTrue);
      expect(matcher('atom'), isTrue);
      expect(matcher('tmm'), isFalse);
    });

    test('contains match can be case-sensitive with quotes', () {
      final matcher = parseSearchFilter('"*Tom*"');
      expect(matcher, isNotNull);
      expect(matcher!('Tomcat'), isTrue);
      expect(matcher('tomcat'), isFalse);
    });
  });

  group('parseSearchFilterDetails', () {
    test('exact match mode with no wildcards', () {
      final filter = parseSearchFilterDetails('tom');
      expect(filter, isNotNull);
      expect(filter!.mode, SearchMatchMode.exact);
      expect(filter.caseSensitive, isFalse);
      expect(filter.term, 'tom');
      expect(filter.matches('Tom'), isTrue);
      expect(filter.matches('tomb'), isFalse);
    });

    test('case-sensitive exact match with quotes', () {
      final filter = parseSearchFilterDetails('"Tom"');
      expect(filter, isNotNull);
      expect(filter!.mode, SearchMatchMode.exact);
      expect(filter.caseSensitive, isTrue);
      expect(filter.term, 'Tom');
      expect(filter.matches('Tom'), isTrue);
      expect(filter.matches('tom'), isFalse);
    });

    test('startsWith match mode with trailing asterisk', () {
      final filter = parseSearchFilterDetails('tom*');
      expect(filter, isNotNull);
      expect(filter!.mode, SearchMatchMode.startsWith);
      expect(filter.term, 'tom');
      expect(filter.matches('Tomcat'), isTrue);
      expect(filter.matches('atom'), isFalse);
    });

    test('contains match mode with surrounding asterisks', () {
      final filter = parseSearchFilterDetails('*tom*');
      expect(filter, isNotNull);
      expect(filter!.mode, SearchMatchMode.contains);
      expect(filter.term, 'tom');
      expect(filter.matches('tombstone'), isTrue);
      expect(filter.matches('atom'), isTrue);
    });
  });
}

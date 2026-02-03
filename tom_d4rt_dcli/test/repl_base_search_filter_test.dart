// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:test/test.dart';
import 'package:tom_d4rt_dcli/src/cli/repl_base.dart';

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
}

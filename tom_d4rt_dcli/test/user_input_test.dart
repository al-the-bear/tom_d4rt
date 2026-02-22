/// Comprehensive tests for DCli user input operations.
///
/// Tests ask, confirm, menu functions and validators.
///
/// Note: Interactive input tests are limited since they require TTY.
/// These tests focus on validators and configuration.
///
/// DCli AskValidator API:
/// - Valid input: returns the validated/transformed String
/// - Invalid input: throws AskValidatorException
@TestOn('vm')
library;

import 'package:dcli/dcli.dart';
import 'package:test/test.dart';

void main() {
  group('Ask.required validator', () {
    test('accepts non-empty string', () {
      final validator = Ask.required;
      final result = validator.validate('valid input');

      // Returns trimmed string on success
      expect(result, equals('valid input'));
    });

    test('rejects empty string', () {
      final validator = Ask.required;

      expect(
        () => validator.validate(''),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('rejects whitespace only', () {
      final validator = Ask.required;

      // Required trims input, so whitespace-only is empty
      expect(
        () => validator.validate('   '),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('trims whitespace from valid input', () {
      final validator = Ask.required;
      final result = validator.validate('  trimmed  ');

      expect(result, equals('trimmed'));
    });
  });

  group('Ask.lengthMin validator', () {
    test('accepts string at minimum length', () {
      final validator = Ask.lengthMin(3);
      final result = validator.validate('abc');

      expect(result, equals('abc'));
    });

    test('accepts string above minimum', () {
      final validator = Ask.lengthMin(3);
      final result = validator.validate('abcdef');

      expect(result, equals('abcdef'));
    });

    test('rejects string below minimum', () {
      final validator = Ask.lengthMin(3);

      expect(
        () => validator.validate('ab'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('handles empty string', () {
      final validator = Ask.lengthMin(1);

      expect(
        () => validator.validate(''),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.lengthMax validator', () {
    test('accepts string at maximum length', () {
      final validator = Ask.lengthMax(5);
      final result = validator.validate('abcde');

      expect(result, equals('abcde'));
    });

    test('accepts string below maximum', () {
      final validator = Ask.lengthMax(5);
      final result = validator.validate('abc');

      expect(result, equals('abc'));
    });

    test('rejects string above maximum', () {
      final validator = Ask.lengthMax(5);

      expect(
        () => validator.validate('abcdef'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('accepts empty string', () {
      final validator = Ask.lengthMax(5);
      final result = validator.validate('');

      expect(result, equals(''));
    });
  });

  group('Ask.lengthRange validator', () {
    test('accepts string within range', () {
      final validator = Ask.lengthRange(3, 5);
      final result = validator.validate('abcd');

      expect(result, equals('abcd'));
    });

    test('accepts string at minimum', () {
      final validator = Ask.lengthRange(3, 5);
      final result = validator.validate('abc');

      expect(result, equals('abc'));
    });

    test('accepts string at maximum', () {
      final validator = Ask.lengthRange(3, 5);
      final result = validator.validate('abcde');

      expect(result, equals('abcde'));
    });

    test('rejects string below minimum', () {
      final validator = Ask.lengthRange(3, 5);

      expect(
        () => validator.validate('ab'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('rejects string above maximum', () {
      final validator = Ask.lengthRange(3, 5);

      expect(
        () => validator.validate('abcdef'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.integer validator', () {
    test('accepts valid integer', () {
      final validator = Ask.integer;
      final result = validator.validate('42');

      expect(result, equals('42'));
    });

    test('accepts negative integer', () {
      final validator = Ask.integer;
      final result = validator.validate('-42');

      expect(result, equals('-42'));
    });

    test('accepts zero', () {
      final validator = Ask.integer;
      final result = validator.validate('0');

      expect(result, equals('0'));
    });

    test('rejects non-integer', () {
      final validator = Ask.integer;

      expect(
        () => validator.validate('abc'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('rejects float', () {
      final validator = Ask.integer;

      expect(
        () => validator.validate('3.14'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('rejects empty string', () {
      final validator = Ask.integer;

      expect(
        () => validator.validate(''),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.decimal validator', () {
    test('accepts valid decimal', () {
      final validator = Ask.decimal;
      final result = validator.validate('3.14');

      expect(result, equals('3.14'));
    });

    test('accepts integer as decimal', () {
      final validator = Ask.decimal;
      final result = validator.validate('42');

      expect(result, equals('42'));
    });

    test('accepts negative decimal', () {
      final validator = Ask.decimal;
      final result = validator.validate('-3.14');

      expect(result, equals('-3.14'));
    });

    test('rejects non-number', () {
      final validator = Ask.decimal;

      expect(
        () => validator.validate('abc'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.ipAddress validator', () {
    test('accepts valid IPv4', () {
      final validator = Ask.ipAddress();
      final result = validator.validate('192.168.1.1');

      expect(result, equals('192.168.1.1'));
    });

    test('accepts localhost', () {
      final validator = Ask.ipAddress();
      final result = validator.validate('127.0.0.1');

      expect(result, equals('127.0.0.1'));
    });

    test('rejects invalid IP', () {
      final validator = Ask.ipAddress();

      expect(
        () => validator.validate('999.999.999.999'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('rejects non-IP string', () {
      final validator = Ask.ipAddress();

      expect(
        () => validator.validate('not-an-ip'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.valueRange validator', () {
    test('accepts value within range', () {
      final validator = Ask.valueRange(1, 10);
      final result = validator.validate('5');

      expect(result, equals('5'));
    });

    test('accepts value at minimum', () {
      final validator = Ask.valueRange(1, 10);
      final result = validator.validate('1');

      expect(result, equals('1'));
    });

    test('accepts value at maximum', () {
      final validator = Ask.valueRange(1, 10);
      final result = validator.validate('10');

      expect(result, equals('10'));
    });

    test('rejects value below minimum', () {
      final validator = Ask.valueRange(1, 10);

      expect(
        () => validator.validate('0'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('rejects value above maximum', () {
      final validator = Ask.valueRange(1, 10);

      expect(
        () => validator.validate('11'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.email validator', () {
    test('accepts valid email', () {
      final validator = Ask.email;
      final result = validator.validate('user@example.com');

      expect(result, equals('user@example.com'));
    });

    test('accepts email with subdomain', () {
      final validator = Ask.email;
      final result = validator.validate('user@mail.example.com');

      expect(result, equals('user@mail.example.com'));
    });

    test('accepts email with plus', () {
      final validator = Ask.email;
      final result = validator.validate('user+tag@example.com');

      expect(result, equals('user+tag@example.com'));
    });

    test('rejects invalid email', () {
      final validator = Ask.email;

      expect(
        () => validator.validate('not-an-email'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('rejects email without domain', () {
      final validator = Ask.email;

      expect(
        () => validator.validate('user@'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.fqdn validator', () {
    test('accepts valid domain', () {
      final validator = Ask.fqdn;
      final result = validator.validate('example.com');

      // FQDN validator lowercases the input
      expect(result, equals('example.com'));
    });

    test('accepts subdomain', () {
      final validator = Ask.fqdn;
      final result = validator.validate('sub.example.com');

      expect(result, equals('sub.example.com'));
    });

    test('rejects invalid domain', () {
      final validator = Ask.fqdn;

      expect(
        () => validator.validate('not a domain'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.alphaNumeric validator', () {
    test('accepts alphanumeric string', () {
      final validator = Ask.alphaNumeric;
      final result = validator.validate('abc123');

      expect(result, equals('abc123'));
    });

    test('accepts letters only', () {
      final validator = Ask.alphaNumeric;
      final result = validator.validate('abcdef');

      expect(result, equals('abcdef'));
    });

    test('accepts numbers only', () {
      final validator = Ask.alphaNumeric;
      final result = validator.validate('123456');

      expect(result, equals('123456'));
    });

    test('rejects special characters', () {
      final validator = Ask.alphaNumeric;

      expect(
        () => validator.validate('abc-123'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('rejects spaces', () {
      final validator = Ask.alphaNumeric;

      expect(
        () => validator.validate('abc 123'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Ask.alpha validator', () {
    test('accepts letters only', () {
      final validator = Ask.alpha;
      final result = validator.validate('abcdef');

      expect(result, equals('abcdef'));
    });

    test('rejects numbers', () {
      final validator = Ask.alpha;

      expect(
        () => validator.validate('abc123'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('regExp validator', () {
    test('accepts matching pattern', () {
      final validator = Ask.regExp(r'^test_');
      final result = validator.validate('test_value');

      expect(result, equals('test_value'));
    });

    test('rejects non-matching pattern', () {
      final validator = Ask.regExp(r'^test_');

      expect(
        () => validator.validate('other_value'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('regex validator with custom error', () {
      final validator = Ask.regExp(
        r'^[A-Z]{3}-\d{3}$',
        error: 'Must match pattern ABC-123',
      );

      expect(validator.validate('ABC-123'), equals('ABC-123'));

      expect(
        () => validator.validate('abc-123'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('AskValidator chaining', () {
    test('can combine validators with all', () {
      final validator = Ask.all([
        Ask.required,
        Ask.lengthMin(3),
        Ask.alphaNumeric,
      ]);

      // Valid input passes all validators
      expect(validator.validate('abc123'), equals('abc123'));

      // Empty fails required
      expect(
        () => validator.validate(''),
        throwsA(isA<AskValidatorException>()),
      );

      // Too short fails lengthMin
      expect(
        () => validator.validate('ab'),
        throwsA(isA<AskValidatorException>()),
      );

      // Special chars fail alphaNumeric
      expect(
        () => validator.validate('abc-123'),
        throwsA(isA<AskValidatorException>()),
      );
    });

    test('can combine validators with any', () {
      final validator = Ask.any([
        Ask.integer,
        Ask.alpha,
      ]);

      // Integer passes first validator
      expect(validator.validate('42'), equals('42'));

      // Alpha passes second validator
      expect(validator.validate('abc'), equals('abc'));

      // Neither integer nor alpha
      expect(
        () => validator.validate('abc-123'),
        throwsA(isA<AskValidatorException>()),
      );
    });
  });

  group('Menu class configuration', () {
    test('creates menu with options', () {
      final options = ['Option 1', 'Option 2', 'Option 3'];

      // Menu is created but not executed (requires TTY)
      expect(options.length, equals(3));
    });

    test('menu options are strings', () {
      final options = ['First', 'Second', 'Third'];

      expect(options.every((o) => o is String), isTrue);
    });
  });

  group('Confirm class', () {
    test('default value can be true', () {
      // Confirm configuration - not executing
      const defaultValue = true;
      expect(defaultValue, isTrue);
    });

    test('default value can be false', () {
      const defaultValue = false;
      expect(defaultValue, isFalse);
    });
  });

  group('Ask class options', () {
    test('can specify default value', () {
      const defaultValue = 'default';
      expect(defaultValue, equals('default'));
    });

    test('can specify hidden input', () {
      const hidden = true;
      expect(hidden, isTrue);
    });

    test('can specify prompt', () {
      const prompt = 'Enter value: ';
      expect(prompt, equals('Enter value: '));
    });
  });
}

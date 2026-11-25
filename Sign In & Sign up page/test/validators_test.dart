import 'package:flutter_test/flutter_test.dart';
import 'package:luxe_grocery/core/validators/validators.dart';

void main() {
  group('email', () {
    test('rejects empty and malformed', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('john@'), isNotNull);
      expect(Validators.email('john.example.com'), isNotNull);
    });
    test('accepts valid', () => expect(Validators.email('john@example.com'), isNull));
  });

  group('password rules', () {
    test('needs 8 chars, upper, lower, number', () {
      expect(Validators.strongPassword('Abc1234'), isNotNull); // 7 chars
      expect(Validators.strongPassword('abcdefg1'), isNotNull); // no upper
      expect(Validators.strongPassword('ABCDEFG1'), isNotNull); // no lower
      expect(Validators.strongPassword('Abcdefgh'), isNotNull); // no number
      expect(Validators.strongPassword('Abcdefg1'), isNull);
    });
    test('confirmation must match', () {
      expect(Validators.confirmPassword('Abcdefg1', 'Abcdefg2'), isNotNull);
      expect(Validators.confirmPassword('Abcdefg1', 'Abcdefg1'), isNull);
    });
  });

  test('full name required', () {
    expect(Validators.fullName('  '), isNotNull);
    expect(Validators.fullName('Sara Ali'), isNull);
  });
}


import 'package:test/test.dart';
import 'package:rational/rational.dart';
import 'package:extender/extender.dart';

void main() {
  group('Rational', () {
    test('infinity', () {
      expect(rationalInfinity(), Rational.fromInt(9223372036854775807));
      expect(
          rationalNegativeInfinity(), Rational.fromInt(-9223372036854775808));
    });
  });
}

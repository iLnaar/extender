import 'package:rational/rational.dart';

final _maxBigInt = 9223372036854775807;
final _minBigInt = -9223372036854775808;

Rational rationalInfinity() => Rational.fromInt(_maxBigInt);
Rational rationalNegativeInfinity() => Rational.fromInt(_minBigInt);

///
/// Rational extension
///
extension RationalExt on Rational {}

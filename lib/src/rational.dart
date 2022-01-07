import 'package:decimal/decimal.dart';
import 'package:extender/src/decimal.dart';
import 'package:extender/src/string.dart';
import 'package:extender/src/utils.dart';
import 'package:rational/rational.dart';
import 'exceptions.dart';


///
///
///
Rational rationalInfinity() => Rational.fromInt(maxBigInt);

///
///
///
Rational? rationalFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is Rational) return value;
  if (value is int) return value.toRational();
  if (value is String) return value.toRational();
  throw BadTypeException(
      'Bad type ${value.runtimeType} of $value value');
}

///
///
///
Rational? rationalFromDynamicE(
    dynamic dynamicValue,
    {String? name,
    Rational ?defaultValue,
    Set<Rational>? allowableValues,
    bool nullAllowed = false }) {
  final value = dynamicValue == null
      ? defaultValue
      : rationalFromDynamic(dynamicValue);
  if (value == null && !nullAllowed) {
    throw NotAllowableValueException(
        'The null value${ofName(name)}is not allowed');
  }
  if (allowableValues == null || allowableValues.isEmpty) return value;
  if (allowableValues.contains(value)) return value;
  throw NotAllowableValueException('The $value value${ofName(name)}is not '
      'one of the allowable ones: $allowableValues');
}

///
///
///
Rational? rationalFromMapEntry(
    Map map,
    dynamic key,
    {Rational ?defaultValue,
    Set<Rational>? allowableValues,
    bool nullAllowed = false }) =>
  rationalFromDynamicE(
      map[key],
      name: key,
      defaultValue: defaultValue,
      allowableValues: allowableValues,
      nullAllowed: nullAllowed);

///
/// Rational extension
///
extension RationalExt on Rational {
  ///
  ///
  ///
  bool get isZero => this == Rational.zero;

  ///
  ///
  /// 
  bool get isNotZero => this != Rational.zero;

  ///
  ///
  ///
  Decimal toDecimalE([int scaleOnInfinitePrecision = maxBigIntDigits]) =>
      toDecimal(scaleOnInfinitePrecision: maxBigIntDigits);

  ///
  ///
  ///
  Decimal toFloorDecimal(int digits) => toDecimalE().floor(scale: digits);

  ///
  ///
  ///
  String toStringAsFixed(int fractionDigits) =>
      toDecimalE().toStringAsFixed(fractionDigits);

  ///
  ///
  ///
  String toStringAsFixedE(int fractionDigits, RoundMode roundMode) =>
    toDecimalE().toStringAsFixedE(fractionDigits, roundMode);
}

import 'package:decimal/decimal.dart';
import 'package:extender/src/string.dart';
import 'package:extender/src/double.dart';
import 'package:extender/src/utils.dart';
import 'exceptions.dart';


///
///
///
Decimal decimalInfinity() => Decimal.fromInt(maxBigInt);

///
///
///
Decimal? decimalFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is Decimal) return value;
  // Так не работает! (не подключаются модули)
  // if (value is int || value is double || value is String) {
  //   return value.toDecimal();
  // }
  // Работает только когда каждое условие в отдельной строке
  if (value is int) return value.toDecimal();
  if (value is double) return value.toDecimal();
  if (value is String) return value.toDecimal();
  throw BadTypeException(
      'Bad type ${value.runtimeType} of $value value');
}

///
///
///
Decimal? decimalFromDynamicE(
    dynamic dynamicValue,
    {String? name,
    Decimal ?defaultValue,
    Set<Decimal>? allowableValues,
    bool nullAllowed = false }) {
  final value = dynamicValue == null
      ? defaultValue
      : decimalFromDynamic(dynamicValue);
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
Decimal? decimalFromMapEntry(
    Map map,
    dynamic key,
    {Decimal ?defaultValue,
    Set<Decimal>? allowableValues,
    bool nullAllowed = false }) =>
  decimalFromDynamicE(
      map[key],
      name: key,
      defaultValue: defaultValue,
      allowableValues: allowableValues,
      nullAllowed: nullAllowed);

///
///
///
Decimal decimalRandom(Decimal start, Decimal end) {
  final doubleStart = start.toDouble();
  final doubleRand = random.nextDouble()
      * (end.toDouble() - doubleStart)
      + doubleStart;
  return doubleRand.toDecimal();
}

///
/// Decimal extension
///
extension DetimalExt on Decimal {
  ///
  ///
  ///
  bool get isZero => this == Decimal.zero;

  ///
  ///
  ///
  bool get isNotZero => this != Decimal.zero;


  ///
  /// This is modified method [Decimal.toStringAsFixed()].
  ///
  /// It differs in that instead of rounding it produces truncation.
  ///
  String toStringAsFixedE(int fractionDigits, RoundMode roundMode) {
    assert(fractionDigits >= 0);
    if (fractionDigits == 0) return round().toBigInt().toString();
    final value = roundMode == RoundMode.round
        ? round(scale: fractionDigits)
        : floor(scale: fractionDigits);
    final intPart = value.toBigInt();
    final decimalPart = (Decimal.one + value.abs() - intPart.abs().toDecimal())
        .shift(fractionDigits);
    return '$intPart.${decimalPart.toString().substring(1)}';
  }
}

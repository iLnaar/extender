import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';
import 'package:extender/src/utils.dart';
import 'exceptions.dart';


///
/// Parse double from dynamic value.
///
/// Valid types: null, double, int and String. Any other type will throw an
/// exception [BadTypeException]. When parsing from a String, an
/// [FormatException] exception may occur if string is bad.
///
/// If [value] is null, return null. If [value] is double or int, return
/// double. If the [value] is string, then the parsed value will be returned.
///
double? doubleFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) {
    try {
      return double.parse(value);
    } on FormatException {
      throw FormatException('Invalid double in string "$value"');
    }
  }
  throw BadTypeException('Bad type ${value.runtimeType} of $value value');
}

///
/// Parse double from dynamic value with additional features.
///
/// This is a extended version of [fromDynamic()] method. It has additional
/// parameters.
///
/// In the [defaultValue] parameter you can set the default value. It is used
/// when [dynamicValue] is null. You can specify all allowed values in the
/// [allowableValues] parameter. If the value is not from this list, then the
/// exception [NotAllowableValueException] will be thrown.
///
/// With the [name] you can make exceptions more informative. If [name] is
/// given, it will be printed in the exception message. It is only used for
/// this.
///
/// With [nullAllowed] you can exclude null values. If the [dynamicValue]
/// value is null, the exception [NotAllowableValueException] will also be
/// thrown.
///
double? doubleFromDynamicE(
    dynamic dynamicValue,
    {String? name,
    double ?defaultValue,
    Set<double>? allowableValues,
    bool nullAllowed = false }) {
  final value = dynamicValue == null
      ? defaultValue
      : doubleFromDynamic(dynamicValue);
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
/// Parse double from Map entry with additional features.
///
/// This is a wrapper for the [fromDynamicE()] method for the simplify of
/// working with Map's
///
/// In the [defaultValue] parameter you can set the default value. It is used
/// when value in map is null. You can specify all allowed values in the
/// [allowableValues] parameter. If the value is not from this list, then the
/// exception [NotAllowableValueException] will be thrown.
///
/// With [nullAllowed] you can exclude null values. If the value in map is
/// null, the exception [NotAllowableValueException] will also be thrown.
///
double? doubleFromMapEntry(
    Map map,
    dynamic key,
    {double ?defaultValue,
    Set<double>? allowableValues,
    bool nullAllowed = false }) =>
  doubleFromDynamicE(
      map[key],
      name: key,
      defaultValue: defaultValue,
      allowableValues: allowableValues,
      nullAllowed: nullAllowed);


///
/// double extension
///
extension DoubleExt on double {
  ///
  ///
  ///
  Rational toRational() => Rational.parse(toString());

  ///
  ///
  ///
  Decimal toDecimal() => Decimal.parse(toString());
}
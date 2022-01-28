import 'package:extender/src/utils.dart';
import 'exceptions.dart';

///
///
///
int? intFromDynamic(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) {
    try {
      return int.parse(value);
    } on FormatException {
      throw FormatException('Invalid int in string "$value"');
    }
  }
  throw BadTypeException('Bad type ${value.runtimeType} of $value value');
}

///
///
///
int? intFromDynamicE(
    dynamic dynamicValue,
    {String? name,
    int ?defaultValue,
    Set<int>? allowableValues,
    bool nullAllowed = false }) {
  final value = dynamicValue == null
      ? defaultValue
      : intFromDynamic(dynamicValue);
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
int? intFromMapEntry(
    Map map,
    dynamic key,
    {int ?defaultValue,
    Set<int>? allowableValues,
    bool nullAllowed = false }) =>
  intFromDynamicE(
      map[key],
      name: key,
      defaultValue: defaultValue,
      allowableValues: allowableValues,
      nullAllowed: nullAllowed);

///
/// Generates a list of random int values in a range [0; max). You can enable or
/// disable duplicate values.
///
List<int> randomIntList(int max, [bool allowReps = true]) {
  final list = <int>[];
  while(list.length < max) {
    final rand = random.nextInt(max);
    if (allowReps || !list.contains(rand)) list.add(rand);
  }
  return list;
}

///
/// int extension
///
extension IntExt on int {}
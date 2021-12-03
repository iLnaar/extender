import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';
import 'exceptions.dart';


///
///
///
String? stringFromDynamic(dynamic value) => value.toString();

///
///
///
String? stringFromDynamicE(
    dynamicValue,
    {String? name,
    String? defaultValue,
    Set<String>? allowableValues,
    bool nullAllowed = false,
    bool emptyAllowed = false}) {
  final value = dynamicValue == null
      ? defaultValue
      : stringFromDynamic(dynamicValue);
  if (value == null && !nullAllowed) {
    if (name == null || name == '') {
      throw NotAllowableValueException('The null value is not allowed');
    }
    throw NotAllowableValueException('The null value of $name is not allowed');
  }
  if (value == '' && !emptyAllowed) {
    if (name == null || name == '') {
      throw NotAllowableValueException('The empty value is not allowed');
    }
    throw NotAllowableValueException('The empty value of $name is not allowed');
  }
  if (allowableValues == null || allowableValues.isEmpty) return value;
  if (allowableValues.contains(value)) return value;
  if (name == null || name == '') {
    throw NotAllowableValueException('The $value value is not one of the '
        'allowable ones: $allowableValues');
  }
  throw NotAllowableValueException('The $value value of $name is not one of '
      'the allowable ones: $allowableValues');
}

///
///
///
String? stringFromMapEntry(
    Map map,
    dynamic key,
    {String ?defaultValue,
    Set<String>? allowableValues,
    bool nullAllowed = false }) =>
  stringFromDynamicE(
    map[key],
    name: key,
    defaultValue: defaultValue,
    allowableValues: allowableValues,
    nullAllowed: nullAllowed);


///
/// String extension
///
extension StringExt on String {
  double toDouble() => double.parse(this);

  Rational toRational() => Rational.parse(this);

  Decimal toDecimal() => Decimal.parse(this);

  String truncateRight(int newLength, String filler) {
    if (newLength < 1) {
      return '';
    } else if (newLength < length) {
      return substring(0, newLength);
    } else if (newLength > length) {
      if (filler.isEmpty) return this;
      final fillerCount = (newLength - length)~/filler.length + 1;
      final newString = this + (filler*fillerCount);
      return newString.substring(0, newLength);
    }
    return this;
  }


  String toWrappedString(int maxLength, [ String separator = ' ' ]) {
    assert(separator.isNotEmpty, 'Separator cannot be empty');

    var sep1i = indexOf(separator);
    if (sep1i == -1 || sep1i + separator.length >= length) return this;

    var lineStart = 0;
    var wrapped = substring(0, sep1i);

    for (; ; ) {
      var sep2i = indexOf(separator, sep1i + separator.length);
      if (sep2i == -1) {
        if (length - lineStart > maxLength) {
          wrapped += separator.trimRight() + '\n'
              + substring(sep1i + separator.length, length).trimLeft();
          return wrapped;
        } else {
          wrapped += substring(sep1i, length);
          return wrapped;
        }
      }
      if (sep2i + separator.trimRight().length - lineStart > maxLength) {
        wrapped += separator.trimRight() + '\n'
            + substring(sep1i + separator.length, sep2i).trimLeft();
        lineStart = sep1i + separator.length;
      } else {
        wrapped += substring(sep1i, sep2i);
      }
      sep1i = sep2i;
    }
  }


  List<String> toList([
    String separator = '\n',
    String Function(String item)? callback
  ]) {
    assert(separator.isNotEmpty, 'Separator cannot be empty');

    var sepIndex = indexOf(separator);
    if (sepIndex == -1) {
      if (callback != null) return [ callback(this) ];
      return [ this ];
    }

    var lineStart = 0;
    final list = <String>[];

    void addItem(String item) {
      if (callback != null) {
        list.add(callback(item));
      } else {
        list.add(item);
      }
    }

    for (; ; ) {
      addItem(substring(lineStart, sepIndex).trim());
      lineStart = sepIndex + separator.length;
      sepIndex = indexOf(separator, sepIndex + separator.length);
      if (sepIndex == -1) {
        addItem(substring(lineStart));
        return list;
      }
    }
  }
}
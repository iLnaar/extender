///
/// An exception is thrown when a value of the wrong type is passed.
///
class BadTypeException implements Exception {
  final String message;

  BadTypeException(this.message);

  @override
  String toString() => 'BadTypeException: $message';
}

///
/// An exception is thrown when a value is passed that is not in the list of
/// valid values.
///
class NotAllowableValueException implements Exception {
  final String message;

  NotAllowableValueException(this.message);

  @override
  String toString() => 'NotAllowableValueException: $message';
}
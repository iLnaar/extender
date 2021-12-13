
///
///
///
abstract class StringEnum {
  String value;

  ///
  ///
  ///
  Set<String> getValidValues();

  ///
  ///
  ///
  StringEnum(this.value) {
    _validate();
  }

  ///
  ///
  ///
  void _validate() {
    final validValues = getValidValues().contains(value);
    if (!validValues) {
      throw Exception('$value is not one of the valid values $validValues');
    }
  }

  ///
  ///
  ///
  @override
  bool operator ==(Object other) {
    if (other is StringEnum) return other.value == value;
    if (other is String) return other == value;
    throw Exception('Invalid type ${other.runtimeType} for comparison.');
  }

  ///
  ///
  ///
  @override
  int get hashCode => value.hashCode;
}
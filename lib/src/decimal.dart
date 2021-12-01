import 'package:decimal/decimal.dart';

///
/// Decimal extension
///
extension DetimalExt on Decimal {
  ///
  /// This is modified method [Decimal.toStringAsFixed()].
  ///
  /// It differs in that instead of rounding it produces truncation.
  ///
  String toStringAsFixedFloor(int fractionDigits) {
    assert(fractionDigits >= 0);
    if (fractionDigits == 0) return round().toBigInt().toString();
    final value = floor(scale: fractionDigits);
    final intPart = value.toBigInt();
    final decimalPart = (Decimal.one + value.abs() - intPart.abs().toDecimal())
        .shift(fractionDigits);
    return '$intPart.${decimalPart.toString().substring(1)}';
  }
}

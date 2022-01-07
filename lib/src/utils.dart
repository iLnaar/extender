import 'dart:math';


enum RoundMode { floor, round }

final debugMode = _debugMode();
final random = Random();

const maxBigInt = 9223372036854775807;
const minBigInt = -9223372036854775808;
const maxBigIntDigits = 19;


///
///
///
bool _debugMode() {
  bool debug = false;
  assert(() {
    debug = true;
    return true;
  }());
  return debug;
}

///
///
///
String ofName(String? name) =>
    name == null || name == ''
        ? ' '
        : ' of $name ';

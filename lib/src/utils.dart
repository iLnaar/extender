
enum RoundMode { floor, round }


const maxBigInt = 9223372036854775807;
const minBigInt = -9223372036854775808;
const maxBigIntDigits = 19;


String ofName(String? name) =>
    name == null || name == ''
        ? ' '
        : ' of $name ';

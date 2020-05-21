:- module('numbers', [
  number//1
]).

% Integers
number(Number) -->
  { var(Number) },
  digits(Digits),
  { number_chars(Number, Digits) }.
number(Number) -->
  {
    nonvar(Number),
    number_chars(Number, Digits)
  },
  digits(Digits).

digits([Digit]) --> digit(Digit).
digits([Digit|Rest]) -->
  digit(Digit),
  digits(Rest).

digit('0') --> "0".
digit('1') --> "1".
digit('2') --> "2".
digit('3') --> "3".
digit('4') --> "4".
digit('5') --> "5".
digit('6') --> "6".
digit('7') --> "7".
digit('8') --> "8".
digit('9') --> "9".

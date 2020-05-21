:- module('parser', [
  parse_commands/2
]).

:- use_module('tokens').
:- use_module('spaces').
:- use_module('numbers').

commands(Commands) -->
  spaces,
  rows(Commands),
  spaces.
commands([]) --> [].

rows([Command|OtherCommands]) -->
  command(Command),
  spaces,
  new_lines,
  spaces,
  rows(OtherCommands).
rows([Command]) --> command(Command).
rows([]) --> [].

command(command(none, Operation, Then)) -->
  operation(Operation),
  spaces,
  then,
  spaces,
  command(Then).
command(command(After, Operation, none)) -->
  operation(Operation),
  spaces,
  after,
  spaces,
  command(After).
command(command(none, Operation, none)) -->
  operation(Operation).

operation(operation(Direction, Value)) -->
  direction(Direction),
  spaces,
  number(Value).
operation(Operation) -->
  left_parenthesis,
  spaces,
  command(Operation),
  spaces,
  right_parenthesis.

parse_commands(Code, Commands) :-
  string_codes(Code, Stream),
  phrase(commands(Commands), Stream).

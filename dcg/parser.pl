:- module(parser, [
  parse_commands/2
]).

:- use_module(tokens).
:- use_module(spaces).
:- use_module(numbers).

commands([]) --> [].
commands(Commands) -->
  spaces,
  rows(Commands),
  spaces.

rows([]) --> [].
rows([Command]) --> command(Command).
rows([Command|Rest]) -->
  command(Command),
  spaces,
  new_lines,
  spaces,
  rows(Rest).

command(command(none, Operation, none)) --> operation(Operation).
command(command(none, Operation, Then)) -->
  operation(Operation),
  spaces,
  then,
  spaces,
  command(Then).
command(command(command(ChildAfter, ChildOperation, Then), Operation, Then)) -->
  operation(Operation),
  spaces,
  after,
  spaces,
  command(command(ChildAfter, ChildOperation, Then)).

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
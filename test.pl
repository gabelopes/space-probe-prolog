% :- use_module(dcg/parser).
:- use_module(dcg/parser).
:- use_module(space_probe).
:- use_module(operations).

start :-
  Code = "forward 945 then left 6\nbackward 9 after right 1",
  parse_commands(Code, Commands),
  get_operations(Commands, Operations),
  directed_move(Operations, Result),
  writeln(Result).
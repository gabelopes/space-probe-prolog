:- module('operations', [
  extract_operations/2
]).

extract_operations([Command|OtherCommands], Operations) :-
  extract_operations(OtherCommands, PartialOperations),
  list_operations(Command, List),
  append(List, PartialOperations, Operations).
extract_operations([], []).

list_operations(operation(Direction, Value), [operation(Direction, Value)]).
list_operations(command(none, Command, none), List) :-
  list_operations(Command, List).
list_operations(command(none, Command, Then), List) :-
  list_operations(Command, CommandList),
  list_operations(Then, ThenList),
  append(CommandList, ThenList, List).
list_operations(command(After, Command, none), List) :-
  list_operations(After, AfterList),
  list_operations(Command, CommandList),
  append(AfterList, CommandList, List).
list_operations(command(none, none, none), []).

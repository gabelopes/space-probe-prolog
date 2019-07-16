:- module(operations, [
  get_operations/2
]).

get_operations([], []).
get_operations([Command|Rest], Ordered) :-
  get_operations(Rest, PartiallyOrdered),
  list_operations(Command, List),
  append(List, PartiallyOrdered, Ordered).

list_operations(command(none, none, none), []).
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
list_operations(command(After, Command, Then), List) :-
  list_operations(After, AfterList),
  list_operations(Command, CommandList),
  list_operations(Then, ThenList),
  append([AfterList, CommandList, ThenList], List).
:- module(tokens, [
  left_parenthesis//0,
  right_parenthesis//0,
  direction//1,
  then//0,
  after//0
]).

left_parenthesis --> "(".
right_parenthesis --> ")".

direction(forward) --> "forward".
direction(backward) --> "backward".
direction(left) --> "left".
direction(right) --> "right".
then --> "then".
after --> "after".

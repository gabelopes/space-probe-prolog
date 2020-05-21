:- module(tokens, [
  left_parenthesis/2,
  right_parenthesis/2,
  direction/3,
  then/2,
  after/2
]).

left_parenthesis --> "(".
right_parenthesis --> ")".

direction(forward) --> "forward".
direction(backward) --> "backward".
direction(left) --> "left".
direction(right) --> "right".
then --> "then".
after --> "after".

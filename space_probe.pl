:- module(space_probe, [
  move/2,
  move/3,
  directed_move/2,
  directed_move/3
]).

move(Operations, Result) :-
  move(point(0, 0), Operations, Result).
move(Point, [], Point).
move(Point, [Operation|Rest], OffsetPoint) :-
  calculate_position(Point, Operation, PartialPoint),
  move(PartialPoint, Rest, OffsetPoint).

calculate_position(point(X, Y), operation(forward, Value), point(X, MovedY)) :-
  MovedY is Y + Value.
calculate_position(point(X, Y), operation(backward, Value), point(X, MovedY)) :-
  MovedY is Y - Value.
calculate_position(point(X, Y), operation(right, Value), point(MovedX, Y)) :-
  MovedX is X + Value.
calculate_position(point(X, Y), operation(left, Value), point(MovedX, Y)) :-
  MovedX is X - Value.

% The directed move tracks the current direction and moves the space probe accordingly.
% For example: if the space probe is moving forward, and then wants to take a left, the
% new position will be left. Now if it wants to take a left again, then it will be moving
% backwards. Once again left, then it will be moving right, etc.
% 
% The reasoning behind the algorithm used lies in identifying a group that is isomorph
% to the following operation table: (the found isomorph group is on the right)
%                +---+---+---+---+---+          +----+----+----+----+----+
%                | * | F | B | L | R |          |  * |  1 | -1 | -i |  i |
%                +---+---+---+---+---+          +----+----+----+----+----+
%                | F | F | B | L | R |          |  1 |  1 | -1 | -i |  i |
%                +---+---+---+---+---+          +----+----+----+----+----+
%                | B | B | F | R | L |    =>    | -1 | -1 |  1 |  i | -i |
%                +---+---+---+---+---+          +----+----+----+----+----+
%                | L | L | R | B | F |          | -i | -i |  i | -1 |  1 |
%                +---+---+---+---+---+          +----+----+----+----+----+
%                | R | R | L | F | B |          |  i |  i | -i |  1 | -1 |
%                +---+---+---+---+---+          +----+----+----+----+----+
% Since the isomorph group has a Complex subset and the operation is multiplication, we use
% a bijective mapping `direction_scalar` (to act as the isomorphism) and `multiply_complex`,
% which will do the operation part.
% 
% Once we determine the direction using the isomorphism, the rest of the algorithm is calculated
% exactly as the simple `move`, using `calculate_position`.
directed_move(Operations, Result) :-
  directed_move(point(0, 0), Operations, Result).
directed_move(Point, Operations, Result) :-
  directed_move(forward, Point, Operations, Result).
directed_move(_, Point, [], Point).
directed_move(CurrentDirection, Point, [operation(Direction, Value)|Rest], OffsetPoint) :-
  determine_direction(CurrentDirection, Direction, ResultantDirection),
  calculate_position(Point, operation(ResultantDirection, Value), PartialPoint),
  directed_move(ResultantDirection, PartialPoint, Rest, OffsetPoint).

determine_direction(FromDirection, ToDirection, ResultantDirection) :-
  direction_scalar(FromDirection, FromScalar),
  direction_scalar(ToDirection, ToScalar),
  multiply_complex(FromScalar, ToScalar, ResultantScalar),
  direction_scalar(ResultantDirection, ResultantScalar).

multiply_complex(point(X, Y), point(Z, W), point(A, B)) :-
  A is X * Z - Y * W,
  B is X * W + Y * Z.

direction_scalar(forward, point(1, 0)).
direction_scalar(backward, point(-1, 0)).
direction_scalar(left, point(0, -1)).
direction_scalar(right, point(0, 1)).
# Space Probe

This is a rewriting of the Space Probe meant to use Prolog and appropriate tools for such a simple problem.

## Specification

The language has 4 commands, 2 operators and 1 data type, which help in moving a space probe around, well, the space, which is assumed to be a discrete 2-dimensional one. Those are:

|Type|Word|Description|
|-|-|-|
|Command|`forward x`|Moves the SB x meters forward.|
|Command|`backward x`|Moves the SB x meters backward.|
|Command|`left x`|Turns the SB to the left and moves x meters forward.|
|Command|`right x`|Turns the SB to the right and moves x meters forward.|
|Operator|`a then b`|Executes a followed by b. It is equal to specifying each command in a separate line.|
|Operator|`a after b`|Executes b, and only then executes a. It is equal to specifying each command in a separate line in reverse order.|
|Data Type|int|Every `x` is an integer.
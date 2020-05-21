:- module('spaces', [
  spaces//0,
  required_spaces//0,
  new_line//0,
  new_lines//0
]).

spaces --> space, spaces.
spaces --> [].

required_spaces --> space, spaces.

space --> " ".
space --> "\t".
space --> "\v".

new_line --> "\r\n".
new_line --> "\n".
new_line --> "\r".

new_lines --> new_line, new_lines.
new_lines --> new_line.

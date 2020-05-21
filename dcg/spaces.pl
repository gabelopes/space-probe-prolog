:- module('spaces', [
  spaces//0,
  required_spaces//0,
  new_line//0,
  new_lines//0
]).

spaces --> [].
spaces --> space, spaces.

required_spaces --> space, spaces.

space --> " ".
space --> "\s".
space --> "\t".

new_line --> "\n\r".
new_line --> "\r\n".
new_line --> "\n".
new_line --> "\r".

new_lines --> new_line.
new_lines --> new_line, new_lines.

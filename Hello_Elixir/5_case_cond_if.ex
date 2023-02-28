# Elixir
# case, cond, and if

# https://elixir-lang.org/getting-started/case-cond-and-if.html

# control flow structures

###### case

# compares a value against many patterns until finds a matching one

case {1,2,3} do
  {4,5,6} ->
    "no match"
  {1,x,3} ->
    "This clause will match and bind x to 2 in this clause"
  _ ->
    "matches any value"
end

# to pattern match against an existing variable, use the ^ operator
x = 5

case {1,2,3} do
  {4,5,6} ->
    "no match"
  {1,^x,3} ->
    "This clause will NOT match because ^x refers to an existing variable with a value of 5"
  _ ->
    "matches any value"
end

# Clauses also allow extra conditions to be specified via guards
case {1,2,3} do
  {1,x,3} when x > 0 ->
    "will match"
  _ ->
    "Would match, if guard condition were not satisfied"
end

case {1,-2,3} do
  {1,x,3} when x > 0 ->
    "will NOT match"
  _ ->
    "Will match, because here x = -2"
end

x = -2
case {1,2,3} do
  {1,^x,3} when x > 0 ->
    "will NOT match because pins to exsisting variable"
  _ ->
    "Will match, because pins to exsisting x variable with value of -2"
end

# NOTE, that in Elixir different data types can be compared so also other that number data types can result true in x > 0 comparison!
x = "t" # e.g., when x is a string, the cond will return "x is larger that 0"

case x do
  0 ->
    "x = 0"
  -4 ->
    "x is -4"
  x when x > 0 ->
    "x is larger that 0"
  _ ->
    "x is something else"
end

# NOTE, this is incorrect!
case x do
  0 ->
    "x = 0"
  x > 0 -> # this will cause ** (CompileError) iex:6: cannot invoke remote function :erlang.>/2 inside a match
    "x is larger that 0"
  _ ->
    "x is something else"
end

case x do
  0 ->
    "x = 0"
  x when is_nil(x) ->
    "x is nil"
  _ ->
    "x is something else"
end

# Keep in mind errors in guards do not leak but simply make the guard fail

case 1 do
  x when hd(x) -> "Won't match, because hd(1) gives ArgumentError"
  x -> "Got #{x}"
end
# guards documentation: https://hexdocs.pm/elixir/patterns-and-guards.html#guards


###### cond

# check different conditions and find the first one that does not evaluate to nil or false
# equivalent to else if clauses in many imperative languages

# If all of the conditions return nil or false, an error (CondClauseError) is raised.
# For this reason, it may be necessary to add a final condition, equal to true, which will always match. Similar to "else"

x = 2 # returns "default"
x = 3 # "true, if x = 3"
# NOTE, that if values of x is not suitable for calculation, an error will be rised!
x = "t" # ** (ArithmeticError) bad argument in arithmetic expression: "t" + 3 :erlang.+("t", 3)

cond do
  2 + 3 == 6 ->
    "not true"
  x + 3 == 6 ->
    "true, if x = 3"
  true ->
    "default"
end

# remember, that cond considers any value besides nil and false to be true
cond do
  hd([1,2,3]) ->
    "1 is considered s true"
  true ->
    "default"
end


###### if and unless

# return variable from if statement: https://stackoverflow.com/questions/39550644/elixir-set-variable-in-if-statement
# In Elixir every statement returns the value. Instead of assigning variable in if
# you can assign whole if statement value into variable.
a = 0
a = if true do
      1 + 1
    else
      a + 1
    end

# the macros if/2 and unless/2 are useful when you need to check for only one condition

# If the condition given to if/2 returns false or nil,
# the body given between do-end is not executed and instead it returns nil.
# The opposite happens with unless/2

x = 3

# returns "do this when x > 0"
if x > 0 do
  "do this when x > 0"
end

# returns nil
unless x > 0 do
  "do this when x is not larger than 0"
end

# scoping in Elixir: If any variable is declared or changed inside if, case, and similar constructs,
# the declaration and change will only be visible inside the construct.
x = 3

if true do
  x = x+1
end

x # 3

# to change a value, it needs to be returned
x = if true do
  x = x + 1
end

x # 4


str = "documentation"
version = 5

if String.contains?(str, "documentation") && version > 3 && version < 7 do
  IO.puts(String.replace(str, "documentation", "methods"))
end
# if version is > 3 and <7 and "documentation" is found in given string, it's replaced by "methods"

###### do-end bocks

# above, control structures: case, cond, if, and unless, were all wrapped in do-end blocks

x = if true do
  x = x + 1
  else
    "something else"
end

# This is same as the example above
x = if true, do: x = x + 1, else: "something else"

values = [1, 4, 6]
values = if is_nil(values), do: 0, else: values
IO.inspect(vaues)
# Notice how the example above has a comma between true and do:,
# that’s because it is using Elixir’s regular syntax where each argument is separated by a comma.
# This syntax is using keyword lists.

# do-end blocks are a syntactic convenience built on top of the keyword ones.
# That’s why do/end blocks do not require a comma between the previous argument and the block.

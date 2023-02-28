# Elixir
# PATTERN MATCHING

# https://elixir-lang.org/getting-started/pattern-matching.html


###### The match operator

# = operator is used for assigning variables, but it's actually called the match operator
x = 1 # 1
1 = x # 1. 1 = x is a valid expression, and it matched because both the left and right side are equal to 1
2 = x # ** (MatchError) no match of right hand side value: 1


###### Pattern matching

# pattern match on TUPLES
{a, b, c} = {:hello, "world", 42} # {:hello, "world", 42}
a # :hello

# aim to compare different types rises an error
{a, b, c} = [:hello, "world", 42]  # ** (MatchError) no match of right hand side value: [:hello, "world", 42]

# match on specific values. Assert that the left side will only match the right side
# when the right side is a tuple that starts with the atom :ok:
{:ok, result} = {:ok, 13} # {:ok, 13}

{:ok, result} = {:error, "what ever"} # ** (MatchError) no match of right hand side value: {:error, "what ever"}

# pattern match on LISTS
[a, b, c] = [1, 2, 3]
[head | tail] = [1, 2, 3]
[head|tail] = [3] # [3], -> head is 3, tail is []

# The [head | tail] format is also used for prepending items to a list
list = [12,2,4]
list2 = [13|list] # [13, 12, 2, 4]

# compare to
list3 = [13, list] # [13, [12, 2, 4]]

# adding stuff to the end does NOT work in similar way because head returns the first item and tail the rest
list = [list|2] # [[12, 2, 4] | 2]

# Pattern matching allows developers to easily destructure data types such as tuples and lists.


###### The pin operator

# Variables in Elixir can be rebound, i.e. a new value can be assigned to the variable
x = 1
x = 2

# pin operator ^ is used to access previously bound values.
# Use the pin operator ^ when you want to pattern match against a variable’s existing value rather than rebinding the variable.
x = 1
^x = 2 # ** (MatchError) no match of right hand side value: 2

# Because we have pinned x when it was bound to the value of 1, it is equivalent to the following: 1=2

[^x, 3, 4] = [1, 3, 4] # [1, 3, 4]
[^x, 3, 4] = [2, 3, 4] # ** (MatchError) no match of right hand side value: [2, 3, 4]

# If a variable is mentioned more than once in a pattern, all references should bind to the same value:
{x, x} = {1, 1} # {1, 1}
{^x, x} = {1, 2}
{x, x} = {1, 2} # ** (MatchError) no match of right hand side value: {1, 2}

# if some values are not needed, they can be pinned to an underscrore variable _.
[head | _] = [1, 2, 3]
head # 1
_ # ** (CompileError) iex:44: invalid use of _. "_" represents a value to be ignored in a pattern and cannot be used in expressions

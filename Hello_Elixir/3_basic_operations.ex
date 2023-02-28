# Elixir
# BASIC OPERATIONS

# https://elixir-lang.org/getting-started/basic-operators.html
# reference page on operators: https://hexdocs.pm/elixir/operators.html

#### arithmetic operators: +, -, *, /

####  division and remainder div/2 rem/2

#### for list manipulation: ++ and --

#### string concatenation: <>

#### boolean operators: or, and and not
# expect something that evaluates to a boolean (true or false) as their first argument:

# or and and are short-circuit operators. They only execute the right side if the left side is not enough to determine the result:
true or raise("This error will never be raised")

#### boolean operators: ||, && and !

# accept arguments of any type. For these operators, all values except false and nil will evaluate to true

# or
1 || 12 # 1
false || 12 # 12

# and
nil && 13 # nil
true && 17 # 17

# not
!true # false
!1 # false
!0 # false
!nil # true

# use and, or and not when you are expecting booleans. If any of the arguments are non-boolean, use &&, || and !

#### comparison operators: ==, !=, ===, !==, <=, >=, < and >

# comaprison of different data types is possible
# The overall sorting order is defined below:
# number < atom < reference < function < port < pid < tuple < map < list < bitstring
1 < :atom # true
"s" > :atom # true

#### match operator: =
# used for pattern matching

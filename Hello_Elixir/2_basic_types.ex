# Elixir
# BASIC TYPES

# More on Hello_Elixir.ex

# Elixir basic types: integers, floats, booleans, atoms, strings, lists and tuples.
# Elixir typespecs: https://hexdocs.pm/elixir/typespecs.html

###### BASIC TYPES ######

1 # integer
0x1F # integer, returns 31
1.0 # float
1.3e-9 # float
true # boolean
false # boolean
:atom # atom
"string" # string
[1, 2, 3] # list
{1, 2, 4} # tuple

# Elixir supports shortcut notations for entering binary, octal, and hexadecimal numbers:
0b1010 # 10
0o777 # 511
0x3F # 63

###### BASIC ATRITMERIC ######

is_number(3) # true
is_number(3.7) # true
is_integer(3) # true
is_float(3.5) # true

###### BOOLEANS ######
is_boolean(true) # true
is_boolean(:false) # true. The booleans true and false are also atoms

###### ATOMS ######

# An atom is a constant whose value is its own name

:atom
is_atom(:error) # true

# Elixir allows you to skip the leading : for the atoms false, true and nil.
true == :true
is_atom(false) # trues

# Aliases start in upper case and are also atoms:
is_atom(Hello) # true
is_atom(Test) # true
is_atom(test) # ** (CompileError) iex:92: undefined function test/0 (stdlib 3.15.2) lists.erl:1358: :lists.mapfoldl/3

###### STRINGS ######

"this is a string"

# string interpolation:
string = :world
"hellö #{string}"

# line break
"hello\nworld" # in iex prints "hello\nworld"
IO.puts("hello\nworld") # prints words on two lines and returns the atom :ok after printing

# Strings in Elixir are represented internally by contiguous sequences of bytes known as binaries
is_binary("hellö")is_binary("hellö") # true
byte_size("string") # 6

# String module contains functions for strings
String.capitalize("string") # "String"


###### ANONYMOUS FUNCTIONS ######

# Anonymous functions allow us to store and pass executable code around as if it was an integer or a string.
# They are delimited by the keywords fn and end

add = fn a,b -> a + b end # an anonymous function stored in a variable called add
add.(1,2) # NOTE the dot (to distinguish from named functions)
is_function(add)

# Anonymous functions in Elixir are also identified by the number of arguments they receive.
# check if add is a function that expects exactly 2 arguments
is_function(add, 2) # true
is_function(add, 1) # false

# A variable assigned inside a function does not affect its surrounding environment
x = 42
(fn -> x = 0 end).()
x

###### (LINKED) LISTS ######

# Values can be of any type
myList = [1, true, 2, false, 3, true]

# Two lists can be concatenated or subtracted using the ++/2 and --/2 operators, respectively
myList -- [true, false] # [1, 2, 3, true]

# Elixir data structures are immutable ->
# List operators never modify the existing list. Concatenating to or removing elements from a list returns a new list.
myList # [1, true, 2, false, 3, true]

# data cannot be mutated, but can be transformed
myList = myList -- [true, false]
myList # [1, 2, 3, true]

# head and tail
hd(myList) # 1
tl(myList) # [2, 3, true]

# When Elixir sees a list of printable ASCII numbers, Elixir will print that as a charlist (literally a list of characters)
[1,2,3] #[1, 2, 3]

[11, 12, 13] # '\v\f\r'
IO.puts [11,12,13] # ^K^L :ok

[104, 101, 108, 108, 111] # 'hello'

# Single quotes are charlists, double quotes are strings.
'hello' == "hello" # false

# use i/1 function to retrieve information about values
i 'hello'


###### TUPLES ######

# Elixir uses curly brackets to define tuples. Like lists, tuples can hold any value

# Access a tuple element by index. Indexes start from zero
tuple = {:ok, "hello"}
elem(tuple, 0) # :ok
tuple_size(tuple) # 2

put_elem(tuple, 1, "world") # {:ok, "world"}

# new item replaces some previous item, because setting index out of the range of the tuple gives an error -> cannot append a value by put_elem
put_elem(tuple, 2, "world") # ** (ArgumentError) errors were found at the given arguments: * 1st argument: out of range :erlang.setelement(3, {:ok, "hello"}, "world")

# in both cases below, float variable contains the first element of the tuple that Float.parse/1 function returns
{float, _} = Float.parse("6e-05")
float = Float.parse("6e-05") |> elem(0) # useful when value is needed in a pipeline and needed directly, e.g. when "populating" a changeset

###### LISTS VS TUPLES  ######

# Lists are stored in memory as linked lists, meaning that each element in a list holds its value
# and points to the following element until the end of the list is reached.
# This means accessing the length of a list is a linear operation: we need to traverse the whole list in order to figure out its size.

# Similarly, the performance of list concatenation depends on the length of the left-hand list:
list = [1, 2, 3]

# This is fast as we only need to traverse `[0]` to prepend to `list`
[0] ++ list # [0, 1, 2, 3]

# This is slow as we need to traverse `list` to append 4
list ++ [4] # [1, 2, 3, 4]


# Tuples store elements contiguously in memory.
# This means accessing a tuple element by index or getting the tuple size is a fast operation.
# However, updating or adding elements to tuples is expensive because it requires creating a new tuple in memory:

# Most of the time, Elixir is going to guide you to do the right thing.
# For example, there is an elem/2 function to access a tuple item but there is no built-in equivalent for lists:

# When counting the elements in a data structure, Elixir also abides by a simple rule:
# the function is named size if the operation is in constant time (i.e. the value is pre-calculated)
# or length if the operation is linear (i.e. calculating the length gets slower as the input grows).
# As a mnemonic, both “length” and “linear” start with “l”.


###### Port, Reference, and PID data types (usually used in process communication) ######

# See Processes chapter

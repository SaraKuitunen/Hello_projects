# Elixir
# Protocols

# Protocols are a mechanism to achieve POLYMORPHISM in Elixir
# when you want BEHAVIOR to vary depending on the DATA TYPE.

# possible solution via PATTERN MATCHING and GUARD CLAUSES
defmodule Utility do
  def type(value) when is_binary(value), do: "string"
  def type(value) when is_integer(value), do: "integer"
  # ... other implementations ...
end

Utility.type("foo") # "string"
Utility.type(123) # "integer"

# In contract to pattern matching and guard clauses,
# protocols allow us to EXTEND THE ORIGINAL BEHAVIOR for as many data types as we need.
# !!! That’s because DISPATCHING on a PROTOCOL is available to any DATA TYPE that has
# IMPLEMENTED the protocol and a protocol can be implemented by anyone, at any time!!!

# Utility.type/1 functionality as a protocol
defprotocol Utility do
  @spec type(t) :: String.t()
  def type(value)
end

defimpl Utility, for: BitString do # add implementation of the protocol
  def type(_value), do: "string"
end

defimpl Utility, for: Integer do
  def type(_value), do: "integer"
end

Utility.type("foo") # "string"
Utility.type(123) # "integer"

# The output is exactly the same as if we had a single module with multiple functions

# With protocols, however, we are no longer stuck having to continuously
# modify the same module to support more and more data types.

# Functions defined in a protocol may have more than one input,
# but the dispatching will always be based on the data type of the first input.

###### Example

defprotocol Size do
  @doc "Calculates the size (and not the length!) of a data structure"
  def size(data)
end

# The Size protocol expects a function called size that receives one argument
# (the data structure we want to know the size of) to be implemented.

defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end

Size.size("string") # 6
Size.size(%{key: "value"}) # 1
Size.size({1,2,3,4}) # 4

Size.size([1,2,3])
#** (Protocol.UndefinedError) protocol Size not implemented for [1, 2, 3] of type List
#    iex:32: Size.impl_for!/1
#    iex:34: Size.size/1

# It’s possible to implement protocols for all Elixir data types:
# Atom
# BitString
# Float
# Function
# Integer
# List
# Map
# PID
# Port
# Reference
# Tuple

###### Protocols and structs

# although structs are maps, they do not share protocol implementations with maps
# Instead of sharing protocol implementation with maps, structs require their own protocol implementation.

# Since a MapSet has its size precomputed and accessible through MapSet.size/1, we can define a Size implementation for it
defimpl Size, for: MapSet do
  def size(set), do: MapSet.size(set)
end

new_set = %MapSet{} = MapSet.new
MapSet.size(set) # 0
Size.size(set) # 0

# If desired, you could come up with your own semantics for the size of your struct.
# Not only that, you could use structs to build more robust data types,
# like queues, and implement all relevant protocols, such as Enumerable and possibly Size, for this data type.

defmodule User do
  defstruct [:name, :age]
end

defimpl Size, for: User do
  def size(_user), do: 2
end

Size.size(%User{}) # 2

###### Implementing Any

# To avoid manually implementing protocols for all types, implement the ptotocol for Any
# to either derive protocol implementations for our types or automatically implement the protocol for all types

### Deriving

defimpl Size, for: Any do
  def size(_), do: 0
end

defmodule OtherUser do
  @derive [Size]
  defstruct [:name, :age]
end

# When deriving, Elixir will implement the Size protocol for OtherUser
# based on the implementation provided for Any. -> size will be 0!

Size.size(%OtherUser{}) # 0 !!!

### Fallback to Any

# tell the protocol to fallback to Any when an implementation cannot be found.

defprotocol Size do
  @fallback_to_any true
  def size(data)
end

defimpl Size, for: Any do
  def size(_), do: 0
end

defmodule User do
  defstruct name: "John", age: 27
end

# Now all data types (including structs) that have not implemented
# the Size protocol will be considered to have a size of 0
Size.size(%{}) # 0

# the implementation of Size (the protocol) for Any is not one that can apply to any data type.
# For the majority of protocols, raising an error when a protocol is not implemented is the proper behaviour.

# Which technique is best between deriving and falling back to Any depends on the use case but,
# given Elixir developers prefer explicit over implicit, you may see many libraries pushing towards the @derive approach.


###### Built-in protocols

# Enumerable
Enum.reduce([1,2,4], 0, fn x, acc -> x + acc end) # 7

# String.Chars protocol: specifies how to convert a data structure
# to its human representation as a string. It’s exposed via the to_string function
to_string :hello # "hello"

# Notice that string interpolation in Elixir calls the to_string function
"age: #{25}" # "age: 25"

# Above works because numbers implement the String.Chars protocol

# Passing a tuple, for example, will lead to an error
"tuple: #{{1,2}}"
#** (Protocol.UndefinedError) protocol String.Chars not implemented for {1, 2} of type Tuple

# “print” a more complex data structure using the inspect function, based on the Inspect protocol
# The Inspect protocol is the protocol used to transform any data structure into a readable textual representation.
"tuple: #{inspect {:ok, "hello"}}"  # "tuple: {:ok, \"hello\"}"
"tuple: #{inspect {1,2}}" # "tuple: {1, 2}"

# whenever the inspected value starts with #, it is representing a data structure in non-valid Elixir syntax.
# This means the inspect protocol is not reversible as information may be lost along the way
inspect &(&1+2) # "#Function<44.40011524/1 in :erl_eval.expr/5>"

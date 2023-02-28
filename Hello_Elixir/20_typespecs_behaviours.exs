# Elixir
# Typespecs and behaviours

###### Types and specs

# Elixir is a dynamically typed language, so all types in Elixir are checked at runtime.
# Nonetheless, Elixir comes with typespecs, which are a notation used for:
# 1. declaring typed function signatures (also called specifications);
# 2. declaring custom types.

### Function specifications

# Elixir provides many built-in types, such as integer or pid, that can be used to document function signatures.

# For example, in its documentation (https://hexdocs.pm/elixir/Kernel.html#round/1), round/1’s typed signature is written as:
round(number()) :: integer()

# The syntax is to put the function and its input on the left side of the ::
# and the return value’s type on the right side. Be aware that types may omit parentheses.

# In code, function specs are written with the
@spec
# attribute

# Elixir supports compound types as well.
# For example, a list of integers has type [integer], or maps that define keys and types

# typespecs docs: https://hexdocs.pm/elixir/typespecs.html#types-and-their-syntax

### Defining custom types

# Defining custom types can help communicate the intention of your code and increase its readability.
# Custom types can be defined within modules via the @type attribute.

# @typedoc attribute is used to document custom types.
defmodule Person do
  @typedoc """
  A 4 digit year, e.g. 1984
  """
  @type year :: integer

  @spec current_age(year) :: integer
  def current_age(year_of_birth), do: # implementation
end

# Tuples are a compound type and each tuple is identified by the types inside it (in this case, a number and a string).
defmodule LousyCalculator do
  @typedoc """
  Just a number followed by a string.
  """
  @type number_with_remark :: {number, String.t}

  @spec add(number, number) :: number_with_remark
  def add(x, y), do: {x + y, "You need a calculator to do that?"}

  @spec multiply(number, number) :: number_with_remark
  def multiply(x, y), do: {x * y, "It is like addition on steroids."}
end

# Custom types defined through @type are exported and are available outside the module they’re defined in

### Static code analysis

# Typespecs are not only useful to developers as additional documentation.
# The Erlang tool Dialyzer, for example, uses typespecs in order to perform static analysis of code.


###### Behaviours

# BEHAVIOURS provide a way to:
  # define a set of functions that have to be implemented by a module;
  # ensure that a module implements all the functions in that set.

# Unlike Protocols, behaviours are independent of the type/data.

### Defining behaviours

# Say we want to implement a bunch of parsers, each parsing structured data:
# for example, a JSON parser and a MessagePack parser.
# Each of these two parsers will behave the same way:
# both will provide a parse/1 function and an extensions/0 function.

# create a Parser BEHAVIOUR:
defmodule Parser do
  @doc """
  Parses a string. return an Elixir representation of the structured data
  """
  @callback parse(String.t) :: {:ok, term} | {:error, String.t}

  @doc """
  Lists all supported file extension. return a list of file extensions that can be used for each type of data
  """
  @callback extensions() :: [String.t]
end

# Modules adopting the Parser behaviour will have to implement all the functions
# defined with the @callback attribute. @callback expects a function name and a function specification.

# the "term" type is used to represent the parsed value.
# In Elixir, the "term" type is a shortcut to represent any type.


### Adopting behaviours

defmodule JSONParser do
  @behaviour Parser

  @impl Parser
  def parse(str), do: {:ok, "some json " <> str} # ... parse JSON

  @impl Parser
  def extensions, do: ["json"]
end

import JSONParser
parse("to be parsed.") # {:ok, "some json to be parsed."}
extensions() # ["json"]

# incorrect argument throws an error
parse(1)
#** (ArgumentError) errors were found at the given arguments:
#  * 1st argument: not a bitstring
#    :erlang.byte_size(1)
#    iex:25: JSONParser.parse/1

defmodule YAMLParser do
  @behaviour Parser

  @impl Parser
  def parse(str), do: {:ok, "some yaml " <> str} # ... parse YAML

  @impl Parser
  def extensions, do: ["yml"]
end

# If a module adopting a given behaviour doesn’t implement one of the callbacks
# required by that behaviour, a compile-time warning will be generated.

# Furthermore, with @impl you can also make sure that you are implementing
# the correct callbacks from the given behaviour in an explicit manner.
# For example, if JSONParser would implement parse/0 instead of parse/1, warning would be given.


### Dynamic dispatch

# Behaviours are frequently used with dynamic dispatching.
# For example, we could add a parse! function to the Parser module that dispatches
# to the given implementation and returns the :ok result or raises in cases of :error:

defmodule Parser do
  @callback parse(String.t) :: {:ok, term} | {:error, String.t}
  @callback extensions() :: [String.t]

  def parse!(implementation, contents) do
    case implementation.parse(contents) do
      {:ok, data} -> data
      {:error, error} -> raise ArgumentError, "parsing error: #{error}"
    end
  end
end

# --> import Parser, import JSONParser
parse!(JSONParser,"to be parsed") # "some json to be parsed". Equivivalent to: Parser.parse!(JSONParser,"to be parsed")
parse!(JSONParser,0)
#** (ArgumentError) errors were found at the given arguments:
#  * 1st argument: not a bitstring
#    :erlang.byte_size(0)
#    iex:45: JSONParser.parse/1
#    iex:45: Parser.parse!/2

parse!(YAMLParser, "to be parsed") # "some yaml to be parsed"
parse!(YAMLParser, 4)
#** (ArgumentError) errors were found at the given arguments:
#  * 1st argument: not a bitstring
#    :erlang.byte_size(4)
#    iex:51: YAMLParser.parse/1
#    iex:45: Parser.parse!/2

# Note you don’t need to define a behaviour in order to dynamically dispatch on a module,
# but those features often go hand in hand.

# Elixir
# MODULES and FUNCTIONS

# https://elixir-lang.org/getting-started/modules-and-functions.html

# Elixir functions return the last executed statement
  # https://stackoverflow.com/questions/37445838/returning-values-in-elixir
  # https://elixir-examples.github.io/examples/return-early


# MODULES: In Elixir we group several functions into modules

# defmodule macro is used to define macros.
# def and defp macros are used to define functions in the modules

###### Compilation

# Most of the time it is convenient to write modules into files so they can be compiled and reused

# compile a file: elixirc name.ex
# -> generates Elixir.Name.beam file containing the bytecode for the module
# -> module definition is available in iex, if iex is opened in the same directory the bytocode file is in

# Elixir projects are usually organized into three directories:

# _build - contains compilation artifacts
# lib - contains Elixir code (usually .ex files)
# test - contains tests (usually .exs files)

# When working on actual projects, the build tool called mix will be responsible
# for compiling and setting up the proper paths for you


###### Scripted mode

# For learning and convenience purposes, Elixir also supports a scripted mode
# which is more flexible and does not generate any compiled artifacts.

# .exs extension instead of .ex
# .ex files are meant to be compiled while .exs files are used for scripting.
# Elixir treats both files exactly the same way

# execute: elixir name.exs -> compiles and loads the file into memory, but no .beam file is written to disk


###### Named functions

# def -> function can be invoked from other modules
# defp -> a private function can only be invoked locally

# Function declarations also support guards and multiple clauses.
# If a function has several clauses, Elixir will try each clause until it finds one that matches.

defmodule Math do
  def zero?(0) do # The trailing question mark in zero? means that this function returns a boolean
    true
  end

  # same function name can be used for same type of function (defp zero?() would give Compilation error)
  def zero?(x) when is_integer(x) do
    false
  end

  defp do_zero?(x) do
    if x === 0, do: "is zero", else: "not zero"
  end
end

# compile: elixirc 8_modules_and_functions.ex
# run below in iex:
IO.puts Math.zero?(0) # true  :ok
IO.puts Math.zero?(1) # false :ok
# IO.puts Math.zero?(1.1) # ** (FunctionClauseError) no function clause matching in Math.zero?/1

# IO.puts Math.do_zero?(1.1)# ** (UndefinedFunctionError) function Math.do_zero?/1 is undefined or private.

###### Function capturing

# & capture operator

fun = &Math.zero?/1 # capture named function zero?/1 to fun variable
is_function(fun) # true, fun is a anonymous function
fun.(0) # true, Remebber that anonymous function must be invoked with a dot

# Local or imported functions can be captured without the module
&is_function/1 # &:erlang.is_function/1
(&is_function/1).(fun) # true

# capture syntax can also be used as a shortcut for creating functions
# The &1 represents the first argument passed into the function
fun = &(&1 +1) #Function<44.40011524/1 in :erl_eval.expr/5>. SAME as fn x -> x + 1 end
fun.(3) # 4

fun2 = &"This is #{&1}, right #{&2}?" #Function<44.40011524/1 in :erl_eval.expr/5>
fun2.("magic", "John") # "This is magic, right John?"

# documentation: https://hexdocs.pm/elixir/Kernel.SpecialForms.html#&/1

###### Default arguments

# Named functions in Elixir support default arguments

defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end

  # If a function with default values has multiple clauses,
  # it is required to create a function head
  # (a function definition without a body) for declaring defaults
  def join_2(a, b \\ nil, sep \\ " ") # a function head

  # When b is not given
  # The leading underscore in _sep means that the variable will be ignored in this function
  def join_2(a, b, _sep) when is_nil(b) do
    a
  end

  def join_2(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world") # Hello world
IO.puts Concat.join("Hello", "world", "_") # Hello_world

IO.puts(Concat.join_2("Hello", "world", ".")) # Hello.world
IO.puts Concat.join_2("Hello", "world") # Hello world
IO.puts Concat.join_2("Hello") # Hello

# When using default values, one must be careful to avoid overlapping function definitions!

# Elixir
# RECURSION

# https://elixir-lang.org/getting-started/recursion.html

# functional programming language VS imperative programming language
# https://docs.microsoft.com/en-us/dotnet/standard/linq/functional-vs-imperative-programming

# The functional programming paradigm was explicitly created
# to support a pure functional approach to problem solving.
# Functional programming is a form of declarative programming.
# a functional approach involves composing the problem as a set of functions to be executed

# In contrast, most mainstream languages, including object-oriented programming (OOP) languages
# such as C#, Visual Basic, C++, and Java, were designed to primarily support imperative (procedural) programming.
# Code specifies the steps that the computer must take to accomplish the goal

# What is difference between functional and imperative programming languages?
# https://stackoverflow.com/questions/17826380/what-is-difference-between-functional-and-imperative-programming-languages
# Advantages of Pure Functions: pure functions are composable: that is, self-contained and stateless.
# Each function is designed to accomplish a specific task given its arguments. The function does not rely on any external state.
# -> Increased readability and maintainability.

# What does composability mean in context of functional programming?
# https://stackoverflow.com/questions/2887013/what-does-composability-mean-in-context-of-functional-programming

# Functional programming vs Object Oriented programming
# https://stackoverflow.com/questions/2078978/functional-programming-vs-object-oriented-programming

# OOP vs Functional Programming vs Procedural
# https://stackoverflow.com/questions/552336/oop-vs-functional-programming-vs-procedural

# Functional Programming vs. OOP
# https://softwareengineering.stackexchange.com/questions/9730/functional-programming-vs-oop

# Functional, Declarative, and Imperative Programming
# https://stackoverflow.com/questions/602444/functional-declarative-and-imperative-programming


###### Loops through recursion

# Immutability -> loops in Elixir (as in any functional programming language) are written differently from imperative languages
# recursion: a function is called recursively until a condition is reached
# that stops the recursive action from continuing. No data is mutated in this process.

# Similar to case, a function may have many clauses.
# A particular clause is executed when the arguments passed to the function match
# the clause’s argument patterns and its guards evaluate to true.

# passing an argument that does not match any clause, Elixir raises a FunctionClauseError

defmodule Recursion do
  def print_multiple_times(msg, n) when n > 0 do
    # "when n > 0 do" is a guard. When it evalueates to false, Elixir tries the next function clause
    IO.puts(msg)
    print_multiple_times(msg, n - 1) # calls itself passing n - 1 as second argument
  end

  # termination clause returning the atom :ok
  def print_multiple_times(_msg, 0) do #  NOTE, that msg argument is ignored and the second parameter is 0, instead of n
    :ok
  end
end

###### Reduce and map algorithms

# Reduce algorithm: The process of taking a list and reducing it down to one value. It is central to functional programming.

defmodule Reduce do
  # summarize items in a list
  def sum_list([head | tail], accumulator) do
    # add the head of the list to the accumulator and call sum_list again,
    # recursively, passing the tail of the list as its first argument
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do # when the list is emty, this clause will match
    accumulator # return accumulator that contains the sum of the items in the given list
  end
end

# Call the sum_list function. NOTE that this function sums the items in the list and the 2. argument.
# So, 0 must be given as the 2. argument, if only items in the list are wanted to be summarized
IO.puts Reduce.sum_list([1,3,5,7], 0) # 16  :ok

# double items in a list, ANTISOLUTION
defmodule Double do
  # accumulator is argument is given as emty list []
  def double_list([head | tail], accumulator) do
    double_list(tail, accumulator ++ [head * 2]) # NOTE, that multiplication result needs to be given as list to be correctly inserted in the accumulator list
  end

  def double_list([], accumulator) do # when the list is emty, this clause will match
    accumulator # return accumulator that contains the sum of the items in the given list
  end
end

# Call double_list, give accumulator argument as empty list
# NOTE that when double_list function definitions were inside Reduce module, the below error was given
# IO.puts Reduce.double_list([1,2,3], []) # ** (UndefinedFunctionError) function Reduce.double_list/2 is undefined or private
IO.puts Double.double_list([1,2,3], []) # ^B^D^F  :ok

# double items in a list, CORRECT solution
# The process of taking a list and mapping over it is known as a MAP algorithm.

defmodule Math do
  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end

# HOW does the returned list gets saved here?
# NOTE, that the double_each() call is inside the list that gets returned
# Run Math.double_each([1, 2, 3]) --> head: 1, tail: [2,3]
# --> [1 * 2 | double_each([2,3])]
# --> [1 * 2 | [2 * 2 | double_each([3])]]
# --> [1 * 2 | [2 * 2 | [3 * 2 | double_each([])]]]
# --> [1 * 2 | [2 * 2 | [3 * 2 | []]]]
# is same as [2 | [4 | [6 | []]]]
# is same as [2, 4, 6]

# [1 * 2 | [2 * 2 | [3 * 2 | []]]] === [2,4,6] # true

Math.double_each([1, 2, 3])

# The Enum module provides many conveniences for working with lists.
# For instance, the examples above could be written as
Enum.reduce([1,2,3], 0, fn(x, acc) -> x + acc end) # 6
Enum.map([1,2,3], fn(x) -> x * 2 end)

# Same with capture syntax
Enum.reduce([1,2,3], 0, &+/2) # this is equivalent to this: Enum.reduce([1,2,3], 0, &(&1 + &2)), https://elixirforum.com/t/why-is-the-capture-syntax-2-equivalent-to-1-2/1031
Enum.map([1,2,3], &(&1 *2))

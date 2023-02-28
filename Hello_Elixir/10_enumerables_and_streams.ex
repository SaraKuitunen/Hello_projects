# Elixir
# ENUMERABLES and STREAMS

###### Enumerables

# Elixir provides the concept of enumerables (e.g. lists and maps) and the Enum module to work with them.

# lists
Enum.map([1,2,3], fn x -> x * 2 end) # [2, 4, 6]

# maps
Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end) # [2, 12]

# ranges
Enum.map(1..3, fn x -> x * 2 end) # [2, 4, 6]

Enum.reduce(1..3, 0, &+/2) # 6

# We say the functions in the Enum module are polymorphic because they can work with diverse data types.
# In particular, the functions in the Enum module can work with any data type that implements the Enumerable protocol.

# The functions in the Enum module are limited to enumerating values in data structures.
# For specific operations, like inserting and updating particular elements,
# reach for modules specific to the data type.

###### Eager vs Lazy

# All the functions in the Enum module are eager. Many functions expect an enumerable and return a list back

odd? = &(rem(&1, 2), != 0)

1..100000 |> # starts with a range
Enum.map(&(&1* 3)) |> # multiply each elem in the range by three and returns a list
Enum.filter(odd?) |> # keep odd values and returns a new list
Enum.sum() # sum all values in the list -> 7500000000

###### The pipe operator

# The |> symbol used in the snippet above is the pipe operator:
# it takes the output from the expression on its left side and
# passes it as the first argument to the function call on its right side.

# Its purpose is to highlight the data being transformed by a series of functions.

# above without using pipe operator |>
Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?))

# pipe documentation: https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2

###### Streams

# Focus on the Enum module first and only move to Stream for the particular scenarios
# where laziness is required, to either deal with slow resources or large, possibly infinite, collections.

# As an alternative to Enum, Elixir provides the Stream module which supports lazy operations
# Streams are lazy, composable enumerables

# Many functions in the Stream module accept any enumerable as an argument and return a stream as a result.

# Steams are composable because we can pipe many stream operations

# this stream pipes stream operations map and filter??
1..100000 |> Stream.map(&(&1 * 3)) # returns a data type, an actual stream, that represents the map computation over the range 1..100_000 --> Stream<[enum: 1..100000, funs: [#Function<47.58486609/1 in Stream.map/2>]]>
|> Stream.filter(odd?) # build a series of computations ? Stream<[enum: 1..100000, funs: [#Function<47.58486609/1 in Stream.map/2>, #Function<39.58486609/1 in Stream.filter/2>]]>
|> Enum.sum # 7500000000. passage to Enum module invokes the series of computations

# Instead of generating intermediate lists, streams build a series of computations
# that are invoked only when we pass the underlying stream to the Enum module.
# Streams are useful when working with large, possibly infinite, collections.

# Steam module also provides functions for creating streams.
  # Stream.cycle/1 can be used to create a stream that cycles a given enumerable infinitely.
  # Stream.unfold/2 can be used to generate values from a given initial value
  # Stream.resource/3 can be used to wrap around resources, guaranteeing
    # they are opened right before enumeration and closed afterwards, even in the case of failures

# Elixir
# KEYWORD LISTS and MAPS

# https://elixir-lang.org/getting-started/keywords-and-maps.html

# In Elixir, has two main associative data structures: keyword lists and maps.
# associative data structures are data structures that are able to
# associate a certain value (or multiple values) to a key.

# Different languages call these different names like dictionaries, hashes, associative arrays, etc.


###### Keyword lists

# a list of tuples, where the first item of the tuple (i.e. the key) is an atom

list = [{:a, 1}, {:b, 2}] # [a: 1, b: 2]
list == [a: 1, b: 2] # true. Elixir supports a special syntax for defining such lists: [key: value]

# list operations can be used
new_list = [a: 0] ++ list
new_list[:a] # 0, Note that values added to the front are the ones fetched on lookup

# Keyword lists are important because they have three special characteristics:
  # Keys must be atoms.
  # Keys are ordered, as specified by the developer.
  # Keys can be given more than once.

# For example, the Ecto library makes use of these features to provide an elegant DSL for writing database queries:
query =
  from w in Weather,
    where: w.prcp > 0,
    where: w.temp < 20,
    select: w

# keyword lists are the default mechanism for passing options to functions in Elixir.
# In general, when the keyword list is the last argument of a function, the square brackets are optional.
if false, do: :this, else: :that # :that. The do: and else: pairs form a keyword list!

# Although it is possible pattern match on keyword lists, it is rarely done in practice
# since pattern matching on lists requires the number of items and their order to match:

# In order to manipulate keyword lists, Elixir provides the Keyword module.

# Remember, keyword lists are simply lists, and as such they provide the same linear performance characteristics as lists.
# NOTE, to store many items or guarantee one-key associates with at maximum one-value, use maps instead.

###### Maps

# maps are the “go to” data structure for a key-value store
map = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
map[:a] # 1
map[2] # :b
map[:b] # nil

# Compared to keyword lists:
  # Maps allow any value as a key
  # Maps’ keys do not follow any ordering
  # Keys are unique
  # Maps are useful with pattern matching

# When a map is used in a pattern, it will always match on a subset of the given value:
# A map matches as long as the keys in the pattern exist in the given map. Therefore, an empty map matches all maps.
%{} = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
%{:a => a} = %{:a => 1, 2 => :b} # %{2 => :b, :a => 1}
a # 1

%{:c => c} = %{:a => 1, 2 => :b} # ** (MatchError) no match of right hand side value: %{2 => :b, :a => 1}

# Variables can be used when accessing, matching and adding map keys
n = 1
map = %{n => :one} # %{1 => :one}
map[n] # :one
%{^n => :one} = %{1 => :one, 2 => :two, 3 => :three} # %{1 => :one, 2 => :two, 3 => :three}
%{n => :one} = %{1 => :one, 2 => :two, 3 => :three} # ** (CompileError) iex:74: cannot use variable n as map key inside a pattern. Map keys in patterns can only be literals (such as atoms, strings, tuples, and the like) or an existing variable matched with the pin operator (such as ^some_var)

# The Map module provides an API with convenience functions to manipulate maps
Map.get(%{:a => 1, 2 => :b}, :a) # 1
Map.get(%{"a" => 1, "2" => :b}, "a")
Map.put(%{:a => 1, 2 => :b}, :c, 3 ) # %{2 => :b, :a => 1, :c => 3}
Map.put(%{:a => 1, 2 => :b}, :a, 3 ) # NOTE, that keys are unique. adding existing key replases the original %{2 => :b, :a => 3}
Map.to_list(%{:a => 1, 2 => :b}) # [{2, :b}, {:a, 1}]

# Update values
map = %{:a => 1, 2 => :b}
%{map | 2 => :two} # %{2 => :two, :a => 1}, NOTE, that the key needs to be found in the map

# When all the keys in a map are atoms, you can use the keyword syntax for convenience
map = %{c: 1, d: 2} # %{c: 1, d: 2}

# access values of ATOM keys
# Elixir developers typically prefer to use the map.key syntax/ notation and pattern matching instead of
# the functions in the Map module when working with maps because they lead to an assertive style of programming
# Blog post on how to get more concise and faster software by writing assertive code in Elixir: https://dashbit.co/blog/writing-assertive-code-with-elixir
map.c # 1
map.e # ** (KeyError) key :e not found in: %{2 => :b, :a => 1}

# dynamic access returns nil, instead of an error, when key is not found
map[:c] # 1
map[:e] # nil

# PREFER STRICT SYNTAX when possible as it helps us find bugs early on

# Comprehensions and :into option can be used to transform values in a map
for {key, val} <- %{:a => 1, :b => 2}, into: %{}, do: {key, val * val} # %{a: 1, b: 4}

###### Nested data structures

# Macros for manipulating nested data structures
  # put_in/2
  # update_in/2
  # get_and_update_in/2 -> extract a value and update the data structure at once

  # macros allowing dynamic access into the data structure
  # put_in/3
  # update_in/3
  # get_and_update_in/3

# see documentation: https://hexdocs.pm/elixir/Kernel.html

users = [john: %{name: "john", age: 23, languages: ["Elixir", "Erlang"]},
        mary: %{name: "Mary", age: 31, languages: ["R", "Python", "C#"]}
      ]

# access values
users[:john].languages # ["Elixir", "Erlang"]

# update values
users = put_in(users[:john].languages, ["Elixir", "Erlang", "JavaScript"]) # NOTE, that this input replaces the original value
users = put_in users[:john].languages, ["Elixir", "Erlang", "JavaScript"]  # Parenthesis are optional

# The update_in/2 macro is similar but allows us to pass a function that controls how the value changes
users = update_in users[:john].languages, fn languages ->
  List.delete(languages, "Erlang") end

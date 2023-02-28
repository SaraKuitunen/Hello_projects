# Elixir
# Comprehensions

# In Elixir, it is common to loop over an Enumerable, often filtering out some results
# and mapping values into another list. Comprehensions are syntactic sugar for such constructs:
# they group those common tasks into the for special form.

# A comprehension is made of three parts: generators, filters, and collectables.


###### Generators and filters

# Comprehensions generally provide a much more concise representation
# than using the equivalent functions from the Enum and Stream modules

# Generator
for n <- [1,3,6], do: n * n # [1, 9, 36]

# Generator expressions support pattern matching on their left-hand side
values = [good: 1, good: 3, bad: 6]
for {:good, n} <- values, do: n * n # [1, 9]

# filters can be used to select some particular elements
# Comprehensions discard all elements for which the filter expression returns false or nil
for n <- 0..5, rem(n, 3) === 0, do: n * n # [0,9]

# comprehensions allow multiple generators and filters to be given
dirs = ['/Users/sarakuitunen/Movies', '/Users/sarakuitunen/Downloads']

for dir <- dirs,
  file <- File.ls!(dir),
  path = Path.join(dir, file),
  File.regular?(path) do # Returns true if the path is a regular file.
    File.stat!(path).size # File.stat!(path) returns information about the path: File.Stat struct.
  end
  # [0, 162, 162, 162, 4377704, 14340, 162, 0, 162, 2231864, 162, 162, 162, 2543559, 162, 162, 16901]

for dir <- dirs,
  file <- File.ls!(dir),
  path = Path.join(dir, file),
  size = File.stat!(path).size,
  File.regular?(path) and size > 1000 do # Returns true if the path is a regular file and size is larger than 1000 bytes
    {file, size} # returns filename and file size
  end

#  [
#    {"lab meeting Jukarainen 20122021.pdf", 4377704},
#    {".DS_Store", 14340},
#    {"Notes_2021_1.docx", 2231864},
#    {"Notes_2021_2.docx", 2543559},
#    {"risteys_dir_struct_MVC_20210923.drawio", 16901}
#  ]

# calculate the cartesian product of two lists
for i <- [:a, :b, :c], j <- [1,2], do: {i,j} # [a: 1, a: 2, b: 1, b: 2, c: 1, c: 2]

# NOTE, variable assignments inside the comprehension are not reflected outside of the comprehension.

###### Bitstring generators

#  A bitstring is a contiguous sequence of bits in memory. Elixir data type. denoted with the <<>> syntax (bitstring constructor)

# Bitstring generators are also supported and are very useful when you need to comprehend over bitstring streams.

pixels = <<213, 45, 546, 53, 64, 224>>
is_bitstring(pixels) # true
for <<r::8, g::8, b::8 <- pixels>>, do: {r, g, b} # [{213, 45, 34}, {53, 64, 224}]

# A bitstring generator can be mixed with “regular” enumerable generators, and supports filters as well.


###### The :into option

# result of a comprehension can be inserted into different data structure than list
#  by passing the :into option to the comprehension

# \s resolves to 32, which is the character code of a space. -> c != ?\s filters out empty spaces. e.g. c != ?o would filter out o-letters
# into: "" -> returns a string
for <<c <- " hello world ">>, c != ?\s, into: "", do: <<c>>  # "helloworld"

# Note, that adding "!" causes this to return empty string
for <<c <- " hello world! ">>, c != ?\s, into: "", do: <<>> # ""

# Sets, maps, and other dictionaries can also be given to the :into option.
# In general, :into accepts any structure that implements the COLLECTABLE protocol.

# transform values in a map
for {key, val} <- %{"a" => 1, "b" => 2}, into: %{}, do: {key, val * val} # %{"a" => 1, "b" => 4}
for {key, val} <- %{:a => 1, :b => 2}, into: %{}, do: {key, val * val} # %{a: 1, b: 4}

# Since the IO module provides streams (that are both Enumerables and Collectables),
# an echo terminal that echoes back the upcased version of whatever is typed can be implemented using comprehensions
stream = IO.stream(:stdio, :line) # %IO.Stream{device: :standard_io, line_or_bytes: :line, raw: false}

for line <- stream, into: stream do
  String.upcase(line) <> "\n"
end

# type any string into the terminal and you will see that the same value will be printed in upper-case.
# Unfortunately, this example also got your IEx shell stuck in the comprehension,
# so you will need to hit Ctrl+C twice to get out of it.


###### Other options

# Comprehensions support other options, such as:
:reduce
:uniq

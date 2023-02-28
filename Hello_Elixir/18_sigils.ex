# Elixir
# Sigils

# In Elixir, many many structures have textual representation

# Sigils are one of the mechanisms for working with textual representations.
# Sigils in Elixir: regular expressions, strings, char lists, word lists, calendar sigils, and custom sigils

# formed of
# 1. a tilde (~)
# 2. a letter (which identifies the sigil)
# 3. a delimiter
# (4.) optionally, modifiers can be added after the final delimiter.


###### Regular expressions

# A regular expression that matches strings which contain "foo" or "bar"
regex = ~r/foo|bar/
"foo" =~ regex # true
"ba" =~ regex # false
"BAR" =~ regex # false

# Elixir provides Perl-compatible regular expressions (regexes). Regex module: https://hexdocs.pm/elixir/Regex.html
# Regexes also support modifiers.
# For example, the i modifier makes a regular expression case insensitive
"HELLO" =~ ~r/hello/i # true


# supported delimiters:
~r/hello/
~r|hello|
~r"hello"
~r'hello'
~r(hello)
~r[hello]
~r{hello}
~r<hello>


###### Strings, char lists, and word lists sigils

### Strings

# The ~s sigil is used for generating strings, like double quotes are. Useful, when string contails double quotes.
~s(A string with "double" quotes) # "A string with \"double\" quotes"

is_binary(~s(A string with "double" quotes)) # true
is_binary("A string with \"double\" quotes") # true
is_binary('single quotes') # false


### Char lists

# The ~c sigil is useful for generating char lists that contain single quotes
~c(this is a char list containing 'single quotes') # 'this is a char list containing \'single quotes\''


### Word lists

# The ~w sigil is used to generate lists of words
~w(foo bar baz) # ["foo", "bar", "baz"]

# c, s and a modifiers (for char lists, strings, and atoms, respectively),
# can be used to specify the data type of the elements of the resulting list
~w(foo bar baz)a # [:foo, :bar, :baz]


###### Interpolation and escaping in string sigils

# lowercase letter sigils perform escaping and interpolation, but uppercse letter sigils do not
~s(String with escape codes \x26 #{"inter" <> "polation"}) # "String with escape codes & interpolation"
~S(String with escape codes \x26 #{"inter" <> "polation"}) # "String with escape codes \\x26 \#{\"inter\" <> \"polation\"}"


# The following escape codes can be used in strings and char lists:

#\\ – single backslash
#\a – bell/alert
#\b – backspace
#\d - delete
#\e - escape
#\f - form feed
#\n – newline
#\r – carriage return
#\s – space
#\t – tab
#\v – vertical tab
#\0 - null byte
# \uDDDD and \u{D...} - represents a Unicode codepoint in hexadecimal (such as \u{1F600})
#\xDD - represents a single byte in hexadecimal (such as \x13)


#Plus, \" escapes a double quote inside a double-quoted string,
#and, \' escapes a single quote inside a single-quoted char list
#Nevertheless, it is better style to change delimiters than to escape them.


# Sigils also support heredocs, that is, three double-quotes or single-quotes as separators
#iex(1)> ~s"""
#...(1)> this is a heredoc string
#...(1)> """

# -> "this is a heredoc string\n"


###### Calendar sigils

### Date
# A %Date{} struct (https://hexdocs.pm/elixir/Date.html) can be created with ~D sigil
d = ~D[2022-01-03] # ~D[2022-01-03]
is_map(d) # true
d.year # 2022
d.month # 1
d.day # 3
d.calendar # Calendar.ISO

### Time
# A %Time{} struct (https://hexdocs.pm/elixir/Time.html) created with ~T sigil
t = ~T[10:42:17.3] # ~T[10:42:17.3]
t.hour #10
t.minute # 42
t.second # 17
t.microsecond # {300000, 1}
t.calendar # Calendar.ISO

### NaiveDateTime
# A %NaiveDateTime{} struct. does not contain timezone information
ndt = ~N[2022-01-03 10:46:07] # ~N[2022-01-03 10:46:07]
ndt.year # 2022
ndt.second # 7

### UTC DateTime
# A %DateTime{} struct contains same info as NaiveDateTime + fields to track timezone
dt = ~U[2022-01-03 10:46:07Z] # ~U[2022-01-03 10:46:07Z]
%DateTime{minute: minute, time_zone: time_zone} = dt # ~U[2022-01-03 10:46:07Z]
minute # 46
time_zone # "Etc/UTC"


###### Custom sigils
~r/foo/i # ~r/foo/i
sigil_r(<<"foo">>, 'i') # ~r/foo/i
sigil_r(<<"foo">>, 'i') == ~r/foo/i # true

# We can also provide our own sigils by implementing functions that follow the sigil_{character} pattern
defmodule MySigils do
  def sigil_i(string, []), do: String.to_integer(string)
  def sigil_i(string, [?n]), do: -String.to_integer(string)
end

# run in terminal:
# elixirc 19_sigils.ex
# import MySigils
# ~i(13) # 13
# ~i(42)n # -42

# Elixir
# Binaries, strings, and charlists

# https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html

###### Unicode and Code Points

# The Unicode Standard acts as an official registry of virtually all the characters we know
# -> ones and zeros on one machine mean the same thing when they are transmitted to another

# Unicode organizes all of the characters in its repertoire into code charts,
# and each character is given a unique numerical index. This numerical index is known as a Code Point.

# use a ? in front of a character literal to reveal its code point
?a # 97
?1 # 49

# Note that most Unicode code charts will refer to a code point by its hexadecimal representation,
# e.g. 97 translates to 0061 in hex, and we can represent any Unicode character in an Elixir string
# by using the \u notation and the hex representation of its code point number
"\u0061" === "a" # true
0x0061 = 97 = ?a #97. these match

0x0061 === 97 # true
97 === ?a # true
0x0061 === ?a # true

"\u0061" === 97 # false


###### UTF-8 and Endcodings

# Whereas the code point is WHAT we store, an encoding deals with HOW we store it: encoding is an implementation.
# In other words, we need a mechanism to convert the code point numbers into bytes
# so they can be stored in memory, written to disk, etc.

# Elixir uses UTF-8 to encode its strings, which means that code points are encoded as a series of 8-bit bytes.
# UTF-8 is a VARIABLE WIDTH character encoding that uses one to four bytes to store each code point;
# it is capable of encoding all valid Unicode code points.

# UTF-8 also provides a notion of graphemes.
# Graphemes may consist of multiple characters that are often perceived as one.
# For example, é can be represented in Unicode as a single character and
# the combination of the character e and ´ into a single grapheme.

string = "héllo"
String.length(string) # String.length/1 counts graphemes -> returns 5
length(String.to_charlist(string)) # String.to_charlist/1 converts a string to a list of codepoints -> number of codepoints is 6
byte_size(string) # byte_size/1 reveals the number of underlying raw bytes needed to store the string when using UTF-8 encoding -> 7

# A common trick in Elixir to see the inner binary representation of a string is to concatenate the null byte <<0>> to it
"hełło" <> <<0>> # <<104, 101, 197, 130, 197, 130, 111, 0>>

# Alternatively, you can view a string’s binary representation by using IO.inspect/2:
IO.inspect("hełło", binaries: :as_binaries) # <<104, 101, 197, 130, 197, 130, 111>>   "hełło"

###### Bitstrings

# A bitstring is a fundamental data type in Elixir, denoted with the <<>> syntax.
# A bitstring is a contiguous sequence of bits in memory.

# By default, 8 bits (i.e. 1 byte) is used to store each number in a bitstring,
# but you can manually specify the number of bits via a ::n modifier to denote the size in n bits,
# or you can use the more verbose declaration ::size(n)

<<42>> === <<42::8>>
<<3::4>> # <<3::size(4)>>

# For example, the decimal number 3 when represented with 4 bits in base 2 would be 0011,
# which is equivalent to the values 0, 0, 1, 1, each stored using 1 bit
<<0::1, 0::1, 1::1, 1::1>> == <<3::4>> # true

# Any value that exceeds what can be stored by the number of bits provisioned is truncated

# 257 in base 2 would be represented as 100000001,
# but since we have reserved only 8 bits for its representation (by default),
# the left-most bit is ignored and the value becomes truncated to 00000001, or simply 1 in decimal.
<<1>> === <<257>> # true

# writing a bitstring/binary to iex shows its string reperesentation
# NOTE, that 0 is an unprintable character. If a bitstring/binary contains 0, it's not printed as a string
# Elixir can't tell the difference between just a binary, and a binary representing a string,
# when the binary representing a string contains unprintable characters.
# https://stackoverflow.com/questions/22517250/how-to-convert-an-elixir-binary-to-a-string

raw = <<84, 104, 101, 32, 102, 111, 108, 108, 111, 119, 105, 110, 103, 32, 101, 115, 99, 97, 112, 101, 32, 99, 111, 100, 101, 115, 32, 99, 97, 110, 32, 98, 101, 32, 117, 115, 101, 100, 32, 105, 110, 32, 115, 116, 114, 105, 110, 103, 115, 32, 97, 110, 100, 32, 99, 104, 97, 114, 32, 108, 105, 115, 116, 115, 58, 10, 10, 92, 32, 226, 128, 147, 32, 115, 105, 110, 103, 108, 101, 32, 98, 97, 99, 107, 115, 108, 97, 115, 104, 10, 7, 32, 226, 128, 147, 32, 98, 101, 108, 108, 47, 97, 108, 101, 114, 116, 10, 8, 32, 226, 128, 147, 32, 98, 97, 99, 107, 115, 112, 97, 99, 101, 10, 127, 32, 45, 32, 100, 101, 108, 101, 116, 101, 10, 27, 32, 45, 32, 101, 115, 99, 97, 112, 101, 10, 12, 32, 45, 32, 102, 111, 114, 109, 32, 102, 101, 101, 100, 10, 10, 32, 226, 128, 147, 32, 110, 101, 119, 108, 105, 110, 101, 10, 13, 32, 226, 128, 147, 32, 99, 97, 114, 114, 105, 97, 103, 101, 32, 114, 101, 116, 117, 114, 110, 10, 32, 32, 226, 128, 147, 32, 115, 112, 97, 99, 101, 10, 9, 32, 226, 128, 147, 32, 116, 97, 98, 10, 11, 32, 226, 128, 147, 32, 118, 101, 114, 116, 105, 99, 97, 108, 32, 116, 97, 98, 10>>
# "The following escape codes can be used in strings and char lists:\n\n\\ – single backslash\n\a – bell/alert\n\b – backspace\n\d - delete\n\e - escape\n\f - form feed\n\n – newline\n\r – carriage return\n  – space\n\t – tab\n\v – vertical tab\n"
is_bitstring(raw) # true
is_binary(raw) # true

###### Binaries

# A binary is a bitstring where the number of bits is divisible by 8!!!

is_bitstring(<<3::4>>) # true
is_binary(<<3::4>>) # false

is_bitstring(<<0, 255, 42>>) # true
is_binary(<<0, 255, 42>>) # true

# pattern match on binaries / bitstrings
<<0,1,x>> = <<0,1,2>> # <<0, 1, 2>>
x # 2

# :: binary modifiers can be used to match on a binary of unknown size
<<head::binary-size(2), rest::binary>> = <<0, 1, 2, 3>> # <<0, 1, 2, 3>>
head # <<0, 1>>
rest # <<2, 3>>

# A STRING IS A UTF-8 ENCODED BINARY, where the code point for each character is encoded using 1 to 4 bytes
is_binary("hello") # true
is_binary(<<239, 191, 19>>) # true
String.valid?(<<239, 191, 19>>) # false. not every binary is a valid string

# The string concatenation operator <> is actually a binary concatenation operator
<<head, rest::binary>> = "banana" # "banana"
head # 98.
head == ?b # true
rest # "anana"

# NOTE, that in case of word starting with amultibyte characters, the head would match the first byte of the character
# Therefore, when pattern matching on strings, it is important to use the utf8 modifier
<<x::utf8, rest::binary>> = "über"
x == ?ü # true, without utf8 modifier would be false
rest # "ber", without utf8 modifier would be <<188, 98, 101, 114>>, where 188 is the second byte of ü character


###### Charlists

# A CHARLIST IS A LIST OF INTEGERS WHERE ALL THE INTEGERS ARE VALID CODE POINTS

# charlists are created with single-quoted literals
'hello' # 'hello'
is_list('hello') # true

'hełło' # [104, 101, 322, 322, 111]
is_list('hełło') # true

# Interpreting integers as code points may lead to some surprising behavior.
# For example, if you are storing a list of integers that happen to range between 0 and 127,
# by default IEx will interpret this as a charlist and it will display the corresponding ASCII characters.
heartbeats_per_minute = [99, 97, 116] # cat
# HOW TO PREVENT THE ABOVE?

# convert a charlist to a string and back by using the to_string/1 and to_charlist/1 functions
to_charlist("hełło") # [104, 101, 322, 322, 111]
to_string('hełło') # "hełło"
to_string(:hello) # "hello
to_string(1) # "1"


# charlists, being lists, use the list concatenation operator ++
'hel' ++ 'lo'

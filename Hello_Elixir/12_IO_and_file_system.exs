# Elixir
# IO and the file system

###### The IO module

# The IO module is the main mechanism in Elixir for reading and writing to
# standard input/output (:stdio), standard error (:stderr), files, and other IO devices.
IO.puts("hello world")
IO.gets("yes or no? ")
answer =  IO.gets("yes or no? ")

# By default, functions in the IO module read from the standard input and write to the standard output.
# That can be chnaged by passing an argument
IO.puts(:stderr, "hello world")

###### The File module

# The File module contains functions that allow us to open files as IO devices.

# By default, files are opened in binary mode, which requires developers to use
# the specific IO.binread/2 and IO.binwrite/2 functions from the IO module

{:ok, file} = File.open("hello", [:write])
IO.binwrite(file, "world")
File.close(file)
File.read("hello")
# if the file does not exists, this error is given: {:error, :enoent}

# the File module has many functions to work with the file system. Those functions are named after their UNIX equivalents.
# File.rm/1 -> remove files
# File.mkdir/1 -> create directories
# File.mkdir_p/1 -> create directories and all their parent chain.
# File.cp_r/2 ->  copy files and directories recursively (i.e., copying the contents of the directories too).
# File.rm_rf/1 -> remove files and directories recursively

# functions in File module have ! verions. rerurns
# the version with ! returns the contents of the file instead of a tuple,
#  and if anything goes wrong the function raises an error.
File.read("hello") # {:ok, "world"}
File.read!("hello") # "world"

File.read("unknown") # {:error, :enoent}
File.read!("unknown") # ** (File.Error) could not read file "unknown": no such file or directory

# The version without ! is preferred when you want to handle different outcomes using pattern matching

###### The Path module

Path.join("foo", "bar") # "foo/bar"
Path.expand("~/hello") # "/Users/sarakuitunen/hello"

# Using functions from the Path module as opposed to directly manipulating strings is preferred
# since the Path module takes care of different operating systems transparently.

###### Processes

{:ok, file} = File.open("hello", [:write])
# File.open/2 returns a tuple like {:ok, pid} because the IO module actually works with processes.
# Given a file is a process, when you write to a file that has been closed,
# you are actually sending a message to a process which has been terminated

File.close(file)
IO.write(file, "is anybody out there")
# ** (ErlangError) Erlang error: :terminated
#    (stdlib 3.15.2) :io.put_chars(#PID<0.148.0>, :unicode, "is anybody out there")

###### iodata and chardata

# The functions in IO and File also allow lists to be given as arguments.
# Not only that, they also allow a mixed list of lists, integers, and binaries to be given.
# NOTE, when using lists in IO operations, depending on encoding of the IO device, the list
# should be presented either as a bunch of bytes or a bunch of characters

# Binaries are already represented by the underlying bytes and as such their representation is always “raw”.

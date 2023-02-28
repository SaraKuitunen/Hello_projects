# Elixir
# try, catch, and rescue

# Elixir has three ERROR MECHANISMS: errors, throws, and exits.

###### Errors

# Errors (or exceptions) are used when exceptional things happen in the code.
# A runtime error can be raised any time by using raise/1
raise "runtime error" # ** (RuntimeError) runtime error

# Other errors can be raised with raise/2 passing the error name and a list of keyword arguments:
raise ArgumentError, message: "invalid argument foo" # ** (ArgumentError) invalid argument foo
raise(ArgumentError, message: "invalid argument foo") # this is the same as above

# own errors can be defined inside a module by using the defexeption construct.
defmodule MyModule do
  defexception message: "default message"
end

# to use the module, comment out above lines to raise errors and the compile the module
# run in iex:
# create an error with the same name as the module it’s defined in
raise MyModule # -> ** (MyModule) default message.
raise MyModule, message: "custom error message" # ** (MyModule) custom error message

# Errors can be RESCUED using the try/rescue construct
try do
  raise "oops"
rescue
  e in RuntimeError -> e
end
# %RuntimeError{message: "oops"}
# above rescues the runtime error and returns the exception itself instead of "** (RuntimeError) oops"

# If you don’t have any use for the exception, you don’t have to pass a variable to rescue
try do
  raise "oops"
rescue
  RuntimeError -> "Error message"
end
# "Error message"

# In practice, Elixir developers rarely use the try/rescue construct.

# Many functions in the Elixir standard library have two versions:
# one returning a {:ok, result} or {:error, reason} tuples
# and its ! conterpart returns the result (not wrapped in a tuple)
# if everything goes fine or raises an exception instead of returning tuples to match against.

# --> dependig on the situation, case can be used to match againts returned tuples or
# let error be raised. E.g. use File.read! when file is expected to be found and the lack of that file is truly an error


### Reraise

# While we generally avoid using try/rescue in Elixir, one situation
# where we may want to use such constructs is for observability/monitoring
try do
  # some code
rescue
  e ->
    Logger.error(Exeption.format(:error, e, __STACKTRACE__))
    reraise e, __STACKTRACE__
end

# In the example above, we rescued the exception, logged it, and then re-raised it.
# We use the __STACKTRACE__ construct both when formatting the exception and when re-raising.
# This ensures we reraise the exception as is, without changing value or its origin.

# In Elixir, errors are taken literally: they are reserved for unexpected and/or exceptional situations,
# never for controlling the flow of our code. For flow control constructs, throws should be used.

###### Throws

# In Elixir, a value can be thrown and later be caught. throw and catch are reserved for situations
# where it is not possible to retrieve a value unless by using throw and catch.

# uncommon in practice except when interfacing with libraries that do not provide a proper API.

# For example, let’s imagine the Enum module did not provide any API for finding a value
# and that we needed to find the first multiple of 13 in a list of numbers
try do
  Enum.each(-50..0, fn x ->
    if rem(x, 13) == 0, do: throw(x)
  end)
  "No multiples of 13."
catch
  x -> "Got #{x}"
end
# "Got -39"

# Since Enum does provide a proper API, in practice Enum.find/2 is the way to go
Enum.find(-50..0, &(rem(&1, 13)==0)) # -39


###### Exits

# All Elixir code runs inside processes that communicate with each other.
# When a process dies of “natural causes” (e.g., unhandled exceptions), it sends an exit signal.
# A process can also die by explicitly sending an exit signal

spawn_link(fn -> exit("exit reason") end)  # ** (EXIT from #PID<0.167.0>) shell process exited with reason: "exit reason"

# exit can be “caught” using try/catch
try do
  exit("I'm exiting!")
catch
  :exit, _ -> "not really"
end
# "not really"

# Using try/catch is already uncommon and using it to catch exits is even rarer.
# try/catch and try/rescue are uncommon because supervison system is used to handle errors.

# EXIT SIGNALS are an important part of the fault tolerant system provided by the Erlang VM.
# Processes usually run under SUPERVISION TREES which are themselves processes that listen
# to exit signals from the supervised processes. Once an exit signal is received,
# the supervision strategy kicks in and the supervised process is restarted.


###### After

# Sometimes it’s necessary to ensure that a resource is cleaned up after some action
# that could potentially raise an error. The try/after construct allows you to do that.
# The after clause will be executed regardless of whether or not the tried block succeeds.

try do
  # some code to try to run
  raise "oops, something went wrong"
after
  # some code for cleaning up
  IO.inspect("this is run afterwards")
end

# "this is run afterwards"
# ** (RuntimeError) oops, something went wrong

# Note, however, that if a linked process exits, this process will exit and the after clause will not get run.

# The entire body of a function can be wrapped in a try construct, e.g.
# to guarantee some code will be executed afterwards. In such cases, Elixir allows you to omit the try line
# Elixir will automatically wrap the function body in a try whenever one of after, rescue or catch is specified.

defmodule RunAfter do
  def without_even_trying do
    raise "oops"
  after
    IO.puts("cleaning up!")
  end
end

RunAfter.without_even_trying
# cleaning up!
# ** (RuntimeError) oops


###### Else

# If an else block is present, it will match on the results of the try block whenever
# the try block finishes without a throw or an error.

x = 2 # -> :small
x = 0.5 # -> :large
x = 0 # -> :infinity

try do
  1/x
  rescue
    ArithmeticError ->
      :infinity
  else
    y when y < 1 and y > -1 ->
      :small
    _ ->
      :large
end


###### Variables scope
# Similar to case, cond, if and other constructs in Elixir,
# variables defined inside try/catch/rescue/after blocks do not leak to the outer context

# Furthermore, variables defined in the do-block of try are not available inside rescue/after/else either.
# This is because the try block may fail at any moment and therefore the variables may have never been bound in the first place.

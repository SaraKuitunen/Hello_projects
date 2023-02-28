# Elixir
# Module attributes

# Module attributes in Elixir serve three purposes:
  # 1. They serve to ANNOTATE the module, often with information to be used by the user or the VM.
  # 2. They work as CONSTANTS.
  # 3. They work as a TEMPORARY MODULE STORAGE to be used during compilation.

###### 1. As annotations

@moduledoc # provides documentation for the current module.
@doc #  provides documentation for the function or macro that follows the attribute.
@spec #  provides a typespec for the function that follows the attribute.
@behaviour # (notice the British spelling) used for specifying an OTP or user-defined behaviour.

# Elixir promotes the use of Markdown with heredocs to write readable documentation.
# Heredocs are multi-line strings, they start and end with triple double-quotes (""" """),
# keeping the formatting of the inner text.

# access the documentation of any compiled module directly from IEx:
elixirc module.ex # compile
h Module
h Module.function


###### 2. As “constants”

# Elixir developers often use module attributes when they wish to make a value more visible or reusable
defmodule MyServer do
  @initial_state %{host: "127.0.0.1", port: 3456}
  IO.inspect @initial_state
end

# Attributes can also be read inside functions
defmodule MyServer do
  @my_data 14
  def first_data, do: @my_data
  @my_data 13
  def second_data, do: @my_data
end

MyServer.first_data #=> 14
MyServer.second_data #=> 13

# Functions may be called when defining a module attribute:

defmodule MyApp.Status do
  @service URI.parse("https://example.com")
  def status(email) do
    SomeHttpClient.get(@service)
  end
end

# The function above will be called at COMPILATION time and its return value,
# not the function call itself, is what will be substituted in for the attribute.

# This can be useful for pre-computing constant values, but it can also cause problems
# if you’re expecting the function to be called at runtime.
# For example, if you are reading a value from a database or an environment variable
# inside an attribute, be aware that it will read that value only at compilation time.
# Be careful, however: functions defined in the same module as the attribute itself
# cannot be called because they have not yet been compiled when the attribute is being defined.

# Every time an attribute is read inside a function, Elixir takes a snapshot of its current value.
# Therefore if you read the same attribute multiple times inside multiple functions,
# you may end-up making multiple copies of it. The solution is to move the attribute to shared function.

### Accumulating attributes

defmodule Foo do
  Module.register_attribute __MODULE__, :param, accumulate: true

  @param :foo
  @param :bar
  # here @param == [:bar, :foo]
end


###### 3. As temporary storage

defmodule MyTest do
  use ExUnit.Case, async: true

  @tag :external
  @tag os: :unix
  test "contacts external service" do
    # ...
  end
end

# In the example above, ExUnit stores the value of async: true
# in a module attribute to change how the module is compiled.

# Elixir
# Structs

# Structs are extensions built on top of maps that provide compile-time checks and default values.

###### Defining structs

defmodule User do
  defstruct name: "John", age: 27
end

# The keyword list used with defstruct defines what fields the struct will have along with their default values.
# Structs take the name of the module they’re defined in.

# We can now create User structs by using a syntax similar to the one used to create maps
# if you have defined the struct in a separate file, you can compile the file inside IEx before proceeding by running c "file.exs"

%User{} # %User{age: 27, name: "John"}
%User{name: "Jane"} # %User{age: 27, name: "Jane"}

# Structs provide compile-time guarantees that only the fields (and all of them)
# defined through defstruct will be allowed to exist in a struct

%User{oops: :field}
# ** (KeyError) key :oops not found
#    expanding struct: User.__struct__/1
#    iex:47: (file)


###### Accessing and updating structs

# same technique and syntax as for maps
john = %User{}
jane = %{john | name: "Jane"}
jane.name


###### Structs are bare maps underneath

# structs are bare maps with a fixed set of fields.
# As maps, structs store a “special” field named __struct__ that holds the name of the struct

is_map(john) # true
john.__struct__ # User

# Notice that we referred to structs as BARE maps because none of the protocols
# implemented for maps are available for structs. For example, you can neither enumerate nor access a struct

# However, since structs are just maps, they work with the functions from the Map module
jess = Map.put(%User{}, :name, "Jess") # %User{age: 27, name: "Jess"}
Map.merge(jess, %User{name: "John"})  # %User{age: 27, name: "John"} #
Map.keys(jess) # [:__struct__, :age, :name]


###### Default values and required keys

# If you don’t specify a default key value when defining a struct, nil will be assumed
# If struct contains both explicit default values, and implicit nil values,
# fields which implicitly default to nil, must be specified first

defmodule User do
  defstruct [:email, name: "John", age: 27]
end

#  %User{age: 27, email: nil, name: "John"}}

%User{} # %User{age: 27, email: nil, name: "John"}

# You can also enforce that certain keys have to be specified
# when creating the struct via the @enforce_keys module attribute

defmodule Car do
  @enforce_keys [:make]
  defstruct [:model, :make]
end

# %Car{make: nil, model: nil}}

%Car{}
#** (ArgumentError) the following keys must also be given when building struct Car: [:make]
#    expanding struct: Car.__struct__/1
#    iex:19: (file)

%Car{make: "Audi"}  # %Car{make: "Audi", model: nil}

# Enforcing keys provides a simple compile-time guarantee to aid developers when building structs.
# It is not enforced on updates and it does not provide any sort of value-validation.

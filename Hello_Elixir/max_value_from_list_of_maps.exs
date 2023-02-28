# get max value from a list of maps

list= [1,2,3,4]
#IO.inspect(Enum.max(list))
#IO.inspect(Enum.at(list, 0))

map =
  %{value1: 0.0, value2: 2.0, value3: 3, value4: 10}

#IO.inspect(Enum.max(map))
#IO.inspect(map.value1)

tuple_list = [{"string1", 1}, {"string2", 2}]

list_of_1_elements = for tup <- tuple_list, do: elem(tup, 0)
IO.inspect(list_of_1_elements)

list_of_1_elements = for {string, _} <- tuple_list, do: string
IO.inspect(list_of_1_elements)

map_list=
  [
    %{age: 0.0, value: 0.0},
    %{age: 1.0, value: 2.11},
    %{age: 2.0, value: 3.29},
    %{age: 3.0, value: 3.9899999999999998},
    %{age: 4.0, value: 2.98}
  ]

# gets max based on values in age
IO.inspect(Enum.max(map_list))
IO.inspect(Enum.at(map_list, 0))
IO.inspect(Enum.at(map_list, 0))
IO.inspect(Enum.at(map_list, 0).value)
IO.inspect(Enum.at(map_list, 3).value)

# make a list of values of the "value" key from the list of maps
# this creates a list because a list is the default output of for

# values = for %{age: age, value: value} <- map_list, do: value
# NOTE! this gives the following warning
# warning: variable "age" is unused (if the variable is not meant to be used, prefix it with an underscore)

# variable "age" is unused so it has an underscore prefix
values = for %{age: _age, value: value} <- map_list, do: value
IO.inspect("values list:")
IO.inspect(values)

# take the max of values
max_value = Enum.max(values)
IO.inspect(max_value)


# take a max of two values
IO.inspect("max of two values:")
max_value = Enum.max([max_value, 38])
IO.inspect(max_value)

# add 10% of the max_value to itself
max_value = Float.ceil(max_value + (max_value/10))
IO.inspect(max_value)

# note that order of key value pairs in maps is alphabetic
map = %{y: 5, females: [1,3], males: [3,6,6]}
IO.inspect(map)

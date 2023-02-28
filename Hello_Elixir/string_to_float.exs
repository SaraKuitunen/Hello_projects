string_number = "2000.0"
IO.inspect(string_number)
IO.inspect(is_binary(string_number))

converted_number = String.to_float(string_number)
IO.inspect(converted_number)

float_number = 2000.0
IO.inspect(float_number) # 2.0e3

int_number = round(float_number)
IO.inspect(int_number) # 2000

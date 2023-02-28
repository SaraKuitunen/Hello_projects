key_fig =
  %{
    fg_endpoint_id: 112,
    nindivs_all: 3001,
    nindivs_female: 1200,
    nindivs_male: nil,
    median_age_all: 34.5,
    median_age_female: 36.7,
    median_age_male: 33.1,
    prevalence_all: 1.5,
    prevalence_female: 1.4,
    prevalence_male: 1.6,
    dataset: "FR"
  }
  |> Enum.reduce(
      %{},
      fn {k, v}, acc ->
        case v do
          nil -> Map.put(acc, k, "-")
          _ -> Map.put(acc, k, v)
        end
      end
    )

IO.inspect(key_fig)

##########
test_map = %{foo: "102", zoo: "103", bar: "104"}

test = for {k, v} <- test_map,
  into: %{},
  do: {k, String.to_integer(v)}

IO.inspect(test)


##########

test_2 = Enum.reduce(
  %{foo: "102", zoo: "103", bar: "104"},
  %{},
  fn {k, v}, acc ->
    Map.put(acc, k, String.to_integer(v))
  end
)

IO.inspect(test_2)

##########
test_map = %{foo: "102", zoo: "103", bar: "104"}

test_3 = Enum.reduce(
  test_map,
  %{},
  fn {k, v}, acc ->
    Map.put(acc, k, String.to_integer(v))
  end
)

IO.inspect("test_3: ")
IO.inspect(test_3)

##########

test_map = %{foo: "102", zoo: nil, bar: "104"}

test_4 = Enum.reduce(
  test_map,
  %{},
  fn {k, v}, acc ->
    case v do
      nil -> Map.put(acc, k, "-")
      _ -> Map.put(acc, k, v)
    end
  end
)

IO.inspect("test_4: ")
IO.inspect(test_4)

##########

test_map = %{foo: "102", zoo: nil, bar: "104"}
test_map = nil

test_5 =
  case test_map do
    nil -> nil
    _ ->
      Enum.reduce(
        test_map,
        %{},
        fn {k, v}, acc ->
          case v do
            nil -> Map.put(acc, k, "-")
            _ -> Map.put(acc, k, v)
          end
        end
      )
  end


IO.inspect("test_5: ")
IO.inspect(test_5)

##########

key_fig =
  %{
    fg_endpoint_id: 112,
    nindivs_all: 3001,
    nindivs_female: 1200,
    nindivs_male: nil,
    median_age_all: 34.5,
    median_age_female: 36.7,
    median_age_male: 33.1,
    prevalence_all: 1.5,
    prevalence_female: 1.4,
    prevalence_male: 1.6,
    dataset: "FR"
  }

key_figures =
  case key_fig do
    nil -> nil
    _ ->
      Enum.reduce(
        key_fig,
        %{},
        fn {k, v}, acc ->
          case v do
            nil -> Map.put(acc, k, "-")
            _ -> Map.put(acc, k, v)
          end
        end
      )
  end

IO.inspect("key_figures: ")
IO.inspect(key_figures)

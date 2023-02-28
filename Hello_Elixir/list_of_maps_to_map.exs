# NOTE that the functions don't work because functions cannot be defined outside modules and they would need Risteys modules
# they are here only to show how data is get

# --> DON'T try to run this file, instead take example and can run pieces in iex


endpoint_name = "E4_CYSTFIBRO"

def get_relationships(endpoint_name) do
  endpoint = Repo.get_by!(Definition, name: endpoint_name)

  data_assocs(endpoint)

end

defp data_assocs(endpoint) do
  query =
    from assoc in CoxHR,
      join: prior in Definition,
      on: assoc.prior_id == prior.id,
      join: outcome in Definition,
      on: assoc.outcome_id == outcome.id,
      where: assoc.prior_id == ^endpoint.id,
      order_by: [desc: assoc.hr],
      select: %{
        prior_id: prior.id,
        outcome_id: outcome.id,
        outcome_name: outcome.name,
        outcome_longname: outcome.longname,
        lagged_hr_cut_year: assoc.lagged_hr_cut_year,
        hr: assoc.hr,
        ci_min: assoc.ci_min,
        ci_max: assoc.ci_max,
        pvalue: assoc.pvalue,
      }

  #IO.inspect(query)
  #IO.inspect("Repo.all(query)")
  #IO.inspect(Repo.all(query))
  Repo.all(query)
end

surv = FGEndpoint.get_relationships(endpoint_name)

# FGEndpoint.get_relationships(endpoint_name) returned below data
surv = [
  %{
    ci_max: 2.406532630980357,
    ci_min: 1.2542348391803086,
    hr: 1.737341954653664,
    hr_binned: 0.8909090909090909,
    lagged_hr_cut_year: 0,
    outcome_id: 12466,
    outcome_longname: "Any mental disorder",
    outcome_name: "KRA_PSY_ANYMENTAL",
    prior_id: 11026,
    pvalue: 8.918893153162456e-4
  },
  %{
    ci_max: 2.3811677697007094,
    ci_min: 1.1296716755206018,
    hr: 1.6401029797221438,
    hr_binned: 0.8260869565217391,
    lagged_hr_cut_year: 0,
    outcome_id: 13454,
    outcome_longname: "Pain (limb, back, neck, head abdominally)",
    outcome_name: "PAIN",
    prior_id: 11026,
    pvalue: 0.0092971447917238
  },
  %{
    ci_max: 1.830981670820374,
    ci_min: 0.9450909725520484,
    hr: 1.3154635107066261,
    hr_binned: 0.6551724137931034,
    lagged_hr_cut_year: 0,
    outcome_id: 12029,
    outcome_longname: "Hypertension, essential",
    outcome_name: "I9_HYPTENSESS",
    prior_id: 11026,
    pvalue: 0.10411547941131946
  }
]

# go through list of maps and creates a map where each map from the list is saved as a value for a key that is the outcome_id inside that map
# --> each map can be picked by outcome_id
surv_map = for map <- surv, into: %{}, do: {map.outcome_id, map}

# returns
%{
  12029 => %{
    ci_max: 1.830981670820374,
    ci_min: 0.9450909725520484,
    hr: 1.3154635107066261,
    hr_binned: 0.6551724137931034,
    lagged_hr_cut_year: 0,
    outcome_id: 12029,
    outcome_longname: "Hypertension, essential",
    outcome_name: "I9_HYPTENSESS",
    prior_id: 11026,
    pvalue: 0.10411547941131946
  },
  12466 => %{
    ci_max: 2.406532630980357,
    ci_min: 1.2542348391803086,
    hr: 1.737341954653664,
    hr_binned: 0.8909090909090909,
    lagged_hr_cut_year: 0,
    outcome_id: 12466,
    outcome_longname: "Any mental disorder",
    outcome_name: "KRA_PSY_ANYMENTAL",
    prior_id: 11026,
    pvalue: 8.918893153162456e-4
  },
  13454 => %{
    ci_max: 2.3811677697007094,
    ci_min: 1.1296716755206018,
    hr: 1.6401029797221438,
    hr_binned: 0.8260869565217391,
    lagged_hr_cut_year: 0,
    outcome_id: 13454,
    outcome_longname: "Pain (limb, back, neck, head abdominally)",
    outcome_name: "PAIN",
    prior_id: 11026,
    pvalue: 0.0092971447917238
  }
}


# put to map and format data
surv_map_formatted = for map <- surv, into: %{}, do: {
  map.outcome_id, %{
    ci_max: round(map.ci_max),
    ci_min: round(map.ci_min),
    hr: round(map.hr),
    hr_str: to_string(map.hr),
    hr_binned: map.hr_binned,
    lagged_hr_cut_year: map.lagged_hr_cut_year,
    outcome_id: map.outcome_id,
    outcome_longname: map.outcome_longname,
    outcome_name: map.outcome_name,
    prior_id: map.prior_id,
    pvalue: map.pvalue
  }
}


rel_2 = Enum.map(rel, fn r -> Map.put(r, :hr, 3) end)

# this way can more key-values pairs to map
rel_2 = Enum.map(rel, fn r ->
  r
  |> Map.put(:hr, 3)
  |> Map.put(:hr_str, "3")
end)


empty_fr_assocs = %{
  ci_max: nil,
  ci_min: nil,
  hr: nil,
  hr_str: nil,
  outcome_id: nil,
  outcome_longname: nil,
  outcome_name: nil,
  prior_id: nil,
  pvalue_star: nil,
}

id = 12029
fr_assocs = case Map.get(surv_map, id) do
  nil -> empty_fr_assocs
  map -> map
end



###### simple example
list = [1, 2, 3, 4]
results = %{}

joined_results = Enum.reduce(list, results, fn x, acc ->
  Map.put(acc, x, x*3)
end)
# joined_results: %{1 => 3, 2 => 6, 3 => 9, 4 => 12}

####### simple example 2
joined_results = Enum.reduce(list, results, fn x, acc ->
  case x do
    3 ->
      Map.put(acc, x, x*3)
    _ ->
      Map.put(acc, x, x*2)
  end
end)
######

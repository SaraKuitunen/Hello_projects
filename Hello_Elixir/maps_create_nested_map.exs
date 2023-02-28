steps = [
  %{
    name: :all,
    data: nil
  },
  %{
    name: :sex_rule,
    data: "endpoint.sex"
  },
  %{
    name: :conditions,
    data: "parse_conditions(endpoint)"
  },
  %{
    name: :multi,
    data: "parse_multi(endpoint)"
  },
  %{
    name: :min_number_events,
    data: "parse_min_number_events(endpoint)"
  },
  %{
    name: :includes,
    data: "parse_include(endpoint)"
  }
]

#counts_FG = get_explainer_step_counts(endpoint, "FG")
counts_FG =
  %{
    all: 356077,
    conditions: 356077,
    includes: 126,
    min_number_events: 126,
    multi: 126,
    sex_rule: 356077
  }

#counts_FR = get_explainer_step_counts(endpoint, "FR")
counts_FR =
  %{
    all: 5560770,
    conditions: 5560770,
    includes: 5260,
    min_number_events: 5260,
    multi: 5260,
    sex_rule: 5560770
  }


steps_map_list =
  Enum.map(steps, fn step ->
    # get step_name from step map using pattern matching
    %{name: step_name} = step
    # nil or count as an integer
    count_FG = counts_FG[step_name]
    #count_FR = counts_FR[step_name]
    Map.put_new(step, :nindivs_post_step_FG, count_FG)
    #Map.put_new(step, :nindivs_post_step_FR, count_FR)
  end)

IO.inspect(steps_map_list)


#[
#  %{
#    name: :all,
#    data: nil
#    :nindivs_post_step_FG: 356077
#  },
#  %{
#    name: :sex_rule,
#    data: endpoint.sex
#    :nindivs_post_step_FG: 356077
#  },
#  ...
#]


steps_map_list =
  Enum.map(steps, fn step ->
    # get step_name from step map using pattern matching
    %{name: step_name} = step
    # nil or count as an integer
    count_FG = counts_FG[step_name]
    count_FR = counts_FR[step_name]
    step = Map.put_new(step, :nindivs_post_step_FG, count_FG)
    Map.put_new(step, :nindivs_post_step_FR, count_FR)
  end)

IO.inspect(steps_map_list)

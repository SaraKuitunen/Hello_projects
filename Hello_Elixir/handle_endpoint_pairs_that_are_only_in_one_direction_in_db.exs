# Handle "bidirectiona" endpoint pair data that is saved only in one direction in DB

# A way to get results for a endpoint pair from DB where either one of the endpoints
# can be "endpoint a" and another one being "endpoint b", i.e. pair can be saved either
# as a --> b or b --> a

# e.g. results B – A would se same as A – B, but B – A reuslts are not saved to the DB because A – B reuslts are
# -> below backed code handles gets also B – A results when getting results where B is latter endpoint (endpoint b)

# A – A
# A – B
# A – C
# A – D
# B – B
# B – C
# B – D
# C – C
# C – D
# D – D

# get FG genetic correlations
fg_genetic_correlations = get_genetic_correlations(endpoint)

# !!!! pass endpoint.id argument that is id of the current endpoint, i.e. endpoint of the selected endpoint page
joined_results = join_results(fg_genetic_correlations, "fg_gen_corr", joined_results, template, endpoint.id)

def get_genetic_correlations(endpoint) do
  # !!! select based on fg_endpoint_a_id AND fg_endpoint_b_id
  # each genetic correlation pair is saved in the DB only once, because with genetic correlations a --> b is same as b --> a
  # --> need to query the data so that get all results for a given endpoint, regardless whether it's saved in the DB
  # as endpoint_a or endpoint_b
  Repo.all(
    from gen_corr in GeneticCorrelation,
      where:
        (gen_corr.fg_endpoint_a_id == ^endpoint.id or
        gen_corr.fg_endpoint_b_id == ^endpoint.id) and
        gen_corr.fg_endpoint_a_id != gen_corr.fg_endpoint_b_id,
      select: %{
        fg_endpoint_b_id: gen_corr.fg_endpoint_b_id,
        fg_endpoint_a_id: gen_corr.fg_endpoint_a_id,
        rg: gen_corr.rg,
        rg_se: gen_corr.se,
        rg_pvalue: gen_corr.pvalue,
      }
  )
end

# !!!! have current_endpoint_id argument
# current_endpoint_id is optional argument, so when join_results/5 is called for joining data from other DB table,
# endpoint id doesn't need to be passed
def join_results(data_list, data_type, joined_results, template, current_endpoint_id \\ nil) do
  Enum.reduce(data_list, joined_results, fn data_map, acc ->
    # Format the data so that it has field "fg_endpoint_b_id" having the id of the endpoint of interest
    # and other field names match with the respective names in the template map
    # !!!! pass current_endpoint_id
    data_map = format_data(data_map, data_type, current_endpoint_id)

    # If current endpoint in the given data list (i.e., the pair endpoint of the endpoint of current page) is found from
    # the joined reults, append reusults to the corresponding map, otherwise create a new map using the teplate map.
    # Template map is used when creating a new map to make sure that all maps have keys for all possible fields.
    # --> Join all results from all tables together
    case Map.get(acc, data_map.fg_endpoint_b_id) do
      nil ->
        # If map for current endpoint b is not found, results for the current endpoint pair have not been available
        # in FG correlations, which means that the map doesn't have name of the endpoint b and it needs to be added.
        # Name and longname are added here to avoid any unnecassary enumeration throught the data maps
        name_map = Repo.one(
          from definition in Definition,
            where: definition.id == ^data_map.fg_endpoint_b_id,
            select: %{
              name: definition.name,
              longname: definition.longname
            }
        )

        tmp = Map.merge(template, name_map)
        tmp = Map.merge(tmp, data_map)

        Map.put(acc, tmp.fg_endpoint_b_id, tmp)
      map ->
        Map.put(acc, data_map.fg_endpoint_b_id, Map.merge(map, data_map))
    end
  end)
end

defp format_data(map, data_type, current_endpoint_id) do
  case data_type do
    "fr_case_overlaps" ->
      %{
        fg_endpoint_b_id: map.fg_endpoint_b_id,
        fr_case_overlap_percent: round_and_str(map.case_overlap_percent, 2),
        fr_case_overlap_N: map.case_overlap_N
      }

    "fr_surv" ->
      %{
        fg_endpoint_b_id: map.outcome_id,
        hr_ci_max: round_and_str(map.ci_max, 2),
        hr_ci_min: round_and_str(map.ci_min, 2),
        hr: map.hr,
        hr_str: round_and_str(map.hr, 2),
        hr_pvalue_str: pvalue_star(map.pvalue, 9773) # 9773 is number of all converged FR survival analyses in the R10 input data file, used for bonferroni correction
      }

    "fr_surv_extremity" ->
      %{
        fg_endpoint_b_id: map.endpoint_id,
        hr_binned: map.percent_rank
      }

    "fg_gen_corr" ->
      # !!! get correct endpoint id based on comparing it to the endpoint id of the selelected endpoint page, i.e. current_endpoint_id
      # the DB query returns both fg_endpoint_a_id and fg_endpoint_b_id because the results
      # for one enpoint pair can be saved in two different directions in the DB,
      # so need to here get the id of the "other" endoint than the endpoint of current endpoint page
      id = if map.fg_endpoint_b_id != current_endpoint_id, do: map.fg_endpoint_b_id, else: map.fg_endpoint_a_id

      %{
        fg_endpoint_b_id: id,
        rg: map.rg,
        rg_str: round_and_str(map.rg, 2),
        rg_ci_min: round_and_str(get_95_ci(map.rg, map.rg_se, "lower"), 2),
        rg_ci_max: round_and_str(get_95_ci(map.rg, map.rg_se, "upper"), 2),
        rg_pvalue_str: pvalue_star(map.rg_pvalue, 2737077) # 2737077 is number of all converged FG genetic correlation analyses in the R10 input data file, used for bonferroni correction
      }

    "fg_gen_corr_extremity" ->
      %{
        fg_endpoint_b_id: map.endpoint_id,
        rg_binned: map.percent_rank
      }

    _ ->
      raise "Given data type for formatting data doesn't match with any of the allowed keywords for data format."
  end
end

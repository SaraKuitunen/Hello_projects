# save this file in risteys_elixir & run in risteys_elixir dir in GC VM
# run options:
    # ./run_data_imports.sh
    # sh run_data_imports.sh
    # bash run_data_imports.sh

# check that being in correct dir
pwd

echo 'import data'

# Import data
# echo 'import icd10 data'
# mix run import_icd10.exs ~/risteys_r10_data/risteys_FG_r10_data/from_previous_versions/finngen_R6_medcode_ref.csv

# echo '----------------------------------------------------------------------------------'
# echo 'import icd9 data'
# mix run import_icd9.exs ~/risteys_r10_data/risteys_FG_r10_data/from_previous_versions/finngen_R6_medcode_ref.csv

# echo '----------------------------------------------------------------------------------'
# echo 'import endpoints data'
# finngen_R10_endpoint_core_noncore_1.0__added_omit2_myfix.csv: omit 2 endpoints from control file and F5_SAD are removed
# mix run import_endpoint_csv.exs ~/risteys_r10_data/risteys_FG_r10_data/finngen_R10_endpoint_core_noncore_1.0__added_omit2_myfix.csv ~/risteys_r10_data/risteys_FG_r10_data/FINNGEN_ENDPOINTS_DF10_Final_2022-05-16.names_tagged_ordered.csv ~/risteys_r10_data/risteys_FG_r10_data/TAGLIST_DF10.csv ~/risteys_r10_data/risteys_FG_r10_data/from_previous_versions/ICD10_koodistopalvelu_2015-08_26_utf8.csv ~/risteys_r10_data/risteys_FG_r10_data/from_previous_versions/finngen_correlation_clusters_DF8.csv

# echo '----------------------------------------------------------------------------------'
# echo 'import FinnGen intermediate counts data'
# mix run import_intermediate_counts.exs ~/risteys_r10_data/risteys_FG_r10_data/from_THLregisterteam_intermediate_counts_finngen_endpoints_intermediate_counts_green_export_R10_v1.csv FG

# echo '----------------------------------------------------------------------------------'
# echo 'import ontology data'
# mix run import_ontology.exs ~/risteys_r10_data/ontology_2022-08-22.json

# echo '----------------------------------------------------------------------------------'
# echo 'import excluded endpoints data'
# mix run import_excluded_endpoints.exs ~/risteys_r10_data/risteys_FR_r10_data/excluded_endpoints_FR_Risteys_R10.csv

echo '----------------------------------------------------------------------------------'
echo 'import FinRegistry key figures, full population'
mix run import_key_figures.exs ~/risteys_r10_data/risteys_FR_r10_data/key_figures_all_2022-10-10_with_EXALLC_EXMORE.csv FR

echo '----------------------------------------------------------------------------------'
echo 'import FinRegistry key figures, only index persons'
mix run import_key_figures.exs ~/risteys_r10_data/risteys_FR_r10_data/key_figures_index_2022-10-10_with_EXALLC_EXMORE.csv FR_index

# echo '----------------------------------------------------------------------------------'
# echo 'import FinnGen key figures'
# mix run import_key_figures.exs ~/risteys_r10_data/risteys_FG_r10_data/key_figures_all__fg_r10__2022-10-17.csv FG

echo '----------------------------------------------------------------------------------'
echo 'import FinRegistry age distributions'
mix run import_distributions.exs ~/risteys_r10_data/risteys_FR_r10_data/distribution_age_2022-10-10_with_EXALLC_EXMORE.csv age FR

# echo '----------------------------------------------------------------------------------'
# echo 'import FinnGen age distributions'
# mix run import_distributions.exs ~/risteys_r10_data/risteys_FG_r10_data/distribution_age__fg_r10__2022-10-17.csv age FG

echo '----------------------------------------------------------------------------------'
echo 'import FinRegistry year distributions'
mix run import_distributions.exs ~/risteys_r10_data/risteys_FR_r10_data/distribution_year_2022-10-10_with_EXALLC_EXMORE.csv year FR

# TODO: find out why counts don't match!!!
# echo '----------------------------------------------------------------------------------'
# echo 'import FinnGen year distributions'
# mix run import_distributions.exs ~/risteys_r10_data/risteys_FG_r10_data/distribution_year__fg_r10__2022-10-17.csv year FG

# echo '----------------------------------------------------------------------------------'
# echo 'import FinRegistry cumulative incidence'
# mix run import_stats_cumulative_incidence.exs ~/risteys_r10_data/risteys_FR_r10_data/cumulative_incidence_2022-10-10_with_EXALLC_EXMORE.csv FR

# echo '----------------------------------------------------------------------------------'
# echo 'import FG cumulative incidence'
# mix run import_stats_cumulative_incidence.exs ~/risteys_r10_data/risteys_FG_r10_data/all__cumulative_incidence__fg_r10__2022-10-17.csv FG

# echo '----------------------------------------------------------------------------------'
# echo 'import Mortality baselines'
# mix run import_interactive_mortality_baseline.exs ~/risteys_r10_data/risteys_FR_r10_data/mortality_baseline_cumulative_hazard_2022-10-11_with_EXALLC_EXMORE.csv

# echo '----------------------------------------------------------------------------------'
# echo 'import Mortality parameters'
# mix run import_interactive_mortality_params.exs ~/risteys_r10_data/risteys_FR_r10_data/mortality_params_2022-10-11_with_EXALLC_EXMORE.csv

# echo '----------------------------------------------------------------------------------'
# echo 'import Mortality counts'
# mix run import_mortality_counts.exs ~/risteys_r10_data/risteys_FR_r10_data/mortality_counts_2022-10-11_with_EXALLC_EXMORE.csv

# TODO: find out why counts don't match!!!
# echo '----------------------------------------------------------------------------------'
# echo 'import correlations'
# mix run import_correlations.exs ~/risteys_r10_data/risteys_FG_r10_data/corr_pheno-fg-r10.0_geno-fg-r9.1.0_full-join__2022-09-08.csv ~/risteys_r10_data/risteys_FG_r10_data/from_previous_versions/dummy__r9_fg_r2_0_8_p_5e_08_keep_cs.variants__small-headers__2022-05-02.csv

echo '----------------------------------------------------------------------------------'
echo 'import FG upset plots and tables'
mix run import_upset_plots.exs ~/risteys_r10_data/risteys_FG_r10_data/upset_plots fg


echo 'FINISHED RUNNIG IMPORT SCRIPTS.'


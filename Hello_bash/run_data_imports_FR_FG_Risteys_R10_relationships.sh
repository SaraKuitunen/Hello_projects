# save this file in risteys_elixir & run in risteys_elixir dir in GC VM

# remember to give execute permission: chmod +x run_data_imports_FR_FG_Risteys_R10_relationships.sh

# run options:
    # ./run_data_imports_FR_FG_Risteys_R10_relationships.sh
    # sh run_data_imports_FR_FG_Risteys_R10_relationships.sh
    # bash run_data_imports_FR_FG_Risteys_R10_relationships.sh

# run & save both stderr and stdout to a file: ./run_data_imports_FR_FG_Risteys_R10_relationships.sh &> log_import_script_runs.txt

# check that being in correct dir
pwd

echo 'import data'


echo 'import FinnGen correlations'
mix run import_correlations.exs ~/risteys_r10_data/risteys_FG_r10_data/corr_pheno-fg-r10.0_geno-fg-r9.1.0_full-join__2022-12-12.csv ~/risteys_r10_data/risteys_FG_r10_data/dummy__r9_fg_r2_0_8_p_5e_08_keep_cs.variants__small-headers__2022-05-02.csv &> log_correlations.txt

echo '----------------------------------------------------------------------------------'

echo 'import FinnGen genetic correlations'
mix run import_genetic_correlations.exs ~/risteys_r10_data/risteys_FG_r10_data/finngen_R10_FIN.ldsc.summary.tsv &> log_gen_correlations.txt


echo '----------------------------------------------------------------------------------'
echo 'import FinRegistry case counts'
mix run import_case_overlaps_fr.exs ~/risteys_r10_data/risteys_FR_r10_data/case_overlap_2022-12-31.csv &> log_fr_case_overlaps.txt


echo '----------------------------------------------------------------------------------'
echo 'import FinRegistry survival analysis results'
mix run import_coxhr.exs ~/risteys_r10_data/risteys_FR_r10_data/surv_priority_endpoints_2022-12-25.csv &> log_surv_analysis.txt

echo 'FINISHED RUNNIG IMPORT SCRIPTS.'


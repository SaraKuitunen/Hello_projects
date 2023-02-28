bch_t0 = 0.022606478096040637

bch_t = 0.15821701863795554
age = 50
birth_year = 2022 - age

birth_year_coef = -0.0126
birth_year_mean = 1952.4097
exposure_coef = 0.262
exposure_mean = 0.1035

S_t0 = exp(-bch_t0 * 
             exp(birth_year_coef * (birth_year - birth_year_mean)
                 + exposure_coef * (1 - exposure_mean)
                )
          )
 

S_t = exp(-bch_t * 
            exp(birth_year_coef * (birth_year - birth_year_mean)
                + exposure_coef * (1 - exposure_mean)
            )
)


AR = (1 - S_t / S_t0) *100
  

AR 

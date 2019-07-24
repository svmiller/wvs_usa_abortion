# note: carr and r2sd are copies of car::recode() and arm::rescale() respectively.
# I created these functions in my stevemisc package to avoid function clashes with those package and tidyverse packages.
WVS_USA_Abortion %>%
  mutate(ajd = carr(aj, "1=0; 2:10=1"),
         z_age = r2sd(age),
         z_ideo = r2sd(ideology),
         z_satisf = r2sd(satisfinancial),
         z_cai = r2sd(cai),
         z_god = r2sd(godimportant)) -> Data  

saveRDS(Data, "data/data.rds")
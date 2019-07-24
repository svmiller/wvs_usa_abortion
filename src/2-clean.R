WVS_USA_Abortion %>%
  mutate(ajd = car::recode(aj, "1=0; 2:10=1"),
         z_age = arm::rescale(age),
         z_ideo = arm::rescale(ideology),
         z_satisf = arm::rescale(satisfinancial),
         z_cai = arm::rescale(cai),
         z_god = arm::rescale(godimportant)) -> Data  

saveRDS(Data, "data/data.rds")

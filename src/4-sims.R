data_grid(Data,
          .model=Models[[1]],
          ajd = 0, aj = 0,
          nesting(z_god)) %>%
  na.omit %>%
  mutate_at(vars(contains("z_"), -z_god), list(~replace(., . != 0, 0))) %>%
  mutate(year = 0) -> Newdat







merTools::predictInterval(Models[[1]],
                          newdata=Newdat, 
                          include.resid.var=F,
                          n.sims=1000, seed=8675309,
                          returnSims = TRUE) -> M1_summarysims

attributes(M1_summarysims)$sim.results %>%
  data.frame() %>% tbl_df() %>%
  bind_cols(.,Newdat) %>% 
  mutate(godimportant = seq(1, 10)) %>%
  select(godimportant, everything()) %>%
  group_by(godimportant) %>%
  gather(sim, value, X1:X1000) %>%
  mutate(model = names(Models)[1]) -> M1sims


merTools::predictInterval(Models[[2]],
                          newdata=Newdat, 
                          include.resid.var=F,
                          n.sims=1000, seed=8675309,
                          type = "probability",
                          returnSims = TRUE) -> M2_summarysims


attributes(M2_summarysims)$sim.results %>%
  data.frame() %>% tbl_df() %>%
  bind_cols(.,Newdat) %>% 
  mutate(godimportant = seq(1, 10)) %>%
  select(godimportant, everything()) %>%
  mutate_at(vars(contains("X")), boot::inv.logit) %>%
  group_by(godimportant) %>%
  gather(sim, value, X1:X1000) %>%
  mutate(model = names(Models)[2]) -> M2sims


Sims = bind_rows(M1sims, M2sims)

saveRDS(Sims, "data/sims.rds")

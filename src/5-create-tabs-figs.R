

tidy(Models[[1]]) %>% mutate(model = "Linear Mixed Effects") %>%
  filter(group == "fixed") -> M1df

tidy(Models[[2]]) %>% mutate(model = "Logistic Mixed Effects") %>%
  filter(group == "fixed") -> M2df


bind_rows(M1df, M2df) %>%
  filter(term != "(Intercept)") %>%
  dwplot(.,
         dot_args = list(aes(shape = model),
                         size = 3))  %>%
  relabel_predictors(c(
    z_age = "Age",
    female = "Female",
    z_ideo = "Ideology",
    z_satisf = "Financial Satisfaction",
    z_cai = "Child Autonomy Index",
    z_god = "Importance of God"
  )) +
  theme_steve_web() +
  labs(color = "Model",
       shape = "Model") + 
  geom_vline(xintercept = 0, linetype="dashed")  -> plot_models


Sims %>%
  group_by(model, godimportant) %>%
  summarize(mean = mean(value),
            sd = sd(value),
            se = sd/sqrt(n()),
            lwr = quantile(value, .025),
            upr = quantile(value, .975)) %>%
  ggplot(.,aes(as.factor(godimportant), y=mean, ymin=lwr, ymax=upr)) + 
  theme_steve_web() + geom_pointrange() + 
  coord_flip() + facet_wrap(~model, scales="free_x") +
  labs(x = "The Importance of God to the Respondent (1-10)",
       y = "Expected Value (with 95% Intervals)") -> plot_sims



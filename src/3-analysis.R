M1 <- lmer(aj ~ z_age + female + 
             z_ideo + z_satisf + z_cai + z_god + (1 | year), data = Data,
           control=lmerControl(optimizer="bobyqa",
                               optCtrl=list(maxfun=2e5)))

M2 <- glmer(ajd ~ z_age + female +
              z_ideo + z_satisf + z_cai + z_god + 
              (1 | year), 
            data = Data, family=binomial(link="logit"),
            control=glmerControl(optimizer="bobyqa",
                                 optCtrl=list(maxfun=2e5)))

list("linear" = M1,
     "logistic" = M2) -> Models


saveRDS(Models, "data/models.rds")

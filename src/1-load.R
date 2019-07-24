data <- getURL("https://raw.githubusercontent.com/svmiller/wvs-usa-abortion-attitudes/master/wvs-usa-abortion-attitudes-data.csv")
WVS_USA_Abortion <- read.csv(text = data) %>% tbl_df()

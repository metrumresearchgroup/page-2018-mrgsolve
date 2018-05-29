source("src/global.R")
library(rmarkdown)
render("doc/rmd/deck_00.Rmd", output_dir = "doc")
render("doc/rmd/deck_01.Rmd", output_dir = "doc")
render("doc/rmd/deck_02.Rmd", output_dir = "doc")
render("doc/rmd/deck_03.Rmd", output_dir = "doc")
render("handson_epo_pts.Rmd", output_dir = "doc")
render("handson_opg_answer.Rmd", output_dir = "doc")
render("handson_meropenem_vpc.Rmd", output_dir = "doc")
render("handson_sim_ebe.Rmd", output_dir = "doc")
render("handson_specification.Rmd", output_dir = "doc")




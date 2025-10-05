# Have renv explicitly use all the deps in DESCRIPTION and dev/DESCRIPTION
# Note: for this hook to be used, you must use
# `renv$settings$snapshot.type("custom")` when setting up your renv
# for the project
options(
  renv.snapshot.filter = function(project) {
    renv::dependencies(
      file.path(project, c("DESCRIPTION", "dev/DESCRIPTION")),
      dev = TRUE,
      quiet = TRUE
    )$Package
  }
)

source("renv/activate.R")

if (interactive()) {
  source("dev/activate.R")
}

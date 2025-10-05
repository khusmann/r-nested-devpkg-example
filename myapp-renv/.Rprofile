# Have renv explicitly use all the deps in DESCRIPTION and dev/DESCRIPTION
# Note: you must set `renv$settings$snapshot.type("custom")` for this
# to take effect
options(
  renv.snapshot.filter = function(project) {
    get_deps <- function(desc_path) {
      read.dcf(desc_path, fields = c("Imports", "Suggests")) |>
        lapply(\(i) strsplit(i, ",")) |>
        unlist() |>
        trimws() |>
        (\(x) gsub("\\s*\\(.*\\)", "", x))() # Remove version indicators
    }
    c("DESCRIPTION", "dev/DESCRIPTION") |>
      lapply(\(i) file.path(project, i)) |>
      lapply(get_deps) |>
      unlist() |>
      unique()
  }
)

source("renv/activate.R")

if (interactive()) {
  source("dev/activate.R")
}

if (interactive()) {
  if (!requireNamespace("pkgload", quietly = TRUE)) {
    stop(
      paste0(
        'pkgload is not installed. Please run `install.packages("pkgload")` ',
        'and then restart your session.'
      )
    )
  }

  pkgload::load_all(
    "dev",
    attach = FALSE,
    export_all = FALSE,
    attach_testthat = FALSE
  )
}

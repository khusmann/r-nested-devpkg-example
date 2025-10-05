if (interactive()) {
  if (!requireNamespace("pkgload", quietly = TRUE)) {
    stop("pkgload is not installed. Please install and restart your session.")
  }

  pkgload::load_all(
    "dev",
    attach = FALSE,
    export_all = FALSE,
    attach_testthat = FALSE
  )
}

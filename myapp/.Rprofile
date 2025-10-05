if (interactive()) {
  if (requireNamespace("pkgload", quietly = TRUE)) {
    pkgload::load_all(
      "dev",
      attach = FALSE,
      export_all = FALSE,
      attach_testthat = FALSE
    )
  } else {
    warning(
      paste0(
        'Unable to load mypackage.dev, pkgload is not installed.\n',
        'Please run `install.packages("pkgload") and then restart your session.'
      ),
      call. = FALSE
    )
  }
}

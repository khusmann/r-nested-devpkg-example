local({
  make_quiet <- function(code) {
    sink(nullfile())
    on.exit(sink(), add = TRUE)
    force(code)
  }

  # Use make_quiet to prevent renv from printing
  renv_status <- make_quiet(renv::status())

  if (renv_status$synchronized) {
    pkgload::load_all(
      "dev",
      attach = FALSE,
      export_all = FALSE,
      attach_testthat = FALSE
    )
  } else {
    warning(
      paste0(
        "Your development environment is not set up.\n",
        "Please resolve `renv::status()` and then restart your session."
      ),
      call. = FALSE
    )
  }
})

local({
  pkgfn <- getOption("renv.snapshot.filter")
  if (is.function(pkgfn) && all(pkgfn(".") %in% installed.packages())) {
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
        "Please run `renv::restore()` and then restart your session."
      ),
      call. = FALSE
    )
  }
})

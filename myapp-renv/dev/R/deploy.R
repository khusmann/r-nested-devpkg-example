confirm_dirty_continue <- function(.call = rlang::caller_call()) {
  if (nrow(gert::git_status()) > 0) {
    cat("\n")
    cli::cli_alert_warning(
      c(
        "Working directory is dirty. ",
        "Are you sure you want to continue deploying?"
      )
    )
    if (utils::menu(c("Yes", "No")) != 1) {
      cli::cli_abort("Aborted by user", call = .call)
    }
  }
}

shallow_clone <- function(url, path, .call = rlang::caller_call()) {
  # Gert doesn't support --depth 1, unfortunately, so we use system2
  # https://github.com/r-lib/gert/issues/101
  status <- system2(
    "git", c("clone", "--depth", "1", shQuote(url), shQuote(path))
  )
  if (status != 0) {
    cli::cli_abort("Failed to clone repo", call = .call)
  }
}

local_repo <- function(
    project_dir = gert::git_find(),
    latest_commit = gert::git_log(max = 1)$commit,
    .local_envir = parent.frame()) {
  # To make complete sure we don't accidentally deploy anything not already
  # hosted in git, we clone the project to a temp dir, and do the deployments
  # from there
  #
  # Note that we turn our project_dir into a file:// url because otherwise
  # the --depth = 1 doesn't work!
  cli::cli_progress_step("Cloning project into temporary directory")
  clone_dir <- withr::local_tempdir(.local_envir = .local_envir)
  project_dir_url <- paste0("file://", normalizePath(project_dir))
  shallow_clone(project_dir_url, clone_dir)

  cli::cli_progress_step("Setting working dir to {clone_dir}")
  withr::local_dir(clone_dir, .local_envir = .local_envir)
}

#' Deploy myapp
#'
#' @param config Which configuration to use
#'
#' @export
deploy <- function(config = "default") {
  cli::cli_rule(left = "Deploy myapp")

  # Make sure all changes are committed
  confirm_dirty_continue()

  cli::cli_progress_step("Cloning repo to temporary directory")
  local_repo()
  withr::local_dir("myapp-renv") # Change wd to project folder

  cli::cli_progress_step("Creating new renv.lock without dev dependencies")
  renv::snapshot(
    ".",
    packages = c(
      renv::dependencies("DESCRIPTION")$Package,
      "pkgload" # pkgload is used in app.R, not in the package
    ),
    prompt = FALSE
  )

  cli::cli_progress_step("Setting envvars for configuration `{config}`")
  env_vars <- c(
    MYAPP_CONFIG = config
  )

  withr::local_envvar(env_vars)

  cli::cli_progress_step("Deploying app")
  #  rsconnect::deployApp(
  #    appFiles = c(
  #      "app.R",
  #      "inst",
  #      "DESCRIPTION",
  #      "NAMESPACE",
  #      "R",
  #      "renv.lock"
  #    ),
  #    appName = glue::glue("myapp [{config}]"),
  #    envVars = names(env_vars) # These will be set on the connect server
  #  )


  # Other things you can do here:
  # - Build and deploy the pkgdown docs?
  # - Build other configurations and deploy to other systems?
  # - etc. etc.

  cli::cli_process_done()
}

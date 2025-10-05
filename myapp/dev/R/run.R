run_helper <- function() {
  cli::cli_inform("Called run_helper (that's not exported)")
}

#' Deploy myapp
#'
#' @param config Which configuration to use
#'
#' @export
run <- function(config = "default") {
  cli::cli_inform("Deploying configuration: {config}")
  run_helper()

  # Examples of what might go here
  # - Set environment vars based on config
  # - Generate & cache test data
  # - Run styler / lintr?
  # - etc.

  shiny::runApp(source("app.R", local = TRUE)$value)
}

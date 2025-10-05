
deploy_helper <- function() {
  cli::cli_inform("Called deploy_helper (that's not exported)")
}

#' Deploy myapp
#'
#' @param config Which configuration to use
#'
#' @export
deploy <- function(config = "default") {
  cli::cli_inform("Deploying configuration: {config}")
  deploy_helper()
}

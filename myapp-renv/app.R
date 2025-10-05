pkgload::load_all(
  attach = FALSE,
  export_all = FALSE,
  attach_testthat = FALSE
)

shiny::shinyApp(
  ui = myapp::app_ui,
  server = myapp::app_server
)

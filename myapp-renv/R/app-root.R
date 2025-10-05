#' myapp app ui
#'
#' @export
app_ui <- function() {
  shiny::fluidPage(
    titlePanel = shiny::titlePanel("Simple Shiny Demo"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::sliderInput("n",
                           "Number of observations:",
                           min = 10,
                           max = 1000,
                           value = 100)
      ),
      shiny::mainPanel(
        shiny::plotOutput("hist")
      )
    )
  )
}

#' myapp app server
#'
#' @param input Shiny inputs
#' @param output Shiny outputs
#'
#' @export
app_server <- function(input, output) {
  output$hist <- shiny::renderPlot({
    hist(rnorm(input$n),
         main = paste("Histogram of", input$n, "random numbers"),
         col = "skyblue", border = "white")
  })
}

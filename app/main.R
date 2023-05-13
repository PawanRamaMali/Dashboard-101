box::use(
  shiny[bootstrapPage, moduleServer, NS, renderText, tags, textOutput, div],
  imola[flexPanel],
  echarts4r[...],
)

box::use(
  app/view/content,
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  div(
    style = "margin-top:10px; margin-bottom:5px;",
    content$ui(id = ns("dashboard"))
  )
}

#' @export
server <- function(id) {

  moduleServer(id, function(input, output, session) {
    content$server("dashboard")
  })
}

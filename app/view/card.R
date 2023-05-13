box::use(shiny[...],
         echarts4r[...],
         glue[glue],
         flexdashboard[gaugeOutput,])

#' @export
key_metrics_card <- function(id,
                             card_height = "50vh",
                             header_text = "",
                             key_metric = "",
                             key_metric_text = "") {
  div(
    class = "card text-white bg-card mb-3",
    style = glue("height:{card_height};"),
    div(style = "margin: 0.5rem;margin-left: 1rem;
      font-weight: bold;font-size: larger",
        header_text),
    div(
      class = "card-body",
      style = "overflow:hidden;",
      div(
        class = "card-title",
        style = "margin-top: -1rem;
        font-size: xxx-large;font-weight: bold;",
        h1(key_metric)
      ),
      p(class = "card-text",
        key_metric_text),
      div(shinycssloaders::withSpinner(echarts4rOutput(id),
                                       type = 4,
                                       size = 0.5,
                                       color = "#58D9F9"))
    )
  )
}


#' @export
key_danger_metrics_card <- function(id,
                                    card_height = "50vh",
                                    header_text = "",
                                    key_metric = "",
                                    key_metric_text = "") {
  div(
    class = "card text-white bg-card mb-3",
    style = glue("max-width:40rem; height:{card_height};"),
    div(style = "margin: 0.5rem;margin-left: 1rem;
      font-weight: bold;font-size: larger",
        header_text),
    div(
      class = "card-body",
      style = "overflow:hidden;",
      div(
        div(
          class = "card-title",
          style = "margin-top: -1rem;
        font-size: xxx-large;font-weight: bold;",
          h1(key_metric)
        ),
        p(class = "card-text",
          key_metric_text)
      )
      ,
      div(shinycssloaders::withSpinner(echarts4rOutput(id),
                                       type = 4,
                                       size = 0.5,
                                       color = "#58D9F9"))
    )
  )
}


#' @export
metrics_info_card <- function(card_height = "50vh",
                              metric_key,
                              metric_value) {
  div(
    class = "card text-white bg-card mb-3",
    style = glue("max-width:40rem; height:{card_height};"),
    div(style = "margin: 0.5rem;margin-left: 1rem;
      font-weight: bold;font-size: larger",
        "by medium"),
    div(
      class = "card-body",
      style = "overflow:hidden;",
      div(
        class = "card-title",
        fluidRow(column(
          10,
          div(class = "metric_info_key", metric_key[[1]])
        ),
        column(
          2,
          div(class = "metric_info_value",
              style = "display: flex; justify-content: flex-end;",
              metric_value[[1]])
        )),
        hr(),
        fluidRow(column(
          10,
          div(class = "metric_info_key", metric_key[[2]])
        ),
        column(
          2,
          div(class = "metric_info_value",
              style = "display: flex; justify-content: flex-end;",
              metric_value[[2]])
        )),
        hr(),
        fluidRow(column(
          10,
          div(class = "metric_info_key", metric_key[[3]])
        ),
        column(
          2,
          div(class = "metric_info_value",
              style = "display: flex; justify-content: flex-end;",
              metric_value[[3]])
        )),
        hr(),
        fluidRow(column(
          10,
          div(class = "metric_info_key", metric_key[[4]])
        ),
        column(
          2,
          div(class = "metric_info_value",
              style = "display: flex; justify-content: flex-end;",
              metric_value[[4]])
        )),
        hr(),
        fluidRow(column(
          10,
          div(class = "metric_info_key", metric_key[[5]])
        ),
        column(
          2,
          div(class = "metric_info_value",
              style = "display: flex; justify-content: flex-end;",
              metric_value[[5]])
        ))
      )
    )
  )
}


#' @export
map_card <- function(id,
                     card_height = "50vh") {
  div(
    class = "card text-white bg-card mb-3",
    style = glue(
      "max-width:40rem; height:{card_height};overflow:hidden;
                 position:inherit;"
    ),
    div(
      class = "card-body",
      p(
        class = "card-title",
        style = "margin-top: -0.5rem;
        font-weight: bold;",
        "User Locations - live"
      ),
      div(style = "margin-top: -120px;",
          shinycssloaders::withSpinner(echarts4rOutput(id),
                                       type = 4,
                                       size = 0.5,
                                       color = "#58D9F9"))
    )
  )
}

#' @export
gauge_card <- function(id,
                       card_height = "50vh") {
  div(
    class = "card text-white bg-card mb-3",
    style = glue(
      "max-width:40rem; height:{card_height};overflow:hidden;
                 position:inherit;"
    ),
    div(
      class = "card-body",
      p(
        class = "card-title",
        style = "margin-top: -0.5rem;
        font-weight: bold;",
        "Bounce Rate - 7 days"
      ),
      div(style = "resize: both; overflow:auto;",
          fluidRow(
            column(2,
                   ),
            column(8,
                   gaugeOutput(id)
                   # shinycssloaders::withSpinner(echarts4rOutput(id),
                   #                              type = 4,
                   #                              size = 0.5,
                   #                              color = "#58D9F9")
                   ),
            column(2,)
          )
         
          )
    )
  )
}

#' @export
side_card <- function(card_height = "50vh",
                      side_heading = "",
                      metrics1 = "",
                      metrics1_text = "",
                      metrics2 = "",
                      metrics2_text = "") {
  div(
    class = "card text-white bg-card mb-3",
    style = glue(
      "max-width:40rem; height:{card_height};overflow:hidden;
                 position:inherit;"
    ),
    div(
      class = "card-body",
      p(
        class = "card-title",
        style = "margin-top: -0.5rem;
        font-weight: bold;",
        side_heading
      ),
      div(fluidRow(column(
        6,
        h1(metrics1),
        p(metrics1_text)
      ),
      column(
        6,
        h1(metrics2),
        p(metrics2_text)
      )))
    )
  )
}

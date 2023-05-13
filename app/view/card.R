box::use(shiny[...],
         echarts4r[...],
         glue[glue],
         flexdashboard[gaugeOutput, ])

#' @export
key_metrics_card <- function(id,
                             header_text = "",
                             key_metric = "",
                             key_metric_text = "") {
  div(
    class = "card text-white bg-card mb-3 metrics_card",
    div(class = "metrics_card_header",
        header_text),
    div(
      class = "card-body",
      div(
        class = "card-title",
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
metrics_info_card <- function(metric_key,
                              metric_value) {
  div(
    class = "card text-white bg-card mb-3 metrics_info_card",
    div(class = "metrics_card_header",
        "by medium"),
    div(
      class = "card-body",
      div(
        class = "card-title",
        fluidRow(column(
          10,
          div(class = "metric_info_key", metric_key[[1]])
        ),
        column(
          2,
          div(class = "metric_info_value",
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
              metric_value[[5]])
        ))
      )
    )
  )
}


#' @export
map_card <- function(id) {
  div(
    class = "card text-white bg-card mb-3 side_card",
    div(
      class = "card-body",
      p(
        class = "card-title",
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
gauge_card <- function(id) {
  div(
    class = "card text-white bg-card mb-3 side_card",
    div(
      class = "card-body",
      p(
        class = "card-title",
        "Bounce Rate - 7 days"
      ),
      div(gaugeOutput(id))
    )
  )
}

#' @export
side_card <- function(side_heading = "",
                      metrics1 = "",
                      metrics1_text = "",
                      metrics2 = "",
                      metrics2_text = "") {
  div(
    class = "card text-white bg-card mb-3 side_card",
    div(
      class = "card-body",
      p(
        class = "card-title",
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

box::use(
  shiny[...],
  bslib[...],
  echarts4r[...],
  tibble[tibble, rownames_to_column],
  flexdashboard[gaugeOutput, renderGauge, gauge, gaugeSectors, ]
)

box::use(
  app/view/card[...],
)

ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    theme = bs_theme(version = 5),
    fluidRow(
      column(3,
             div(
             key_metrics_card(ns("plot_1"),
                              header_text = "Conversions",
                              key_metric = "229",
                              key_metric_text = "past 7 days"),
             metrics_info_card(
               list("organic", "cpc", "(none)", "referral", "p_social"),
               list("97", "49", "49", "31", "3"))
             )
      ),
      column(3,
             div(
              key_metrics_card(ns("plot_2"),
                               header_text = "Conversion rate",
                               key_metric = "0.9%",
                               key_metric_text = "7 day average"),
             metrics_info_card(
               list("cpc", "p_social", "referral", "(none)",  "organic"),
               list("6.0%", "3.7%", "3.1%", "0.7%", "0.6%"))
             )
      ),
      column(3,
             key_metrics_card(ns("plot_3"),
                              header_text = "Sessions",
                              key_metric = "26.9K",
                              key_metric_text = "past 7 days"),
             metrics_info_card(
               list("organic", "(none)", "cpc",  "referral", "p_social"),
               list("17.3K", "6,603", "1,333", "1,009", "87"))
      ),
      column(3,
             div(
               side_card(side_heading = "Stickiness - 7 day",
                         metrics1 = "80.3%", metrics1_text = "New users",
                         metrics2 = "1.14", metrics2_text = "Sessions per user"),
               side_card(side_heading = "Engagement - 7 day",
                         metrics1 = "59s", metrics1_text = "Avg session duration",
                         metrics2 = "1.47", metrics2_text = "Pages per session"),
             gauge_card(ns("gauge_plot")),
             map_card(ns("map_plot"))
             )
      )
    )
  )
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {
    d <- tibble(continent = c("Asia", "Europe", "Africa", "Australia", "Americas"),
                lat = c(54.0479,
                        54.5260,
                        8.7832,
                        -25.2744,
                        34.5260),
                long = c(100.6197,
                         15.2551,
                         34.5085,
                         133.7751,
                         -100.2551),
                value = 50)
    output$gauge_plot <- renderGauge({
      gauge(82.5,
            min = 0,
            max = 100,
            symbol = "%",
            sectors = gaugeSectors(success = c(50, 100),
                                   warning = c(20, 40),
                                   danger = c(0, 20),
                                   colors = c("#04D1FF", "#E5C852", "#E5C852")))
    })
    output$map_plot <- renderEcharts4r({
    d |>
      e_charts(long) |>
      e_geo(
        roam = FALSE
      ) |>
      e_legend(show = FALSE)
    })
    output$plot_1 <- renderEcharts4r({
      data.frame(
        x = seq(10),
        y = stats::rnorm(10, 10, 3),
        z = stats::rnorm(10, 10, 3),
        w = stats::rnorm(10, 10, 3)
      ) |>
        e_charts(x) |>
        e_line(z, showSymbol  = FALSE,
               smooth      = TRUE,
               color = "#E5C852",
               animationDuration = 3000,
               animationEasing = "circularInOut",
               lineStyle   = list(width = 3)) |>
        e_line(y, showSymbol  = FALSE,
               smooth      = TRUE,
               color = "#04D1FF",
               animationDuration = 3000,
               animationEasing = "circularInOut",
               lineStyle   = list(width = 3)) |>
        e_legend(show = FALSE) |>
        e_hide_grid_lines() |>
        e_tooltip(trigger = "axis",
                  valueFormatter = htmlwidgets::JS("(value) => value.toFixed(2)"))
    })
    output$plot_2 <- renderEcharts4r({
      data.frame(
        x = seq(10),
        y = stats::rnorm(10, 10, 3),
        z = stats::rnorm(10, 10, 3),
        w = stats::rnorm(10, 10, 3)
      ) |>
        e_charts(x) |>
        e_line(z, showSymbol = FALSE,
               smooth = TRUE,
               color = "#E5C852",
               animationDuration = 3000,
               animationEasing = "circularInOut",
               lineStyle   = list(width = 3)) |>
        e_line(y, showSymbol  = FALSE,
               smooth      = TRUE,
               color = "#04D1FF",
               animationDuration = 3000,
               animationEasing = "circularInOut",
               lineStyle   = list(width = 3)) |>
        e_legend(show = FALSE) |>
        e_hide_grid_lines() |>
        e_tooltip(trigger = "axis",
                  valueFormatter = htmlwidgets::JS("(value) => value.toFixed(2)"))
    })
    output$plot_3 <- renderEcharts4r({
      data.frame(
        x = seq(10),
        y = stats::rnorm(10, 10, 3),
        z = stats::rnorm(10, 10, 3),
        w = stats::rnorm(10, 10, 3)
      ) |>
        e_charts(x) |>
        e_line(z, showSymbol  = FALSE,
               smooth = TRUE,
               color = "#E5C852",
               animationDuration = 3000,
               animationEasing = "circularInOut",
               lineStyle = list(width = 3)) |>
        e_line(y, showSymbol  = FALSE,
               smooth = TRUE,
               color = "#04D1FF",
               animationDuration = 3000,
               animationEasing = "circularInOut",
               lineStyle = list(width = 3)) |>
        e_legend(show = FALSE) |>
        e_hide_grid_lines() |>
        e_tooltip(trigger = "axis",
                  valueFormatter = htmlwidgets::JS("(value) => value.toFixed(2)"))
    })
  })
}

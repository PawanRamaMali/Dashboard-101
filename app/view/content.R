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
                              card_height = "55vh",
                              header_text = "Conversions",
                              key_metric = "229",
                              key_metric_text = "past 7 days"),
             metrics_info_card("40vh",
                        list("organic", "cpc", "(none)", "referral", "p_social"),
                        list("97", "49", "49", "31", "3"))
             )
      ),
      column(3,
             div(
               key_danger_metrics_card(ns("plot_2"),
                                       card_height = "55vh",
                                       header_text = "Conversion rate",
                                key_metric = "0.9%",
                              key_metric_text = "7 day average"),
             metrics_info_card("40vh",
                          list("cpc", "p_social", "referral", "(none)",  "organic"),
                          list("6.0%", "3.7%", "3.1%", "0.7%", "0.6%"))
             )
      ),
      column(3,
             key_metrics_card(ns("plot_3"),
                              card_height = "55vh",
                              header_text = "Sessions",
                              key_metric = "26.9K",
                              key_metric_text = "past 7 days"),
             metrics_info_card("40vh",
                               list("organic", "(none)", "cpc",  "referral", "p_social"),
                               list("17.3K", "6,603", "1,333", "1,009", "87"))
      ),
      column(3,
             div(
               side_card("22vh",
                         side_heading = "Stickiness - 7 day",
                         metrics1 = "80.3%", metrics1_text = "New users",
                         metrics2 = "1.14", metrics2_text = "Sessions per user"),
               side_card("22vh",
                         side_heading = "Engagement - 7 day",
                         metrics1 = "59s", metrics1_text = "Avg session duration",
                         metrics2 = "1.47", metrics2_text = "Pages per session"),
             gauge_card(ns("gauge_plot"), "22vh"),
             map_card(ns("map_plot"), "22vh")
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
    # output$gauge_plot <- renderEcharts4r({
    #   e_charts() |>
    #     e_gauge(
    #       82.5,
    #       "82.5%",
    #       startAngle = 180,
    #       endAngle = 0,
    #       min = 0,
    #       max = 100,
    #       splitNumber = 10,
    #       radius = "180",
    #       itemStyle = list(color = "#58D9F9",
    #                        shadowColor = "rgba(0,138,255,0.45)",
    #                        shadowBlur = 10,
    #                        shadowOffsetX = 2,
    #                        shadowOffsetY = 2),
    #       axisLine = list(roundCap = TRUE, lineStyle = list(width = 18)),
    #       progress = list(show = TRUE, roundCap = TRUE,  width = 18),
    #       axisTick = list(show = FALSE),
    #      splitLine = list(show = FALSE),
    #       axisLabel = list(
    #         show = FALSE,
    #         color = "#000000",
    #         fontWeight = "bold",
    #         borderRadius = 5
    #       ),
    #       pointer = list(show = TRUE, length = "80%",
    #                       icon = "path://M2090.36389,615.30999 L2090.36389,
    #                      615.30999 C2091.48372,615.30999 2092.40383,
    #                      616.194028 2092.44859,617.312956 L2096.90698,
    #                      728.755929 C2097.05155,732.369577 2094.2393,
    #                      735.416212 2090.62566,735.56078 C2090.53845,
    #                      735.564269 2090.45117,735.566014 2090.36389,
    #                      735.566014 L2090.36389,735.566014 C2086.74736,
    #                      735.566014 2083.81557,732.63423 2083.81557,
    #                      729.017692 C2083.81557,728.930412 2083.81732,
    #                      728.84314 2083.82081,728.755929 L2088.2792,
    #                      617.312956 C2088.32396,616.194028 2089.24407,
    #                      615.30999 2090.36389,615.30999 Z"
    #                      )
    #     )
    # })
    output$gauge_plot = renderGauge({
      gauge(0.82, 
            min = 0, 
            max = 1, 
            sectors = gaugeSectors(success = c(0.5, 1), 
                                   warning = c(0.3, 0.5),
                                   danger = c(0, 0.3)))
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

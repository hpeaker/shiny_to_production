
penguinsUI <- function(id, df_num) {
  ns <- NS(id)

  fluidRow(
    column(3,
           hr(),
           varSelectInput(ns("xvar"), "X variable", df_num, selected = "Bill Length (mm)"),
           varSelectInput(ns("yvar"), "Y variable", df_num, selected = "Bill Depth (mm)"),
           hr(), # Add a horizontal rule
           checkboxInput(ns("by_species"), "Show species", TRUE),
           checkboxInput(ns("show_margins"), "Show marginal plots", TRUE),
           checkboxInput(ns("smooth"), "Add smoother")
    ),
    column(9,
           plotOutput(ns("scatter"))
    )
  )
}

penguinsServer <- function(id, penguins_data) {
  moduleServer(
    id,
    function(input, output, session) {
      output$scatter <- renderPlot({
        p <- ggplot(penguins_data(), aes(!!input$xvar, !!input$yvar)) + list(
          theme(legend.position = "bottom"),
          if (input$by_species) aes(color = Species),
          geom_point(),
          if (input$smooth) geom_smooth()
        )

        if (input$show_margins) {
          margin_type <- if (input$by_species) "density" else "histogram"
          p <- ggExtra::ggMarginal(p, type = margin_type, margins = "both",
                                   size = 8, groupColour = input$by_species, groupFill = input$by_species)
        }

        p
      }, res = 100)
    }
  )
}

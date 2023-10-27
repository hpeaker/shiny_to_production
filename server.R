
server <- function(input, output, session) {
  subsetted <- reactive({
    req(input$species)
    df |> filter(Species %in% input$species)
  })

  penguinsServer("top", subsetted)
  penguinsServer("bottom", subsetted)
}

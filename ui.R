
ui <- fluidPage(
  theme = bs_theme(bootswatch = "minty"),
  checkboxGroupInput(
    "species", "Filter by species",
    choices = unique(df$Species),
    selected = unique(df$Species)
  ),
  penguinsUI("top", df_num),
  hr(),
  penguinsUI("bottom", df_num)
)

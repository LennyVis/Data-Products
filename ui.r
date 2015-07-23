
shinyUI(pageWithSidebar(
  headerPanel("Car Acceptability"),
  sidebarPanel(
    sliderInput("maxdepth",
                "Maximum depth of the tree model",
                min=2,
                max=6,
                value=3),
    checkboxGroupInput("vars",
                       "Variables to be included in the model",
                       c("Price" = "price",
                         "Doors" = "doors",
                         "Numb of persons" = "persons",
                         "Luggage area" = "lug_boot",
                         "Safety" = "safety"),
                       selected=c("price", "doors", "persons", "lug_boot", "safety"))
  ),
  mainPanel(
    plotOutput("rpartPlot")
  )
))
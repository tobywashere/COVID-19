library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict deaths from COVID-19 cases"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderCases", "What is the number of COVID-19 cases in the country?",
                  0, 308850, value=6615),
      checkboxInput("showModel", "Show/Hide Model", value = FALSE)
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted deaths from the model:"),
      textOutput("pred1")
    )
  )
))

library(shiny)
library(dplyr)

shinyServer(function(input, output) {
  data <- read.csv('04-04-2020.csv')
  data <- select(data, Country_Region, Confirmed, Deaths) %>%
    group_by(Country_Region) %>%
    summarise_all(sum) %>%
    arrange(desc(Confirmed))
  model <- lm(Deaths~Confirmed, data = data)

  modelpred <- reactive({
    casesInput <- input$sliderCases
    predict(model, newdata = data.frame(Confirmed=casesInput))
  })

  output$plot1 <- renderPlot({
    casesInput <- input$sliderCases
    plot(data$Confirmed, data$Deaths, xlab = "Confirmed Cases",
         ylab = "Deaths", bty = "n", pch = 16,
         xlim = c(min(data$Confirmed), max(data$Confirmed)),
         ylim = c(min(data$Deaths), max(data$Deaths)))
    if (input$showModel) {
      abline(model, col = "red", lwd = 2)
    }
    legend('topleft', c("Linear Model Prediction"), pch = 16,
           col = c("red"), bty = "n", cex = 1.2)
    points(casesInput, modelpred(), col = "red", pch = 16, cex = 2)
  })

  output$pred1 <- renderText({
    round(modelpred(), 0)
  })
})

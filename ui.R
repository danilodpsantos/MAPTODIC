library(shiny)
library(shinyjs)
library(xlsx)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("cerulean"),

  useShinyjs(),

  fixedRow(
    h3(" "),
    column(
      4,
      img(src = "figures/elsa.jpg", align = "left")
    ),

    column(3,
      align = "middle",
      fileInput("file", "Escolha o mapa:",
        multiple = FALSE,
        accept = c(".pdf")
      )
    ),

    column(2,
      textInput(
        inputId = "letter",
        label = "LETRA:",
        value = "C"
      ),
      align = "middle"
    ),

    column(1,
      h3(" "),
      h3(" "),
      actionButton("gg", "Gerar dicionario", class = "btn btn-primary"),
      align = "middle"
    ),

    column(1,
      align = "middle",
      h3(" "),
      h3(" "),
      downloadButton("downloadData", "Download")
    ),

    column(1,
      align = "middle",
      h3(" "),
      h3(" "),
      actionButton("clear", "Limpar", class = "btn btn-danger")
    )
  ),
  fluidRow(
    column(
      2,
      tableOutput("tbview")
    ),
    column(10,
      uiOutput("pdfview"),
      offset = 0
    )
  )
))

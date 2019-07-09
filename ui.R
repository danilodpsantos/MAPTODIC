ler_libs <- function(packages){
  # Cria vetor com os nomes dos packages chamados que não estão instalados:
  instalar <- packages[!(packages %in% installed.packages()[, "Package"])]
  
  # Caso exista algum package não instalado na lista:
  if(length(instalar) > 0){
    # Instala os packages e suas dependências (packages dos quais eles dependem):
    install.packages(pkgs = instalar, dependencies = TRUE)
  }
  
  # Aplica a função "require" em cada package, com a opção "character.only = TRUE" para passar os nomes como strings:
  invisible(sapply(packages, require, character.only = TRUE))
}

ler_libs(c("shiny", "shinyjs", "xlsx", "shinythemes", "textreadr"))

library(shiny)
library(shinyjs)
library(xlsx)
library(shinythemes)
library(textreadr)

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
      fileInput("file", "Escolha o arquivo:",
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

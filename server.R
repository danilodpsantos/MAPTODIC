library(shiny)
library(shinyjs)
library(xlsx)

shinyServer(function(input, output) {
  source(file = "www/functions/PDFTODICAPP.r", encoding = "UTF-8")

  observe({
    req(input$file)

    show("pdfview")

    file.copy(input$file$datapath, "www/temp/mypdf.pdf", overwrite = T)

    output$pdfview <- renderUI({
      tags$iframe(style = "height:5000px; width:100%", src = "temp/mypdf.pdf")
    })
  })

  observeEvent(input$gg, {
    show("tbview")
  })

  ntext <- eventReactive(input$gg, {
    arquivo <- input$file

    if (is.null(arquivo)) {
      return()
    }

    pdftodicn("www/temp/mypdf.pdf", toupper(input$letter))
  })

  output$tbview <- renderTable({
    if (is.null(ntext())) {
      return()
    }
    ntext()
  }, digits = 0)

  output$downloadData <- downloadHandler(
    filename = function() {
      paste("Dicionario", ".xlsx", sep = "")
    },
    content = function(file) {
      write.xlsx(ntext(), file, row.names = FALSE)
    }
  )

  observeEvent(input$clear, {
    reset("file")
    hide("pdfview")
    hide("tbview")
  })
})

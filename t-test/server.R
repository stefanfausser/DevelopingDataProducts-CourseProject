shinyServer(
    function(input, output, session) {
        data <- reactive({
            inFile <- input$file1
            
            # use 'mtcars' when data is not uploaded
            if (is.null(inFile))
                return(mtcars)
            
            read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)
        })
        
        observe({
            updateSelectInput(
                session,
                "var1",
                choices=names(data()))
        })
        
        observe({
            updateSelectInput(
                session,
                "var2",
                choices=names(data()))
        })
        
        # Perform the t-test
        output$ttest <- renderPrint({
            # check required variables, stop when not available
            req(input$var1,
                input$var2,
                data
            )
            
            var1 <- data()[,input$var1]
            var2 <- data()[,input$var2]
            
            t.test(var1, var2, 
                   alternative = input$alternative, 
                   paired = as.logical(input$paired),
                   var.equal = as.logical(input$eqvar),
                   conf.level = input$conflevel)
        })
        
        output$plot <- renderPlot({
            # check required variables, stop when not available
            req(input$var1,
                input$var2,
                data
            )
            
            var1 <- data()[,input$var1]
            var2 <- data()[,input$var2]

            boxplot(cbind(var1, var2))
        })
    }
)

shinyUI(pageWithSidebar(
    headerPanel("Two sample t-test"),
    sidebarPanel(
        tabsetPanel(
            tabPanel('Load data',
                     fileInput('file1', 'Choose CSV File',
                               accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                     tags$hr(),
                     checkboxInput('header', 'Header', TRUE),
                     radioButtons('sep', 'Separator',
                                  c(Comma=',',
                                    Semicolon=';',
                                    Tab='\t'),
                                  'Comma'),
                     radioButtons('quote', 'Quote',
                                  c(None='',
                                    'Double Quote'='"',
                                    'Single Quote'="'"),
                                  'Double Quote')
            ),
            tabPanel('Parameters',
                     selectInput("var1", 
                                 label = "First variable",
                                 ""
                     ),
                     selectInput("var2", 
                                 label = "Second variable",
                                 ""
                     ),
                     radioButtons("paired",
                                  "Paired:",
                                  choices = c("No" = "FALSE",
                                              "Yes" = "TRUE")),
                     radioButtons("eqvar",
                                  "Assume equal variances",
                                  choices = c("No" = "FALSE",
                                              "Yes" = "TRUE")),
                     selectInput("alternative",
                                 label = "Alternative hypothesis",
                                 choices = c("Equal" = "two.sided", 
                                             "Less" = "less",
                                             "Greater" = "greater")),
                     sliderInput("conflevel",
                                  label = "Confidence level",
                                  value = 0.95,
                                  min = 0.8,
                                  max = 0.99,
                                  step = 0.01),
                     submitButton("Submit")
            )
        )
    ),
    mainPanel(
        h1("Instructions"),
        p("1. Upload your data file in tab", strong("Load data")),
        helpText("When no data file is uploaded then 'mtcars' is used by default"),
        p("2. Set the t-test parameters in tab", strong("Parameters")),
        helpText("Default is an unpaired two-sample Welch's t-test"),
        p("3. Click on", strong("Submit"), "in tab", strong("Parameters")),
        h1("Results"),
        verbatimTextOutput("ttest"),
        plotOutput("plot")
    )
))

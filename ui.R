library(shiny)
dfwData <- read.csv("AEAP_NYSERDA_Chem_94-12_v9_web.csv")
 
# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Darrin Fresh Water Demo"),

  # Sidebar with controls to select the lake to plot
  sidebarPanel(
  
  selectInput("variable", "Lake name:",
              
               as.list(
               
               unique(as.character(as.vector(dfwData[,c(2)])))
                 
                   )
  
              ),
              
  selectInput("samplelayer", "Sample Layer:",
              
               as.list(
               
               unique(as.character(as.vector(dfwData[,c(8)])))
                 
                   )
  
              ),
              
  wellPanel( 
            p(strong("Plot")), 
            
            selectInput("variable3", "X axis:",
              
               as.list(
               
               unique(as.character(as.vector(colnames(dfwData)[5:30])))
                 
                   )
  
              ),
              
            selectInput("variable4", "Y axis:",
              
               as.list(
               
               unique(as.character(as.vector(colnames(dfwData)[6:30])))
                 
                   )
            
            )),
                         
                               
              
  wellPanel( 
            p(strong("Analysis")), 
            
            checkboxInput(inputId = "CCF", label = "Show cross correlation", value = FALSE) 
            
            )
                         
                   ),
  
  mainPanel(
    
    plotOutput("lakePlot"),
    
    conditionalPanel(condition = "input.CCF", 
         br(), 
         plotOutput("ccfPlot"))   
    
           )
))

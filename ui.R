library(shiny)
dfwData <- read.csv("AEAP_NYSERDA_Chem_94-12_v9_web.csv")
 
# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Darrin Fresh Water Demo"),

  # Sidebar with controls to select the lake to plot
  sidebarPanel(
  
  selectInput("variable", "Lakename:",
              
               as.list(
               
               unique(as.character(as.vector(dfwData[,c(2)])))
                 
                   )
  
              )),
  
  mainPanel(
    
    plotOutput("lakePlot")
    
           )

))

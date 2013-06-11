library(shiny)
library(gdata)
library(xts)

#dfwData[,c(2,4,11,12)]

# Define server logic required to plot pH value against ANC
shinyServer(function(input, output) {

  # Generate a plot of the requested variable via time and only 

  output$lakePlot <- renderPlot({
  	dfwData <- read.csv("AEAP_NYSERDA_Chem_94-12_v9_web.csv")
  # Create Line Chart
#print(colnames(dfwData))
	alllakes = unique(dfwData[,2])
	nlakes = length(alllakes)
	dfwData$Date <- as.Date(dfwData$Date, "%d-%b-%y")
	dfwData$pH_air_eq <- as.numeric(dfwData$pH_air_eq)
    dfwData$ANC.ueq.L. <- as.numeric(dfwData$ANC.ueq.L.) 
#print(alllakes)
# add lines 
#  for(i in 1:nlakes){
  	#print(i)
#  i = which(dfwData[dfwData[,2] == input$variable,])

	subdata = na.omit(dfwData[dfwData[,2] == input$variable & dfwData[,8] == input$samplelayer, c(2,4,11,12)])

	#subdata = dfwData[dfwData[,2] == alllakes[i],]
#print(alllakes[i])

    lakePh = xts(subdata[,3],order.by= subdata$Date)
#   index(lakePh) = as.Date(index(lakePh))
    lakeAnc = xts(subdata[,4],order.by= subdata$Date)
	
	plot(lakePh,yaxt="n", type="n",
         main="pH vs ANC of the lake")
    lines(lakePh,col="red")
    
    mtext("pH air eq",side=2,col="red",line=2.5)
    axis(2,ylim=range(subdata[,3]),col="red",col.axis="red",las=1)
    
    axis(1,xlim=range(index(lakePh)),at=index(lakePh),label=index(lakePh))
    print(subdata)    
    mtext("Time(Date)",side=1,col="black",line=2.5)    

            
    par(new=TRUE)
    
    plot(lakeAnc,
         axes=FALSE,type="l", main="", col ="blue")
    
    mtext("ANC(ueq/L)",side=4,col="blue",line=-1.5)
    axis(4,ylim=range(subdata[,4]),col="blue",col.axis="blue",las=1)
    

    
# add a legend

legend("topleft", legend=colnames(subdata)[3:4], cex=0.8, lty=rep(1,2),col=c("red", "blue"))

  })
  
   output$ccfPlot <- renderPlot({
   	
   	dfwData <- read.csv("AEAP_NYSERDA_Chem_94-12_v9_web.csv")
  # Create Line Chart
#print(colnames(dfwData))
	alllakes = unique(dfwData[,2])
	nlakes = length(alllakes)
	dfwData$Date <- as.Date(dfwData$Date, "%d-%b-%y")
	dfwData$pH_air_eq <- as.numeric(dfwData$pH_air_eq)
    dfwData$ANC.ueq.L. <- as.numeric(dfwData$ANC.ueq.L.) 
#print(alllakes)
# add lines 
#  for(i in 1:nlakes){
  	#print(i)
#  i = which(dfwData[dfwData[,2] == input$variable,])

	subdata = na.omit(dfwData[dfwData[,2] == input$variable & dfwData[,8] == input$samplelayer, c(2,4,11,12)])

	#subdata = dfwData[dfwData[,2] == alllakes[i],]
#print(alllakes[i])

    lakePh = xts(subdata[,3],order.by= subdata$Date)
#   index(lakePh) = as.Date(index(lakePh))
    lakeAnc = xts(subdata[,4],order.by= subdata$Date)
    
   	 ccf(drop(lakePh),drop(lakeAnc),main="Cross Correlation Analysis")
   	 })
  
  })


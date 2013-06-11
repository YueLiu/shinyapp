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
	dfwData[,input$variable3] <- as.numeric(dfwData[,input$variable3])
    dfwData[,input$variable4] <- as.numeric(dfwData[,input$variable4]) 
#print(alllakes)
# add lines 
#  for(i in 1:nlakes){
  	#print(i)
#  i = which(dfwData[dfwData[,2] == input$variable,])
print(input$variable)
print(input$variable3)
print(input$variable4)



	subdata = na.omit(dfwData[dfwData[,2] == input$variable & dfwData[,8] == input$samplelayer, c("LakeName","Date",input$variable3,input$variable4)])
	print(subdata)

	#subdata = dfwData[dfwData[,2] == alllakes[i],]
#print(alllakes[i])

    lake_x = xts(subdata[,input$variable3],order.by= subdata$Date)
    print(input$variable3)
    lake_y = xts(subdata[,input$variable4],order.by= subdata$Date)
	
	plot(lake_x,yaxt="n", type="n",
         main= "x vs y of the lake")
    lines(lake_x,col="red")
    
    mtext(input$variable3,side=2,col="red",line=2.5)
    axis(2,ylim=range(subdata[,input$variable3]),col="red",col.axis="red",las=1)
    
    axis(1,xlim=range(index(lake_x)),at=index(lake_x),label=index(lake_x))
    print(subdata)    
    mtext("Time(Date)",side=1,col="black",line=2.5)    

            
    par(new=TRUE)
    
    plot(lake_y,
         axes=FALSE,type="l", main="", col ="blue")
    
    mtext(input$variable4,side=4,col="blue",line=-1.5)
    axis(4,ylim=range(subdata[,input$variable4]),col="blue",col.axis="blue",las=1)
    

    
# add a legend

legend("topleft", legend=c(input$variable3,input$variable4), cex=0.8, lty=rep(1,2),col=c("red", "blue"))

  })
  
   output$ccfPlot <- renderPlot({
   	
   	dfwData <- read.csv("AEAP_NYSERDA_Chem_94-12_v9_web.csv")
  # Create Line Chart
#print(colnames(dfwData))
	alllakes = unique(dfwData[,2])
	nlakes = length(alllakes)
	dfwData$Date <- as.Date(dfwData$Date, "%d-%b-%y")
	dfwData[,input$variable3] <- as.numeric(dfwData[,input$variable3])
    dfwData[,input$variable4] <- as.numeric(dfwData[,input$variable4])
#print(alllakes)
# add lines 
#  for(i in 1:nlakes){
  	#print(i)
#  i = which(dfwData[dfwData[,2] == input$variable,])

	subdata = na.omit(dfwData[dfwData[,2] == input$variable & dfwData[,8] == input$samplelayer, c("LakeName","Date",input$variable3,input$variable4)])
	
	#subdata = dfwData[dfwData[,2] == alllakes[i],]
#print(alllakes[i])

    lake_x = xts(subdata[,input$variable3],order.by= subdata$Date)
#   index(lakePh) = as.Date(index(lakePh))
    lake_y = xts(subdata[,input$variable4],order.by= subdata$Date)
    
    if (input$CCF == TRUE)
   	 ccf(drop(lake_x),drop(lake_y),main="Cross Correlation Analysis")
   	 
   	 })
  
  })


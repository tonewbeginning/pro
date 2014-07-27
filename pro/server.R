# Contributed by Joe Cheng, February 2013 Requires googleVis version 0.4.0 and shiny 0.4.0 or higher
# server.R
library(googleVis)
library(shiny)
library(RCurl)

shinyServer(function(input, output) {
  
  output$view <- renderGvis(
    {
      Country=c("Argentina","Chile","Uruguay","Venezuela","Brazil","Colombia","Suriname","Peru","Ecuador","Bolivia","Paraguay","Guyana")
      Per.Day.Cost<-c(40, 39, 36, 34, 29, 24, 24, 24, 20, 13, 11, 11)
      x=cbind(Country,Per.Day.Cost)
      x=data.frame(x)
      x$Per.Day.Cost=as.numeric(x$Per.Day.Cost)
      dailybudget=input$budget/input$numdays
      x$Country=as.character(x$Country);  x$InBudgettxt[dailybudget<x$Per.Day.Cost]="Out of Budget"
      x$InBudgettxt[dailybudget>x$Per.Day.Cost]="In Budget" 
      x$InBudgettxt[dailybudget>2*x$Per.Day.Cost]="Well within Budget" 
      x$InBudget[dailybudget<x$Per.Day.Cost]=1
      x$InBudget[dailybudget>x$Per.Day.Cost]=2
      x$InBudget[dailybudget>2*x$Per.Day.Cost]=3
              G <- gvisGeoChart(x, locationvar = "Country", colorvar = "InBudget",hovervar="Country" 
                        ,options=list(region="005",gvis.editor="             Is your holiday in Budget?",height=500,width=500,backgroundColor="lightblue"
                                      ,colorAxis="{colors:['orange', 'grey','green']}"))
      a=c("Orange","Grey","Green","Out of budget","In budget","Well within budget")
      dim(a)=c(3,2)
      colnames(a)=c("Color","Vacation_In_Country_is: ")
      a=data.frame(a)
      a1=gvisTable(a,options=list(width=300,height=120))
      gvisMerge(a1,G,horizontal=FALSE,tableOptions="bgcolor=\"#CCCCCC\" cellspacing=10")
    }
    )
})
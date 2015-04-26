library(shiny)
library(ggplot2)

# Prepare lists for user input
col.names <- c("Street.Name", "Price", "Block.Size.m2", "Transaction.Type", "Purpose"
               ,"Bed.Num", "Bath.Num", "Garage.Num", "Street.Type", "Contract.Year")

Bedrm.Num <- c("1","2","3","4","5")
BlockSize <- c("200", "400", "600", "800", "1000", "1200", "1400", "1600", "1800", "2000"
               , "2500", "3000", "3500")


shinyUI(navbarPage("House Price Toolbox",
  
      tabPanel("Explore",
               sidebarLayout(
                  sidebarPanel(
      
                    p("Explore the data by choosing X and Y axis to display."),
                    selectInput('x', 'X', col.names, "Bed.Num"),
                    selectInput('y', 'Y', col.names, "Price")
                  ),
                
                  mainPanel(
                    plotOutput('plot')
                  )
               )
      ),
      tabPanel("Predict",
               sidebarLayout(
                 sidebarPanel(
                   
                   p("Select values and click the button to calculate the price prediction."),
                   selectInput('b', 'Number of Bedrooms', Bedrm.Num, "3"),
                   selectInput('l', "Block Size (m2)", BlockSize, "600"),
                   actionButton('btnRunPredict', "Predict Price")
  
                 ),
                 
                 mainPanel(
                   p("Price Prediction (AUD)."),
                   verbatimTextOutput('predict')
                 )
               )
               
      ),
      tabPanel("About",
               mainPanel(
                 includeMarkdown("include.md")
               )
      )
  )
)
library(shiny)

# Plotting
library(ggplot2)


# Required by includeMarkdown
library(markdown)

# Load data
dataset <- read.csv("data/HousePricesHawker.csv", header = TRUE, na.strings = "NA")
dataset <- subset(dataset, grepl("*Residential*", dataset$Purpose, ignore.case = TRUE))

# Data Conversions
dataset$Contract.Date <- as.Date(dataset$Contract.Date , "%d/%m/%Y")
dataset$Transaction.Date <- as.Date(dataset$Transaction.Date , "%d/%m/%Y")
dataset$Advertise.Date <- as.Date(dataset$Advertise.Date , "%d/%m/%Y")
dataset$Contract.Year <- as.factor(format(dataset$Contract.Date, "%Y"))


# Prepare the model
set.seed(33833)
model <- lm(Price ~ Bed.Num + Block.Size.m2, data = dataset) 

# Shiny server 
shinyServer(
function(input, output, session) {
  
  # Button click event for Predict
  datainput  <- eventReactive(input$btnRunPredict,{
    Bed.Num <- as.numeric(input$b)
    Block.Size.m2 <- as.numeric(input$l)
    
    data.frame(Bed.Num = Bed.Num,
               Block.Size.m2 = Block.Size.m2)
  })
  
  # Data Exploration tab
  output$plot <- renderPlot({
    p <- ggplot(dataset, aes_string(x=input$x, y=input$y)) + geom_point()
    print(p)
  }, height=700)
  
  # Prediction tab
  output$predict <- renderPrint({
    predict(model, newdata = datainput())
  })
  
}
)
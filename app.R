library(shiny)
library(scrollrevealR)
library(pivta)
library(bubblyr)

ui <- fluidPage(
    
tags$head(tags$style("
                     
@import url('https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@700&display=swap');
                     
body{

font-family: 'Josefin Sans', sans-serif;

color:#B18BEA;


}
                     
                     ")),
    
bubbly(theme = "rladies"), 


div(id = "title1", h1("Table Pivoting with pivta"), align = "center"),


br(),


sidebarLayout(
    
    sidebarPanel(
        
   helpText("The", a(href="https://github.com/feddelegrand7/pivta", "pivta") , "package allows you to implement a reporting table within a Shiny app. 
   The table on the right is blank. By clicking ont the 'Connect' icon you can upload a csv/json file and work on it. 
   You can also provide a remote URL to a csv or json file. \
   Note that there is a size limit of 1MB.")
   
   
   
   ), 
   
   mainPanel(
       
       pivtaOutput(outputId = "pivta1")
       
       )
    
    
),


br(), br(), br(), br(),


sidebarLayout(
    
    sidebarPanel(
        
    helpText("Now, we'll work on the", a(href = "https://www.imdb.com/title/tt0386676/", "Office US") ,  "(which is my favorite show)", 
             a(href = "https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-03-17/readme.md", "rating data"), 
             "We need to prodive the URL of the csv file to 'dsource' argument of the 'pivta' function"), 
    
    helpText("You can process more variables, work on the mean, median or even calculate your own measure. Try it out ! click on the 'Field' icon and
             drag and drop !")
    
    
    ),
    
   
   mainPanel(
       
       
       pivtaOutput(outputId = "pivta2")
       
       

   )
   
   
   
   
), 



br(), br(), br(), br(),


sidebarLayout(
    
    sidebarPanel(
        
        helpText()
        
        
    ),
    
    
    mainPanel(
        
        
        pivtaOutput(outputId = "pivta3")
        
        
        
    )
    
    
    
    
)






    
    
)

server <- function(input, output) {
    
    
# Implementing the blank pivot table ------------------------------------------
output$pivta1 <- renderPivta({
    
 
    pivta()
    
    
})



output$pivta2 <- renderPivta({
    
    
    
    pivta(dsource = "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv")
    
    
})



output$pivta3 <- renderPivta({
    
    
    pivta(
        report = "https://gist.githubusercontent.com/feddelegrand7/b62a2c4da3c744ed6900894a627fdc7c/raw/ba0c73c8ccaa2f0edd99e0d404f3dd983e7ae8a4/The_Office_Report.json"
        )
    
    
    
    
})
    
}

shinyApp(ui = ui, server = server)

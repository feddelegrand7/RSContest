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
    
bubbly(color = "#1D1D1D"), 


div(id = "title1", h1("Table Pivoting with pivta"), align = "center"),


br(),



sidebarLayout(
    
    sidebarPanel(
        
   wellPanel("The", a(href="https://github.com/feddelegrand7/pivta", "pivta") , "package allows you to implement a reporting table within a Shiny app. 
   The table on the right is blank. By clicking ont the 'Connect' icon you can upload a csv/json file and work on it. 
   You can also provide a remote URL to a csv or json file. \
   Note that there is a size limit of 1MB.")
   
   
   
   ), 
   
   mainPanel(
       
       pivtaOutput(outputId = "pivta1")
       
       )
    
    
),


br(), br(), 

h1("Reading the Data"),




    wellPanel("Now, we'll work with the", a(href = "https://www.imdb.com/title/tt0386676/", "Office US") ,  "(which is my favorite show)", 
             a(href = "https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-03-17/readme.md", "rating data"), 
             "We need to prodive the URL of the csv file to 'dsource' argument of the 'pivta' function"), 
    
    pre("pivta(dsource = 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')"),
    
    wellPanel("You'll get this default layout. To create summary measures, you need to change the layout. 
       Go to 'options' and choose 'classic form'. 
       Then using the 'Fields' menu you can pivot/unpivot, summarize data, format cells and more"),

    pivtaOutput(outputId = "pivta2"),



br(), br(), 


h1("Data Summary"),



        
        wellPanel("After manipulating the data, you can save a 'report.json' file 
                  which stores the information related to the output. In the table on the right, 
                  I've made some data wrangling beforehand, saved the report using the 'Save' icon and hosted it", 
                  a(href = "https://gist.githubusercontent.com/feddelegrand7/b62a2c4da3c744ed6900894a627fdc7c/raw/524515b412eb4d8e2bae5c3807376602b7421a5e/The_Office_Report.json",
                    "here"), " you can also save it locally but you'll need to upload it manually each time you run the app (using the 'Open' icon). Then using only the 'report' argument, we get this table which 
                  retrieves the data and the performed analysis."), 
        
        pre("pivot(report = 'https://gist.githubusercontent.com/feddelegrand7/b62a2c4da3c744ed6900894a627fdc7c/raw/524515b412eb4d8e2bae5c3807376602b7421a5e/The_Office_Report.json')"),
    
   
        pivtaOutput(outputId = "pivta3"), 


        br(), br(),


        wellPanel("Note that pivta is an R wrapper for the", a(href = "https://www.webdatarocks.com/", "WebDataRocks JavaScript library"),
                  "you can red the documentation", a(href = "https://www.webdatarocks.com/doc/", "here.")),



scroll_reveal(target = c("#pivta1", "#pivta2", "#pivta3"), 
              duration = 3000, 
              origin = "right"), 

use_reveal()






    
    
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
        report = "https://gist.githubusercontent.com/feddelegrand7/b62a2c4da3c744ed6900894a627fdc7c/raw/524515b412eb4d8e2bae5c3807376602b7421a5e/The_Office_Report.json"
        )
    
    
    
    
})
    
}

shinyApp(ui = ui, server = server)

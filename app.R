library(shiny)
library(pivta)
library(bubblyr)

ui <- fluidPage(
  tags$head(
    tags$style(
      "

@import url('https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@700&display=swap');

body{

font-family: 'Josefin Sans', sans-serif;

color:#B18BEA;


}

                     ")
  ),

bubbly(theme = "bigmom", color = "#1D1D1D"),


div(
  id = "title1",
  h1("Table Pivoting with pivta"),
  align = "center"
),


br(),



sidebarLayout(sidebarPanel(
  wellPanel(
    "The",
    a(href = "https://github.com/feddelegrand7/pivta", target = "_blank", "pivta") ,
    "package allows you to implement a reporting table within a Shiny app.
   The table on the right is blank. By clicking ont the 'Connect' icon you can upload a csv/json file and work on it.
   You can also provide a remote URL to a csv/json file. \
   Note that there is a size limit of 1MB."
  )
  
),

mainPanel(pivtaOutput(outputId = "pivta1"))),


br(),
br(),

h1("Reading the Data"),


wellPanel(
  "Now as example, we'll work with the",
  a(href = "https://www.imdb.com/title/tt0386676/", target = "_blank", "Office US") ,
  "(which is my favorite show)",
  a(href = "https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-03-17/readme.md", target =
      "_blank", "rating data frame. "),
  "We need to prodive the URL of the csv file to 'dsource' argument of the 'pivta' function"
),

pre(
  "pivta(dsource = 'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-17/office_ratings.csv')"
),
br(),

wellPanel(
  "You'll get this default layout. To create summary measures, you need to change the it.
       Go to 'Options' and choose 'classic form'.
       Then using the 'Fields' menu you can pivot/unpivot table, summarize data, format cells and more"
),

pivtaOutput(outputId = "pivta2"),



br(),
br(),


h1("Data Summary"),



wellPanel(
  "After manipulating the data, you can save a 'report.json' file
                  which stores the information related to the output. On the table above, I've made some data wrangling, saved the report using the 'Save' icon and hosted it",
  a(href = "https://gist.githubusercontent.com/feddelegrand7/b62a2c4da3c744ed6900894a627fdc7c/raw/524515b412eb4d8e2bae5c3807376602b7421a5e/The_Office_Report.json",
    "here"),
  ". Note that you can also save the report locally but you'll need to upload it manually each time you run the app (using the 'Open' icon). Then using only the 'report' argument of the 'pivta' function,
                  we get the summary table below which retrieves the Office rating data frame and the performed analysis. The pivta package is an R wrapper for the",
  a(
    href = "https://www.webdatarocks.com/",
    target = "_blank",
    "WebDataRocks JavaScript library"
  ),
  "you can read the documentation",
  a(href = "https://www.webdatarocks.com/doc/", target = "_blank", "here."),
  " Finally, the code that rendered this application is contained",
  a(href = "https://github.com/feddelegrand7/RSContest/blob/master/app.R", target = "_blank", "here.")
),

pre(
  "pivot(report = 'https://gist.githubusercontent.com/feddelegrand7/b62a2c4da3c744ed6900894a627fdc7c/raw/524515b412eb4d8e2bae5c3807376602b7421a5e/The_Office_Report.json')"
),


pivtaOutput(outputId = "pivta3"),
br(),
br(),
br(),
br()







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
    pivta(report = "https://gist.githubusercontent.com/feddelegrand7/b62a2c4da3c744ed6900894a627fdc7c/raw/524515b412eb4d8e2bae5c3807376602b7421a5e/The_Office_Report.json")
    
    
    
    
  })
  
}

shinyApp(ui = ui, server = server)

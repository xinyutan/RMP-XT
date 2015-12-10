library(shiny)
require(markdown)

dept_groups <<- list("Business&Economics&Accounting",
                     "Science", 
                     "Literature&Art&Music", 
                     "Engineering", 
                     "Bio&Health", 
                     "Mathmatics", 
                     "Religion&Philosophy", 
                     "Humanity&Sociology&Psychology", 
                     "Other")

shinyUI(fluidPage(
        # Application title
        titlePanel("Most Relavents Words"),
        includeMarkdown("README.md"),
        # siderbar layout
        sidebarLayout(
                sidebarPanel(
                        # select a department
                        selectInput("dept", label = "Department", 
                                    choices = dept_groups,
                                    width = '100%', 
                                    selected = TRUE)
                        
                ),
                
                # render the plot
                mainPanel(
                        tabsetPanel(
                        tabPanel("Most positive", plotOutput("most_pos")),
                        tabPanel("Most negative", plotOutput("most_neg"))
                        #textOutput("values")
#                         verbatimTextOutput("dateText"),
#                         verbatimTextOutput("dateText2"),
#                         verbatimTextOutput("dateRangeText")
                        )
                )
        )
        
))
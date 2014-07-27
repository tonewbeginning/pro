# ui.R
shinyUI(pageWithSidebar(
  headerPanel("South-American Vacation Budget plot"),
  sidebarPanel(
    numericInput('numdays',label= 'Enter number of days of stay', value=10,min = 10, max = 10000, step = 0.001),
    numericInput('budget',label= 'What is your overall budget in USD', value=1000,min = 10, max = 10000, step = 0.001),
    submitButton('Submit'),
    h4("About the App"),
    p("This app shows you south american countries you can afford to visit, given your vacation days and your overall vacation budget"),
    p("Budget is in US dollars and must be more then number of days of stay"),
    p("An assumption regarding per day cost of living equal to per capita income has been made."),
    p("Per capita income per day has been calculated as per annum per capital income ( as provided by world bank for 2013) divided by 365 and rounded off to the next integer.")
  ),
  mainPanel(
    htmlOutput("view")
  )
))
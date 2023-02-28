library(shiny)

# read in the user base rds file
user_base <- readRDS("user_base.rds")

#### UI ####
ui <- fluidPage(
  #### authenitication ####
  # add logout button UI
  div(class = "pull-right", shinyauthr::logoutUI(id = "logout")),
  # add login panel UI function
  shinyauthr::loginUI(id = "login"),
  
  #### page content ####
  # setup table output to show user info after login
  tableOutput("user_table"),
  fluidRow(
    htmlOutput('login_info')
  )
)

#### SERVER ####
server <- function(input, output, session) {
  #### authenitication ####
  # call login module supplying data frame, 
  # user and password cols and reactive trigger
  credentials <- shinyauthr::loginServer(
    id = "login",
    data = user_base,
    user_col = user,
    pwd_col = password,
    sodium_hashed = TRUE,
    log_out = reactive(logout_init())
  )
  
  # call the logout module with reactive trigger to hide/show
  logout_init <- shinyauthr::logoutServer(
    id = "logout",
    active = reactive(credentials()$user_auth)
  )
  
  #### page content ####
  output$user_table <- renderTable({
    # use req to only render results when credentials()$user_auth is TRUE
    req(credentials()$user_auth)
    credentials()$info
  })
  
  # if(credentials()$user_auth == password){
  #   output$login_info <-  renderUI(
  #     tags$p("Correct password")
  #   )
  # }
  # -> Error in : Operation not allowed without an active reactive context.
  # You tried to do something that can only be done from inside a reactive consumer.
  
  output$login_info <-  renderUI(
    if(credentials()$user_auth == password){
      tags$p("Correct password")
    }
  )
  
  
}

shinyApp(ui = ui, server = server)
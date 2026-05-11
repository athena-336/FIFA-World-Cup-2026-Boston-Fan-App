ui <- navbarPage(
  
  id = "tabs",
  windowTitle = "World Cup - Boston",
  title = "World Cup - Boston",
  position = "fixed-top",
  collapsible = TRUE,
  inverse = FALSE,
  theme = shinytheme("flatly"),
  
  header = tags$head(
    tags$style(HTML("
    /* Override Flatly theme body text color */
    body {
      color: #ffffff !important;
    }
    
    /* Make all labels gold */
    label,
    .control-label,
    .shiny-input-container label {
      color: #FFD700 !important;
      font-weight: 700 !important;
    }
    
    /* Ensure all text containers are white */
    p, span, li, div:not(.selectize-input) {
      color: #ffffff;
    }
    
    /* Keep select inputs readable - FIX FOR DROPDOWNS */
    .selectize-input,
    .selectize-input *,
    .selectize-dropdown,
    .selectize-dropdown *,
    .selectize-dropdown .option,
    .selectize-dropdown .item {
      color: #2c3e50 !important;  /* Dark text for dropdowns */
      background-color: #ffffff !important;  /* White background */
    }
    
    /* Style the selected item in the input box */
    .selectize-input .item {
      color: #2c3e50 !important;
      background: transparent !important;
    }
    
    /* Style dropdown hover state */
    .selectize-dropdown .option:hover,
    .selectize-dropdown .active {
      background: #FFD700 !important;
      color: #0a1628 !important;
    }
    
    /* Dark background for body */
    body {
      background: #0a1628 !important;
    }
  "))
  ),
  
  tabPanel(
    value = 0,
    title = "World Cup - Boston",
    uiOutput("uiHome")
  ),
  
  tabPanel(
    value = 7,
    title = "Boston Stadium",
    uiOutput("uiStadium")
  ),  
  
  navbarMenu(
    title = "Matches",
    
    tabPanel(
      value = 11,
      title = "Match 1",
      uiOutput("uiMatch1")
    ),
    
    tabPanel(
      value = 12,
      title = "Match 2",
      uiOutput("uiMatch2")
    ),
    
    tabPanel(
      value = 13,
      title = "Match 3",
      uiOutput("uiMatch3")
    ),
    
    tabPanel(
      value = 14,
      title = "Match 4",
      uiOutput("uiMatch4")
    ),
    
    tabPanel(
      value = 15,
      title = "Match 5",
      uiOutput("uiMatch5")
    ),
    
    tabPanel(value = 16, title = "Match 6 (Round of 32)", uiOutput("uiMatch6")),
    tabPanel(value = 17, title = "Match 7 (Quarter Finals)", uiOutput("uiMatch7"))
  ),
  
  tabPanel(
    value = 8,
    title = "Tickets",
    uiOutput("uiTickets")
  ),
  
  tabPanel(
    value = 2,
    title = "Transportation",
    uiOutput("uiTransport")
  ),
  
  tabPanel(
    value = 4,
    title = "Lodging",
    uiOutput("uiLodging")
  ),
  
  tabPanel(
    value = 3,
    title = "Dining",
    uiOutput("uiDining")
  ),
  
  tabPanel(
    value = 5,
    title = "Fan Experience",
    uiOutput("uiFan")
  ),
  
  tabPanel(
    value = 6,
    title = "Players & Teams",
    uiOutput("uiPlayers")
  ),
  
  tabPanel(
    value = 9,
    title = "About Us",
    uiOutput("uiAbout")
  )
)
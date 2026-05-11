library(lubridate)

server <- function(input, output, session) {
  
  #Global CSS
  output$globalCSS <- renderUI({
    tags$style(HTML("
      /* ── Base ── */
      body, .shiny-app { background:#0a1628 !important; font-size:15px; }

      /* ── General text readability ── */
      p, span, div, li { color:#ffffff; }
      h1, h2, h3, h4, h5 { color:#ffffff !important; }

      /* ── Navbar ── */
      .navbar, .navbar-default {
        background:#060e1a !important;
        border-bottom:1px solid rgba(255,215,0,0.2) !important;
        box-shadow:none !important;
      }
      .navbar-default .navbar-nav > li > a {
        color:#ffffff !important;
        font-size:12px; letter-spacing:0.8px; font-weight:700; text-transform:uppercase;
      }
      .navbar-default .navbar-nav > li > a:hover,
      .navbar-default .navbar-nav > .active > a,
      .navbar-default .navbar-nav > .active > a:focus {
        color:#FFD700 !important; background:transparent !important;
      }
      .navbar-default .navbar-brand { color:white !important; font-weight:800; letter-spacing:1px; }

      /* ── Tabs ── */
      .tab-content { background:#0a1628 !important; }
      .nav-tabs { border-bottom:1px solid rgba(255,255,255,0.12) !important; }
      .nav-tabs > li > a {
        color:#ffffff !important; background:transparent !important;
        border:none !important; font-size:13px; font-weight:700;
        letter-spacing:1px; text-transform:uppercase;
      }
      .nav-tabs > li.active > a,
      .nav-tabs > li.active > a:focus,
      .nav-tabs > li.active > a:hover {
        color:#FFD700 !important; background:transparent !important;
        border:none !important; border-bottom:2px solid #FFD700 !important;
      }

      /* ── Form controls ── */
      .selectize-input {
        background:#0d1f35 !important; color:#ffffff !important;
        border:1px solid rgba(255,255,255,0.2) !important;
        border-radius:6px !important; box-shadow:none !important;
        font-size:14px !important;
      }
      .selectize-dropdown {
        background:#0d1f35 !important; color:#ffffff !important;
        border:1px solid rgba(255,255,255,0.2) !important;
        font-size:14px !important;
      }
      .selectize-dropdown .option { color:#ffffff !important; }
      .selectize-dropdown .option:hover,
      .selectize-dropdown .option.active { background:#FFD700 !important; color:#0a1628 !important; }
      .irs--shiny .irs-bar   { background:#FFD700 !important; border-color:#FFD700 !important; }
      .irs--shiny .irs-handle{ background:#FFD700 !important; border-color:#FFD700 !important; }
      .irs--shiny .irs-from, .irs--shiny .irs-to, .irs--shiny .irs-single {
        background:#FFD700 !important; color:#0a1628 !important; font-weight:700;
      }
      .irs--shiny .irs-line    { background:rgba(255,255,255,0.15) !important; }
      .irs--shiny .irs-min,
      .irs--shiny .irs-max,
      .irs--shiny .irs-grid-text { color:#ffffff !important; font-size:12px !important; }
      label,
      .control-label,
      .shiny-input-container label,
      .shiny-input-container .control-label,
      .form-group label,
      .form-group .control-label,
      .checkbox label,
      .radio label,
      .checkbox-inline,
      .radio-inline {
        color:#ffffff !important; font-size:12px !important;
        letter-spacing:0.5px; font-weight:600 !important;
      }
      /* Shiny slider labels */
      .irs-grid-text, .irs-min, .irs-max { color:#ffffff !important; }
      /* Checkbox group / radio group text */
      .shiny-input-checkboxgroup label,
      .shiny-input-radiogroup label { color:#ffffff !important; }
      input[type='text'],
      input[type='number'],
      input[type='search'],
      textarea,
      select {
        background:#0d1f35 !important; color:#ffffff !important;
        border:1px solid rgba(255,255,255,0.2) !important;
        border-radius:6px !important; font-size:14px !important;
      }
      /* Shiny slider value tooltip */
      .irs--shiny .irs-single,
      .irs--shiny .irs-from,
      .irs--shiny .irs-to { color:#0a1628 !important; }
      /* Slider min/max labels */
      .irs--shiny .irs-min,
      .irs--shiny .irs-max { color:#ffffff !important; font-size:11px !important; }

      /* ── DataTable dark theme ── */
      .dataTables_wrapper,
      .dataTables_wrapper label,
      .dataTables_info,
      .dataTables_paginate,
      .dataTables_filter label,
      .dataTables_length label { color:#ffffff !important; font-size:13px !important; }
      .dataTables_wrapper .dataTables_filter input,
      .dataTables_wrapper .dataTables_length select {
        background:#0d1f35 !important; color:#ffffff !important;
        border:1px solid rgba(255,255,255,0.2) !important; font-size:13px !important;
      }
      table.dataTable thead th,
      table.dataTable thead th.sorting,
      table.dataTable thead th.sorting_asc,
      table.dataTable thead th.sorting_desc,
      table.dataTable thead td {
        color:#ffffff !important; background:#060e1a !important;
        font-size:11px !important; letter-spacing:1px !important;
        text-transform:uppercase !important;
        border-bottom:1px solid rgba(255,215,0,0.15) !important;
        font-weight:700 !important;
      }
      table.dataTable tbody tr     { background:#0d1f35 !important; color:#ffffff !important; }
      table.dataTable tbody tr:hover{ background:#1a3a5c !important; color:#ffffff !important; }
      table.dataTable tbody tr.odd  { background:#0a1e32 !important; color:#ffffff !important; }
      table.dataTable tbody td      { border-color:rgba(255,215,0,0.08) !important;
                                      font-size:13px !important; padding:10px 12px !important; }
      .dataTables_wrapper .paginate_button { color:#ffffff !important; background:transparent !important;
                                             border:1px solid rgba(255,255,255,0.3) !important; }
      .dataTables_wrapper .paginate_button.current {
        background:#FFD700 !important; color:#0a1628 !important;
        border:none !important; border-radius:4px !important; font-weight:800 !important;
      }
      .dataTables_wrapper .paginate_button:hover {
        background:rgba(255,215,0,0.2) !important; color:#ffffff !important;
      }
      .dataTables_wrapper .dataTables_info,
      .dataTables_wrapper .dataTables_paginate,
      .dataTables_wrapper .dataTables_paginate .paginate_button,
      .dataTables_wrapper .dataTables_paginate .paginate_button.disabled { color:#ffffff !important; }

      /* ── Scrollbar ── */
      /* ── Price filter checkboxes styled as gold pill toggles ── */
      #dining_price .checkbox-inline { margin-right:0 !important; }
      #dining_price input[type='checkbox'] { display:none; }
      #dining_price input[type='checkbox'] + span {
        display:inline-block; padding:7px 16px; border-radius:5px; cursor:pointer;
        font-size:13px; font-weight:700; letter-spacing:0.5px;
        border:1.5px solid rgba(255,215,0,0.4); color:#FFD700;
        background:transparent; transition:all 0.15s; user-select:none;
      }
      #dining_price input[type='checkbox']:checked + span {
        background:#FFD700 !important; color:#0a1628 !important;
        border-color:#FFD700 !important;
      }
      #dining_price input[type='checkbox'] + span:hover {
        border-color:#FFD700; background:rgba(255,215,0,0.12);
      }
      ::-webkit-scrollbar { width:5px; height:5px; }
      ::-webkit-scrollbar-track { background:#060e1a; }
      ::-webkit-scrollbar-thumb { background:#FFD700; border-radius:3px; }

    "))
  })
  
  #dark dt
  dt_header_cb <- JS(
    "function(thead, data, start, end, display) {",
    "  $(thead).find('th').css({'color':'white','background-color':'#060e1a'});",
    "}"
  )
  dt_draw_cb <- JS(
    "function(settings) {",
    "  var c = $(this.api().table().container());",
    "  c.find('.dataTables_length label,.dataTables_filter label,.dataTables_info,.dataTables_paginate,.paginate_button').css('color','white');",
    "  c.find('.dataTables_length select').css({'color':'white','background-color':'#0d1f35','border':'1px solid rgba(255,255,255,0.2)'});",
    "  c.find('.paginate_button.current').css({'background':'#FFD700','color':'#0a1628','border':'none','border-radius':'4px'});",
    "}"
  )
  
 #Countdown Timer 
  countdown_values <- reactive({
    invalidateLater(1000, session)
    target <- as.POSIXct("2026-06-13 21:00:00", tz="America/New_York")
    d <- as.numeric(difftime(target, Sys.time(), units="secs"))
    if (d <= 0) return(list(days="0", hours="00", minutes="00", seconds="00"))
    list(days    = as.character(as.integer(d %/% 86400)),
         hours   = sprintf("%02d", as.integer((d %% 86400) %/% 3600)),
         minutes = sprintf("%02d", as.integer((d %% 3600) %/% 60)),
         seconds = sprintf("%02d", as.integer(d %% 60)))
  })
  output$days    <- renderText({ countdown_values()$days })
  output$hours   <- renderText({ countdown_values()$hours })
  output$minutes <- renderText({ countdown_values()$minutes })
  output$seconds <- renderText({ countdown_values()$seconds })

  # HOME
  output$uiHome <- renderUI({
    div(
      style="background:#0a1628; min-height:100vh;",
      
      # hero
      div(
        style="width:100%; height:80vh; background-image:url('bostonhome.jpg');
               background-size:cover; background-position:center top;
               display:flex; align-items:center; justify-content:center;
               text-align:center; position:relative;",
        div(style="position:absolute; inset:0;
                    background:linear-gradient(to bottom,rgba(10,22,40,0.5),rgba(10,22,40,0.88));"),
        div(
          style="position:relative; z-index:2; max-width:820px; padding:0 24px;",
          div(style="display:inline-block; background:#FFD700; color:#0a1628;
                      font-size:11px; font-weight:800; letter-spacing:3px;
                      padding:5px 18px; border-radius:2px; margin-bottom:22px;",
              "FIFA WORLD CUP 2026\u2122"),
          h1(style="color:white; font-size:68px; font-weight:900; margin:0 0 8px 0;
                     font-family:Georgia,serif; letter-spacing:-2px; line-height:1.0;", "Boston"),
          p(style="color:#ffffff; font-size:14px; margin:0 0 36px 0;
                    letter-spacing:3px; text-transform:uppercase;",
            "Gillette Stadium \u00b7 Foxborough, Massachusetts"),
          div(
            style="display:flex; gap:16px; justify-content:center; flex-wrap:wrap;",
            lapply(list(
              list(label="5 Matches",     sub="Group Stage"),
              list(label="Jun 13\u201326", sub="Match Window"),
              list(label="68,756",        sub="Capacity")
            ), function(s) {
              div(style="background:rgba(255,255,255,0.06); border:1px solid rgba(255,215,0,0.25);
                          border-radius:6px; padding:16px 28px; min-width:120px;",
                  div(style="font-size:24px; font-weight:800; color:#FFD700; font-family:Georgia,serif;", s$label),
                  div(style="font-size:10px; color:#ffffff; text-transform:uppercase;
                              letter-spacing:1.5px; margin-top:4px;", s$sub))
            })
          )
        )
      ),
      
      # countdown band
      div(
        style="background:#060e1a; border-bottom:1px solid rgba(255,215,0,0.1); padding:44px 40px;",
        div(
          style="max-width:800px; margin:0 auto; text-align:center;",
          div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                      text-transform:uppercase; margin-bottom:6px;", "Countdown to First Kickoff"),
          p(style="color:#ffffff; font-size:12px; margin:0 0 30px 0;",
            "Haiti vs Scotland \u00b7 June 13, 2026 \u00b7 9:00 PM ET"),
          div(
            style="display:flex; justify-content:center; gap:20px; flex-wrap:wrap;",
            lapply(list(list(id="days","Days"), list(id="hours","Hours"),
                        list(id="minutes","Mins"), list(id="seconds","Secs")), function(x) {
                          div(style="text-align:center; min-width:90px;",
                              div(style="font-size:54px; font-weight:900; color:white; line-height:1;
                              font-family:Georgia,serif;",
                                  textOutput(x[[1]], inline=TRUE)),
                              div(style="font-size:10px; color:#FFD700; text-transform:uppercase;
                              letter-spacing:2px; margin-top:8px; font-weight:700;", x[[2]]),
                              div(style="width:32px; height:1px; background:#FFD700; margin:8px auto 0; opacity:0.35;"))
                        })
          )
        )
      ),
      
      # match list — dynamic from DB
      div(
        style="max-width:820px; margin:0 auto; padding:52px 32px 72px;",
        div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                    text-transform:uppercase; margin-bottom:8px;", "Group Stage"),
        h2(style="color:white; font-family:Georgia,serif; font-size:32px;
                   font-weight:700; margin:0 0 28px 0;", "Boston Matches"),
        div(
          style="display:flex; flex-direction:column; gap:3px;",
          lapply(1:nrow(boston_matches_data()), function(i) {
            m <- boston_matches_data()[i,]
            round_label <- ifelse(m$round_number=="Group Stage",
                                  paste("Group", m$group_name), m$round_number)
            div(
              style="background:rgba(255,255,255,0.03); border:1px solid rgba(255,255,255,0.05);
                     border-radius:6px; padding:16px 24px; display:flex;
                     align-items:center; justify-content:space-between; cursor:pointer;",
              onclick=paste0("Shiny.setInputValue('nav_to_match','match",i,"')"),
              onmouseover="this.style.background='rgba(255,215,0,0.07)';this.style.borderColor='rgba(255,215,0,0.3)';",
              onmouseout="this.style.background='rgba(255,255,255,0.03)';this.style.borderColor='rgba(255,255,255,0.05)';",
              div(style="display:flex; align-items:center; gap:20px;",
                  div(style="font-size:10px; color:#FFD700; font-weight:700;
                              letter-spacing:1px; text-transform:uppercase; min-width:52px;",
                      paste("Match",i)),
                  div(
                    div(style="font-size:17px; font-weight:700; color:white;",
                        paste(m$home_team,"vs",m$away_team)),
                    div(style="font-size:12px; color:#ffffff; margin-top:3px;",
                        paste0(format(as.POSIXct(m$match_datetime),"%b %d"),
                               " \u00b7 ",format(as.POSIXct(m$match_datetime),"%I:%M %p ET"),
                               " \u00b7 Gillette Stadium"))
                  )
              ),
              span(style="font-size:10px; font-weight:800; color:#0a1628; background:#FFD700;
                           padding:4px 12px; border-radius:3px; letter-spacing:0.5px;",
                   round_label)
            )
          })
        )
      )
    )
  })
  
  # DINING
  # Google Maps scale: $ = inexpensive  $$ = moderate  $$$ = expensive  $$$$ = very expensive
  GOOGLE_PRICE_RANGE <- c(
    "1"  = "$$",   # Red Robin — chain casual dining, Google Maps confirmed $$
    "2"  = "$",    # Citra A Fresh Café — fast-casual café counter service
    "3"  = "$$",   # The Harp Patriot Place — sports bar, Google Maps $$
    "4"  = "$",    # Five Guys — fast food, Google Maps confirmed $
    "5"  = "$$",   # Six String Grill & Stage — bar & grill $$
    "6"  = "$$",   # Scorpion Bar Patriot Place — Mexican bar & grill $$
    "7"  = "$",    # Achilitos Taqueria — fast-casual tacos $9-14, Google Maps $
    "8"  = "$$",   # Citizen Crust — sit-down pizza restaurant $$
    "9"  = "$$$",  # Saga Hibachi Steakhouse & Sushi Bar — hibachi/sushi $$$
    "10" = "$",    # Tropical Smoothie Cafe — smoothie counter, Google Maps $
    "11" = "$",    # Baristo Cafe Bar — café counter service $
    "12" = "$$",   # Tavolino — casual-elegant Italian, Facebook confirmed $$, $15-35
    "13" = "$",    # Cupcake Charlie's — bakery/sweets counter $
    "14" = "$$",   # Fat Tuesday at Patriot Place — bar drinks & snacks $$
    "15" = "$$",   # Claudia — Italian restaurant at Patriot Place $$
    "16" = "$$",   # Estella Patriot Place — restaurant $$
    "17" = "$$",   # Twenty8 Food & Spirits — bar & restaurant $$
    "18" = "$$",   # Bar Louie — chain bar & grill, Google Maps confirmed $$
    "19" = "$$",   # Olive Garden — chain casual Italian, Google Maps confirmed $$
    "20" = "$",    # Chick-fil-A — fast food, Google Maps confirmed $
    "21" = "$$",   # Curry Leaf Foxborough — Indian restaurant $$
    "22" = "$",    # Laced Pizza & Pub — local pizza & pub $
    "23" = "$$",   # Fusion Bar & Grill — bar & grill $$
    "24" = "$$",   # Lafayette House — American restaurant $$
    "25" = "$$",   # Conrad's Restaurant — local sit-down diner $$
    "26" = "$",    # Omega Pizza Foxboro — local takeout pizza $
    "27" = "$",    # Dairy Queen — fast food, Google Maps confirmed $
    "28" = "$",    # Pizza Time Foxboro — local takeout pizza $
    "29" = "$",    # Mai Pearl — Chinese takeout $
    "30" = "$",    # Lovely Pizza — local delivery/takeout pizza $
    "31" = "$$",   # UNION STRAW — upscale American, craft cocktails $$
    "32" = "$$",   # Station One by Shovel Town Brewery — brewery restaurant $$
    "33" = "$",    # Scram Kitchen and Coffee — breakfast café $
    "34" = "$$",   # Rally Point Inn & Pub — pub with full menu $$
    "35" = "$",    # South Street Pizzeria — local takeout pizzeria $
    "36" = "$",    # The Commons Neighborhood Eatery — local breakfast café $
    "37" = "$",    # Foxboro House of Pizza — local takeout pizza $
    "38" = "$",    # Gunther Tooties — café/coffee shop $
    "39" = "$",    # Sweetness and Honey Bakery — bakery counter $
    "40" = "$$",   # Banh Mi Foxboro — Vietnamese restaurant $$
    "41" = "$$",   # Hao Sushi — sit-down sushi restaurant $$
    "42" = "$$",   # Augusta's - Foxboro — American bistro $$
    "43" = "$",    # Loewen's Café — café counter $
    "44" = "$",    # Papa Gino's — pizza chain, Google Maps confirmed $
    "45" = "$",    # Honey Dew Donuts — donut/coffee shop $
    "46" = "$",    # Kampers Kitchen — local diner $
    "47" = "$$",   # 99 Restaurants — chain casual dining, Google Maps confirmed $$
    "48" = "$$",   # Jake n JOES Sports Grille — sports bar & grill $$
    "49" = "$",    # Foxboro Mandarin Chinese & Japanese Restaurant — takeout $
    "50" = "$$",   # Bangkok Café — sit-down Thai restaurant $$
    "51" = "$$$",  # Shaking Crab — seafood boil, Google Maps confirmed $$$
    "52" = "$"     # Taste and See Sourdough Bread — artisan bakery $
  )
  
  
  dining_data <- reactive({
    df <- tryCatch(
      dbGetQuery(con, "
        SELECT rest_id, title, category, stars,
               miles_from_stadium, latitude, longitude, address,
               COALESCE(price_range, 'N/A') AS price_range
        FROM gillette_restaurants
        ORDER BY miles_from_stadium ASC
      "),
      error = function(e) {
        # price_range column not in DB yet — fetch without it
        d <- dbGetQuery(con, "
          SELECT rest_id, title, category, stars,
                 miles_from_stadium, latitude, longitude, address
          FROM gillette_restaurants
          ORDER BY miles_from_stadium ASC
        ")
        d$price_range <- NA_character_
        d
      }
    )
 
    rid_key <- as.character(df$rest_id)
    looked_up <- GOOGLE_PRICE_RANGE[rid_key]
    # Where lookup value, use it --> otherwise keep the DB value (or N/A)
    df$price_range <- ifelse(
      !is.na(looked_up),
      looked_up,
      ifelse(is.na(df$price_range) | df$price_range == "N/A", "N/A", df$price_range)
    )
    df
  })
  
  filtered_dining <- reactive({
    dining_data()
  })
  
  selected_restaurant <- reactiveVal(NULL)
  
  output$uiDining <- renderUI({
    dd <- dining_data()
    
    # return N/A when the filtered set is empty
    safe_avg  <- tryCatch(round(mean(dd$stars, na.rm=TRUE), 1), error=function(e) "N/A")
    safe_min  <- tryCatch(paste0(round(min(dd$miles_from_stadium, na.rm=TRUE), 2), " mi"), error=function(e) "N/A")
    safe_cats <- tryCatch(length(unique(na.omit(dd$category))), error=function(e) "N/A")
    
    div(
      style="background:#0a1628; min-height:100vh; padding-top:60px;",
      
      # hero header
      div(style="background:linear-gradient(135deg,#060e1a,#0d1f35);
                 padding:56px 48px 40px; border-bottom:1px solid rgba(255,215,0,0.1);",
          div(style="max-width:1300px; margin:0 auto;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:10px;",
                  "Gillette Stadium \u00b7 Patriot Place"),
              h1(style="color:white; font-family:Georgia,serif; font-size:42px;
                         font-weight:700; margin:0 0 10px 0;", "Dining"),
              p(style="color:#ffffff; font-size:15px; margin:0; max-width:520px;",
                "Explore restaurants near the stadium. Click a pin for full details and directions.")
          )
      ),
      
      div(style="max-width:1300px; margin:0 auto; padding:36px 20px 64px;",
          
          # stat row
          div(
            style="display:flex; gap:14px; margin-bottom:24px; flex-wrap:wrap;",
            lapply(list(
              list(val=nrow(dd),       lbl="Restaurants"),
              list(val=safe_avg,       lbl="Avg Rating"),
              list(val=safe_min,       lbl="Closest"),
              list(val=safe_cats,      lbl="Cuisines")
            ), function(s) {
              div(style="flex:1; min-width:140px; background:#0d1f35;
                          border:1px solid rgba(255,215,0,0.12); border-radius:8px;
                          padding:18px 20px; border-top:3px solid #FFD700;",
                  div(style="font-size:28px; font-weight:800; color:white;
                              font-family:Georgia,serif;", s$val),
                  div(style="font-size:11px; color:#ffffff; text-transform:uppercase;
                              letter-spacing:1.5px; margin-top:4px;", s$lbl))
            })
          ),
          
          # filter panel
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                      border-radius:8px; padding:22px 24px; margin-bottom:22px;",
              fluidRow(
                column(3, selectInput("dining_cat","Cuisine:",
                                      choices=c("All", sort(unique(na.omit(dd$category)))))),
                column(3, sliderInput("dining_dist","Max Distance (mi):",min=0,max=5,value=2,step=0.1)),
                column(3, sliderInput("dining_stars","Min Stars:",min=0,max=5,value=0,step=0.5)),
                column(3, br(),
                       actionButton("reset_dining","Reset Filters",
                                    style="margin-top:6px; width:100%; background:transparent;
                                    border:1px solid rgba(255,215,0,0.5); border-radius:5px;
                                    padding:8px; font-size:11px; color:#FFD700; font-weight:800;
                                    letter-spacing:1.5px; text-transform:uppercase; cursor:pointer;"))
              ),
              # Price filter row — Google Maps $ signs as toggle buttons
              div(style="margin-top:18px; border-top:1px solid rgba(255,255,255,0.07); padding-top:18px;",
                  div(style="font-size:12px; font-weight:700; color:#ffffff;
                              letter-spacing:1px; text-transform:uppercase; margin-bottom:10px;",
                      "Price Range"),
                  div(style="display:flex; gap:8px; flex-wrap:wrap;",
                      checkboxGroupInput(
                        "dining_price", label=NULL,
                        choices=list("$ Inexpensive"="$","$$ Moderate"="$$","$$$ Expensive"="$$$"),
                        selected=NULL,
                        inline=TRUE
                      )
                  ),
                  div(style="font-size:12px; color:#ffffff; margin-top:6px;",
                      "Leave blank to show all prices. Matches Google Maps price signs.")
              )
          ),
          
          uiOutput("dining_count_badge"),
          
          # map 
          fluidRow(
            column(8,
                   div(style="border-radius:12px; overflow:hidden;
                               border:1px solid rgba(255,255,255,0.1);
                               box-shadow:0 4px 20px rgba(0,0,0,0.4);",
                       leafletOutput("diningMap", height="600px"))
            ),
            column(4, uiOutput("dining_detail_panel"))
          ),
          
          br(),
          
          # bottom table
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                      border-radius:8px; padding:20px; margin-top:20px;",
              DT::dataTableOutput("diningTable"))
      )
    )
  })
  
  output$dining_count_badge <- renderUI({
    df <- tryCatch(filtered_dining(), error=function(e) NULL)
    if (is.null(df)) return(NULL)
    n <- nrow(df)
    color <- if(n == 0) "#f87171" else "#FFD700"
    label <- if(n == 0) "No restaurants match \u2014 try adjusting your filters"
    else paste0(n," restaurant", if(n!=1)"s" else "", " match your filters")
    div(style="margin-bottom:16px;",
        span(style=paste0("background:rgba(255,215,0,0.15); color:",color,"; font-weight:800;
                           font-size:12px; padding:6px 18px; border-radius:4px;
                           letter-spacing:1px; text-transform:uppercase;
                           border:1px solid rgba(255,215,0,0.35);"),
             label))
  })
  
  observeEvent(input$reset_dining, {
    updateSelectInput(session,       "dining_cat",   selected="All")
    updateSliderInput(session,       "dining_dist",  value=2)
    updateSliderInput(session,       "dining_stars", value=0)
    updateCheckboxGroupInput(session,"dining_price", selected=character(0))
    selected_restaurant(NULL)
  })
  
  output$diningMap <- renderLeaflet({
    df <- filtered_dining()
    # Guard: add price_range column if DB doesn't have it
    if (!"price_range" %in% colnames(df)) df$price_range <- "N/A"
    price_col <- ifelse(is.na(df$price_range) | !nzchar(df$price_range), "N/A", df$price_range)
    leaflet() %>%
      addTiles(urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
               attribution = "© OpenStreetMap contributors") %>%
      setView(lng=-71.26, lat=42.091, zoom=12) %>%
      addAwesomeMarkers(lat=42.0909, lng=-71.2643, label="Gillette Stadium",
                        icon=makeAwesomeIcon(icon="university",library="fa",
                                             markerColor="red",iconColor="white")) %>%
      {
        if (nrow(df) > 0)
          addCircleMarkers(.,
                           lat=df$latitude, lng=df$longitude,
                           layerId=df$rest_id,
                           radius=10, color="#0a1628", fillColor="#FFD700", fillOpacity=0.95, weight=2,
                           label=paste0("\u2605 ",round(df$stars,1)," | ",price_col," — ",df$title),
                           labelOptions=labelOptions(
                             noHide=FALSE, direction="top", offset=c(0,-15),
                             style=list("color"="#0a1628","font-family"="Arial,sans-serif",
                                        "font-size"="12px","font-weight"="700",
                                        "background-color"="white","border"="2px solid #FFD700",
                                        "padding"="5px 10px","border-radius"="6px",
                                        "box-shadow"="0 2px 8px rgba(0,0,0,0.25)")),
                           popup=paste0(
                             "<div style='font-family:Arial,sans-serif;padding:12px;min-width:180px;background:white;border-radius:8px;'>",
                             "<b style='font-size:14px;color:#0a1628;'>",df$title,"</b><br>",
                             "<span style='color:#555;font-size:12px;'>",df$category,"</span><br>",
                             "<div style='margin:8px 0 4px;display:flex;align-items:center;gap:8px;'>",
                             "<span style='font-size:13px;color:#333;'>",df$stars," \u2b50</span>",
                             "<span style='background:#FFD700;color:#0a1628;font-weight:800;font-size:12px;",
                             "padding:2px 8px;border-radius:4px;'>",price_col,"</span>",
                             "</div>",
                             "<span style='color:#666;font-size:11px;'>\U0001f4cd ",df$miles_from_stadium," mi from stadium</span>",
                             "</div>"))
        else .
      }
  })
  
  observe({
    df <- tryCatch(filtered_dining(), error = function(e) NULL)
    if (is.null(df)) return()
    # Only run when the map output exists in the client
    proxy <- leafletProxy("diningMap")
    proxy %>% clearGroup("restaurants")
    if (nrow(df) > 0) {
      price_col <- if ("price_range" %in% colnames(df)) df$price_range else rep("N/A", nrow(df))
      proxy %>% addCircleMarkers(
        lat=df$latitude, lng=df$longitude,
        layerId=df$rest_id, group="restaurants",
        radius=10, color="#0a1628", fillColor="#FFD700", fillOpacity=0.95, weight=2,
        label=paste0("\u2605 ",round(df$stars,1)," | ",price_col," — ",df$title),
        labelOptions=labelOptions(
          noHide=FALSE, direction="top", offset=c(0,-15),
          style=list("color"="#0a1628","font-family"="Arial,sans-serif",
                     "font-size"="12px","font-weight"="700",
                     "background-color"="white","border"="2px solid #FFD700",
                     "padding"="5px 10px","border-radius"="6px")),
        popup=paste0(
          "<div style='font-family:Arial,sans-serif;padding:12px;min-width:180px;background:white;border-radius:8px;'>",
          "<b style='font-size:14px;color:#0a1628;'>",df$title,"</b><br>",
          "<span style='color:#555;font-size:12px;'>",df$category,"</span><br>",
          "<div style='margin:8px 0 4px;display:flex;align-items:center;gap:8px;'>",
          "<span style='font-size:13px;color:#333;'>",df$stars," \u2b50</span>",
          "<span style='background:#FFD700;color:#0a1628;font-weight:800;font-size:12px;",
          "padding:2px 8px;border-radius:4px;'>",price_col,"</span>",
          "</div>",
          "<span style='color:#666;font-size:11px;'>\U0001f4cd ",df$miles_from_stadium," mi from stadium</span>",
          "</div>"))
    }
  })
  
  output$dining_detail_panel <- renderUI({
    div(
      style="background:#0d1f35; padding:40px 25px; border-radius:12px;
             border:1px solid rgba(255,255,255,0.1); color:white;
             min-height:600px; display:flex; flex-direction:column;
             justify-content:center; text-align:center;",
      div(style="font-size:48px; margin-bottom:20px; color:#FFD700;", "\U0001f374"),
      h3(style="color:white; font-family:Georgia,serif; margin-bottom:10px;", "Select a Restaurant"),
      p(style="color:#ffffff; font-size:14px; line-height:1.6;",
        "Click any pin on the map to see full details, rating breakdown, and directions.")
    )
  })
  
  observeEvent(input$diningMap_marker_click, {
    click <- input$diningMap_marker_click
    if (is.null(click) || is.null(click$id)) return()
    
    df  <- filtered_dining()
    idx <- which(df$rest_id == click$id)
    if (length(idx) == 0) return()
    rest <- df[idx, ]
    selected_restaurant(rest)
    
    stars_filled <- min(5, max(0, round(rest$stars)))
    stars_empty  <- 5 - stars_filled
    star_str <- paste0(paste(rep("\u2b50", stars_filled), collapse=""),
                       paste(rep("\u2606", stars_empty),  collapse=""))
    
    dist_color <- if (rest$miles_from_stadium <= 1) "#4ade80"
    else if (rest$miles_from_stadium <= 2) "#fb923c"
    else "#f87171"
    
    price_label <- if (!is.null(rest$price_range) && !is.na(rest$price_range) && nzchar(rest$price_range))
      rest$price_range else "N/A"
    
    output$dining_detail_panel <- renderUI({
      div(
        style="background:#0d1f35; padding:25px; border-radius:12px;
               border:1px solid #FFD700; color:white; min-height:600px;
               box-shadow:0 10px 30px rgba(0,0,0,0.5);",
        
        div(style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:14px;",
            div(
              h2(style="color:#FFD700; margin:0 0 4px 0; font-family:Georgia,serif;
                         font-size:20px; line-height:1.2;", rest$title),
              span(style="font-size:12px; font-weight:700; color:#ffffff;
                           letter-spacing:1px; text-transform:uppercase;", rest$category)
            ),
            actionButton("dining_close_detail","\u2715",
                         style="background:none; border:none; font-size:18px;
                                color:#ffffff; cursor:pointer; padding:0; margin-top:2px;")
        ),
        
        tags$hr(style="border-top:1px solid rgba(255,215,0,0.2); margin-bottom:16px;"),
        
        # rating + distance + price row
        div(style="display:flex; justify-content:space-between; margin-bottom:18px; gap:8px;",
            div(style="text-align:center; flex:1; background:#060e1a; border-radius:8px; padding:12px 4px;",
                div(style="font-size:16px;", star_str),
                div(style="font-size:22px; color:#FFD700; font-weight:800;
                            font-family:Georgia,serif; margin-top:4px;", rest$stars),
                div(style="font-size:11px; color:#ffffff; text-transform:uppercase;
                            letter-spacing:1px; margin-top:4px;", "Rating")),
            div(style=paste0("text-align:center; flex:1; background:#060e1a; border-radius:8px; padding:12px 4px;"),
                div(style="font-size:20px;", "\U0001f4cd"),
                div(style=paste0("font-size:20px; font-weight:800; color:",dist_color,";
                                   font-family:Georgia,serif; margin-top:4px;"),
                    paste0(round(rest$miles_from_stadium,2)," mi")),
                div(style="font-size:11px; color:#ffffff; text-transform:uppercase;
                            letter-spacing:1px; margin-top:4px;", "Distance")),
            div(style="text-align:center; flex:1; background:#060e1a; border-radius:8px; padding:12px 4px;",
                div(style="font-size:20px;", "\U0001f4b0"),
                div(style="font-size:22px; font-weight:800; color:#FFD700;
                            font-family:Georgia,serif; margin-top:4px;", price_label),
                div(style="font-size:11px; color:#ffffff; text-transform:uppercase;
                            letter-spacing:1px; margin-top:4px;", "Price"))
        ),
        
        # address bar
        div(style="background:#060e1a; border-radius:8px; padding:12px 14px;
                    display:flex; align-items:center; gap:10px; margin-bottom:16px;",
            span(style="font-size:16px;", "\U0001f5fa\ufe0f"),
            span(style="color:#ffffff; font-size:13px; line-height:1.4;", rest$address)
        ),
        
        # embedded mini-map
        tags$iframe(
          width="100%", height="260", frameborder="0",
          style="border:0; border-radius:8px; margin-bottom:16px;",
          src=paste0("https://maps.google.com/maps?q=",
                     URLencode(paste(rest$title, rest$address)),
                     "&hl=en&z=15&output=embed")
        ),
        
        # CTA button
        tags$a(
          href=paste0("https://www.google.com/maps/dir/?api=1&destination=",
                      rest$latitude,",",rest$longitude),
          target="_blank",
          style="display:block; width:100%; background:#FFD700; color:#0a1628;
                  font-weight:800; text-align:center; border:none;
                  padding:14px; border-radius:8px; cursor:pointer;
                  text-decoration:none; font-size:13px; letter-spacing:1px;
                  text-transform:uppercase;",
          "Get Directions \u2192"
        )
      )
    })
  })
  
  observeEvent(input$diningMap_click,    { selected_restaurant(NULL); output$dining_detail_panel <- renderUI({ div(style="background:#0d1f35;padding:40px 25px;border-radius:12px;border:1px solid rgba(255,255,255,0.1);color:white;min-height:600px;display:flex;flex-direction:column;justify-content:center;text-align:center;",div(style="font-size:48px;margin-bottom:20px;color:#FFD700;","\U0001f374"),h3(style="color:white;font-family:Georgia,serif;margin-bottom:10px;","Select a Restaurant"),p(style="color:#ffffff;font-size:14px;","Click any pin on the map to see details and directions.")) }) })
  observeEvent(input$dining_close_detail,{ selected_restaurant(NULL); output$dining_detail_panel <- renderUI({ div(style="background:#0d1f35;padding:40px 25px;border-radius:12px;border:1px solid rgba(255,255,255,0.1);color:white;min-height:600px;display:flex;flex-direction:column;justify-content:center;text-align:center;",div(style="font-size:48px;margin-bottom:20px;color:#FFD700;","\U0001f374"),h3(style="color:white;font-family:Georgia,serif;margin-bottom:10px;","Select a Restaurant"),p(style="color:#ffffff;font-size:14px;","Click any pin on the map to see details and directions.")) }) })
  
  output$diningTable <- DT::renderDataTable({
    df <- filtered_dining()
    
    if (nrow(df) == 0) {
      # Return a friendly N/A table when no results
      empty <- data.frame(
        Restaurant="N/A", Cuisine="N/A", Stars="N/A",
        Distance="N/A", Price="N/A", Address="No restaurants match your current filters.",
        stringsAsFactors=FALSE
      )
      return(DT::datatable(empty, rownames=FALSE, class="stripe",
                           options=list(dom="t", headerCallback=dt_header_cb)))
    }
    
    if (!"price_range" %in% colnames(df)) df$price_range <- "N/A"
    
    cols_to_show <- c("title","category","stars","miles_from_stadium","price_range","address")
    display <- df[, cols_to_show]
    display$miles_from_stadium <- paste0(round(display$miles_from_stadium,2)," mi")
    colnames(display) <- c("Restaurant","Cuisine","Stars","Distance","Price","Address")
    
    DT::datatable(
      display, rownames=FALSE, class="stripe hover",
      options=list(
        pageLength=10, scrollX=TRUE,
        headerCallback=dt_header_cb, drawCallback=dt_draw_cb
      )
    ) %>%
      DT::formatStyle(columns=colnames(display), color="white") %>%
      DT::formatStyle("Stars",
                      color="black", fontWeight="bold",
                      background=DT::styleColorBar(c(0,5),"#FFD700"),
                      backgroundSize="90% 60%",
                      backgroundRepeat="no-repeat",
                      backgroundPosition="center") %>%
      DT::formatStyle("Distance", color="turquoise", fontWeight="bold") %>%
      DT::formatStyle("Price", color="#FFD700", fontWeight="bold")
  })
  
  # BOSTON MATCHES
  boston_matches_data <- reactive({
    dbGetQuery(con, "
      SELECT match_id, match_number, round_number, match_datetime,
             location, home_team, away_team, group_name, result
      FROM matches WHERE location = 'Boston Stadium' ORDER BY match_id
    ")
  })
  
  match_countdowns <- reactiveValues()
  
  match_card <- function(match_data, match_num) {
    match_time_et <- lubridate::force_tz(
      as.POSIXct(match_data$match_datetime, tz="UTC"), "America/New_York")
    start_str <- format(match_time_et, "%Y%m%dT%H%M%S")
    end_str   <- format(match_time_et + 7200, "%Y%m%dT%H%M%S")
    cal_link  <- paste0(
      "https://www.google.com/calendar/render?action=TEMPLATE",
      "&text=", URLencode(paste(match_data$home_team,"vs",match_data$away_team)),
      "&dates=", start_str, "/", end_str,
      "&ctz=America/New_York",
      "&location=Gillette+Stadium+Foxborough+MA"
    )
    div(
      style="background:#0a1628; min-height:100vh; padding:64px 48px 64px;",
      div(style="max-width:720px; margin:0 auto;",
          div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                      text-transform:uppercase; margin-bottom:12px;",
              paste0("Match ",match_num," \u00b7 ",match_data$group_name," \u00b7 ",match_data$round_number)),
          h1(style="color:white; font-family:Georgia,serif; font-size:44px;
                     font-weight:700; margin:0 0 8px 0; line-height:1.1;",
             paste(match_data$home_team,"vs",match_data$away_team)),
          p(style="color:#ffffff; font-size:13px; margin:0 0 36px 0;",
            paste0(format(match_time_et,"%A, %B %d, %Y \u00b7 %I:%M %p ET"),
                   " \u00b7 Gillette Stadium, Foxborough MA")),
          
          # live countdown
          div(style="background:#0d1f35; border:1px solid rgba(255,215,0,0.18);
                      border-radius:8px; padding:28px; margin-bottom:20px; text-align:center;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:18px;","Kickoff Countdown"),
              div(style="display:flex; justify-content:center; gap:20px; flex-wrap:wrap;",
                  lapply(list(list(paste0("match",match_num,"_days"),"Days"),
                              list(paste0("match",match_num,"_hours"),"Hours"),
                              list(paste0("match",match_num,"_minutes"),"Minutes"),
                              list(paste0("match",match_num,"_seconds"),"Seconds")), function(x) {
                                div(style="text-align:center; min-width:70px;",
                                    div(style="font-size:52px; font-weight:900; color:white;
                                    font-family:Georgia,serif; line-height:1;",
                                        textOutput(x[[1]], inline=TRUE)),
                                    div(style="font-size:10px; color:#FFD700; text-transform:uppercase;
                                    letter-spacing:2px; margin-top:6px; font-weight:700;", x[[2]]))
                              })
              ),
              div(style="margin-top:18px;",
                  tags$a(href=cal_link, target="_blank",
                         style="font-size:12px; color:#ffffff; text-decoration:none;",
                         "\U0001f4c5 Add to Google Calendar"))
          ),
          
          # teams
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.06);
                      border-radius:8px; padding:28px; margin-bottom:20px;",
              fluidRow(
                column(5, div(style="text-align:center; padding:14px;",
                              div(style="font-size:10px; color:#ffffff;
                                          text-transform:uppercase; letter-spacing:2px; margin-bottom:8px;","Home"),
                              h2(style="color:white; font-family:Georgia,serif; font-size:26px;
                                         font-weight:700; margin:0;", match_data$home_team))),
                column(2, div(style="text-align:center; padding:22px 0;",
                              div(style="font-size:20px; font-weight:900; color:#FFD700;
                                          font-family:Georgia,serif;","VS"))),
                column(5, div(style="text-align:center; padding:14px;",
                              div(style="font-size:10px; color:#ffffff;
                                          text-transform:uppercase; letter-spacing:2px; margin-bottom:8px;","Away"),
                              h2(style="color:white; font-family:Georgia,serif; font-size:26px;
                                         font-weight:700; margin:0;", match_data$away_team)))
              ),
              div(style="margin-top:18px; padding-top:18px;
                          border-top:1px solid rgba(255,255,255,0.06); text-align:center;",
                  span(style="font-size:10px; color:#ffffff;
                               text-transform:uppercase; letter-spacing:1px;","Result: "),
                  span(style="font-size:13px; color:#ffffff;",
                       ifelse(is.na(match_data$result),"Not yet played",match_data$result)))
          ),
          
          # venue — clickable to transport tab
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.06);
                      border-radius:8px; padding:18px 22px; display:flex;
                      align-items:center; gap:14px; cursor:pointer;",
              onclick="Shiny.setInputValue('nav_to_transport',Math.random())",
              span(style="font-size:22px;", "\U0001f4cd"),
              div(div(style="font-size:10px; color:#ffffff; text-transform:uppercase;
                              letter-spacing:1.5px;","Venue"),
                  div(style="font-size:15px; font-weight:600; color:#FFD700; margin-top:3px;
                              text-decoration:underline;",
                      "Gillette Stadium, Foxborough, Massachusetts")))
      )
    )
  }
  
  # Live per-match countdown observer
  observe({
    invalidateLater(1000, session)
    matches <- boston_matches_data()
    for (i in seq_len(nrow(matches))) {
      mt  <- lubridate::force_tz(as.POSIXct(matches$match_datetime[i], tz="UTC"), "America/New_York")
      d   <- as.numeric(difftime(mt, Sys.time(), units="secs"))
      if (d > 0) {
        match_countdowns[[paste0("match",i,"_days")]]    <- as.character(as.integer(d %/% 86400))
        match_countdowns[[paste0("match",i,"_hours")]]   <- sprintf("%02d", as.integer((d%%86400)%/%3600))
        match_countdowns[[paste0("match",i,"_minutes")]] <- sprintf("%02d", as.integer((d%%3600)%/%60))
        match_countdowns[[paste0("match",i,"_seconds")]] <- sprintf("%02d", as.integer(d%%60))
      } else {
        for (unit in c("_days","_hours","_minutes","_seconds"))
          match_countdowns[[paste0("match",i,unit)]] <- if(unit=="_days") "0" else "00"
      }
    }
  })
  
  observe({
    for (i in 1:7) {
      local({
        idx <- i
        for (unit in c("_days","_hours","_minutes","_seconds")) {
          local({
            key <- paste0("match",idx,unit)
            output[[key]] <- renderText({ match_countdowns[[key]] })
          })
        }
      })
    }
  })
  
  output$uiMatch1 <- renderUI({ df <- boston_matches_data(); req(nrow(df)>=1); match_card(df[1,],1) })
  output$uiMatch2 <- renderUI({ df <- boston_matches_data(); req(nrow(df)>=2); match_card(df[2,],2) })
  output$uiMatch3 <- renderUI({ df <- boston_matches_data(); req(nrow(df)>=3); match_card(df[3,],3) })
  output$uiMatch4 <- renderUI({ df <- boston_matches_data(); req(nrow(df)>=4); match_card(df[4,],4) })
  output$uiMatch5 <- renderUI({ df <- boston_matches_data(); req(nrow(df)>=5); match_card(df[5,],5) })
  output$uiMatch6 <- renderUI({ df <- boston_matches_data(); req(nrow(df)>=6); match_card(df[6,],6) })
  output$uiMatch7 <- renderUI({ df <- boston_matches_data(); req(nrow(df)>=7); match_card(df[7,],7) })
  
  # TRANSPORTATION
  transport_routes_data <- reactive({
    dbGetQuery(con, "SELECT * FROM transport_routes ORDER BY display_order;")
  })
  route_segments_data <- reactive({
    dbGetQuery(con, "SELECT * FROM route_segments ORDER BY route_id, segment_order;")
  })
  selected_route <- reactive({
    routes <- transport_routes_data()
    if (nrow(routes)==0) return(NULL)
    if (is.null(input$route_filter) || !(input$route_filter %in% routes$route_name))
      return(routes[1,,drop=FALSE])
    routes[routes$route_name==input$route_filter,,drop=FALSE]
  })
  selected_segments <- reactive({
    route_row <- selected_route(); segs <- route_segments_data()
    if (is.null(route_row)||nrow(route_row)==0) return(NULL)
    segs[segs$route_id==route_row$route_id[1],,drop=FALSE]
  })
  selected_route_map_url <- reactive({
    route_row <- selected_route()
    if (is.null(route_row)||nrow(route_row)==0) return(NULL)
    paste0("https://www.google.com/maps/embed/v1/directions?",
           "key=AIzaSyDcoxgdGjKHHAbOBCYmV6mJB0afa0u75dM",
           "&origin=",URLencode(route_row$origin_hub[1],reserved=TRUE),
           "&destination=",URLencode(route_row$destination_hub[1],reserved=TRUE),
           "&mode=transit")
  })
  route_reason_text <- reactive({
    route_row <- selected_route()
    if (is.null(route_row)||nrow(route_row)==0) return("")
    origin <- route_row$origin_hub[1]
    if (grepl("Logan",origin,ignore.case=TRUE)) return("Best for visitors arriving directly from the airport.")
    if (grepl("South Station",origin,ignore.case=TRUE)) return("Convenient for travelers staying in downtown Boston.")
    if (grepl("Back Bay",origin,ignore.case=TRUE)) return("Useful for visitors staying around the Back Bay area.")
    if (grepl("Foxboro",origin,ignore.case=TRUE)) return("Simplest option if you are already near the stadium.")
    "A practical route option for reaching Boston Stadium."
  })
  
  output$uiTransport <- renderUI({
    routes <- transport_routes_data()
    if (nrow(routes)==0)
      return(div(style="background:#0a1628;padding:80px;color:white;",p("No route data available.")))
    div(
      style="background:#0a1628; min-height:100vh; padding-top:60px;",
      div(style="background:linear-gradient(135deg,#060e1a,#0d1f35);
                 padding:56px 48px 40px; border-bottom:1px solid rgba(255,215,0,0.1);",
          div(style="max-width:1200px; margin:0 auto;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:10px;","Getting There"),
              h1(style="color:white; font-family:Georgia,serif; font-size:42px;
                         font-weight:700; margin:0 0 10px 0;","Transportation"),
              p(style="color:#ffffff; font-size:15px; margin:0; max-width:580px;",
                "Choose a route, explore step-by-step directions, and view the live transit map.")
          )
      ),
      div(
        style="max-width:1200px; margin:0 auto; padding:36px 48px 64px;
               display:flex; gap:28px; align-items:flex-start;",
        div(style="flex:1.1;",
            div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                        border-radius:8px; padding:18px 20px; margin-bottom:20px;",
                selectInput("route_filter","Choose Your Route:",
                            choices=routes$route_name, selected=routes$route_name[1])),
            uiOutput("route_summary_card"),
            div(style="margin-top:24px;",
                div(style="font-size:10px; font-weight:700; letter-spacing:2px; color:#FFD700;
                            text-transform:uppercase; margin-bottom:12px;","Step-by-Step"),
                uiOutput("route_segment_cards"))
        ),
        div(style="flex:1;",
            div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                        border-radius:8px; padding:16px;",
                div(style="font-size:10px; font-weight:700; letter-spacing:2px; color:#FFD700;
                            text-transform:uppercase; margin-bottom:12px;","Live Route Map"),
                uiOutput("transport_map_embed")))
      ),
      div(style="max-width:1200px; margin:0 auto; padding:0 48px 48px;",
          div(style="font-size:10px; font-weight:700; letter-spacing:2px; color:#FFD700;
                      text-transform:uppercase; margin-bottom:12px;","Segments Table"),
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                      border-radius:8px; padding:20px;",
              DT::dataTableOutput("route_segments_table")))
    )
  })
  
  output$route_summary_card <- renderUI({
    route_row <- selected_route(); req(route_row)
    div(style="background:#0d1f35; border:1px solid rgba(255,215,0,0.15);
                border-radius:8px; padding:24px 26px; border-left:4px solid #FFD700;",
        div(style="font-size:10px; font-weight:700; letter-spacing:2px; color:#FFD700;
                    text-transform:uppercase; margin-bottom:6px;","Selected Route"),
        h2(style="color:white; font-family:Georgia,serif; font-size:22px;
                   font-weight:700; margin:0 0 8px 0;", route_row$route_name[1]),
        p(style="color:#ffffff; font-size:13px; margin:0 0 14px 0;",
          route_reason_text()),
        div(style="display:flex; gap:8px; flex-wrap:wrap; margin-bottom:16px;",
            span(style="background:#FFD700; color:#0a1628; padding:5px 12px; border-radius:3px;
                         font-size:10px; font-weight:800; text-transform:uppercase; letter-spacing:1px;",
                 route_row$primary_mode[1]),
            if(isTRUE(route_row$matchday_only[1]))
              span(style="border:1px solid rgba(255,215,0,0.4); color:#FFD700; padding:5px 12px;
                           border-radius:3px; font-size:10px; font-weight:700; text-transform:uppercase;",
                   "Matchday Only"),
            if(isTRUE(route_row$reservation_required[1]))
              span(style="border:1px solid rgba(255,255,255,0.2); color:#ffffff;
                           padding:5px 12px; border-radius:3px; font-size:10px; font-weight:700;
                           text-transform:uppercase;","Reservation Req.")
        ),
        div(style="display:grid; grid-template-columns:1fr 1fr; gap:10px;",
            lapply(list(
              list(lbl="Origin",      val=route_row$origin_hub[1]),
              list(lbl="Destination", val=route_row$destination_hub[1]),
              list(lbl="Est. Time",   val=ifelse(is.na(route_row$est_total_time_min[1]),"N/A",
                                                 paste0(route_row$est_total_time_min[1]," min"))),
              list(lbl="Est. Fare",   val=ifelse(is.na(route_row$fare_text[1]),"N/A",route_row$fare_text[1]))
            ), function(d) {
              div(style="background:#060e1a; border-radius:6px; padding:12px 14px;",
                  div(style="font-size:9px; color:#ffffff; text-transform:uppercase;
                              letter-spacing:1px; margin-bottom:3px;", d$lbl),
                  div(style="font-size:14px; font-weight:700; color:white;", d$val))
            })
        )
    )
  })
  
  output$route_segment_cards <- renderUI({
    segs <- selected_segments()
    if (is.null(segs)||nrow(segs)==0)
      return(div(style="color:#ffffff;padding:16px;","No segment details available."))
    mode_icon <- function(m) {
      if(is.na(m)) return("\U0001f4cd"); m <- tolower(m)
      if(m=="bus") return("\U0001f68c"); if(m=="commuter_rail") return("\U0001f686")
      if(m=="walk") return("\U0001f6b6"); if(m=="rideshare") return("\U0001f697"); "\U0001f4cd"
    }
    tagList(lapply(seq_len(nrow(segs)), function(i) {
      row <- segs[i,]
      instr <- if(!is.na(row$step_instruction)&&nzchar(row$step_instruction)) row$step_instruction
      else paste(row$from_point,"\u2192",row$to_point)
      div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.06);
                  border-radius:8px; padding:18px 20px; margin-bottom:12px;
                  border-left:3px solid #FFD700;",
          div(style="display:flex; align-items:center; gap:12px; margin-bottom:10px;",
              div(style="width:40px; height:40px; border-radius:50%; background:#060e1a;
                          display:flex; align-items:center; justify-content:center; font-size:20px;",
                  mode_icon(row$mode)),
              div(h3(style="margin:0; color:white; font-size:16px; font-weight:700;",
                     paste("Step",row$segment_order)),
                  p(style="margin:3px 0 0; color:#ffffff; font-size:12px;",instr))
          ),
          div(style="display:flex; gap:8px; margin-bottom:10px; flex-wrap:wrap;",
              span(style="background:#FFD700; color:#0a1628; padding:4px 10px; border-radius:3px;
                           font-size:10px; font-weight:800; text-transform:uppercase;", row$mode),
              if(!is.na(row$line_name)&&nzchar(row$line_name))
                span(style="border:1px solid rgba(255,215,0,0.4); color:#FFD700; padding:4px 10px;
                             border-radius:3px; font-size:10px; font-weight:700;", row$line_name)
          ),
          lapply(list(
            list(lbl="Operator",  val=row$operator_name),
            list(lbl="Est. Time", val=if(!is.na(row$est_time_min)) paste0(row$est_time_min," min") else NA_character_),
            list(lbl="Est. Fare", val=row$fare_text),
            list(lbl="Frequency", val=row$frequency),
            list(lbl="Notes",     val=row$notes)
          ), function(d) {
            if(is.null(d$val)||is.na(d$val)||!nzchar(d$val)) return(NULL)
            div(style="font-size:12px; color:#ffffff; margin-top:4px;",
                tags$b(style="color:#ffffff;",paste0(d$lbl,": ")), d$val)
          })
      )
    }))
  })
  
  output$route_segments_table <- DT::renderDataTable({
    segs <- selected_segments(); req(segs)
    cols <- intersect(c("segment_order","from_point","to_point","mode",
                        "line_name","operator_name","est_time_min","fare_text","notes"),
                      colnames(segs))
    display <- segs[, cols]
    colnames(display) <- c("Step","From","To","Mode","Line","Operator","Time","Fare","Notes")[seq_along(cols)]
    DT::datatable(display, rownames=FALSE, class="stripe hover",
                  options=list(pageLength=10,scrollX=TRUE,
                               headerCallback=dt_header_cb, drawCallback=dt_draw_cb)) %>%
      DT::formatStyle(columns=colnames(display), color="white")
  })
  
  output$transport_map_embed <- renderUI({
    req(selected_route_map_url())
    tags$iframe(src=selected_route_map_url(), width="100%", height="600",
                style="border:0; border-radius:6px;", allowfullscreen=NA,
                loading="lazy", referrerpolicy="no-referrer-when-downgrade")
  })
  
  output$route_tips_card <- renderUI({
    route_row <- selected_route(); segs <- selected_segments(); req(route_row)
    tips <- c()
    if(!is.na(route_row$travel_tip[1])&&nzchar(route_row$travel_tip[1]))
      tips <- c(tips,route_row$travel_tip[1])
    if(!is.na(route_row$service_reliability_note[1])&&nzchar(route_row$service_reliability_note[1]))
      tips <- c(tips,route_row$service_reliability_note[1])
    tips <- c(tips,"Check official schedules before departure.",
              "Allow extra time for crowds before and after the match.")
    if(!is.null(segs)&&any(segs$mode=="walk",na.rm=TRUE))
      tips <- c(tips,"Wear comfortable shoes if your route includes a walking segment.")
    tags$ul(style="margin:0;padding-left:20px;color:#ffffff;font-size:14px;line-height:2;",
            lapply(unique(tips),tags$li))
  })
  
  # STADIUM
  output$uiStadium <- renderUI({
    div(
      style="background:#0a1628; min-height:100vh; padding-top:60px;",
      div(style="width:100%; height:420px; background-image:url('stadium_banner.png');
                 background-size:cover; background-position:center;
                 display:flex; align-items:flex-end; position:relative;",
          div(style="position:absolute; inset:0;
                      background:linear-gradient(to top,#0a1628 20%,rgba(10,22,40,0.3));"),
          div(style="position:relative; z-index:2; padding:0 56px 44px;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:8px;","FIFA World Cup 2026\u2122"),
              h1(style="color:white; font-family:Georgia,serif; font-size:56px;
                         font-weight:800; margin:0;","Boston Stadium"))
      ),
      div(style="max-width:1100px; margin:0 auto; padding:52px 48px 72px;",
          div(style="display:flex; gap:32px; flex-wrap:wrap; margin-bottom:52px;",
              div(style="flex:1; min-width:320px;",
                  img(src="gillette_about.png",
                      style="width:100%; border-radius:8px; border:1px solid rgba(255,255,255,0.06);")),
              div(style="flex:1; min-width:280px;",
                  div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                              text-transform:uppercase; margin-bottom:12px;","About the Venue"),
                  h2(style="color:white; font-family:Georgia,serif; font-size:30px;
                             font-weight:700; margin:0 0 20px 0;","Gillette Stadium"),
                  p(style="color:#ffffff; font-size:15px; line-height:1.8; margin:0 0 14px;",
                    "Gillette Stadium serves as Boston Stadium for FIFA World Cup 2026. Located in Foxborough, it is one of New England's premier sports venues, known for modern facilities and strong event operations."),
                  p(style="color:#ffffff; font-size:15px; line-height:1.8; margin:0 0 14px;",
                    "The venue features upgraded fan spaces, premium concessions, expanded seating areas, and its signature lighthouse-inspired structure."),
                  p(style="color:#ffffff; font-size:15px; line-height:1.8; margin:0;",
                    "Patriot Place next to the stadium. Offers dining, shopping, and entertainment for fans before and after matches!")
              )
          ),
          div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                      text-transform:uppercase; margin-bottom:14px;","Match Day"),
          h2(style="color:white; font-family:Georgia,serif; font-size:30px;
                     font-weight:700; margin:0 0 24px 0;","Checklist"),
          div(style="display:grid; grid-template-columns:1fr 1fr; gap:12px;",
              lapply(list(
                list(icon="\U0001f39f\ufe0f",title="Match Ticket",     body="Confirm your ticket before leaving. Digital tickets are accepted."),
                list(icon="\u23f0",          title="Arrive Early",      body="Gates open hours before kickoff. Allow time for security queues."),
                list(icon="\U0001f6e1\ufe0f",title="Security Policy",  body="Review bag restrictions and prohibited items in advance."),
                list(icon="\U0001f4b3",      title="Cashless Venue",    body="Cards and mobile payments only. No cash accepted inside."),
                list(icon="\U0001f686",      title="Take Transit",      body="MBTA Commuter Rail is strongly recommended on matchdays."),
                list(icon="\U0001f354",      title="Patriot Place",     body="Restaurants, bars, and retail steps from the stadium."),
                list(icon="\U0001f697",      title="Post-Match Traffic",body="Expect heavy traffic and allow extra departure time."),
                list(icon="\U0001f3e8",      title="Accommodation",     body="Book lodging well in advance for World Cup matchdays.")
              ), function(item) {
                div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.06);
                            border-radius:8px; padding:18px 20px; display:flex;
                            gap:14px; align-items:flex-start;",
                    div(style="font-size:22px; margin-top:2px;",item$icon),
                    div(div(style="font-size:13px; font-weight:700; color:white; margin-bottom:4px;",item$title),
                        div(style="font-size:13px; color:#ffffff; line-height:1.5;",item$body)))
              })
          )
      )
    )
  })
  
  # LODGING
  stays_data <- reactive({
    dbGetQuery(con, "SELECT stay_id,title,category,lat,lng,stars,miles_to_stadium,price_per_night
                     FROM stays ORDER BY miles_to_stadium ASC")
  })
  
  filtered_stays <- reactive({
    df <- stays_data()
    req(input$lodging_cat, input$lodging_dist, input$lodging_stars, input$lodging_price)
    if (input$lodging_cat != "All") df <- df[df$category==input$lodging_cat,]
    df <- df[df$miles_to_stadium<=input$lodging_dist,]
    df <- df[df$stars>=input$lodging_stars,]
    df <- df[df$price_per_night>=input$lodging_price[1] & df$price_per_night<=input$lodging_price[2],]
    df
  })
  
  output$uiLodging <- renderUI({
    all_data  <- stays_data(); req(all_data)
    ld        <- all_data
    min_price <- if(nrow(ld)>0&&!all(is.na(ld$price_per_night))) floor(min(ld$price_per_night,na.rm=TRUE)) else 0
    max_price <- if(nrow(ld)>0&&!all(is.na(ld$price_per_night))) ceiling(max(ld$price_per_night,na.rm=TRUE)) else 1000
    cat_choices <- c("All", sort(unique(all_data$category)))
    div(
      style="background:#0a1628; min-height:100vh; color:white; padding-top:60px;",
      div(style="background:linear-gradient(135deg,#060e1a,#0d1f35);
                 padding:56px 48px 40px; border-bottom:1px solid rgba(255,215,0,0.1);",
          div(style="max-width:1300px; margin:0 auto;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:10px;",
                  "Gillette Stadium \u00b7 Foxborough Area"),
              h1(style="color:white; font-family:Georgia,serif; font-size:42px;
                         font-weight:700; margin:0 0 10px 0;","Lodging"),
              p(style="color:#ffffff; font-size:15px; margin:0; max-width:520px;",
                "Hotels and accommodations near the stadium. Click a pin for details and directions.")
          )
      ),
      div(style="max-width:1300px; margin:0 auto; padding:36px 20px 64px;",
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                      border-radius:8px; padding:22px 24px; margin-bottom:22px;",
              fluidRow(
                column(3, selectInput("lodging_cat","Category:",choices=cat_choices,selected="All")),
                column(3, sliderInput("lodging_dist","Max Distance (mi):",min=0,max=5,value=5,step=0.5)),
                column(3, sliderInput("lodging_stars","Min Rating:",min=0,max=5,value=0,step=0.1)),
                column(3, sliderInput("lodging_price","Price Range ($):",
                                      min=min_price,max=max_price,value=c(min_price,max_price)))
              )
          ),
          fluidRow(
            column(8,
                   div(style="border-radius:12px; overflow:hidden; border:1px solid rgba(255,255,255,0.1);
                               box-shadow:0 4px 20px rgba(0,0,0,0.4);",
                       leafletOutput("lodgingMap",height="600px"))
            ),
            column(4, uiOutput("lodgingDetailPanel"))
          ),
          br(),
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                      border-radius:8px; padding:20px; margin-top:20px;",
              DT::dataTableOutput("lodgingTable"))
      )
    )
  })
  
  output$lodgingDetailPanel <- renderUI({
    div(style="background:#0d1f35; padding:40px 25px; border-radius:12px;
               border:1px solid rgba(255,255,255,0.1); color:white; min-height:600px;
               display:flex; flex-direction:column; justify-content:center; text-align:center;",
        div(style="font-size:48px; margin-bottom:20px; color:#FFD700;","\U0001f3e8"),
        h3(style="color:white; font-family:Georgia,serif; margin-bottom:10px;","Select a Hotel"),
        p(style="color:#ffffff; font-size:14px;",
          "Click a marker on the map to view details and get directions."))
  })
  
  output$lodgingMap <- renderLeaflet({
    df <- filtered_stays()
    leaflet(df) %>%
      addTiles() %>%
      addAwesomeMarkers(lat=42.0909,lng=-71.2643,label="Gillette Stadium",
                        icon=makeAwesomeIcon(icon="university",library="fa",
                                             markerColor="blue",iconColor="white")) %>%
      {
        if(nrow(df)>0)
          addCircleMarkers(.,lat=~lat,lng=~lng,layerId=~stay_id,
                           radius=9,color="#FF4500",fillColor="#FFD700",fillOpacity=0.9,weight=2,
                           label=~paste0("$",price_per_night," / night"),
                           labelOptions=labelOptions(noHide=FALSE,direction="top",offset=c(0,-15),
                                                     style=list("color"="#0a1628","font-family"="Arial,sans-serif",
                                                                "font-size"="14px","font-weight"="bold",
                                                                "background-color"="white","border"="2px solid #FFD700",
                                                                "padding"="7px 11px","border-radius"="5px",
                                                                "box-shadow"="2px 2px 8px rgba(0,0,0,0.2)")))
        else .
      }
  })
  
  observeEvent(input$lodgingMap_marker_click, {
    click <- input$lodgingMap_marker_click
    if(is.null(click)||is.null(click$id)) return()
    stay <- dbGetQuery(con, sprintf("SELECT * FROM stays WHERE stay_id=%s",click$id))
    if(nrow(stay)==0) return()
    output$lodgingDetailPanel <- renderUI({
      div(
        style="background:#0d1f35; padding:25px; border-radius:12px; border:1px solid #FFD700;
               color:white; min-height:600px; box-shadow:0 10px 30px rgba(0,0,0,0.5);",
        h2(style="color:#FFD700; margin-top:0; font-family:Georgia,serif; font-size:20px;", stay$title),
        p(style="font-size:14px; color:#ffffff; margin:0 0 12px;", stay$category),
        tags$hr(style="border-top:1px solid rgba(255,215,0,0.2); margin-bottom:16px;"),
        div(style="display:flex; justify-content:space-between; margin-bottom:18px;",
            div(style="text-align:center; flex:1;",
                div(style="font-size:22px; color:#FFD700; font-weight:800;",
                    paste0(stay$stars," \u2b50")),
                div(style="font-size:11px; color:#ffffff; text-transform:uppercase;
                            letter-spacing:1px; margin-top:3px;","Rating")),
            div(style="width:1px; background:rgba(255,255,255,0.1);"),
            div(style="text-align:center; flex:1;",
                div(style="font-size:22px; color:#FFD700; font-weight:800;",
                    paste0("$",stay$price_per_night)),
                div(style="font-size:11px; color:#ffffff; text-transform:uppercase;
                            letter-spacing:1px; margin-top:3px;","Per Night"))
        ),
        tags$iframe(width="100%",height="280",frameborder="0",
                    style="border:0; border-radius:8px; margin-bottom:16px;",
                    src=paste0("https://maps.google.com/maps?q=",stay$lat,",",stay$lng,
                               "&hl=en&z=15&output=embed")),
        tags$a(
          href=paste0("https://www.google.com/maps/dir/?api=1&destination=",stay$lat,",",stay$lng),
          target="_blank",
          style="display:block; width:100%; background:#FFD700; color:#0a1628;
                  font-weight:800; text-align:center; border:none;
                  padding:14px; border-radius:8px; cursor:pointer;
                  text-decoration:none; font-size:13px; letter-spacing:1px;
                  text-transform:uppercase;",
          "Get Directions \u2192"
        )
      )
    })
  })
  
  output$lodgingTable <- DT::renderDataTable({
    df <- filtered_stays()
    df$walk_time <- paste0(round(df$miles_to_stadium*20)," mins")
    df$miles_to_stadium <- round(df$miles_to_stadium,2)
    display <- df[,c("title","category","stars","miles_to_stadium","walk_time","price_per_night")]
    colnames(display) <- c("Hotel Name","Category","Rating","Distance (mi)","Walk Time","Price/Night")
    DT::datatable(display, options=list(pageLength=10,scrollX=TRUE,
                                        headerCallback=dt_header_cb, drawCallback=dt_draw_cb),
                  rownames=FALSE, class="stripe hover") %>%
      DT::formatStyle(columns=setdiff(colnames(display),"Rating"), color="white") %>%
      DT::formatStyle("Rating", color="black", fontWeight="bold",
                      background=DT::styleColorBar(c(0,5),"#FFD700"),
                      backgroundSize="95% 60%",backgroundRepeat="no-repeat",
                      backgroundPosition="center") %>%
      DT::formatCurrency("Price/Night", currency="$")
  })
  
  # FAN EXPERIENCE
  fan_events <- list(
    list(date="Jun 13", match="Jun 13 \u2014 Haiti vs Scotland",
         title="FIFA World Cup Fan Zone: City Hall Plaza",
         desc="Boston's official fan zone opens for Haiti vs Scotland. Free entry, live screening, food vendors, and interactive FIFA activations.",
         details="Located at Boston City Hall Plaza, open from 3:00 PM ET. Expect live DJ sets, country flag displays, and official FIFA merchandise stalls. No ticket required.",
         tag="Free Entry", color="#FFD700"),
    list(date="Jun 14\u201315", match="Jun 14\u201315 \u2014 Between Matches",
         title="Boston Harborfest Pre-Tournament Celebration",
         desc="Live music, food trucks, and cultural performances at Christopher Columbus Park.",
         details="Christopher Columbus Park, Boston Waterfront. Sat 12\u20138 PM, Sun 12\u20136 PM.",
         tag="Free", color="#4ade80"),
    list(date="Jun 16", match="Jun 16 \u2014 France vs Morocco",
         title="France vs Morocco Watch Party: TD Garden",
         desc="Official watch party inside TD Garden with full bar service and big screen viewing.",
         details="TD Garden, 100 Legends Way, Boston. Doors open 4:30 PM ET. Tickets from $25.",
         tag="Ticketed", color="#f87171"),
    list(date="Jun 20", match="Jun 20 \u2014 Scotland vs Iraq",
         title="Scotland vs Iraq Fan March: Kenmore Square",
         desc="Organized fan march from Kenmore Square with live bagpipes and drums.",
         details="Meet at Kenmore Square at 5:00 PM ET. March departs at 5:30 PM.",
         tag="Free", color="#4ade80"),
    list(date="Jun 23", match="Jun 23 \u2014 Norway vs England",
         title="Norway vs England Supporter Meetup: The Harp",
         desc="Pre-match gathering at The Harp, Patriot Place. Arrive early, seats fill up fast.",
         details="The Harp at Patriot Place, 200 Patriot Pl, Foxborough. Opens 4:00 PM ET.",
         tag="Free Entry", color="#FFD700"),
    list(date="Jun 26", match="Jun 26 \u2014 Morocco vs Haiti",
         title="Closing Group Stage Party: Patriot Place Plaza",
         desc="Outdoor celebration for the final Boston group stage match with post-match fireworks.",
         details="Patriot Place Plaza, Foxborough. From 3:00 PM ET. Fireworks at ~9:30 PM.",
         tag="Free", color="#4ade80")
  )
  
  fan_attractions <- list(
    list(icon="\U0001f99e", name="Quincy Market & Faneuil Hall", cat="Food & Culture",
         desc="Boston's most iconic marketplace with dozens of food stalls and street performers.",
         details="Open daily. Near Government Center T stop. Perfect for pre-match lunch.",
         dist="30 min from stadium", color="#FFD700", lat=42.3601, lng=-71.0559),
    list(icon="\u26be", name="Fenway Park Tour", cat="Sports",
         desc="Home of the Red Sox and one of America's most historic ballparks.",
         details="Tours daily 9 AM\u20135 PM. Book at redsox.com/tours. 60\u201390 minutes.",
         dist="35 min from stadium", color="#f87171", lat=42.3467, lng=-71.0972),
    list(icon="\U0001f3a8", name="Museum of Fine Arts", cat="Culture",
         desc="One of the largest art museums in the US with an impressive international collection.",
         details="Wed\u2013Mon 10 AM\u20135 PM (Thu until 10 PM). Adults $27. Green E line.",
         dist="40 min from stadium", color="#c084fc", lat=42.3394, lng=-71.0942),
    list(icon="\U0001f6a2", name="Boston Harbor Cruises", cat="Outdoors",
         desc="Scenic harbor tours with great views of the city skyline.",
         details="Departs from Long Wharf. Tours hourly in summer. 45-min cruise from $32.",
         dist="35 min from stadium", color="#4ade80", lat=42.3601, lng=-71.0501),
    list(icon="\U0001f3db\ufe0f", name="Freedom Trail", cat="History",
         desc="A 2.5-mile walking trail connecting 16 historic sites.",
         details="Self-guided free. Guided tours from Boston Common Visitor Center daily.",
         dist="30 min from stadium", color="#fb923c", lat=42.3598, lng=-71.0576),
    list(icon="\U0001f6cd\ufe0f", name="Patriot Place", cat="Shopping & Dining",
         desc="Right next to Gillette Stadium: 70+ shops, restaurants, and entertainment.",
         details="Daily 10 AM\u20139 PM. 1 Patriot Place, Foxborough. Free parking.",
         dist="0.2 mi from stadium", color="#FFD700", lat=42.0912, lng=-71.2648)
  )
  
  fan_match_plans <- 
    list(match = tags$span(
      style = "font-size:20px; font-weight:700;", "Jun 13 \u2014 Haiti vs Scotland" ),
       kickoff = tags$span(style = "font-size:16px;","9:00 PM ET",
         morning=list(stop="Freedom Trail Walk",      time="10:00 AM", icon="\U0001f3db\ufe0f",
                      tip="Start at Boston Common before the crowds arrive."),
         lunch=list(stop="Quincy Market",             time="1:00 PM",  icon="\U0001f99e",
                    tip="Grab lunch from the food stalls. Budget $15\u201320 per person."),
         afternoon=list(stop="Boston Harbor Cruise",  time="3:00 PM",  icon="\U0001f6a2",
                        tip="45-min scenic cruise \u2014 a relaxing way to pass the afternoon."),
         transit=list(stop="Head to Gillette Stadium",time="6:00 PM",  icon="\U0001f686",
                      tip="MBTA Franklin/Foxboro Line from South Station. ~50 min."),
         match=list(stop="Haiti vs Scotland \u2014 Kickoff", time="9:00 PM", icon="\u26bd",
                    tip="Arrive by 7:30 PM to clear security and find your seats.")),
    list(match="Jun 16 \u2014 France vs Morocco", kickoff="6:00 PM ET",
         morning=list(stop="Museum of Fine Arts",     time="10:00 AM", icon="\U0001f3a8",
                      tip="Relaxed morning at one of the best museums in the US."),
         lunch=list(stop="Fenway Park Area",          time="1:00 PM",  icon="\u26be",
                    tip="Lunch near Kenmore Square."),
         afternoon=list(stop="Patriot Place Arrival", time="3:00 PM",  icon="\U0001f6cd\ufe0f",
                        tip="Browse Patriot Place and grab a pre-match drink."),
         transit=list(stop="Head to Gillette Stadium",time="3:30 PM",  icon="\U0001f686",
                      tip="Franklin/Foxboro Line \u2014 every 30 min on matchdays."),
         match=list(stop="France vs Morocco \u2014 Kickoff", time="6:00 PM", icon="\u26bd",
                    tip="Most anticipated group stage match. Arrive 2 hours early.")),
    list(match="Jun 20 \u2014 Scotland vs Iraq", kickoff="9:00 PM ET",
         morning=list(stop="Fenway Park Tour",        time="10:00 AM", icon="\u26be",
                      tip="Book a guided tour \u2014 60\u201390 minutes."),
         lunch=list(stop="Quincy Market",             time="12:30 PM", icon="\U0001f99e",
                    tip="Try the famous clam chowder in a bread bowl."),
         afternoon=list(stop="Scotland Fan March",    time="5:00 PM",  icon="\U0001f3f4\U000e0067\U000e0062\U000e0073\U000e0063\U000e0074\U000e007f",
                        tip="Fan march from Kenmore Square to Fenway."),
         transit=list(stop="Head to Gillette Stadium",time="6:30 PM",  icon="\U0001f686",
                      tip="Extra trains run on matchdays."),
         match=list(stop="Scotland vs Iraq \u2014 Kickoff", time="9:00 PM", icon="\u26bd",
                    tip="Bring a light jacket \u2014 can get cool at Gillette.")),
    list(match="Jun 23 \u2014 Norway vs England", kickoff="9:00 PM ET",
         morning=list(stop="Boston Harbor Cruise",    time="10:00 AM", icon="\U0001f6a2",
                      tip="Morning cruise for great city views."),
         lunch=list(stop="Freedom Trail Lunch Stop",  time="12:30 PM", icon="\U0001f3db\ufe0f",
                    tip="Walk part of the trail and stop near the North End."),
         afternoon=list(stop="The Harp at Patriot Place", time="5:00 PM", icon="\U0001f37a",
                        tip="Supporter meetup from 4 PM. Arrive early."),
         transit=list(stop="Head to Gillette Stadium",time="7:00 PM",  icon="\U0001f686",
                      tip="Short walk from The Harp to Gillette."),
         match=list(stop="Norway vs England \u2014 Kickoff", time="9:00 PM", icon="\u26bd",
                    tip="High-stakes match. Atmosphere will be electric.")),
    list(match="Jun 26 \u2014 Morocco vs Haiti", kickoff="6:00 PM ET",
         morning=list(stop="Museum of Fine Arts",     time="10:00 AM", icon="\U0001f3a8",
                      tip="Final group stage day \u2014 start with a cultural morning."),
         lunch=list(stop="Quincy Market",             time="1:00 PM",  icon="\U0001f99e",
                    tip="Last chance for a Boston lunch."),
         afternoon=list(stop="Patriot Place Closing Party", time="3:00 PM", icon="\U0001f389",
                        tip="Outdoor celebrations at Patriot Place Plaza."),
         transit=list(stop="Head to Gillette Stadium",time="3:30 PM",  icon="\U0001f686",
                      tip="Walk directly from Patriot Place \u2014 only 0.2 miles."),
         match=list(stop="Morocco vs Haiti \u2014 Kickoff", time="6:00 PM", icon="\u26bd",
                    tip="Post-match fireworks at ~9:30 PM. Stay after the whistle!"))
  )
  
  expanded_event   <- reactiveVal(NULL)
  selected_cat     <- reactiveVal("All")
  selected_attract <- reactiveVal(NULL)
  
  output$uiFan <- renderUI({
    div(
      style="background:#0a1628; min-height:100vh; padding-top:60px;",
      div(style="background:linear-gradient(135deg,#060e1a,#0d1f35);
                 padding:56px 48px 40px; border-bottom:1px solid rgba(255,215,0,0.1);",
          div(style="max-width:1100px; margin:0 auto;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:10px;","Boston 2026"),
              h1(style="color:white; font-family:Georgia,serif; font-size:42px;
                         font-weight:700; margin:0 0 10px 0;","Fan Experience"),
              p(style="color:#ffffff; font-size:15px; margin:0; max-width:600px;",
                "Plan your matchday! Explore local events, build your itinerary, and discover Boston.")
          )
      ),
      div(style="max-width:1100px; margin:0 auto; padding:36px 48px 72px;",
          
          # EVENT CALENDAR
          div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                      text-transform:uppercase; margin-bottom:8px;","Around the Matches"),
          h2(style="color:white; font-family:Georgia,serif; font-size:28px;
                     font-weight:700; margin:0 0 20px 0;","Event Calendar"),
          div(style="display:inline-block; background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                      border-radius:6px; padding:12px 16px; margin-bottom:20px;",
              selectInput("fan_match_filter",label=NULL,
                          choices=c("All Match Days","Jun 13 \u2014 Haiti vs Scotland",
                                    "Jun 14\u201315 \u2014 Between Matches","Jun 16 \u2014 France vs Morocco",
                                    "Jun 20 \u2014 Scotland vs Iraq","Jun 23 \u2014 Norway vs England",
                                    "Jun 26 \u2014 Morocco vs Haiti"),
                          selected="All Match Days", width="320px")),
          uiOutput("fan_calendar_view"),
          uiOutput("fan_event_cards"),
          
          # ATTRACTIONS
          div(style="margin-top:56px;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:8px;","Explore Boston"),
              h2(style="color:white; font-family:Georgia,serif; font-size:28px;
                         font-weight:700; margin:0 0 20px 0;","Nearby Attractions"),
              div(style="display:flex; gap:8px; flex-wrap:wrap; margin-bottom:24px;",
                  lapply(list(
                    list(id="All",               label="All"),
                    list(id="Food & Culture",    label="\U0001f99e Food"),
                    list(id="Sports",            label="\u26be Sports"),
                    list(id="Culture",           label="\U0001f3a8 Culture"),
                    list(id="Outdoors",          label="\U0001f6a2 Outdoors"),
                    list(id="History",           label="\U0001f3db\ufe0f History"),
                    list(id="Shopping & Dining", label="\U0001f6cd\ufe0f Shopping")
                  ), function(btn) {
                    actionButton(paste0("fan_cat_",gsub("[^A-Za-z]","_",btn$id)), btn$label,
                                 style="background:transparent; border:1px solid rgba(255,215,0,0.35);
                                        color:#FFD700; border-radius:4px; padding:6px 14px;
                                        font-size:11px; font-weight:700; cursor:pointer;
                                        letter-spacing:0.5px; text-transform:uppercase;")
                  })
              ),
              uiOutput("fan_attraction_cards"),
              div(style="border-radius:8px; overflow:hidden; margin-bottom:20px;
                          border:1px solid rgba(255,255,255,0.06);",
                  div(style="padding:12px 16px; background:#0d1f35;",
                      div(style="font-size:10px; font-weight:700; letter-spacing:2px; color:#FFD700;
                                  text-transform:uppercase;",
                          "\U0001f4cd Attractions Map \u2014 click a pin for details")),
                  leafletOutput("fanMap",height="380px")),
              uiOutput("fan_attract_detail")
          )
      )
    )
  })
  
  output$fan_calendar_view <- renderUI({
    all_dates <- list(
      list(date="Jun 13",day="Sat",match="Haiti vs Scotland",   is_match=TRUE),
      list(date="Jun 14",day="Sun",match="Between Matches",      is_match=FALSE),
      list(date="Jun 15",day="Mon",match="Between Matches",      is_match=FALSE),
      list(date="Jun 16",day="Tue",match="France vs Morocco",    is_match=TRUE),
      list(date="Jun 20",day="Sat",match="Scotland vs Iraq",     is_match=TRUE),
      list(date="Jun 23",day="Tue",match="Norway vs England",    is_match=TRUE),
      list(date="Jun 26",day="Fri",match="Morocco vs Haiti",     is_match=TRUE)
    )
    div(style="display:flex; gap:8px; flex-wrap:wrap; margin-bottom:24px;",
        lapply(all_dates, function(d) {
          div(style=paste0("background:#0d1f35; border:1px solid rgba(255,255,255,0.06);
                             border-radius:6px; padding:14px 16px; min-width:105px; text-align:center;
                             border-top:3px solid ",
                           if(d$is_match)"#FFD700" else "rgba(255,255,255,0.08)",";"),
              div(style="font-size:9px; color:#ffffff; text-transform:uppercase;
                          letter-spacing:1.5px;",d$day),
              div(style=paste0("font-size:22px; font-weight:800; line-height:1; margin:5px 0; ",
                               if(d$is_match)"color:#FFD700;" else "color:#ffffff;"),
                  d$date),
              div(style=paste0("font-size:9px; font-weight:600; line-height:1.3; ",
                               if(d$is_match)"color:#ffffff;" else "color:#ffffff;"),
                  d$match),
              if(d$is_match) div(style="margin-top:8px;",
                                 span(style="background:#FFD700; color:#0a1628; font-size:8px;
                                              font-weight:800; padding:2px 8px; border-radius:2px;
                                              letter-spacing:1.5px; text-transform:uppercase;",
                                      "MATCH DAY")))
        })
    )
  })
  
  output$fan_event_cards <- renderUI({
    selected <- input$fan_match_filter
    events   <- if(is.null(selected)||selected=="All Match Days") fan_events else
      Filter(function(e) e$match==selected, fan_events)
    if(length(events)==0)
      return(div(style="color:#ffffff;padding:20px;","No events for this match day."))
    div(style="display:flex; flex-direction:column; gap:8px; margin-bottom:20px;",
        lapply(seq_along(events), function(i) {
          e <- events[[i]]; btn_id <- paste0("fan_expand_",i)
          expanded <- isTRUE(expanded_event()==i)
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.06);
                      border-radius:6px; padding:18px 20px; border-left:3px solid #FFD700;",
              div(style="display:flex; align-items:center; justify-content:space-between;",
                  div(style="flex:1;",
                      div(style="font-size:15px; font-weight:700; color:white; margin-bottom:4px;",e$title),
                      div(style="font-size:12px; color:#ffffff;",e$desc)),
                  div(style="margin-left:16px; text-align:right; min-width:120px;",
                      div(style=paste0("font-size:9px; font-weight:800; color:",e$color,
                                       "; letter-spacing:1.5px; text-transform:uppercase; margin-bottom:6px;"),
                          e$tag),
                      div(style="font-size:11px; color:#ffffff; margin-bottom:10px;",
                          paste0("2026 \u00b7 ",e$date)),
                      actionButton(btn_id, if(expanded)"Hide \u25b2" else "Details \u25bc",
                                   style="background:transparent; border:1px solid rgba(255,215,0,0.35);
                                          color:#FFD700; border-radius:3px; padding:5px 12px;
                                          font-size:10px; font-weight:800; cursor:pointer;
                                          letter-spacing:1px; text-transform:uppercase; width:100%;"))
              ),
              if(expanded) div(style="margin-top:14px; padding:14px 16px; background:#060e1a;
                                       border-radius:5px; border-left:2px solid rgba(255,215,0,0.3);",
                               p(style="margin:0; color:#ffffff; font-size:13px;
                                         line-height:1.7;",e$details))
          )
        })
    )
  })
  
  lapply(seq_along(fan_events), function(i) {
    observeEvent(input[[paste0("fan_expand_",i)]], {
      if(isTRUE(expanded_event()==i)) expanded_event(NULL) else expanded_event(i)
    }, ignoreInit=TRUE)
  })
  
  output$fan_day_plan <- renderUI({
    sel <- input$fan_plan_filter
    if(is.null(sel)||sel=="Select a match\u2026") return(NULL)
    plan <- Filter(function(p) p$match==sel, fan_match_plans)
    if(length(plan)==0) return(NULL)
    p <- plan[[1]]
    steps <- list(
      list(time=p$morning$time,   icon=p$morning$icon,   stop=p$morning$stop,   tip=p$morning$tip),
      list(time=p$lunch$time,     icon=p$lunch$icon,     stop=p$lunch$stop,     tip=p$lunch$tip),
      list(time=p$afternoon$time, icon=p$afternoon$icon, stop=p$afternoon$stop, tip=p$afternoon$tip),
      list(time=p$transit$time,   icon=p$transit$icon,   stop=p$transit$stop,   tip=p$transit$tip),
      list(time=p$match$time,     icon=p$match$icon,     stop=p$match$stop,     tip=p$match$tip)
    )
    div(style="background:#0d1f35; border:1px solid rgba(255,215,0,0.18);
                border-radius:8px; padding:28px; margin-bottom:20px;",
        div(style="font-size:10px; font-weight:700; letter-spacing:2px; color:#FFD700;
                    text-transform:uppercase; margin-bottom:6px;","Your Day"),
        h3(style="color:white; font-family:Georgia,serif; font-size:22px;
                   font-weight:700; margin:0 0 4px 0;",sel),
        p(style="color:#ffffff; font-size:11px; margin:0 0 24px 0;
                  text-transform:uppercase; letter-spacing:1px;",
          paste("Kickoff:",p$kickoff)),
        div(lapply(seq_along(steps), function(i) {
          s <- steps[[i]]; is_last <- i==length(steps)
          div(style="display:flex; gap:16px;",
              div(style="display:flex; flex-direction:column; align-items:center; width:36px;",
                  div(style=paste0("width:36px; height:36px; border-radius:50%; display:flex;
                                     align-items:center; justify-content:center; font-size:15px;",
                                   if(is_last)"background:#FFD700;"
                                   else "background:#060e1a; border:1px solid rgba(255,215,0,0.25);"),
                      s$icon),
                  if(!is_last) div(style="width:1px; background:rgba(255,215,0,0.15);
                                           flex:1; min-height:32px; margin:4px 0;")),
              div(style=paste0("flex:1; padding-bottom:",if(is_last)"0" else "20","px;"),
                  div(style="display:flex; align-items:center; gap:10px; margin-bottom:4px;",
                      span(style="font-size:10px; color:#FFD700; font-weight:800;
                                    background:rgba(255,215,0,0.1); padding:2px 10px;
                                    border-radius:3px; letter-spacing:0.5px;",s$time),
                      span(style="font-size:14px; font-weight:700; color:white;",s$stop)),
                  p(style="margin:0; font-size:12px; color:#ffffff; line-height:1.6;",s$tip))
          )
        }))
    )
  })
  
  lapply(list("All","Food & Culture","Sports","Culture","Outdoors","History","Shopping & Dining"), function(cat) {
    observeEvent(input[[paste0("fan_cat_",gsub("[^A-Za-z]","_",cat))]], {
      selected_cat(cat); selected_attract(NULL)
    }, ignoreInit=TRUE)
  })
  
  output$fan_attraction_cards <- renderUI({
    cat <- selected_cat()
    filtered <- if(cat=="All") fan_attractions else Filter(function(a) a$cat==cat, fan_attractions)
    fluidRow(lapply(filtered, function(a) {
      column(4, div(
        style="background:#0d1f35; border:1px solid rgba(255,255,255,0.06);
                border-radius:8px; padding:22px 20px; margin-bottom:16px; border-top:3px solid #FFD700;",
        div(style="font-size:30px; margin-bottom:12px;",a$icon),
        div(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px;
                    text-transform:uppercase; margin-bottom:8px;",a$cat),
        h4(style="margin:0 0 8px 0; color:white; font-weight:700; font-size:15px;",a$name),
        p(style="color:#ffffff; font-size:13px; line-height:1.6; margin:0 0 12px 0;",a$desc),
        div(style="display:flex; align-items:center; gap:6px;",
            span(style="font-size:12px;","\U0001f4cd"),
            span(style="font-size:11px; color:#ffffff;",a$dist))
      ))
    }))
  })
  
  output$fanMap <- renderLeaflet({
    cat <- selected_cat()
    filtered <- if(cat=="All") fan_attractions else Filter(function(a) a$cat==cat, fan_attractions)
    leaflet() %>%
      addTiles(urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
               attribution = "© OpenStreetMap contributors") %>%
      addAwesomeMarkers(lat=42.0909,lng=-71.2643,label="Gillette Stadium",
                        icon=makeAwesomeIcon(icon="futbol-o",library="fa",
                                             markerColor="red",iconColor="white")) %>%
      addAwesomeMarkers(
        lat=sapply(filtered,function(a)a$lat), lng=sapply(filtered,function(a)a$lng),
        layerId=sapply(filtered,function(a)a$name), label=sapply(filtered,function(a)a$name),
        icon=makeAwesomeIcon(icon="star",library="fa",markerColor="orange",iconColor="white"),
        popup=sapply(filtered,function(a) paste0(
          "<div style='background:#0d1f35;color:white;padding:10px;border-radius:6px;",
          "font-family:sans-serif;min-width:150px;'>",
          "<b style='color:#FFD700;font-size:13px;'>",a$name,"</b><br>",
          "<span style='color:#ffffff;font-size:11px;'>",a$cat,"</span><br>",
          "<span style='color:#ffffff;font-size:11px;'>",a$dist,"</span></div>"
        ))
      )
  })
  
  observeEvent(input$fanMap_marker_click, {
    click <- input$fanMap_marker_click
    if(!is.null(click$id)) {
      m <- Filter(function(a) a$name==click$id, fan_attractions)
      if(length(m)>0) selected_attract(m[[1]])
    }
  })
  observeEvent(input$fanMap_click, { selected_attract(NULL) })
  
  output$fan_attract_detail <- renderUI({
    a <- selected_attract(); if(is.null(a)) return(NULL)
    div(style="background:#0d1f35; border:1px solid rgba(255,215,0,0.2);
                border-radius:8px; padding:24px 28px; margin-bottom:20px;
                border-left:4px solid #FFD700;",
        div(style="display:flex; justify-content:space-between; align-items:flex-start; margin-bottom:16px;",
            div(div(style="font-size:26px; margin-bottom:8px;",a$icon),
                h3(style="margin:0 0 4px 0; color:white; font-size:18px; font-weight:700;",a$name),
                span(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px;
                             text-transform:uppercase;",a$cat)),
            actionButton("fan_close_attract","\u2715",
                         style="background:none; border:none; font-size:18px;
                                color:#ffffff; cursor:pointer; padding:0;")),
        p(style="color:#ffffff; font-size:13px; line-height:1.7; margin:0 0 16px;",
          a$details),
        div(style="display:flex; justify-content:space-between; align-items:center;",
            div(style="display:flex; align-items:center; gap:6px;",
                span("\U0001f4cd"),
                span(style="font-size:12px; color:#ffffff;",a$dist)),
            tags$a(href=paste0("https://www.google.com/maps/search/?api=1&query=",URLencode(a$name)),
                   target="_blank",
                   style="background:#FFD700; color:#0a1628; font-size:10px; font-weight:800;
                           padding:8px 16px; border-radius:4px; text-decoration:none;
                           letter-spacing:1px; text-transform:uppercase;",
                   "Google Maps \u2192"))
    )
  })
  observeEvent(input$fan_close_attract, { selected_attract(NULL) })
  
  # PLAYERS & TEAMS
  players_data <- reactive({
    dbGetQuery(con, "
      SELECT p.player_id,
             p.player_name   AS \"Player\",
             t.team_name     AS \"Team\",
             p.position      AS \"Position\",
             c.club_name     AS \"Club\",
             p.date_of_birth AS \"Date of Birth\",
             p.goals         AS \"Goals\"
      FROM players p
      JOIN clubs c ON p.club_id = c.club_id
      JOIN teams t ON p.team_id = t.team_id
      ORDER BY t.team_name, p.goals DESC
    ")
  })
  
  output$uiPlayers <- renderUI({
    df <- players_data()
    team_choices     <- sort(unique(df$Team))
    position_choices <- sort(unique(df$Position))
    top_scorer       <- df[which.max(df$Goals),]
    div(
      style="background:#0a1628; min-height:100vh; padding-top:60px;",
      div(style="background:linear-gradient(135deg,#060e1a,#0d1f35);
                 padding:56px 48px 40px; border-bottom:1px solid rgba(255,215,0,0.1);",
          div(style="max-width:1100px; margin:0 auto;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:10px;","Boston Group Stage"),
              h1(style="color:white; font-family:Georgia,serif; font-size:42px;
                         font-weight:700; margin:0 0 10px 0;","Players & Teams"),
              p(style="color:#ffffff; font-size:15px; margin:0; max-width:520px;",
                "Browse all players from Boston's group stage matches.")
          )
      ),
      div(style="max-width:1100px; margin:0 auto; padding:36px 48px 64px;",
          div(style="display:flex; gap:14px; margin-bottom:24px; flex-wrap:wrap;",
              lapply(list(
                list(val=nrow(df),               lbl="Total Players"),
                list(val=length(team_choices),   lbl="National Teams"),
                list(val=length(unique(df$Club)),lbl="Clubs"),
                list(val=sum(df$Goals),          lbl="Combined Goals")
              ), function(s) {
                div(style="flex:1; min-width:140px; background:#0d1f35;
                            border:1px solid rgba(255,215,0,0.12); border-radius:8px;
                            padding:20px 22px; border-top:3px solid #FFD700;",
                    div(style="font-size:32px; font-weight:800; color:white;
                                font-family:Georgia,serif;",s$val),
                    div(style="font-size:9px; color:#ffffff; text-transform:uppercase;
                                letter-spacing:1.5px; margin-top:4px;",s$lbl))
              })
          ),
          div(style="background:#0d1f35; border:1px solid rgba(255,215,0,0.2);
                      border-radius:8px; padding:20px 24px; margin-bottom:22px;
                      display:flex; align-items:center; gap:16px;",
              div(style="font-size:34px;","\U0001f3c6"),
              div(div(style="font-size:9px; font-weight:800; letter-spacing:2px; color:#FFD700;
                              text-transform:uppercase; margin-bottom:4px;","Top Scorer"),
                  h3(style="color:white; font-family:Georgia,serif; font-size:20px;
                             font-weight:700; margin:0 0 3px 0;",top_scorer$Player),
                  p(style="color:#ffffff; font-size:12px; margin:0;",
                    paste0(top_scorer$Goals," goals \u00b7 ",top_scorer$Team," \u00b7 ",top_scorer$Club)))
          ),
          div(style="background:#0d1f35; border:1px solid rgba(255,255,255,0.07);
                      border-radius:8px; padding:20px 22px; margin-bottom:22px;",
              fluidRow(
                column(4,selectInput("pt_team","Team:",
                                     choices=c("All Teams"="ALL",setNames(team_choices,team_choices)),
                                     selected="ALL")),
                column(4,selectInput("pt_pos","Position:",
                                     choices=c("All Positions"="ALL",setNames(position_choices,position_choices)),
                                     selected="ALL")),
                column(4,textInput("pt_search","Search:",placeholder="Player name\u2026"))
              )
          ),
          tabsetPanel(id="playerSubTabs",
                      tabPanel("Player Table",
                               div(style="margin-top:18px; background:#0d1f35; border-radius:8px; padding:16px;",
                                   DT::dataTableOutput("playerMainTable"))),
                      tabPanel("Team Overview",
                               div(style="margin-top:22px;",
                                   fluidRow(column(6,plotOutput("teamGoalBar",height="300px")),
                                            column(6,plotOutput("teamSizeBar",height="300px"))),
                                   div(style="margin-top:18px; background:#0d1f35; border-radius:8px; padding:16px;",
                                       selectInput("pt_team_detail","Select team:",
                                                   choices=setNames(team_choices,team_choices),
                                                   selected=team_choices[1]),
                                       DT::dataTableOutput("teamDetailTable")))),
                      tabPanel("Position Breakdown",
                               div(style="margin-top:22px;",
                                   fluidRow(column(6,plotOutput("positionDonut",height="360px")),
                                            column(6,plotOutput("topScorerBar",height="360px")))))
          )
      )
    )
  })
  
  filtered_players <- reactive({
    df <- players_data()
    if(!is.null(input$pt_team)   && input$pt_team   !="ALL") df <- df[df$Team==input$pt_team,]
    if(!is.null(input$pt_pos)    && input$pt_pos    !="ALL") df <- df[df$Position==input$pt_pos,]
    if(!is.null(input$pt_search) && nchar(trimws(input$pt_search))>0)
      df <- df[grepl(input$pt_search,df$Player,ignore.case=TRUE),]
    df[,c("Player","Team","Position","Club","Date of Birth","Goals")]
  })
  
  output$playerMainTable <- DT::renderDataTable({
    DT::datatable(filtered_players(),
                  options=list(pageLength=15,scrollX=TRUE,
                               headerCallback=dt_header_cb, drawCallback=dt_draw_cb),
                  rownames=FALSE, class="stripe hover") %>%
      DT::formatStyle(columns=c("Player","Team","Position","Club","Date of Birth"), color="white") %>%
      DT::formatStyle("Goals", color="white", fontWeight="bold")
  })
  
  dark_plot_theme <- function() {
    ggplot2::theme_minimal(base_size=13) +
      ggplot2::theme(
        plot.background  = ggplot2::element_rect(fill="#0d1f35",color=NA),
        panel.background = ggplot2::element_rect(fill="#0d1f35",color=NA),
        panel.grid.major = ggplot2::element_line(color="#1a2f45"),
        panel.grid.minor = ggplot2::element_blank(),
        text             = ggplot2::element_text(color="white"),
        axis.text        = ggplot2::element_text(color="#6b8aaa"),
        plot.title       = ggplot2::element_text(face="bold",color="white"),
        legend.background= ggplot2::element_rect(fill="#0d1f35",color=NA),
        legend.text      = ggplot2::element_text(color="#9ab0c8")
      )
  }
  
  output$teamGoalBar <- renderPlot({
    df <- players_data(); agg <- aggregate(Goals~Team,data=df,FUN=sum)
    agg <- agg[order(-agg$Goals),]
    ggplot2::ggplot(agg,ggplot2::aes(x=reorder(Team,Goals),y=Goals,fill=Goals)) +
      ggplot2::geom_bar(stat="identity") + ggplot2::coord_flip() +
      ggplot2::scale_fill_gradient(low="#1a3a5c",high="#FFD700") +
      ggplot2::labs(title="Goals by Team",x=NULL,y="Goals") +
      dark_plot_theme() + ggplot2::theme(legend.position="none")
  })
  
  output$teamSizeBar <- renderPlot({
    df <- players_data(); agg <- aggregate(Player~Team,data=df,FUN=length)
    names(agg)[2] <- "Players"
    ggplot2::ggplot(agg,ggplot2::aes(x=reorder(Team,Players),y=Players,fill=Players)) +
      ggplot2::geom_bar(stat="identity") + ggplot2::coord_flip() +
      ggplot2::scale_fill_gradient(low="#1a3a5c",high="#FFD700") +
      ggplot2::labs(title="Squad Size by Team",x=NULL,y="Players") +
      dark_plot_theme() + ggplot2::theme(legend.position="none")
  })
  
  output$teamDetailTable <- DT::renderDataTable({
    req(input$pt_team_detail); df <- players_data()
    df <- df[df$Team==input$pt_team_detail, c("Player","Position","Club","Date of Birth","Goals")]
    DT::datatable(df[order(-df$Goals),],
                  options=list(pageLength=25,scrollX=TRUE,dom="tip",
                               headerCallback=dt_header_cb,drawCallback=dt_draw_cb),
                  rownames=FALSE, class="stripe hover") %>%
      DT::formatStyle(columns=c("Player","Position","Club","Date of Birth","Goals"), color="white")
  })
  
  output$positionDonut <- renderPlot({
    df <- players_data()
    if(!is.null(input$pt_team)&&input$pt_team!="ALL") df <- df[df$Team==input$pt_team,]
    agg <- as.data.frame(table(Position=df$Position))
    agg$fraction <- agg$Freq/sum(agg$Freq)
    agg$ymax <- cumsum(agg$fraction); agg$ymin <- c(0,head(agg$ymax,-1))
    agg$label <- paste0(agg$Position,"\n",agg$Freq)
    ggplot2::ggplot(agg,ggplot2::aes(ymax=ymax,ymin=ymin,xmax=4,xmin=2.5,fill=Position)) +
      ggplot2::geom_rect() +
      ggplot2::geom_text(ggplot2::aes(x=3.25,y=(ymin+ymax)/2,label=label),
                         size=3.5,fontface="bold",color="white") +
      ggplot2::coord_polar(theta="y") + ggplot2::xlim(c(0,4)) +
      ggplot2::scale_fill_manual(values=c("Forward"="#FFD700","Midfielder"="#f59e0b",
                                          "Defender"="#1a5f9e","Goalkeeper"="#0d1f35")) +
      ggplot2::labs(title="Players by Position") + ggplot2::theme_void(base_size=13) +
      ggplot2::theme(plot.title=ggplot2::element_text(face="bold",hjust=0.5,size=15,color="white"),
                     legend.position="none",
                     plot.background=ggplot2::element_rect(fill="#0d1f35",color=NA))
  })
  
  output$topScorerBar <- renderPlot({
    df <- players_data()
    if(!is.null(input$pt_team)&&input$pt_team!="ALL") df <- df[df$Team==input$pt_team,]
    top10 <- head(df[order(-df$Goals),],10); top10 <- top10[top10$Goals>0,]
    ggplot2::ggplot(top10,ggplot2::aes(x=reorder(Player,Goals),y=Goals,fill=Team)) +
      ggplot2::geom_bar(stat="identity") +
      ggplot2::geom_text(ggplot2::aes(label=Goals),hjust=-0.3,size=4,fontface="bold",color="white") +
      ggplot2::coord_flip() + ggplot2::scale_fill_brewer(palette="Set2") +
      ggplot2::labs(title="Top Scorers",x=NULL,y="Goals") +
      dark_plot_theme() + ggplot2::theme(legend.position="bottom",
                                         legend.title=ggplot2::element_blank())
  })
  
  # TICKETS
  ticket_data <- reactive({
    dbGetQuery(con, "
      SELECT tc.category_name, tc.description, tp.round_name,
             tp.tickets_available, tp.price_usd_min, tp.price_usd_max
      FROM ticket_pricing tp
      JOIN ticket_categories tc ON tp.category_id = tc.category_id
      ORDER BY tp.round_name, tp.category_id
    ")
  })
  
  output$uiTickets <- renderUI({
    div(
      style="background:#0a1628; min-height:100vh; padding-top:60px;",
      div(style="background:linear-gradient(135deg,#060e1a,#0d1f35);
                 padding:56px 48px 40px; border-bottom:1px solid rgba(255,215,0,0.1);",
          div(style="max-width:1100px; margin:0 auto;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:10px;",
                  "FIFA World Cup 2026\u2122 \u00b7 Official"),
              h1(style="color:white; font-family:Georgia,serif; font-size:42px;
                         font-weight:700; margin:0 0 10px 0;","Tickets"),
              p(style="color:#ffffff; font-size:15px; margin:0; max-width:520px;",
                "Official ticket categories for Gillette Stadium, Foxborough MA.")
          )
      ),
      div(style="max-width:1100px; margin:0 auto; padding:36px 48px 64px;",
          div(style="display:inline-block; background:#0d1f35;
                      border:1px solid rgba(255,255,255,0.07); border-radius:6px;
                      padding:12px 16px; margin-bottom:22px;",
              selectInput("ticket_round","Round:",
                          choices=c("Group Stage","Round of 32","Quarter-finals"),
                          selected="Group Stage", width="260px")),
          uiOutput("ticketMatchInfo"),
          uiOutput("ticketCards"),
          
          #seating map
          div(style="margin-top:40px; background:#0d1f35; border:1px solid rgba(255,215,0,0.18);
                      border-radius:8px; padding:28px 32px;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:6px;",
                  "Gillette Stadium · Seating Map"),
              p(style="color:#ffffff; font-size:13px; margin:0 0 20px 0;",
                "Select your category above to see where your seats are located."),
              div(style="text-align:center;",
                  tags$img(src="Boston Stadium.png",
                           style="max-width:100%; border-radius:8px;",
                           alt="Boston Stadium Seating Map")),
              
              div(style="margin-top:20px;",
                  div(style="font-size:10px; font-weight:700; letter-spacing:2px; color:#FFD700;
                              text-transform:uppercase; margin-bottom:12px;",
                      "Click a category to see pricing:"),
                  div(style="display:flex; flex-wrap:wrap; gap:10px; justify-content:center;",
                      lapply(list(
                        list(color="#C8922A", id="cat1", label="Category 1"),
                        list(color="#C0392B", id="cat2", label="Category 2"),
                        list(color="#2471A3", id="cat3", label="Category 3 ★"),
                        list(color="#1E8449", id="cat4", label="Category 4")
                      ), function(cat) {
                        actionButton(
                          cat$id,
                          label = cat$label,
                          style = paste0("background:", cat$color, "; color:white; border:none;
                                          font-weight:700; font-size:12px; padding:8px 18px;
                                          border-radius:4px; cursor:pointer;")
                        )
                      })
                  ),
                  uiOutput("categoryPriceInfo")
              )
          ),
          div(style="text-align:center; margin-top:32px;",
              p(style="color:#ffffff; font-size:13px; margin-bottom:12px;",
                "Explore all ticket options on the official FIFA website:"),
              tags$a(href="https://www.fifa.com/en/tournaments/mens/worldcup/canadamexicousa2026/tickets",
                     target="_blank",
                     style="display:inline-block; background:#FFD700; color:#0a1628;
                             padding:14px 40px; border-radius:4px; font-size:12px;
                             font-weight:800; text-decoration:none; letter-spacing:2px;
                             text-transform:uppercase;",
                     "Explore & Buy Official Tickets on FIFA.com"))
      )
    )
  })
  
  cat_info <- list(
    cat1 = list(name="Category 1", color="#C8922A",
                desc="100 Level field side + central 200 Level. Best views, closest to pitch.",
                group="$210–$295", r32="$260–$375", qf="$400–$580"),
    cat2 = list(name="Category 2", color="#C0392B",
                desc="Corner 200 Level + upper sideline 300 Level. Great angle views.",
                group="$158–$173", r32="$195–$237", qf="$275–$360"),
    cat3 = list(name="Category 3 ★ Best Value", color="#2471A3",
                desc="Corner 300 Level. Upper tier angled view. Best bang for your buck!",
                group="$111–$130", r32="$138–$164", qf="$195–$260"),
    cat4 = list(name="Category 4", color="#1E8449",
                desc="End zone 300 Level. Most affordable option.",
                group="$100–$128", r32="$125–$160", qf="$190–$248")
  )
  
  selected_cat <- reactiveVal(NULL)
  
  observeEvent(input$cat1, { selected_cat("cat1") })
  observeEvent(input$cat2, { selected_cat("cat2") })
  observeEvent(input$cat3, { selected_cat("cat3") })
  observeEvent(input$cat4, { selected_cat("cat4") })
  
  output$categoryPriceInfo <- renderUI({
    req(selected_cat())
    info <- cat_info[[selected_cat()]]
    div(style=paste0("margin-top:16px; background:#060e1a; border:1px solid ",
                     info$color, "; border-radius:8px; padding:20px 24px; text-align:left;"),
        div(style=paste0("font-size:13px; font-weight:800; color:", info$color,
                         "; margin-bottom:6px;"), info$name),
        p(style="color:#ffffff; font-size:12px; margin:0 0 14px 0;", info$desc),
        div(style="display:flex; gap:16px; flex-wrap:wrap;",
            lapply(list(
              list(round="Group Stage",    price=info$group),
              list(round="Round of 32",    price=info$r32),
              list(round="Quarter-finals", price=info$qf)
            ), function(r) {
              div(style="background:#0d1f35; border-radius:6px; padding:10px 16px; flex:1; min-width:120px;",
                  p(style="margin:0 0 3px 0; font-size:9px; color:#FFD700;
                            text-transform:uppercase; letter-spacing:1px;", r$round),
                  p(style="margin:0; font-size:16px; font-weight:800; color:white;",
                    r$price))
            })
        )
    )
  })
  output$ticketMatchInfo <- renderUI({
    req(input$ticket_round)
    info <- list(
      "Group Stage"    = "Haiti vs Scotland \u00b7 Iraq vs Norway \u00b7 Scotland vs Morocco \u00b7 England vs Ghana \u00b7 Norway vs France",
      "Round of 32"    = "Match 74 \u00b7 Monday, June 29, 2026 \u00b7 4:30 PM ET",
      "Quarter-finals" = "Match 97 \u00b7 Thursday, July 9, 2026 \u00b7 4:00 PM ET"
    )
    div(style="background:#0d1f35; border:1px solid rgba(255,215,0,0.18);
                border-radius:6px; padding:14px 20px; margin-bottom:24px;
                border-left:3px solid #FFD700;",
        div(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px;
                    text-transform:uppercase; margin-bottom:5px;", input$ticket_round),
        p(style="margin:0; color:#ffffff; font-size:13px;",
          info[[input$ticket_round]]))
  })
  
  output$ticketCards <- renderUI({
    req(input$ticket_round)
    td <- ticket_data(); filtered <- td[td$round_name==input$ticket_round,]
    fluidRow(lapply(1:nrow(filtered), function(i) {
      row <- filtered[i,]; is_best <- row$category_name=="Cat 3"
      column(2, div(
        style=paste0("background:#0d1f35; border:1px solid rgba(255,255,255,0.06);
                      border-radius:8px; padding:22px 14px; text-align:center;
                      margin-bottom:16px; border-top:3px solid #FFD700;",
                     if(is_best)"outline:1px solid rgba(255,215,0,0.4);" else ""),
        if(is_best) div(style="background:#FFD700; color:#0a1628; font-size:8px; font-weight:800;
                                padding:3px 10px; border-radius:2px; margin-bottom:10px;
                                display:inline-block; letter-spacing:2px; text-transform:uppercase;",
                        "BEST VALUE"),
        h4(style="color:#FFD700; margin:0 0 6px 0; font-weight:800; font-size:17px;
                   font-family:Georgia,serif;", row$category_name),
        p(style="color:#ffffff; font-size:11px; margin:0 0 14px 0; line-height:1.5;",
          row$description),
        div(style="background:#060e1a; border-radius:6px; padding:14px 8px;",
            p(style="margin:0 0 3px 0; font-size:9px; color:#ffffff;
                      text-transform:uppercase; letter-spacing:1px;","Est. Price Range"),
            p(style="margin:0; font-size:20px; font-weight:800; color:white;
                      font-family:Georgia,serif;",
              paste0("$",row$price_usd_min," \u2013 $",row$price_usd_max))),
        p(style="margin:10px 0 0 0; font-size:10px; color:#ffffff;",
          paste0("\u007e",row$tickets_available," available"))
      ))
    }))
  })
  
  # ABOUT
  output$uiAbout <- renderUI({
    
    # FIFA trivia Q&A data
    trivia <- list(
      list(q="How many teams compete in FIFA World Cup 2026?",
           opts=c("32","36","48","64"), ans=3,
           fact="2026 is the first World Cup with 48 teams, up from 32 in 2022!"),
      list(q="Which country has won the most FIFA World Cups?",
           opts=c("Germany","Argentina","Brazil","France"), ans=3,
           fact="Brazil has won 5 World Cups: 1958, 1962, 1970, 1994, and 2002."),
      list(q="How many matches will Boston (Gillette Stadium) host?",
           opts=c("3","4","5","6"), ans=3,
           fact="Boston hosts 5 group stage matches across June 13\u201326, 2026."),
      list(q="What is Gillette Stadium's official seating capacity?",
           opts=c("55,000","62,000","68,756","72,000"), ans=3,
           fact="Gillette Stadium holds 68,756 fans. Home of the New England Patriots and Revolution."),
      list(q="Which city is NOT a host city for FIFA World Cup 2026?",
           opts=c("Boston","Chicago","Los Angeles","Seattle"), ans=2,
           fact="Chicago is not a host city. The US hosts 11 cities including Boston, LA, NYC, and Dallas."),
      list(q="What year was the FIFA World Cup first held?",
           opts=c("1920","1930","1938","1950"), ans=2,
           fact="The first FIFA World Cup was held in Uruguay in 1930, Uruguay won it!")
    )
    
    div(
      style="background:#0a1628; min-height:100vh; padding-top:60px;",
      
      # hero
      div(style="background:linear-gradient(135deg,#060e1a,#0d1f35);
                 padding:56px 48px 40px; border-bottom:1px solid rgba(255,215,0,0.1);",
          div(style="max-width:1000px; margin:0 auto; text-align:center;",
              div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:10px;",
                  "APAN 5310 \u00b7 Columbia University \u00b7 Spring 2026"),
              h1(style="color:white; font-family:Georgia,serif; font-size:42px;
                         font-weight:700; margin:0;","Meet the Team")
          )
      ),
      
      div(style="max-width:980px; margin:0 auto; padding:48px 48px 72px;",
          
          # team cards
          fluidRow(
            column(4,
                   tags$div(
                     style="width:100%; height:230px; perspective:1000px; cursor:pointer; margin-bottom:18px;",
                     onmouseover="this.querySelector('.fi').style.transform='rotateY(180deg)';",
                     onmouseout="this.querySelector('.fi').style.transform='rotateY(0deg)';",
                     tags$div(class="fi",
                              style="position:relative; width:100%; height:230px; transition:transform 0.6s; transform-style:preserve-3d;",
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:1px solid rgba(255,255,255,0.06); border-top:3px solid #FFD700; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center; padding:16px; box-sizing:border-box;",
                                tags$img(src="carolyn.png",         
                                         style="width:72px; height:72px; border-radius:50%; border:2px solid #FFD700; margin-bottom:6px; object-fit:cover;"),
                                tags$div(style="font-size:28px; margin-bottom:4px;", "\U0001f3e0"),
                                tags$h3(style="color:white; font-family:Georgia,serif; font-weight:700; margin:0 0 4px 0; font-size:15px;", "Carolyn Zeng"),
                                tags$div(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px; text-transform:uppercase;", "Matches")
                              ),
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:2px solid #FFD700; transform:rotateY(180deg); display:flex; flex-direction:column; align-items:center; justify-content:center; padding:12px; box-sizing:border-box;",
                                tags$div(style="font-size:10px; font-weight:800; color:#FFD700; letter-spacing:1px; text-transform:uppercase; margin-bottom:8px; text-align:center;",
                                         "\U0001f517 Connect with us on LinkedIn!"),
                                tags$img(src="carolyn_code.png",
                                         style="width:155px; height:155px; object-fit:contain; background:white; padding:6px; border-radius:4px;")
                              )
                     )
                   )
            ),
            column(4,
                   tags$div(
                     style="width:100%; height:230px; perspective:1000px; cursor:pointer; margin-bottom:18px;",
                     onmouseover="this.querySelector('.fi').style.transform='rotateY(180deg)';",
                     onmouseout="this.querySelector('.fi').style.transform='rotateY(0deg)';",
                     tags$div(class="fi",
                              style="position:relative; width:100%; height:230px; transition:transform 0.6s; transform-style:preserve-3d;",
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:1px solid rgba(255,255,255,0.06); border-top:3px solid #FFD700; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center; padding:16px; box-sizing:border-box;",
                                tags$img(src="sunny.jpg",         
                                         style="width:72px; height:72px; border-radius:50%; border:2px solid #FFD700; margin-bottom:6px; object-fit:cover;"),
                                tags$div(style="font-size:28px; margin-bottom:4px;", "\U0001f3df\ufe0f"),
                                tags$h3(style="color:white; font-family:Georgia,serif; font-weight:700; margin:0 0 4px 0; font-size:15px;", "Sunny Guo"),
                                tags$div(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px; text-transform:uppercase;", "Tickets")
                              ),
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:2px solid #FFD700; transform:rotateY(180deg); display:flex; flex-direction:column; align-items:center; justify-content:center; padding:12px; box-sizing:border-box;",
                                tags$div(style="font-size:10px; font-weight:800; color:#FFD700; letter-spacing:1px; text-transform:uppercase; margin-bottom:8px; text-align:center;",
                                         "\U0001f517 Connect with us on LinkedIn!"),
                                tags$img(src="sunny_code.png",
                                         style="width:155px; height:155px; object-fit:contain; background:white; padding:6px; border-radius:4px;")
                              )
                     )
                   )
            ),
            column(4,
                   tags$div(
                     style="width:100%; height:230px; perspective:1000px; cursor:pointer; margin-bottom:18px;",
                     onmouseover="this.querySelector('.fi').style.transform='rotateY(180deg)';",
                     onmouseout="this.querySelector('.fi').style.transform='rotateY(0deg)';",
                     tags$div(class="fi",
                              style="position:relative; width:100%; height:230px; transition:transform 0.6s; transform-style:preserve-3d;",
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:1px solid rgba(255,255,255,0.06); border-top:3px solid #FFD700; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center; padding:16px; box-sizing:border-box;",
                                tags$img(src="joe.jpeg",         
                                         style="width:72px; height:72px; border-radius:50%; border:2px solid #FFD700; margin-bottom:6px; object-fit:cover;"),
                                tags$div(style="font-size:28px; margin-bottom:4px;", "\U0001f68c"),
                                tags$h3(style="color:white; font-family:Georgia,serif; font-weight:700; margin:0 0 4px 0; font-size:15px;", "Joe Wang"),
                                tags$div(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px; text-transform:uppercase;", "Transportation")
                              ),
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:2px solid #FFD700; transform:rotateY(180deg); display:flex; flex-direction:column; align-items:center; justify-content:center; padding:12px; box-sizing:border-box;",
                                tags$div(style="font-size:10px; font-weight:800; color:#FFD700; letter-spacing:1px; text-transform:uppercase; margin-bottom:8px; text-align:center;",
                                         "\U0001f517 Connect with us on LinkedIn!"),
                                tags$img(src="joe_code.png",
                                         style="width:155px; height:155px; object-fit:contain; background:white; padding:6px; border-radius:4px;")
                              )
                     )
                   )
            ),
            column(4,
                   tags$div(
                     style="width:100%; height:230px; perspective:1000px; cursor:pointer; margin-bottom:18px;",
                     onmouseover="this.querySelector('.fi').style.transform='rotateY(180deg)';",
                     onmouseout="this.querySelector('.fi').style.transform='rotateY(0deg)';",
                     tags$div(class="fi",
                              style="position:relative; width:100%; height:230px; transition:transform 0.6s; transform-style:preserve-3d;",
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:1px solid rgba(255,255,255,0.06); border-top:3px solid #FFD700; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center; padding:16px; box-sizing:border-box;",
                                tags$img(src="lc.png",
                                         style="width:72px; height:72px; border-radius:50%; border:2px solid #FFD700; margin-bottom:6px; object-fit:cover;"),
                                tags$div(style="font-size:28px; margin-bottom:4px;", "\U0001f37d\ufe0f"),
                                tags$h3(style="color:white; font-family:Georgia,serif; font-weight:700; margin:0 0 4px 0; font-size:15px;", "Leanne Chung"),
                                tags$div(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px; text-transform:uppercase;", "Dining and Fan Experience")
                              ),
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:2px solid #FFD700; transform:rotateY(180deg); display:flex; flex-direction:column; align-items:center; justify-content:center; padding:12px; box-sizing:border-box;",
                                tags$div(style="font-size:10px; font-weight:800; color:#FFD700; letter-spacing:1px; text-transform:uppercase; margin-bottom:8px; text-align:center;",
                                         "\U0001f517 Connect with us on LinkedIn!"),
                                tags$img(src="lc_code.png",
                                         style="width:155px; height:155px; object-fit:contain; background:white; padding:6px; border-radius:4px;")
                              )
                     )
                   )
            ),
            column(4,
                   tags$div(
                     style="width:100%; height:230px; perspective:1000px; cursor:pointer; margin-bottom:18px;",
                     onmouseover="this.querySelector('.fi').style.transform='rotateY(180deg)';",
                     onmouseout="this.querySelector('.fi').style.transform='rotateY(0deg)';",
                     tags$div(class="fi",
                              style="position:relative; width:100%; height:230px; transition:transform 0.6s; transform-style:preserve-3d;",
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:1px solid rgba(255,255,255,0.06); border-top:3px solid #FFD700; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center; padding:16px; box-sizing:border-box;",
                                tags$img(src='athena.jpeg',         
                                         style="width:72px; height:72px; border-radius:50%; border:2px solid #FFD700; margin-bottom:6px; object-fit:cover;"),
                                tags$div(style="font-size:28px; margin-bottom:4px;", "\U0001f3e8"),
                                tags$h3(style="color:white; font-family:Georgia,serif; font-weight:700; margin:0 0 4px 0; font-size:15px;", "Athena Huang"),
                                tags$div(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px; text-transform:uppercase;", "Lodging")
                              ),
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:2px solid #FFD700; transform:rotateY(180deg); display:flex; flex-direction:column; align-items:center; justify-content:center; padding:12px; box-sizing:border-box;",
                                tags$div(style="font-size:10px; font-weight:800; color:#FFD700; letter-spacing:1px; text-transform:uppercase; margin-bottom:8px; text-align:center;",
                                         "\U0001f517 Connect with us on LinkedIn!"),
                                tags$img(src="athena_code.png",
                                         style="width:155px; height:155px; object-fit:contain; background:white; padding:6px; border-radius:4px;")
                              )
                     )
                   )
            ),
            column(4,
                   tags$div(
                     style="width:100%; height:230px; perspective:1000px; cursor:pointer; margin-bottom:18px;",
                     onmouseover="this.querySelector('.fi').style.transform='rotateY(180deg)';",
                     onmouseout="this.querySelector('.fi').style.transform='rotateY(0deg)';",
                     tags$div(class="fi",
                              style="position:relative; width:100%; height:230px; transition:transform 0.6s; transform-style:preserve-3d;",
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:1px solid rgba(255,255,255,0.06); border-top:3px solid #FFD700; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center; padding:16px; box-sizing:border-box;",
                                tags$img(src='zoey.jpeg',        
                                         style="width:72px; height:72px; border-radius:50%; border:2px solid #FFD700; margin-bottom:6px; object-fit:cover;"),
                                tags$div(style="font-size:28px; margin-bottom:4px;", "\U0001f4ca"),
                                tags$h3(style="color:white; font-family:Georgia,serif; font-weight:700; margin:0 0 4px 0; font-size:15px;", "Zoey Huang"),
                                tags$div(style="font-size:9px; font-weight:800; color:#FFD700; letter-spacing:2px; text-transform:uppercase;", "Players & Teams")
                              ),
                              tags$div(
                                style="position:absolute; width:100%; height:100%; backface-visibility:hidden; -webkit-backface-visibility:hidden; border-radius:8px; background:#0d1f35; border:2px solid #FFD700; transform:rotateY(180deg); display:flex; flex-direction:column; align-items:center; justify-content:center; padding:12px; box-sizing:border-box;",
                                tags$div(style="font-size:10px; font-weight:800; color:#FFD700; letter-spacing:1px; text-transform:uppercase; margin-bottom:8px; text-align:center;",
                                         "\U0001f517 Connect with us on LinkedIn!"),
                                tags$img(src="zoe_code.png",
                                         style="width:155px; height:155px; object-fit:contain; background:white; padding:6px; border-radius:4px;")
                              )
                     )
                   )
            )
          )
          ,
          
          # about project box
          div(style="background:#0d1f35; border:1px solid rgba(255,215,0,0.15);
                      border-radius:10px; padding:32px 36px; text-align:center; margin-top:8px; margin-bottom:40px;",
              div(style="font-size:10px; font-weight:800; letter-spacing:3px; color:#FFD700;
                          text-transform:uppercase; margin-bottom:12px;","About This Project"),
              p(style="color:#ffffff; font-size:15px; line-height:1.8;
                        margin:0 auto; max-width:580px;",
                "Built for APAN 5310 at Columbia University. We normalized FIFA World Cup 2026 data into a PostgreSQL database and built this interactive R Shiny app to help fans plan their Boston matchday experience.")
          ),
          
          # Trivia quiz
          div(style="font-size:10px; font-weight:700; letter-spacing:3px; color:#FFD700;
                      text-transform:uppercase; margin-bottom:8px;","Fun & Games"),
          h2(style="color:white; font-family:Georgia,serif; font-size:28px;
                     font-weight:700; margin:0 0 6px 0;","\u26bd FIFA World Cup Trivia"),
          p(style="color:#ffffff; font-size:14px; margin:0 0 24px 0;",
            "Test your World Cup knowledge! Pick an answer and see how you do."),
          
          # score display
          div(style="display:flex; align-items:center; gap:16px; margin-bottom:20px;",
              uiOutput("trivia_score_badge"),
              actionButton("trivia_reset","\u21ba Restart Quiz",
                           style="background:transparent; border:1px solid rgba(255,215,0,0.5);
                                  color:#FFD700; border-radius:5px; padding:8px 18px;
                                  font-size:12px; font-weight:800; letter-spacing:1px;
                                  text-transform:uppercase; cursor:pointer;")
          ),
          
          # current question card
          uiOutput("trivia_question_ui"),
          
          # result feedback
          uiOutput("trivia_feedback_ui"),
          
          # next button
          uiOutput("trivia_next_ui")
      )
    )
  })
  
  #Trivia state
  trivia_questions <- list(
    list(q="How many teams compete in FIFA World Cup 2026?",
         opts=c("32 teams","36 teams","48 teams","64 teams"), ans=3,
         fact="2026 is the first-ever 48-team World Cup, up from 32 in Qatar 2022!"),
    list(q="Which country has won the most FIFA World Cups?",
         opts=c("Germany","Argentina","Brazil","France"), ans=3,
         fact="Brazil has lifted the trophy 5 times: 1958, 1962, 1970, 1994, and 2002."),
    list(q="How many matches will Boston (Gillette Stadium) host?",
         opts=c("3 matches","4 matches","5 matches","6 matches"), ans=3,
         fact="Boston hosts 5 group stage matches from June 13\u201326, 2026."),
    list(q="What is Gillette Stadium's official seating capacity?",
         opts=c("55,000","62,000","68,756","72,000"), ans=3,
         fact="Gillette Stadium holds 68,756 fans. Home of the New England Patriots."),
    list(q="Which city is NOT a FIFA World Cup 2026 host?",
         opts=c("Boston","Chicago","Los Angeles","Dallas"), ans=2,
         fact="Chicago is not a host city. The US hosts 11 cities including Boston, NYC, and LA."),
    list(q="In what year was the FIFA World Cup first held?",
         opts=c("1920","1930","1938","1950"), ans=2,
         fact="The inaugural World Cup was held in Uruguay in 1930 and Uruguay won it!")
  )
  
  trivia_idx      <- reactiveVal(1)
  trivia_score    <- reactiveVal(0)
  trivia_answered <- reactiveVal(FALSE)
  trivia_chosen   <- reactiveVal(NULL)
  
  observeEvent(input$trivia_reset, {
    trivia_idx(1); trivia_score(0); trivia_answered(FALSE); trivia_chosen(NULL)
  })
  
  output$trivia_score_badge <- renderUI({
    n   <- length(trivia_questions)
    idx <- trivia_idx()
    sc  <- trivia_score()
    div(style="background:#0d1f35; border:1px solid rgba(255,215,0,0.2);
                border-radius:8px; padding:10px 20px; display:inline-block;",
        span(style="font-size:13px; color:#ffffff;", "Score: "),
        span(style="font-size:18px; font-weight:800; color:#FFD700;",
             paste0(sc," / ",min(idx-1,n))),
        span(style="font-size:12px; color:#ffffff; margin-left:10px;",
             paste0("Q",min(idx,n)," of ",n)))
  })
  
  output$trivia_question_ui <- renderUI({
    idx <- trivia_idx()
    if (idx > length(trivia_questions)) {
      sc <- trivia_score()
      n  <- length(trivia_questions)
      msg <- if(sc==n) "\U0001f3c6 Perfect score! You're a World Cup genius!"
      else if(sc>=n*0.7) "\U0001f44f Great job! Solid World Cup knowledge."
      else "\U0001f4da Keep studying, the World Cup is full of surprises!"
      return(div(
        style="background:#0d1f35; border:2px solid #FFD700; border-radius:10px;
                padding:40px; text-align:center;",
        div(style="font-size:48px; margin-bottom:16px;","\U0001f3c6"),
        h3(style="color:#FFD700; font-family:Georgia,serif; font-size:24px; margin:0 0 10px;",
           "Quiz Complete!"),
        p(style="color:#ffffff; font-size:16px; margin:0 0 10px;",msg),
        p(style="color:#ffffff; font-size:15px; margin:0;",
          paste0("You scored ",sc," out of ",n," questions."))
      ))
    }
    q    <- trivia_questions[[idx]]
    done <- trivia_answered()
    ch   <- trivia_chosen()
    
    div(
      style="background:#0d1f35; border:1px solid rgba(255,215,0,0.2);
              border-radius:10px; padding:28px; margin-bottom:12px;",
      div(style="font-size:10px; font-weight:800; color:#FFD700; letter-spacing:2px;
                  text-transform:uppercase; margin-bottom:10px;",
          paste0("Question ",idx," of ",length(trivia_questions))),
      h3(style="color:white; font-family:Georgia,serif; font-size:20px;
                 font-weight:700; margin:0 0 22px 0; line-height:1.4;", q$q),
      div(style="display:grid; grid-template-columns:1fr 1fr; gap:10px;",
          lapply(seq_along(q$opts), function(oi) {
            is_correct <- oi == q$ans
            is_chosen  <- !is.null(ch) && oi == ch
            btn_style  <- if (!done) {
              "background:#060e1a; border:2px solid rgba(255,215,0,0.3); color:white;
               border-radius:8px; padding:14px 16px; width:100%; text-align:left;
               font-size:14px; font-weight:600; cursor:pointer; transition:all 0.15s;"
            } else if (is_correct) {
              "background:#166534; border:2px solid #4ade80; color:#ffffff;
               border-radius:8px; padding:14px 16px; width:100%; text-align:left;
               font-size:14px; font-weight:700; cursor:default;"
            } else if (is_chosen) {
              "background:#7f1d1d; border:2px solid #f87171; color:#ffffff;
               border-radius:8px; padding:14px 16px; width:100%; text-align:left;
               font-size:14px; font-weight:700; cursor:default;"
            } else {
              "background:#060e1a; border:2px solid rgba(255,255,255,0.1); color:#ffffff;
               border-radius:8px; padding:14px 16px; width:100%; text-align:left;
               font-size:14px; cursor:default;"
            }
            icon_prefix <- if (done && is_correct) "\u2705 "
            else if (done && is_chosen && !is_correct) "\u274c "
            else paste0(LETTERS[oi],". ")
            if (!done) {
              actionButton(paste0("trivia_ans_",oi), paste0(LETTERS[oi],". ",q$opts[[oi]]),
                           style=btn_style)
            } else {
              div(style=btn_style, paste0(icon_prefix, q$opts[[oi]]))
            }
          })
      )
    )
  })
  
  lapply(1:4, function(oi) {
    observeEvent(input[[paste0("trivia_ans_",oi)]], {
      if (trivia_answered()) return()
      q <- trivia_questions[[trivia_idx()]]
      trivia_chosen(oi)
      trivia_answered(TRUE)
      if (oi == q$ans) trivia_score(trivia_score() + 1)
    }, ignoreInit=TRUE)
  })
  
  output$trivia_feedback_ui <- renderUI({
    if (!trivia_answered()) return(NULL)
    idx <- trivia_idx()
    if (idx > length(trivia_questions)) return(NULL)
    q   <- trivia_questions[[idx]]
    ch  <- trivia_chosen()
    correct <- !is.null(ch) && ch == q$ans
    div(style=paste0("border-radius:8px; padding:16px 20px; margin-bottom:12px; ",
                     if(correct) "background:rgba(22,101,52,0.4); border:1px solid #4ade80;"
                     else "background:rgba(127,29,29,0.4); border:1px solid #f87171;"),
        div(style=paste0("font-size:15px; font-weight:800; margin-bottom:6px; ",
                         if(correct)"color:#4ade80;" else "color:#f87171;"),
            if(correct) "\u2705 Correct!" else "\u274c Not quite!"),
        p(style="color:#ffffff; font-size:13px; margin:0; line-height:1.6;",
          paste0("\U0001f4a1 ", q$fact))
    )
  })
  
  output$trivia_next_ui <- renderUI({
    if (!trivia_answered()) return(NULL)
    idx <- trivia_idx()
    n   <- length(trivia_questions)
    label <- if (idx >= n) "See Results \u2192" else "Next Question \u2192"
    actionButton("trivia_next", label,
                 style="background:#FFD700; color:#0a1628; border:none; border-radius:6px;
                        padding:12px 28px; font-size:13px; font-weight:800; cursor:pointer;
                        letter-spacing:1px; text-transform:uppercase;")
  })
  
  observeEvent(input$trivia_next, {
    trivia_idx(trivia_idx() + 1)
    trivia_answered(FALSE)
    trivia_chosen(NULL)
  })
  
  # Navigation observers
  observeEvent(input$nav_to_match, {
    match_map <- list(match1="11",match2="12",match3="13",
                      match4="14",match5="15",match6="16",match7="17")
    if(input$nav_to_match %in% names(match_map))
      updateNavbarPage(session,"tabs",selected=match_map[[input$nav_to_match]])
  })
  
  observeEvent(input$nav_to_transport, {
    updateNavbarPage(session,"tabs",selected="2")
  })
  
}

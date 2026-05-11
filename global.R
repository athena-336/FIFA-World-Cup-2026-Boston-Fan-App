# the necessary packages
library(leaflet)
library(RPostgres)
library(shiny)
library(shinyalert)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)

library(DBI)
library(DT)
library(leaflet)

# connection to the database
# replace with your server credentials
con = dbConnect(
  drv = dbDriver('Postgres'),
  dbname = 'wc4',
  host = 'db-postgresql-nyc1-44203-do-user-8018943-0.b.db.ondigitalocean.com',
  port = 25060,
  user = 'team4',
  password = 'AVNS_iTUm0yApyq51vNSfblY'
)




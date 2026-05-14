# FIFA World Cup 2026 — Boston Fan Experience App

## 🌐 Live Demo

👉 [FIFA World Cup 2026 Fan APP](https://athena336.shinyapps.io/FIFA_WorldCup2026_Fan_APP/)

An interactive R Shiny application that consolidates match schedules, 
ticketing, transportation, lodging, and dining into a single fan 
planning hub for games at Gillette Stadium, Foxborough MA.

Columbia University · APAN 5310 SQL · Group Project

## Problem

1M+ fans attending FIFA World Cup 2026 Boston face fragmented 
information — match schedules, transit routes, and lodging scattered 
across dozens of platforms with no unified planning tool.

## Solution

A centralized ETL pipeline feeds a normalized PostgreSQL database, 
powering a reactive R Shiny dashboard for real-time fan navigation 
and trip planning.

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | R Shiny (renderUI, fluidRow, tabsetPanel) |
| Database | PostgreSQL (3NF, 8 normalized tables) |
| Mapping | Leaflet, Google Maps API |
| Charts | ggplot2 |
| Tables | DT::datatable |
| Reactivity | reactive(), invalidateLater(1000), observeEvent() |

## Database Schema

8 fully normalized tables (3NF):

`matches` · `teams` · `players` · `clubs` · `gillette_restaurants` · 
`stays` · `transport_routes` · `route_segments` · 
`ticket_categories` · `ticket_pricing` · `stadium_sections`

## Features

- **Match Explorer** — 7 match cards with home/away teams, kickoff 
  time, group, round, and live countdown timer (ticks every second)
- **Stadium & Ticketing** — interactive stadium section map with 
  price tiers filterable by round, view quality, and budget
- **Transport Planner** — step-by-step route directions with live 
  Google Maps iframe embed per route
- **Lodging Map** — Leaflet pin map with click-to-detail panel and 
  Google Maps deep-link
- **Dining Filter** — restaurant map filterable by category, 
  distance, and rating
- **Player & Team Explorer** — filter by team/position, ggplot2 
  donut and bar charts, top-scorer spotlight

## Team

| Member | Module |
|---|---|
| Athena Huang | Lodging |
| Zoey Huang | Players & Teams |
| Leanne Chung | Dining |
| Joe Wang | Transportation & Boston Stadium |
| Carolyn Zeng | Matches |
| Sunny Guo | Tickets |

## Course

Columbia University · APAN 5310 · SQL and Relational Databases

## ----setup, message=FALSE, warning=FALSE, include=FALSE-----------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
	warning = FALSE
)


## ----load, echo=FALSE, message=FALSE, warning=FALSE---------------------------
library(devtools)
devtools::load_all()
library(dplyr)
library(tibble)

## ---- eval=FALSE--------------------------------------------------------------
#  library(footprint)
#  library(dplyr)
#  library(tibble)

## ----include=FALSE------------------------------------------------------------
distance_definitions <- data.frame(
  EPA = c("Short-haul", "Medium-haul", "Long-haul"),
  DEFRA = c("Domestic", "Short-haul", "Long-haul"),
  Distance = c("< 483 km", "483 to 3,700 km", "> 3700 km")
) %>%
  rename("DEFRA/`footprint`" = DEFRA)


## ----echo=FALSE---------------------------------------------------------------
distance_definitions %>%
  knitr::kable()

## -----------------------------------------------------------------------------
airport_footprint("LAX", "LHR", "Economy", "co2e")

## -----------------------------------------------------------------------------
airport_footprint("LAX", "ORD", "Economy", "co2e") + 
  airport_footprint("ORD", "LHR", "Economy", "co2e")

## -----------------------------------------------------------------------------
travel_data <- tibble(name = c("Mike", "Will", "Elle"),
                          from = c("LAX", "LGA", "TYS"),
                          to = c("PUS", "LHR", "TPA"))

## ----echo=FALSE---------------------------------------------------------------
travel_data %>% 
  knitr::kable()

## ----eval=FALSE, include=FALSE------------------------------------------------
#  travel_data %>%
#    rowwise() %>%
#    mutate(emissions = airport_footprint(from, to, "Economy", output = "co2"))

## ----echo=FALSE---------------------------------------------------------------
travel_data %>%
  rowwise() %>%
  mutate(emissions = airport_footprint(from, to, "Economy", output = "co2")) %>%
  knitr::kable()

## -----------------------------------------------------------------------------
latlong_footprint(34.052235, -118.243683, 35.179554, 129.075638)

## -----------------------------------------------------------------------------
travel_data2 <- tribble(~name, ~departure_lat, ~departure_long, ~arrival_lat, ~arrival_long,
         # Los Angeles -> Busan
        "Mike", 34.052235, -118.243683, 35.179554, 129.075638,
        # New York -> London
        "Will", 40.712776, -74.005974, 51.52, -0.10)

## ----echo=FALSE---------------------------------------------------------------
travel_data2 %>% knitr::kable()

## ----eval=FALSE, include=TRUE-------------------------------------------------
#  travel_data2 %>%
#    rowwise() %>%
#    mutate(emissions = latlong_footprint(departure_lat,
#                                         departure_long,
#                                         arrival_lat,
#                                         arrival_long))

## ----echo=FALSE---------------------------------------------------------------
travel_data2 %>%
  rowwise() %>%
  mutate(emissions = latlong_footprint(departure_lat,
                                       departure_long,
                                       arrival_lat,
                                       arrival_long)) %>%
  knitr::kable()


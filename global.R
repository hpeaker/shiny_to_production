library(shiny)
library(bslib)
library(dplyr)
library(ggplot2)
library(ggExtra)

source("penguins.R")

penguins_csv <- "https://raw.githubusercontent.com/jcheng5/simplepenguins.R/main/penguins.csv"

df <- readr::read_csv(penguins_csv)
# Find subset of columns that are suitable for scatter plot
df_num <- df |> select(where(is.numeric), -Year)

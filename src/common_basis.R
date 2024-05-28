library(here)
library(tidyverse)
library(googlesheets4)
library(gghsci)
library(hscidbutil)
library(plotly)
library(glue)
library(svglite)
library(gt)
library(googledrive)
library(plotly)

save_plots <- function(dir,basename,plot,width=6,height=5,units="in",dpi=300, include_format="png") {
  ggsave(glue("{dir}/{basename}.png"),plot,width=width,height=height,dpi=dpi, units=units)
  ggsave(glue("{dir}/{basename}.svg"),plot,width=width,height=height,dpi=dpi, units=units)
  ggsave(glue("{dir}/{basename}.pdf"),plot,width=width,height=height,dpi=dpi, units=units, device = cairo_pdf)
  knitr::include_graphics(glue("{dir}/{basename}.{include_format}"), dpi=dpi)
}

if (!exists("con")) con <- get_connection()
register_tables(con, "fbs_analysis")

local({
  temp_tables <- list_temporary_tables(con, "fbs_analysis")
  if (nrow(temp_tables) > 0) warning("The following temporary tables were found in the database. Use delete_temporary_tables() to remove.\n", temp_tables)
})
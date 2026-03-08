
# 00_config.R
# Global configuration for the sc/snRNA-seq analysis project

suppressPackageStartupMessages({
  library(Seurat)
  library(dplyr)
  library(ggplot2)
  library(openxlsx)
})

set.seed(1234)

# Project directories (relative paths recommended)
project_dir <- "."
data_dir <- file.path(project_dir, "data")
meta_dir <- file.path(project_dir, "metadata")
results_dir <- file.path(project_dir, "results")
fig_dir <- file.path(results_dir, "figures")
tab_dir <- file.path(results_dir, "tables")
obj_dir <- file.path(project_dir, "objects")

dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(tab_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(obj_dir, recursive = TRUE, showWarnings = FALSE)

message("Configuration loaded.")


# 05_generate_tables.R
# Export supplementary tables

source("scripts/00_config.R")

validation <- readRDS(file.path(obj_dir, "validation_annotated.rds"))

markers <- FindAllMarkers(validation,
                          only.pos = TRUE,
                          min.pct = 0.25,
                          logfc.threshold = 0.25)

write.xlsx(markers, file.path(tab_dir, "cluster_markers.xlsx"))

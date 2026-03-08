
# 04_generate_figures.R
# Generate manuscript figures

source("scripts/00_config.R")

validation <- readRDS(file.path(obj_dir, "validation_annotated.rds"))

p <- DimPlot(validation, reduction = "umap", group.by = "seurat_clusters")

ggsave(
  filename = file.path(fig_dir, "umap_clusters.pdf"),
  plot = p,
  width = 6,
  height = 5
)

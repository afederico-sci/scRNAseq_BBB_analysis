
# 03_annotation_and_signatures.R
# Apply annotation and gene signature scoring

source("scripts/00_config.R")

validation <- readRDS(file.path(obj_dir, "validation_processed.rds"))
reference <- readRDS(file.path(obj_dir, "reference_processed.rds"))

# Example gene signature
endothelial_genes <- c("PECAM1", "VWF", "KDR")

validation <- AddModuleScore(validation,
                             features = list(endothelial_genes),
                             name = "EndothelialScore")

reference <- AddModuleScore(reference,
                            features = list(endothelial_genes),
                            name = "EndothelialScore")

saveRDS(validation, file.path(obj_dir, "validation_annotated.rds"))
saveRDS(reference, file.path(obj_dir, "reference_annotated.rds"))

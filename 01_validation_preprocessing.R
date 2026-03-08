
# 01_validation_preprocessing.R
# Preprocess the validation snRNA-seq dataset generated in this study

source("scripts/00_config.R")

# Example: load Cell Ranger matrices
sample_dirs <- list.dirs(file.path(data_dir, "validation_dataset"), recursive = FALSE)

seurat_list <- list()

for (s in sample_dirs) {
  sample_name <- basename(s)
  counts <- Read10X(file.path(s, "filtered_feature_bc_matrix"))

  obj <- CreateSeuratObject(
    counts = counts,
    project = sample_name,
    min.cells = 3,
    min.features = 200
  )

  obj$sample_id <- sample_name
  seurat_list[[sample_name]] <- obj
}

# Merge samples
combined <- merge(seurat_list[[1]], y = seurat_list[-1])

# QC metrics
combined[["percent.mito"]] <- PercentageFeatureSet(combined, pattern = "^MT-")

# Filtering example (adjust thresholds to match manuscript)
combined <- subset(combined, subset =
                     nFeature_RNA > 300 &
                     nFeature_RNA < 8000 &
                     percent.mito < 20)

# Normalization and clustering
combined <- SCTransform(combined, verbose = FALSE)
combined <- RunPCA(combined)
combined <- RunUMAP(combined, dims = 1:30)
combined <- FindNeighbors(combined, dims = 1:30)
combined <- FindClusters(combined, resolution = 0.5)

saveRDS(combined, file.path(obj_dir, "validation_processed.rds"))


# 02_reference_dataset_processing.R
# Process the public reference dataset

source("scripts/00_config.R")

# Example loading (modify according to dataset format)
ref_counts <- Read10X(file.path(data_dir, "reference_dataset"))

ref <- CreateSeuratObject(ref_counts, project = "reference")

ref[["percent.mito"]] <- PercentageFeatureSet(ref, pattern = "^MT-")

ref <- subset(ref, subset =
                nFeature_RNA > 300 &
                percent.mito < 20)

ref <- SCTransform(ref, verbose = FALSE)
ref <- RunPCA(ref)
ref <- RunUMAP(ref, dims = 1:30)
ref <- FindNeighbors(ref, dims = 1:30)
ref <- FindClusters(ref, resolution = 0.5)

saveRDS(ref, file.path(obj_dir, "reference_processed.rds"))

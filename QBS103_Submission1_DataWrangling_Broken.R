setwd("~/Desktop/qbs ds/Haoayng_DS_project")
mtx <- read.csv("QBS103_GSE157103_series_matrix.csv", header = TRUE)
genes <- read.csv("QBS103_GSE157103_genes.csv", header = TRUE)
print(head(mtx))
print(head(genes))
genes <- data.frame(genes)

genes_long <- genes %>%
  filter(X=="A1BG") %>%
  gather(key = "participant_id")
genes_long <- genes_long[-1,]
df <- merge(genes_long, mtx, "participant_id")
rownames(df) <- df$Row.names
df_sub <- df[c("value","age","sex","icu_status")]

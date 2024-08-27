library(tidyverse)
library(ggpubr)



myFunction <- function(data,gene,contVar,catVar1,catVar2) {
  data$geneExp <- as.numeric(data$geneExp)
  p1 <- ggplot(data,aes(x = geneExp)) +
    geom_histogram() + labs(x = paste(gene,'Expression (TPKM)')) + theme_classic()
  p2 <- ggplot(data,aes(x = contVar,y = geneExp)) +
    geom_point() + labs(x = paste(contVar),y = paste(gene,'Expression (TPKM)')) +
    theme_classic()
  p3 <- ggplot(data,aes(x = catVar1,y = geneExp,fill = catVar2)) +
    geom_boxplot() + 
    labs(x = paste(catVar1),y = paste(gene,'Expression (TPKM)'),fill = paste(catVar2)) +
    theme_classic() 
  list(p1,p2,p3)
}

geneList <- c("A1BG","AAAS","AAMP")
plotList <- list()
genes <- read.csv("QBS103_GSE157103_genes.csv")
matrix <- read.csv("QBS103_GSE157103_series_matrix.csv")

genes_long <- genes %>%
  filter(X %in% geneList)
genes_long <- t(genes_long)
matrix_selected <- matrix %>% select("participant_id", "age", "icu_status", "sex")

plot_data <- merge(matrix_selected, genes_long, by = "participant_id")
plot_data$value <- as.numeric(as.character(plot_data$value))
plot_data$age <- as.numeric(as.character(plot_data$age))


plot_data <- merge(genes, matrix, by)

for (i in length(geneList)) {
  plotList <- append(plotList,myFunction(df_sub,gene = geneList[i],contVar = 'sex',
                                catVar1 = 'age',catVar2 = 'icu_status'))
}
ggarrange(plotlist = plotList,ncol = 3,nrow = length(geneList), common.legend = T, legend = 'right')





library(GEOquery)

geo_data <- getGEO("GSE108474", GSEMatrix = TRUE)
head(geo_data)
?geo_data

geo_data <- geo_data[[1]]


head(geo_data)
str(geo_data)

expression_data <- exprs(geo_data)
sample_data <- pData(geo_data)
feature_data <- fData(geo_data)


write.csv(expression_data, "C:/Users/Desktop/Tora Project/Datasets/GSE108474_expression_data.csv", row.names = TRUE)

gse_108474 <- GSE108474_expression_data
print(nrow(gse_108474))
print(ncol(gse_108474))


#normalization function
min_max_normalize <- function(x){
  return ((x-min(x))/(max(x) - min(x)))
}

normalized_dataset_108474 <- as.data.frame(lapply(gse_108474[, 2:542], function(x) {
  if(is.numeric(x)) {
    return(min_max_normalize(x))
  } else {
    return(x)
  }
}))

write.csv(normalized_dataset_108474, "C:/Users/Desktop/Tora Project/Datasets/Normalized_GSE108474_expression_data.csv", row.names = FALSE)

n_data_108474 <- Normalized_GSE108474_expression_data
 
ncol(n_data_108474)


first_col <- gse_108474[, 1]

df2 <- cbind(first_col, n_data_108474)
colnames(df2)[1] <- "id"
head(df2)

write.csv(df2, "C:/Users/Desktop/Tora Project/Datasets/Normalized_GSE108474_expression_data_with_ID.csv", row.names = FALSE)

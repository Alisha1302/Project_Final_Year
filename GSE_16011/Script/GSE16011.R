library(GEOquery)

geo_data <- getGEO("GSE16011", GSEMatrix = TRUE)
head(geo_data)
?geo_data

geo_data <- geo_data[[1]]


head(geo_data)
str(geo_data)

expression_data <- exprs(geo_data)
sample_data <- pData(geo_data)
feature_data <- fData(geo_data)


write.csv(expression_data, "C:/Users/Risha/Desktop/Tora Project/Datasets/GSE16011_expression_data.csv", row.names = TRUE)

data_16011 <- GSE16011_expression_data

print(nrow(data_16011))
print(ncol(data_16011))

#normalization function
min_max_normalize <- function(x){
  return ((x-min(x))/(max(x) - min(x)))
}

normalized_dataset_16011 <- as.data.frame(lapply(data_16011[, 2:285], function(x) {
  if(is.numeric(x)) {
    return(min_max_normalize(x))
  } else {
    return(x)
  }
}))

write.csv(normalized_dataset_16011, "C:/Users/Risha/Desktop/Tora Project/Datasets/Normalized_GSE16011_expression_data.csv", row.names = FALSE)

n_data <- Normalized_GSE16011_expression_data

first_col <- data_16011[, 1]

df2 <- cbind(first_col, n_data)
colnames(df2)[1] <- "id"
head(df2)

write.csv(df2, "C:/Users/Risha/Desktop/Tora Project/Datasets/Normalized_GSE16011_expression_data_with_ID.csv", row.names = FALSE)


#k-means centers 
n_data_16011 <- Normalized_GSE16011_expression_data_with_ID

first_col <- n_data_16011[, 1]
main_data_16011 <- data.frame(lapply(n_data_16011[, -1], as.numeric))
main_data_16011 <- na.omit(main_data)


install.packages("clValid")
library(clValid)

set.seed(1234)

km.out <- kmeans(main_data, centers = 4)
print(km.out)
cluster_centers <- km.out$centers
cluster_centers_df <- data.frame(cluster_centers)
cluster_centers_with_strings <- cbind(first_col[1:nrow(cluster_centers_df)], cluster_centers_df)
print(cluster_centers_with_strings)
write.csv(cluster_centers_with_strings, "C:/Users/Risha/Desktop/Tora Project/Datasets/Cluster_Centers_16011.csv", row.names = FALSE)






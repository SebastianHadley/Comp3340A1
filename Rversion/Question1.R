
data = read.csv("USPresidency.csv")
data$Target = NULL


base_matrix <- matrix(nrow = nrow(data), ncol = nrow(data))

print(data[1])
colnames(base_matrix) <- data[,1]
rownames(base_matrix) <- data[,1]
print(base_matrix)

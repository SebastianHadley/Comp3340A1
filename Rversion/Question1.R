

main <- function(){

data = read.csv("USPresidency.csv")
data$Target = NULL


base_matrix <- matrix(nrow = nrow(data), ncol = nrow(data))

colnames(base_matrix) <- data[,1]
rownames(base_matrix) <- data[,1]

data$Year <- NULL
hamming_matrix <- base_matrix
jaccard_matrix <- base_matrix
x <- 1
y <- 1
# print(dist(data, method ="binary"))
while(x < nrow(base_matrix)+1){
    while(y < ncol(base_matrix)+1){

      hamming_matrix[x,y] <-  get_hamming_distance(data[x,],data[y,])
      jaccard_matrix[x,y] <- get_jaccard_distance(data[x,],data[y,])
      
      y = y + 1
    }
  x = x + 1
  y = 1
}
  
 print(jaccard_matrix)


}


get_jaccard_distance <- function(var1,var2){

  intersection = sum(var1 + var2 == 2)
  union = sum(var1 + var2 == 1) + intersection
  (intersection/union)
}
get_hamming_distance <- function(A,B){
  
  return(sum(A != B))
}

main()


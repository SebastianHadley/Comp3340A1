main <- function(){

  # question_1a()
  data = read.csv("USPresidency.csv")
  data$Target = NULL
  data$Year <- NULL
  col_matrix <- matrix(nrow = ncol(data), ncol = ncol(data))

  colnames(col_matrix) <- colnames(data)
  rownames(col_matrix) <- colnames(data)
  hamming_columns <- col_matrix
  jaccard_columns <- col_matrix
  x <- 1
  y <- 1
  # Loops Through calculating the hamming distances and Jaccard Similarities.
  while(x < nrow(col_matrix)+1){
    while(y < ncol(col_matrix)+1){
      
      hamming_columns[x,y] <-  get_hamming_distance(data[,x],data[,y])
      jaccard_columns[x,y] <- get_jaccard_distance(data[,x],data[,y])
      
      y = y + 1
    }
    x = x + 1
    y = 1
  }
  print(hamming_columns)
  print(jaccard_columns)  
  
  
  
  }




# Creates the matrices for question 1a
question_1a <- function(){
  
  data = read.csv("USPresidency.csv")
  data$Target <- NULL
  # Makes empty base matrix to be used for Question1(a)
  base_matrix <- matrix(nrow = nrow(data), ncol = nrow(data))
  
  colnames(base_matrix) <- data[,1]
  rownames(base_matrix) <- data[,1]
  
  data$Year <- NULL
  hamming_matrix <- base_matrix
  jaccard_matrix <- base_matrix
  
  x <- 1
  y <- 1
  # Loops Through calculating the hamming distances and Jaccard Similarities.
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

# Generates jaccard Similarity for a binary rows
get_jaccard_distance <- function(var1,var2){

  intersection = sum(var1 + var2 == 2)
  union = sum(var1 + var2 == 1) + intersection
  (intersection/union)
}

# Generates hamming distance between two rows
get_hamming_distance <- function(A,B){
  
  return(sum(A != B))
}

main()


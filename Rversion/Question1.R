main <- function(){

   question_1a()
  
  
  }




# Creates the matrices for question 1a
question_1a <- function(){
  
  data = read.csv("USPresidency.csv")
  data$Target <- NULL
  # Makes empty base matrix to be used for Question1(a)
  base_matrix <- matrix(nrow = nrow(data), ncol = nrow(data))
  
  #Assigns the Years as the Names of the columns and rows of the Base Matrix.
  colnames(base_matrix) <- data[,1]
  rownames(base_matrix) <- data[,1]
  
  data$Year <- NULL
  
  #Deep Copies the base matrix into the two result matrixs.
  #Note a deep copy is a new matrix populated with the same values rather then a matrix that refers to the same memory.

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
  #Just for Debugging
  print(jaccard_matrix)
  print(hamming_matrix)
  
}

question_1b <- function()
{
  
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

# Generates jaccard Similarity for a binary rows
get_jaccard_distance <- function(var1,var2){
  #The sum of the pairs of attributes that are both equal to 1; Amount of times both years have 1/true for the same attribute.
  intersection = sum(var1 + var2 == 2)
  #The number of times in which only one of the years value is 1 + the intersection.
  union = sum(var1 + var2 == 1) + intersection
  (intersection/union)
}

# Generates hamming distance between two rows
get_hamming_distance <- function(A,B){
  
  return(sum(A != B))
}

main()


# install.packages('rgexf')
# install.packages('BNSL')
# install.packages('igraph')
# install.packages('XGR')
  # install.packages('multiplex')
# install.packages('cccd')
main <- function(){
   #Dont know if we need these or nah
  library('multiplex')
   # library('rgexf')
   library('cccd')
   library('BNSL')
   library('igraph')
  question_1c()
   
  }


question_1c <- function ()
{
  qa = rowMatrixes()
  qb = columnMatrixs()
  
  #uses the list returned by the functions to get the four matrixes for the jaccard distance and hamming distance.
  ham_rows = qa[[1]]
  ham_columns =qb[[1]]
  jaccard_rows = qa[[2]]
  jaccard_columns = qb[[2]]
  #prints the results needed for question 1 and two
  # write.csv(ham_rows,"hamming_question1a.csv")
  # write.csv(ham_rows,"jaccard_question1a.csv")
  # write.csv(ham_rows,"hamming_question1b.csv")
  # write.csv(ham_rows,"jaccard_question1b.csv")
  
  
  ham_years <- graph_from_adjacency_matrix(ham_rows,mode = 'undirected', weighted = TRUE)
  ham_attributes <- graph_from_adjacency_matrix(ham_columns,mode = 'undirected', weighted = TRUE)
  jaccard_years <- graph_from_adjacency_matrix(jaccard_rows,mode = 'undirected', weighted = TRUE)
  jaccard_attributes <- graph_from_adjacency_matrix(jaccard_columns,mode = 'undirected', weighted = TRUE)
  
  #Sets the labels which is what Yed uses
  V(ham_years)$label <- colnames(ham_rows)
  V(ham_attributes)$label <- colnames(ham_columns)
  print(ham_columns)
  V(jaccard_years)$label <- colnames(jaccard_rows)
  V(jaccard_attributes)$label <- colnames(jaccard_columns)
  E(ham_years)$label <- E(ham_years)$weight
  E(ham_attributes)$label <- E(ham_attributes)$weight
  E(jaccard_years)$label <- E(jaccard_years)$weight
  E(jaccard_attributes)$label <- E(jaccard_attributes)$weight
  print(ham_columns)
  plot(ham_attributes)

    #use something about
  write_graph((mst(ham_years)),'hamming_years.gml',format = "gml")
  write_graph(mst(ham_attributes),'hamming_attributes.gml',format = "gml")
  write_graph(mst(jaccard_years),'jaccard_years.gml',format = "gml")
  write_graph(mst(jaccard_attributes),'jaccard_attributes.gml',format = "gml")
  plot(mst(ham_years))
  plot(mst(jaccard_years))
  plot(mst(ham_attributes))
  plot(mst(jaccard_attributes))
  relative_neighbourhood(ham_rows,jaccard_rows)
  relative_neighbourhood(ham_columns,jaccard_columns)
  nearest_neighbour(ham_rows, jaccard_rows)

}

#used to generate a smaller version of the matrix so you can test it at a more manageable size.
test_small <- function(matrix){
  
  testmatrix = matrix(nrow=8,ncol = 8)
  i = 1
  b = 1
  while(i < 9){
    while(b < 9)
    {
      testmatrix[i,b] <- matrix[i,b]
      b = b + 1
    }
    i = i + 1 
    b = 1
    testmatrix
  }
}
# Creates the matrices for question 1a
rowMatrixes <- function(){
  
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
  g <- list(hamming_matrix,jaccard_matrix)
  
}
relative_neighbourhood <- function(ham,jaccard){
  hamedge <- as.matrix((rng(x = ham, algorithm = 'kd_tree',open = FALSE)),matrix.type = 'edgelist')
  jaccardedge <- as.matrix((rng(x = jaccard, algorithm = 'kd_tree',open = FALSE)),matrix.type = 'edgelist')
  ham_graph <- graph_from_edgelist(hamedge,directed = FALSE)
  jaccard_graph <- graph_from_edgelist(jaccardedge,directed = FALSE)
  
  V(ham_graph)$label <- colnames(ham)
  V(jaccard_graph)$label <- colnames(jaccard)
  # E(ham_graph)$label <- E(ham_graph)$weight
  # E(jaccard_graph)$label <- E(jaccard_graph)$weight
  plot(ham_graph)
  plot(jaccard_graph)
}

nearest_neighbour <- function(ham,jaccard)
{
  
  graph <- nng(x = ham, k = 2,algorithm='cover_tree')
  jac <- nng(x = jaccard, k = 2,algorithm='cover_tree')
  plot(graph)
  plot(jac)
}

columnMatrixs <- function()
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
  g <- list(hamming_columns,jaccard_columns)
  
}

# Generates jaccard Similarity for a binary rows
get_jaccard_distance <- function(var1,var2){
  #The sum of the pairs of attributes that are both equal to 1; Amount of times both years have 1/true for the same attribute.
  intersection = sum(var1 + var2 == 2)
  #The number of times in which only one of the years value is 1 + the intersection.
  union = sum(var1 + var2 == 1) + intersection
  1 - (intersection/union)
}

# Generates hamming distance between two rows
get_hamming_distance <- function(A,B){
  
  return(sum(A != B))
}

main()


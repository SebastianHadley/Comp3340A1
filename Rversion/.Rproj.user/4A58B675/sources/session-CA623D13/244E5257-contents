
usp <- read.csv("USPresidency.csv", sep=",")
print(usp)

usp$Target = NULL
print(usp)

#Q1)
 
# Hamming Distance Matrix

ham_mat <- matrix(nrow = 31, ncol = 31)

year <- usp[ ,1]
#len <- 961
#empty_list <- vector(mode = "list", length = len)

counter = 1


# calculates all hamming distance values row by row whilst inserting these values into matrix variable
for (x in 1:length(year)){
  for (i in 1:length(year)){
    ham_mat[i,x] <- sum(usp[x,c(2,3,4,5,6,7,8,9,10,11,12,13)] != usp[i,c(2,3,4,5,6,7,8,9,10,11,12,13)])
    #counter = counter+1
    #print(counter)
    
  }
  
}

print(ham_mat)


 



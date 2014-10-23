## Functions for caching the inverse of a matrix rather than compute it repeatedly

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  
  ## initialize i
  i <- NULL
  ## set matrix
  set <- function(matrix) {
    m <<- matrix
    i <<- NULL
  }
  ## get matrix
  get <- function() {
    m
  }
  ## set inverse
  setInverse <- function(inverse) {
    i <<- inverse
  }
  ## get inverse
  getInverse <- function() {
    i
  }

  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then the cachesolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getInverse()
  ## check if m is not empty and return
  if( !is.null(m) ) {
    message("getting cached data")
    return(m)
  }
  ## get matrix
  data <- x$get()
  ## compute inverse
  m <- solve(data) %*% data
  ## set inverse
  x$setInverse(m)
  ## return matrix
  m
}

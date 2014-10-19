# 1. Distributed File Systems

## 1.1 Problems
Persistant availability if nodes fail
Network bottlenecks
Distributed programming is complex

## 1.2 Examples
Google GFS, Hadoop HDFS

## 1.3 Functionality
Data kept in spread "chunks" and replicated through multiple machines
Chunk servers also act as compute servers (avoid data movement)
File is split into contiguous chunk (16-64mb) and is replicated 2-3x
Master node stores metadata about where the files are stored
Client talks to master to find chunks and then directly talks to chunk servers

# 2. Map-Reduce Computational Model

Map and Reduce tasks can be specified by the developer

## 2.1 Map
Scan input file record-at-a-time
Extract something your care about from each record (key)

## 2.2 Group by key
Sort and shuffle

## 2.3 Reduce
Apply a reduce step (Aggregate, summarises, filter or transform) and write results

The reads are sequential reads (not random access) why it's very efficient

# 3. Scheduling and Data Flow

## 3.1 Scheduling
All phases are distributes with many tasks doing the work in parallel
M.R. takes care of partitioning, scheduling, group by key, failures and whole communication

## 3.2 Data Flow
Input and final output are stores on the distributed file system
Scheduler tries to schedule map tasks close to physical storage of input
Intermediate results are stored on local FS of Map and Reduce workers
Output is often input to another tasks

Master node takes care of coordination such as task status and idle tasks

If a map-worker fails the worker is reset to idle and the tasks eventually needs to be reschedules on other workers

Rules of thumb
A. Make m much larger than number of nodes
B. One DFS chunk per map is common
C. Improve dynamic load balancing and speed up recovery from worker failures

# 4. Combiners and Partition Functions

## 4.1 Combiners

## 4.2 Partition Functions

# 5.  Link analysis & Page rank

Graph data

# 6. Applications of Set-Similarities

Pages with similar words (classification)

Users with similar tastes by recommendation or consumption

Content with similar set of users

## Similar documents

Mirror sites (search engines shouldn't show all)

Plagiarism

Cluster article by "same story" (Google news)

## Three techniques for similar documents

1. Shingling (convert documents, emails etc. to sets)
2. Minhashing (convert large sets to short signatures, while preserving similarity)
3. Locality-sensitive hasing - LSH (focus on pairs of signatures like to be similar)

### Shingling

The set of strings of length k that appear in the documents

A k-single for a document is a sequence of k characeters that appears in a the document

Example: k=2; doc = abcab. Set of 2-shingles = {ab, bc, ca}

Represent a doc by its set of k-shingles

Documents that are intuitively similar will have many shingles in common

Chaning a word only affects k-shingles withing distance k from the word

Reordering paragraphs only affects the 2k shingles that cross paragraph boundaries

Example: k=3, "The dog which chased the cat" vs. "The dog that chased the cat"

* Only 3-shingles replaces are g_w, _wh, whi, hic, ich, ch_ and h_c

#### Compression Option

To compress long shingles, we can hash them to 4 bytes

* Called tokens

Represent a doc by its tokens, that is, the set of hash values of its k-shingles

Two documents could (rarely) appear to have shingles in common, when in fact only the has-values were shared

### Minhashing

Signatures: short integer vectors that represent the sets, and reflect their similarity

Imagine the rows permuted randomly

Define minhash function h(C) = the number of the first (in the permuted order) row in which column C has 1

Use several (e.g., 100) independant hash functions to create a signature for each column

The signatures can be displayed in another matrix - the signature matrix - whose columns represent the sets and the rows represent the minhash values, in order for that column

#### Jaccard Similarity Measure

The Jaccard similarity of two sets is the size of their intersection divided by the size of their union.

Example: If A has 3 items and B has 2 items and they have 4 in common it would be = 4/5

#### Constructing Signatures

Signatures take much less space

#### Similarity of Singatures

The similarity of signitures is the fraction of the minhash functions in which they agree

* Thinking of signitures as columns of integers, the similarity of signatures is the fraction of rows in which they agree

Thus, the expected similarity of two signatures equals the Jaccard similarity of the columns or sets that the signatures represent

* And the longer the signatures, the smaller will be the expected error

### LSH

Candidate pairs: Those pairs of signatures that we need to test for similarity (test only a small subset to reduce time spent)

General idea: Generate from the collection of all elements (signatures in our example) a small list of candidate pairs: pairs of elements whose similarity must be evaluated

For signature matrices: Hash columns to many buckets, and make elements of the same bucket candidate pairs

#### Entity resolution

The entity-resolution problem is to examine a collection of records and determine which refer to the same entity

* Entities could be people, events, etc.

Typicall, we want to merge records if their values in corresponding fields are similar

#### Fingerprint matching

Represent a fingerprint by the set of positions of minutiae

* These are features of a fingerprint, e.g., points where two ridges come together or a ridge ends.

Place a grid on a fingerprint

* Normalize so identical prints will overlap

Set of grid squares where minutiae are located represent the fingerprint

Possibly, treat minutiae near a grid boundary as if also present in adjacent grid points

No need to minhash, since the number of grid squares is not too large

Represent each fingerprint by a bit-vector with one position for each square

# 7. Large scale machine learning

## Supervised learning

Would like to do prediction: estimate a function f(x) so that y = f(x)

Where y can be:
Real number: Regression
Cateforical: Classification

Data is labeled
* Have many pairs {(x, y)}
** x... vector of binary, categorical, real valued features
** y... class ({+1,-1}, or a real number)

Data will come in feature matrix

Training and test set

## Machine learning methods

k-Nearest Neighbor (Instance based learning)

Support Vector Machines

Decision trees

**Main question:** How to efficiently train (build a model/find model parameters)

### Instance based learning

Example: Nearast neighbor

* Keep the whole training dataset: {(x,y)}

* A query example (vector) q comes

* Find closest examples(s) x

* Predict y

Works both for regression and classification

* Collaborative filtering is an example of k-NN classifier

** Find k most similar people to user x that have rated the content y
** Predict rating yx of x as an average of yk

#### 1-Nearest Neighbor

To make Nearest Neighbor work we need 4 things:

* Distance metric
* How many neighbors to look at?
* Weighting function (optional)
* How to fit with the local points?

# 8. Frequent Itemsets

## The Market-Basket Model

A large set of items, e.g. things sold in a supermarket

A large set of baskets, each of which is a small set of the items, e.g., the things one customer buys on one day

Simplest question: find sets of items that appear "frequently" in the baskets

Support for itemset / = the number of baskets containing all items in /
* Sometimes given as a percentage

Given a support threshold s, sets of items that appear in at least s baskets are called frequent itemssets

### Application

#### Example 1

Items = products; baskets = sets of products someone bought in one trip to the store

Example application: given that many people buy beet and diapers together
* Run a sales on diapers; raise price of beer

It's very hard to deduce causality from data

Only useful if many buy diapers & beer
* Essential for brick-and-mortar stores, not online stores

#### Example 2

Basket = sentences; items = documents containing those sentences

Items that appear together too often could represent plagiarism

Notice items do not have to be "in" baskets
* But it is better if baskets have small number of items, while items can be in large numbers of baskets

#### Example 3

Baskets = documents; items = words

Unusual words appearing together in a large number of documents, e.g. "Brad" and "Angelina" may indicate an interesting relationship

## Association Rules

If-then rules about the contents of baskets

"If a basket contains all of i1...ik then its likely to contain j"

Confindence of this association rule is the probability of j given i1...ik

* That is, the fraction of the basket with i1...ik that also contain j

### Computation Model

Typically, data is kept in flat files

Stored on disk

Stored basket-by-basket

Expand basket into pairs, triples, etc. as you read basket

* Use k nested loops to generate all sets of size k

### File Organization

Items are integers, basket separator might be -1

The true cost of mining disk-resident data is usually the number disk I/O's

In practice, algorithms for finding frequent itemsets read the data in passes - all basket read in turn

Thus, we measure the cost by the number passes an algorithm takes

### Main-Memory Bottleneck

For many frequent-itemset algorithms, main memory is the critical resource

As we read baskets, we need to count something, e.g. occurrences of pairs

The number of different things we can count is limited by main memory

Swapping counts in/out is a disaster

### Finding Frequent Pairs

The hardest problem often turns out to be finding the frequent pairs

* Why? Often frequent pairs are common, frequent triples are rare

** Why? Support threshold is usually set high enough that you don't get too many frequent itemsets

We'll concentrate on pairs, then extend to larger sets

## Naive Algorithm

Read file once, couting in main memory the occurrences of each pair

* From each basket of n items, generate its n(n-1)/2 pairs by two nested loops

Fails if (#items)2 exceeds main memory

* Remember: #items can be 100k (walmart) or 100B (web data)

## A-Priori Algorithm

A two-pass approach called a-priori limits the needs for main memory

Key idea: monotonicity: if a set of items appears at least s times, so does every subset of s

Contrapositive for pairs: if them i does not appear in s basket, then no pair including i can appear in s baskets

### Monotonicity of "Frequent"

### Candidate Pairs

### Extension to Larger Itemsets



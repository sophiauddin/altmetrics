## Reading in and examining data
counts_raw = read.delim("data/counts-raw.txt.gz") #reads in data
dim(counts_raw) #shows num of rows and cols
head(counts_raw) #shows first few lines of every col
tail(counts_raw) #shows last several lines of every col
counts_raw[1, 10] #indexing in R uses square brackets
counts_raw[1:3, 10:12] #slicing (first 3 rows, 10th - 12th cols)
counts_raw[1:3, ] #shorthand for "first 3 rows, ALL columns"
counts_raw[1:10, "pmid"] #can reference by column names!! very helpful
str(counts_raw$daysSincePublished) #structure command; $ references columns
#Displays 1) data type (int=integer), 2) length (24331), and 3) first several values
head(counts_raw$daysSincePublished / 7) #look at weeks since published; this works because R is vectorized
head(counts_raw$daysSincePublished / c(7,1)) #divides odd and even elements by different things
#be careful of vector division; it recycles values!
is.numeric(counts_raw$daysSincePublished) #is this numeric? gives true or false

#In R, factors are used to handle categorical information

str(counts_raw$journal) #this is a factor
levels(counts_raw$journal) #shows you the categories in the factor
#NB: R stores these as numbers so the first level will be stored as 1, the next as 2, etc.

#Default when reading in data w/ character strings is to store as factors because it saves memory

#stringsasfactors=FALSE when reading in data will keep them as strings

as.factor() #re-stores things as factors rather than strings


#How to deal with missing values
counts_raw$authorsCount[1:10] #missing vals stored as NA
is.na(counts_raw$authorsCount[1:10]) #find missing data in data frame; NA is NOT a character string
#Careful: if encountering errors look for missing data! Some R functions don't deal well with NA
anyNA(counts_raw$authorsCount[1:10]) #is there missing data in here at all?

#Looking at a summary of your data
summary(counts_raw$wosCountThru2011) #shows min, max, mean, and quartiles
mean(counts_raw$wosCountThru2011) #mean is built in
median() #median is built in too
sd() #standard dev
hist(counts_raw$wosCountThru2011) #histogram of citation counts
#It's easy to chain commands together in R:
hist(sqrt(counts_raw$wosCountThru2011)) #histogram of sqrt of citation counts
plot(counts_raw$daysSincePublished, counts_raw$wosCountThru2011) #simple scatterplot

## Conditional statements (useful for filtering stuff out of data)
counts_raw$authorsCount[1:10] > 7 #Which papers of the first 10 have more than 7 authors?
#Greater than or equal: >=
#Equal to: == (= is assignment operator)
#Not equal: !=

#How many articles were in PlosONE?
dim(counts_raw[counts_raw$journal == "pone", ]) #"logical indexing"; middle statement returns TRUE for any row where PlosONE is the journal
#then we are indexing counts_raw by which rows have a TRUE for journal = PlosONE
dim(counts_raw[counts_raw$journal != "pone", ]) #How many articles are NOT in PlosONE?

#Is it equal to any of these things?
dim(counts_raw[counts_raw$journal %in% c("pone", "pbio", "pgen"), ])
#Returns papers in PlosONE, PlosBio, or PlosGenetics

#The grep function: is the word "immunology" in any of these?
dim(counts_raw[grepl("Immunology", counts_raw$plosSubjectTags), ]) #grepl returns TRUE if it sees immunology
#First argument for grepl = the word to look for
#2nd argument is where to look (here, subject tag)
#grep is pattern matching; it will return partial matches e.g. grepping "plos" will 
#return PlosOne, PlosGenetics, etc.
#Can't use =="Immunology" because the subject tags are very complex and seldom ONLY include "Immunology"

#If statements
#Careful of bracket structure
if (anyNA(counts_raw$authorsCount)) {  #if what's in the () is TRUE, it will run
  print("Be careful!")
 } else {
      print("Looking good!")
 }
if (anyNA(c(1,1,1))) {  #if what's in the () is TRUE, it will run
  print("Be careful!")
} else {
  print("Looking good!")
}


##For loops in R
for(i in 1:10) {
  print(i)
}

#Doesn't have to be numeric
for(i in c("cat","dog","mouse")) {
  print(i)
}

#Doesn't have to be related to i:
for(i in c("cat","dog","mouse")) {
  print("Tacos?")
}

#Why are loops in R slow? Easy fixes:

x=numeric()
for (i in 1:length(counts_raw$wosCountThru2011)) {
  x=c(x, counts_raw$wosCountThru2011[i] +1)
}
#Vector grows each time you loop thru and just consists of citation counts
#Adding onto vectors = SLOW!
#Set length first
x=numeric(length=length(counts_raw$wosCountThru2011))
for (i in 1:length(counts_raw$wosCountThru2011)) {
  x[i]=counts_raw$wosCountThru2011[i] +1
}

#How many journals in our dataset?
levels(counts_raw$journal)

#Avg number of citations for each of these?
results=numeric(length=length(levels(counts_raw$journal)))

#THiS is cool! You can name the entries in a vector:
names(results)=levels(counts_raw$journal)
results
#Now you can use these names to index your vector
results["pone"]

#Calculate the mean for every journal
  #Iterate over each level of the journal (plos one, etc.)
for (j in levels(counts_raw$journal)) {
  results[j]=mean(counts_raw$wosCountThru2011[counts_raw$journal == j])
  #loops thru journals (j) to give mean of citation counts for that one
  #indexes on column: looking one journal at a time
}
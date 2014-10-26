library(caret)

#read training data set
trainall<-read.csv("pml-training.csv",stringsAsFactors=FALSE)
#row number (X) and user_name are irrelevant for training
trainall<-trainall[,-(1:2)]
#classe to be a factor
trainall$classe<-factor(trainall$classe)

#do the same operations for predicting data set
test<-read.csv("pml-testing.csv",stringsAsFactors=FALSE)
#row number (X) and user_name are irrelevant for training
test<-test[,-(1:2)]
#there is no classe column in the "testing" data set (predicting), so no factorization needed

#split the training data to train and test sets
set.seed(230570)
inTrain = createDataPartition(trainall$classe, p = 3/4, list=FALSE)
training = trainall[inTrain,]
testing = trainall[-inTrain,]

#check if we have some NAs in Y
stopifnot(complete.cases(training$classe))

#select only the columns, where are no NAs
oktrain<-training[,!sapply(training,function(x) any(is.na(x)))]
okcols<-colnames(oktrain)

stopifnot(complete.cases(oktrain))


#train the model of random forest with all defaults
set.seed(232323)
mod<-train(classe ~ ., data=oktrain, method="rf")



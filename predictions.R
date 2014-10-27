#rm(list=ls())
library(caret)

#read training data set
trainall<-read.csv("pml-training.csv",stringsAsFactors=FALSE)
#row number (X) and user_name are irrelevant for training
trainall<-trainall[,-(1:5)]
#classe to be a factor
trainall$classe<-factor(trainall$classe)

#do the same operations for predicting data set
test<-read.csv("pml-testing.csv",stringsAsFactors=FALSE)
#row number (X) and user_name are irrelevant for training
test<-test[,-(1:5)]
#there is no classe column in the "testing" data set (predicting), so no factorization needed

#split the training data to train and test sets
set.seed(230570)
inTrain = createDataPartition(trainall$classe, p = 3/4, list=FALSE)
training = trainall[inTrain,]
testing = trainall[-inTrain,]

#check if we have some NAs in Y
stopifnot(complete.cases(training$classe))

#select only the columns, where are no NAs and non-character cols
oktrain<-training[,!sapply(training,function(x) any(is.na(x)))]
oktrain<-oktrain[,!sapply(oktrain,is.character)]
okcols<-colnames(oktrain)

#use the same columns for testing data set, for validation
oktest<-testing[,okcols]

#use the same columns for the predicting data set (pml-testing.csv)
okPredictcols<-okcols[-grep("classe",okcols)]
okPredict<-test[,okPredictcols]


#check if there are not some undefined cases
stopifnot(complete.cases(oktrain))
stopifnot(complete.cases(oktest))
stopifnot(complete.cases(okPredict))


#train the model of random forest with all defaults
set.seed(232323)
mod<-train(classe ~ ., data=oktest)

#find the Accuracy of the predictor on Train data
predTrain<-predict(mod,oktrain)
confusionMatrix(predTrain,oktrain$classe)

#predict Testing data to get accuracy on test data set
predTest<-predict(mod,oktest)
confusionMatrix(predTest,oktest$classe)

#finally predict the data wanted 20 cases (I call it predicting data set)
predPredict<-predict(mod,okPredict)

#predPredict is a vector for submission

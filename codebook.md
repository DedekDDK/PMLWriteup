Codebook
====================
Welcome to the codebook for Machine Learning Excercise I created during the Coursera project.

###Data
The source data came from http://groupware.les.inf.puc-rio.br/har site and contains various measurements when couple
of people were lifting weights and were doing these excersices either properly (classe=A) or with common mistakes (classe=B ..)

###Data preparation & Analysis
Before processing the data, data from the file pml-training.csv were stripped of the line number and name of the lifter, as 
ther are not relevant for the predictions.
Classe (resulting factor variable) was converted to a factor.

This "training" dataset was split into real train and test datasets, with p=3/4.
All columns containing NAs were removed, as well as other character vectors, containing lot of time Div/0 or nothing. Resulting number of columns in the training set was 54 (incl. classe).

Using train function, the prediction model was calculated, using defaults - Random Forest option, with default bootstrapping (25 reps) for cross-validation, to select best prediction model.
Accuracy of the predictor model is 0.996, Kappa 0.995

Accuracy of the predictor on Training data is: 1.0
Accurace of the predictor on Testing data is: 0.9969

Resulting predictor was used to predict data in the file pml-testing.csv, which was provided without classe value.
These predicted values are to be submitted in the form of 20 separate files, according the result vector.

Resulting vector was used to generate 20 files for submission and all were correct.
(as expected with the Accuracy of 0.9969 on testing data set)

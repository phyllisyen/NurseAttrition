
##____________ Cardiac Unit dataset _____________

data <- fread("HDHI Admission data.csv")
#Dropping irrelevant columns and records
data[,c(1:4,9,12,15,20:29,31:33,36:56):= NULL]
data= data[(RURAL == 'U')]
data[,RURAL:=NULL]

#Looking for missing values and outliers
summary(data)
summary(factor(data$GENDER))
summary(factor(data$ADMISSION_TYPE))

#factoring categorical variables
data$GENDER <- factor(data$GENDER)
data$ADMISSION_TYPE <- factor(data$ADMISSION_TYPE)
data$SMOKING <- factor(data$SMOKING)
data$ALCOHOL <- factor(data$ALCOHOL)
data$HTN <- factor(data$HTN)
data$CAD <- factor(data$CAD)
data$`PRIOR CMP` <- factor(data$`PRIOR CMP`)
data$CKD <- factor(data$CKD)
data$ANAEMIA <- factor(data$ANAEMIA)
data$`ATYPICAL CHEST PAIN` <- factor(data$`ATYPICAL CHEST PAIN`)
data$`HEART FAILURE` <- factor(data$`HEART FAILURE`)
summary(data)

#creating INTENSIVE column
data[,INTENSIVE := ifelse(DURATION_IU == 0,0,1)]
data$INTENSIVE <- factor(data$INTENSIVE)
summary(data)

#Export dataframe into csv file
names(data)[names(data) == 'Data Series'] <- 'HDHI Admission data'
write.csv(nurse.dt, "HDHI Admission data (cleaned).csv")

#age distribution
ggplot(data,aes(x=AGE))+geom_histogram(binwidth = 5,fill="blue",colour="black")+labs(x = "Age", y = "Number of patients admitted", title = "Age distribution of cardiac patients")
summary(data$AGE)

#Length of stay
ggplot(data,aes(x=`DURATION OF STAY`, y = ADMISSION_TYPE))+geom_boxplot()+labs(title = "Length of Stay")
summary(data[ADMISSION_TYPE == 'O',`DURATION OF STAY`])
summary(data[ADMISSION_TYPE == 'E',`DURATION OF STAY`])

#Common medical conditions
summary(data[,8:14])
slices <- summary(data$HTN)
pie(slices,labels = paste(c("No", "Yes"), round(slices/sum(slices)*100, digits = 2)), col=cm.colors(2),main = "Patients with Hypertension")
slices <- summary(data$CAD)
pie(slices,labels = paste(c("No", "Yes"), round(slices/sum(slices)*100, digits = 2)), col=cm.colors(2),main = "Patients with Prior CAD")

#CART
#Standardize result with setseed
set.seed(5)

#for rpart, do not consider duration_IU, since intensive column is base on that
data.cart1 <- rpart(INTENSIVE~ .-DURATION_IU, data = data, method = 'class', control = rpart.control(minsplit = 2, cp = 0))
printcp(data.cart1)

#Display the pruning sequence and 10-fold CV errors, as a chart.
plotcp(data.cart1, main = "Subtrees for HDHI.csv")

#Find CP
cp1 <- sqrt(2.0823e-03*6.9678e-03)

cp1

#Prune and plot the tree
data2 <- prune(data.cart1, cp=cp1)
rpart.plot(data2, nn=T, main ="Pruned tree with cp=0.003809075")

printcp(data2)
print(data2)

## --- Trainset Error & CV Error --------------------------
## Root node error: 2081/12077 = 0.17231
## data2 trainset Misclassification Error = 0.0069678*0.17231 = 0.001200621618
## data2 CV Misclassification Error = 0.68044*0.17231 = 0.1172466164

data2$variable.importance

summary(data2)


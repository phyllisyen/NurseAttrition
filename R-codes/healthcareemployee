
##____________ Employee dataset _____________
employee.dt <- fread('/Users/phyllisyen/Desktop/BC2406 ANALYTICS 1/Project/healthcare_employee.csv')
View(employee.dt)
# subsetting [JobRole] == "Nurse" and [Department] == "Cardiology"
nurse.dt <- employee.dt[c(JobRole == 'Nurse' & Department == 'Cardiology')]

# dropping columns
nurse.dt <- nurse.dt[, ! c("JobRole", "Over18", "StandardHours","EmployeeID", "EmployeeCount","MonthlyRate", "DailyRate", "HourlyRate", "Department")]
View(nurse.dt)
str(nurse.dt)
anyNA(nurse.dt)

# factor nominal variables
nurse.dt$Attrition <- factor(nurse.dt$Attrition)
nurse.dt$BusinessTravel <- factor(nurse.dt$BusinessTravel)
nurse.dt$EducationField <- factor(nurse.dt$EducationField)
nurse.dt$Gender <- factor(nurse.dt$Gender)
nurse.dt$BusinessTravel <- factor(nurse.dt$BusinessTravel)
nurse.dt$MaritalStatus <- factor(nurse.dt$MaritalStatus)
nurse.dt$OverTime <- factor(nurse.dt$OverTime)
nurse.dt$Shift <- factor(nurse.dt$Shift)

#factor ordinal variables
nurse.dt$EnvironmentSatisfaction <- factor(nurse.dt$EnvironmentSatisfaction, ordered= T, levels = c(1,2,3,4))
nurse.dt$JobInvolvement <- factor(nurse.dt$JobInvolvement, ordered= T, levels = c(1,2,3,4))
nurse.dt$JobSatisfaction <- factor(nurse.dt$JobSatisfaction, ordered= T, levels = c(1,2,3,4))
nurse.dt$RelationshipSatisfaction <- factor(nurse.dt$RelationshipSatisfaction, ordered= T, levels = c(1,2,3,4))
nurse.dt$PerformanceRating <- factor(nurse.dt$PerformanceRating, ordered= T, levels = c(1,2,3,4))
nurse.dt$WorkLifeBalance <- factor(nurse.dt$WorkLifeBalance, ordered= T, levels = c(1,2,3,4))
nurse.dt$Education <- factor(nurse.dt$Education, ordered= T, levels = c(1,2,3,4,5))
nurse.dt$JobLevel <- factor(nurse.dt$JobLevel, ordered= T, levels = c(1,2,3,4,5))


# DATA EXPLORATION
nurse.dt[, .N] 
nrow(nurse.dt[Attrition == "Yes"])
42/357 

# ggplot for appendix
ggplot(nurse.dt, aes(x=DistanceFromHome, y = Attrition)) + geom_boxplot() + labs(title = "Boxplot of Distance From Home with Attrition")
x <- nurse.dt[Attrition == "Yes"]
y <- nurse.dt[Attrition == "No"]
median(x$DistanceFromHome)
median(y$DistanceFromHome)

ggplot(nurse.dt, aes(x=TotalWorkingYears, y = Attrition)) + geom_boxplot() + labs(title = "Boxplot of Total Working Years with Attrition")
median(x$TotalWorkingYears)
median(y$TotalWorkingYears)


ggplot(nurse.dt, aes(x = JobInvolvement, fill=Attrition)) + geom_bar(position="fill")  + labs(title = "Level of Job Involvement and Attrition", y = "Percentage of Nurses")
                                                        
ggplot(nurse.dt, aes(x = OverTime, fill=Attrition)) + geom_bar(position="fill")  + labs(title = "Overtime and Attrition", y="Percentage of Nurses") 

ggplot(nurse.dt, aes(x = factor(NumCompaniesWorked), fill=Attrition)) + geom_bar(position="fill")  + labs(title = "Number of Hospitals Worked and Attrition", y="Percentage of Nurses", x = "No. of Hospitals Worked") 

ggplot(nurse.dt, aes(x = JobSatisfaction, fill=Attrition)) + geom_bar(position="fill")  + labs(title = "Level of Job Satisfaction and Attrition", y = "Percentage of Nurses")

ggplot(nurse.dt, aes(x = Shift, fill=Attrition)) + geom_bar(position="fill")  + labs(title = "Shift Worked and Attrition", y = "Percentage of Nurses")

# doing backward regression
fitsall <- glm(Attrition ~ Age + BusinessTravel + DistanceFromHome + Gender + JobInvolvement + JobSatisfaction + MonthlyIncome + NumCompaniesWorked + OverTime + PercentSalaryHike + PerformanceRating + RelationshipSatisfaction + Shift + TotalWorkingYears + TrainingTimesLastYear + WorkLifeBalance + YearsAtCompany + YearsSinceLastPromotion + YearsWithCurrManager, data = nurse.dt, family = "binomial") 
fitsall <- glm(Attrition ~ . -Education -EducationField -EnvironmentSatisfaction -JobLevel -YearsInCurrentRole -MaritalStatus ,  data = nurse.dt, family = "binomial")

# checking multicollinearity
fitsallStep <- step(fitsall)
vif(fitsallStep)

# identifying significant variables
m1 <- glm(Attrition ~ Age + BusinessTravel + DistanceFromHome + TotalWorkingYears + WorkLifeBalance + NumCompaniesWorked + JobInvolvement + JobSatisfaction + Shift + DistanceFromHome + OverTime,  data = nurse.dt, family = "binomial")
summary(m1)

# logistic regression
set.seed(100)
train <- sample.split(Y = nurse.dt$Attrition, SplitRatio = 0.7)
trainset <- subset(nurse.dt, train == T)
testset <- subset(nurse.dt, train == F)
View(trainset)
View(testset)

# train set
train.m1 <- glm(Attrition ~ DistanceFromHome + JobInvolvement +  JobSatisfaction + NumCompaniesWorked + OverTime + Shift + TotalWorkingYears, family = binomial, data = trainset)
summary(train.m1)
OR.train <- exp(coef(train.m1)[-1])
prob.train <- predict(train.m1, type = "response")
train.m1.predict <- ifelse(prob.train > 0.5, "Yes", "No")
table.train.m1 <- table(trainset = trainset$Attrition, train.m1.predict, deparse.level = 2)
table.train.m1
round(prop.table(table2), 3)
mean(train.m1.predict == trainset$Attrition)



# test set
test.m1 <- glm(Attrition ~ DistanceFromHome + JobInvolvement +  JobSatisfaction + NumCompaniesWorked + OverTime + Shift + TotalWorkingYears, family = binomial, data = testset)
summary(test.m1)
OR.test <- exp(coef(test.m1)[-1])
prob.test <- predict(test.m1, type = "response")
test.m1.predict <- ifelse(prob.test > 0.5, "Yes", "No")
table.test.m1 <- table(testset = testset$Attrition, test.m1.predict, deparse.level = 2)
table.test.m1
round(prop.table(table3), 3)
mean(test.m1.predict == testset$Attrition)




install.packages("rpart.plot")    
install.packages("caTools") 
install.packages("ggplot2")
install.packages("data.table")
install.packages("tidyr")

library(data.table)
library(ggplot2)
library(rpart.plot)
library(rpart)
library(caTools)
library(car)
library(tidyr)

setwd("/Users/phyllisyen/Desktop/BC2406 ANALYTICS 1")

##____________ Singstat dataset _____________
#Graph 1__________________________________

#Load & Clean data
adm.dt = fread("adm_monthly.csv", na.strings = "na")
sum(is.na(adm.dt))

adm.dt[is.na(adm.dt)] <- 0
adm.dt[, (2:8) := NULL ]
adm.dt[, (62:421) := NULL ]


#Extract & Assign data values into variables

#Average admissions of public hospitals per month (excluding NHCS)
ph_jan <- as.integer(
  (adm.dt[1,13]-adm.dt[14,13]) + (adm.dt[1,25]-adm.dt[14,25]) + (adm.dt[1,37]-adm.dt[14,37])
  + (adm.dt[1,49]-adm.dt[14,49]) + (adm.dt[1,61]-adm.dt[14,61])
)/65

ph_feb <- as.integer(
  (adm.dt[1,12]-adm.dt[14,12]) + (adm.dt[1,24]-adm.dt[14,24]) + (adm.dt[1,36]-adm.dt[14,36])
  + (adm.dt[1,48]-adm.dt[14,48]) + (adm.dt[1,60]-adm.dt[14,60])
)/65

ph_mar <- as.integer(
  (adm.dt[1,11]-adm.dt[14,11]) + (adm.dt[1,23]-adm.dt[14,23]) + (adm.dt[1,35]-adm.dt[14,35])
  + (adm.dt[1,47]-adm.dt[14,47]) + (adm.dt[1,59]-adm.dt[14,59])
)/65

ph_apr <- as.integer(
  (adm.dt[1,10]-adm.dt[14,10]) + (adm.dt[1,22]-adm.dt[14,22]) + (adm.dt[1,34]-adm.dt[14,34])
  + (adm.dt[1,46]-adm.dt[14,46]) + (adm.dt[1,58]-adm.dt[14,58])
)/65

ph_may <- as.integer(
  (adm.dt[1,9]-adm.dt[14,9]) + (adm.dt[1,21]-adm.dt[14,21]) + (adm.dt[1,33]-adm.dt[14,33])
  + (adm.dt[1,45]-adm.dt[14,45]) + (adm.dt[1,57]-adm.dt[14,57])
)/65

ph_jun <- as.integer(
  (adm.dt[1,8]-adm.dt[14,8]) + (adm.dt[1,20]-adm.dt[14,20]) + (adm.dt[1,32]-adm.dt[14,32])
  + (adm.dt[1,44]-adm.dt[14,44]) + (adm.dt[1,56]-adm.dt[14,56])
)/65

ph_jul <- as.integer(
  (adm.dt[1,7]-adm.dt[14,7]) + (adm.dt[1,19]-adm.dt[14,19]) + (adm.dt[1,31]-adm.dt[14,31])
  + (adm.dt[1,43]-adm.dt[14,43]) + (adm.dt[1,55]-adm.dt[14,55])
)/65

ph_aug <- as.integer(
  (adm.dt[1,6]-adm.dt[14,6]) + (adm.dt[1,18]-adm.dt[14,18]) + (adm.dt[1,30]-adm.dt[14,30])
  + (adm.dt[1,42]-adm.dt[14,42]) + (adm.dt[1,54]-adm.dt[14,54])
)/65

ph_sep <- as.integer(
  (adm.dt[1,5]-adm.dt[14,5]) + (adm.dt[1,17]-adm.dt[14,17]) + (adm.dt[1,29]-adm.dt[14,29])
  + (adm.dt[1,41]-adm.dt[14,41]) + (adm.dt[1,53]-adm.dt[14,53])
)/65

ph_oct <- as.integer(
  (adm.dt[1,4]-adm.dt[14,4]) + (adm.dt[1,16]-adm.dt[14,16]) + (adm.dt[1,28]-adm.dt[14,28])
  + (adm.dt[1,40]-adm.dt[14,40]) + (adm.dt[1,52]-adm.dt[14,52])
)/65

ph_nov <- as.integer(
  (adm.dt[1,3]-adm.dt[14,3]) + (adm.dt[1,15]-adm.dt[14,15]) + (adm.dt[1,27]-adm.dt[14,27])
  + (adm.dt[1,39]-adm.dt[14,39]) + (adm.dt[1,51]-adm.dt[14,51])
)/65

ph_dec <- as.integer(
  (adm.dt[1,2]-adm.dt[14,2]) + (adm.dt[1,14]-adm.dt[14,14]) + (adm.dt[1,26]-adm.dt[14,26])
  + (adm.dt[1,38]-adm.dt[14,38]) + (adm.dt[1,50]-adm.dt[14,50])
)/65

#Average admissions of NHCS per month
nhcs_jan = (adm.dt[14,13] + adm.dt[14,25] + adm.dt[14,37] + adm.dt[14,49] + adm.dt[14,61])/5
nhcs_feb = (adm.dt[14,12] + adm.dt[14,24] + adm.dt[14,36] + adm.dt[14,48] + adm.dt[14,60])/5
nhcs_mar = (adm.dt[14,11] + adm.dt[14,23] + adm.dt[14,35] + adm.dt[14,47] + adm.dt[14,59])/5
nhcs_apr = (adm.dt[14,10] + adm.dt[14,22] + adm.dt[14,34] + adm.dt[14,46] + adm.dt[14,58])/5
nhcs_may = (adm.dt[14,9] + adm.dt[14,21] + adm.dt[14,33] + adm.dt[14,45] + adm.dt[14,57])/5
nhcs_jun = (adm.dt[14,8] + adm.dt[14,20] + adm.dt[14,32] + adm.dt[14,44] + adm.dt[14,56])/5
nhcs_jul = (adm.dt[14,7] + adm.dt[14,19] + adm.dt[14,31] + adm.dt[14,43] + adm.dt[14,55])/5
nhcs_aug = (adm.dt[14,6] + adm.dt[14,18] + adm.dt[14,30] + adm.dt[14,42] + adm.dt[14,54])/5
nhcs_sep = (adm.dt[14,5] + adm.dt[14,17] + adm.dt[14,29] + adm.dt[14,41] + adm.dt[14,53])/5
nhcs_oct = (adm.dt[14,4] + adm.dt[14,16] + adm.dt[14,28] + adm.dt[14,40] + adm.dt[14,52])/5
nhcs_nov = (adm.dt[14,3] + adm.dt[14,15] + adm.dt[14,27] + adm.dt[14,39] + adm.dt[14,51])/5
nhcs_dec = (adm.dt[14,2] + adm.dt[14,14] + adm.dt[14,26] + adm.dt[14,38] + adm.dt[14,50])/5

#X-axis values1: Admissions of public hospitals per month (excluding NHCS)
ph_adm_val <- c(ph_jan, ph_feb, ph_mar, ph_apr, ph_may, ph_jun, ph_jul, ph_aug, ph_sep, ph_oct, ph_nov, ph_dec)

#X-axis values2: Admissions of NHCS per month
nhcs_adm_val <- c(nhcs_jan, nhcs_feb, nhcs_mar, nhcs_apr, nhcs_may, nhcs_jun, nhcs_jul, nhcs_aug, nhcs_sep, nhcs_oct, nhcs_nov, nhcs_dec)

#Y-axis values: Months
months_list <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

#Create a data frame with X & Y axis values
adm_df = data.frame(Months = months_list, Public_Hospital_Adm = ph_adm_val)
adm_df$NHCS_Adm = as.numeric(nhcs_adm_val)

#To allow X-axis(Months) to be in order of Jan-Dec
adm_df$Months <- factor(adm_df$Months, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

#Line graph - Admissions Trend
colors <- c("PH" = "orange", "NHCS" = "blue")
ggplot() + 
  geom_line(data = adm_df, mapping = aes(x = Months, y = Public_Hospital_Adm, group = 1, color= "PH")) +
  geom_point(data = adm_df, mapping = aes(x = Months, y = Public_Hospital_Adm, group = 1, color="PH")) +
  geom_line(data = adm_df, mapping = aes(x = Months, y = NHCS_Adm, group = 1, color="NHCS")) + 
  geom_point(data = adm_df, mapping = aes(x = Months, y = NHCS_Adm, group = 1, color="NHCS")) +
  labs(x = "Month", y = "Admissions", title = "Public Hospitals (PH) vs NHCS Admissions") +
  scale_colour_manual(name="Legend",values=colors) + scale_fill_manual(values=colors)

#-----------------------------------------------------------------------------------------------------------

#Manpower of Public Hospitals (excluding NHCS) for 5 years
mp_ph = c(23324-472, 22483-479, 21373-491, 20734-503, 20313-501)

#Admissions of PH (excluding NHCS) for 5 years
adm_ph_2021 = sum(adm.dt[1,2:13])
adm_ph_2020 = sum(adm.dt[1,14:25])
adm_ph_2019 = sum(adm.dt[1,26:37])
adm_ph_2018 = sum(adm.dt[1,38:49])
adm_ph_2017 = sum(adm.dt[1,50:61])

adm_ph = c(adm_ph_2021, adm_ph_2020, adm_ph_2019, adm_ph_2018, adm_ph_2017)

#Manpower of NHCS for 5 years
mp_nhcs = c(472, 479, 491, 503, 501)

#Admissions of NHCS for 5 years
adm_nhcs_2021 = sum(adm.dt[14,2:13])
adm_nhcs_2020 = sum(adm.dt[14,14:25])
adm_nhcs_2019 = sum(adm.dt[14,26:37])
adm_nhcs_2018 = sum(adm.dt[14,38:49])
adm_nhcs_2017 = sum(adm.dt[14,50:61])

adm_nhcs = c(adm_nhcs_2021, adm_nhcs_2020, adm_nhcs_2019, adm_nhcs_2018, adm_nhcs_2017)

#Ratios
adm_nhcs_2021/(mp_nhcs[1])
# 2021: 1 nurse receive ~20 cases in a year (NHCS)

adm_ph_2021/(mp_ph[1])
# 2021: 1 nurse receive ~21 cases in a year (PH)

adm_nhcs_2021/(mp_nhcs[1] - 29)
adm_ph_2021/(mp_ph[1] + 3040)

old_r = c(adm_nhcs_2021/(mp_nhcs[1]),adm_ph_2021/(mp_ph[1]))
new_r = c(adm_nhcs_2021/(mp_nhcs[1] - 29),adm_ph_2021/(mp_ph[1] + 3040))
list <- c(old_r, new_r)

#Table of nurse-to-patient ratio
r_table <- matrix(list, ncol = 2, nrow = 2)
colnames(r_table) <- c("NHCS", "Public Hospitals")
rownames(r_table) <- c("Old Ratio", "New Ratio")
as.table(r_table)


#Graphs - Manpower Trend
manpower_df <- data.frame(mp_ph, mp_nhcs)
manpower_df$Years <- c(2021,2020,2019,2018,2017)

ggplot(manpower_df, aes(x= Years, y= mp_nhcs, label= mp_nhcs)) +
  geom_point(color = "blue") + geom_line(color = "blue") + geom_text(hjust= 0, vjust= 0) +
  labs(x = "Year", y = "Manpower", title = "NHCS' Manpower (Past 5 years)")

manpower_df2 <- data.frame(mp_ph, mp_ph)
manpower_df2$Years <- c(2021,2020,2019,2018,2017)

ggplot(manpower_df2, aes(x= Years, y= mp_ph, label= mp_ph)) +
  geom_point(color = "orange") + geom_line(color = "orange") + geom_text(hjust= 0, vjust= 0) +
  labs(x = "Year", y = "Manpower", title = "Public hospitals' Manpower (Past 5 years)") +
  theme(axis.text = element_text(size = 15))

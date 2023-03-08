# Healthcare Staff Attrition
## BC2406 Analytics I AY22/23 Final Group Project
Grade: A

Tools used: R

## Project Background
In recent years, AI and Machine Learning made major breakthroughs in heart disease research. News articles herald the work done by many entities including Google and Mayo Clinic.
The National Heart Centre Singapore (NHCS) is interested in using Analytics, Machine Learning or/and AI to further its mission. But they are not Analytics experts. Can Analytics really help our in their mission? How does it work? What ideas/concepts/models are suitable?
Thus, NHCS are looking for good ideas, validated by POCs, that could subsequently be scoped and potentially implemented in NHCS.

Your team is tasked with brainstorming the best ideas and presenting a Proof of Concept (POC) for NHCS senior management to consider. A successful POC will:
1. Describe clearly the specific issue/problem/opportunity to be addressed i.e. the problem/opportunity statement.
2. Explain the current solutions (if any) to solve/mitigate the issue/problem/opportunity.
3. Show how your proposed analytics solution is better/different than current solution(s) using
publicly available dataset(s).
4. Link your analytics results/metrics to desirable business outcomes.
5. Suggest how NHCS could extend/implement your analytics solution.

## Business Opportunity 
The healthcare industry in Singapore is facing a pressing issue of burnout and stress faced by its healthcare workers, specifically nurses. This has translated into high attrition rates, especially with the advent of Covid-19. Attrition rate for local nurses increased from 5.4% in 2020 to 7.4% in 2021. This is a problem that NHCS could possibly be facing now or in the near future with an ageing population that is more susceptible to heart diseases. Therefore, we hope to identify solutions that meet the motivations and needs of nurses to lighten their workload and better retain them. 

## Project Explanation:
Our team utilised 3 datasets in our analysis of this topic, they are:

1. Singstat Patient Admission dataset

The purpose of these datasets is to show the general trend of hospital admissions into NHCS and other public sector hospitals and specialty centres. Upon analysing the data, the team can paint a better picture of the relationship between the rate of admissions and nurses’ workload. The team can compare the NHCS datasets with the data from other specialty centres and hospitals to determine the extent of workload of NHCS nurses that can lead to burnout. 

2. Indian Cardiac Unit dataset 

The purpose of this dataset is to illustrate an average cardiac patient’s profile, specifically looking at average age, length of stay, likelihood of needing intensive care etc. to estimate a nurse’s workload. A patient's likelihood of admitting into a cardiac hospital will be the predictive Y variable, and a CART model will be used to predict this variable. 

3. Healthcare Employee Attrition (adapted from IBM employee attrition) dataset

The purpose of this dataset is to identify relevant factors that could contribute to nurses’ burnout and turnover rate. Predictive Y variable will be a nurse's attrition, and a logistic regression will be used. 


## References: 

NHCS monthly admission rates:
https://tablebuilder.singstat.gov.sg/table/TS/M870041

Singstat hospital admission and public sector outpatient attendance:
https://tablebuilder.singstat.gov.sg/table/TS/M870341
https://tablebuilder.singstat.gov.sg/table/TS/M870311

Admission rates in a Cardiac Unit located in India:
https://www.kaggle.com/datasets/ashishsahani/hospital-admissions-data

Healthcare employee dataset:
https://www.kaggle.com/datasets/jpmiller/employee-attrition-for-healthcare


# This is my first R-Script in quite awhile
# Recplicating the logistic analysis from Matlab for Lauren's paper

# Making the switch to the CARE 2.0 dataset
# The first thing is to work in matlab_code_5-3 directory
setwd("~/Nicholas3/Documents 2022/Lauren/matlab_code_5-3")
library(MASS)

# Read in the table

# Oct 6, 2022 - These tables are working fine, but we are trying the categorical variables
#T_log <- read.csv(file = 't_logistic.csv')
# Jan 3, 2023.  We are now using the non_nan file.  This file has filtered out an NaN's in the RTP column
# The number of concussion goes from 5,075 to 4,377
T_log <- read.csv(file = 't_logistic_no_nan.csv')




# Following: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4842399/
# First Do the full glm


# Ordered by the data file
#full <- glm(pcs ~ sex+stim+migraine+nostim+loc+mh+prev_concuss+scat_high+noncon+limcon+contact+nonncaa+practice+comp+outside+delayreport, family = binomial, data = T_log )

#
# Three of our variable groups have more than a binary comparison: non-contact,limited-contact, & non-ncaa
# AND practice, competition, & out-side sport  AND stim, nostim, & nolad
#
# These three group have redundancy in them and so we need to leave out a category, 
# in other words one category needs to be the reference variable and needs to be removed from the model
#
#  So we are excluding non-NCAA, outside sport (outside), and nolad

full2 <- glm(pcs ~ noncon+limcon+contact+practice+comp+delayreport+sex+migraine+stim+nostim+loc+mh+prev_concuss+scat_high, family = binomial, data = T_log )

#
#  Double check we do not have an order effect
#

# Ordering by z-value - descending
full3 <- glm(pcs ~ contact+limcon+comp+noncon+sex+practice+delayreport+scat_high+prev_concuss+mh+nostim+loc+stim+migraine, family = binomial, data = T_log )

# Ordering by z-value - ascending
full4 <- glm(pcs ~ migraine+stim+loc+nostim+mh+prev_concuss+scat_high+delayreport+practice+sex+noncon+comp+limcon+contact, family = binomial, data = T_log )

               #contact+comp+limcon+noncon+practice+delayreport+sex+scat_high+prev_concuss+mh+nostim+stim+migraine+loc, family = binomial, data = T_log )



summary(full2)
summary(full3)
summary(full4)

#
# Now doing stepwise to the full model and models with coeffcients reordered
#

step2 <- stepAIC(full2,directions = 'both') 
step2$anova

step3 <- stepAIC(full3,directions = 'both') 
step3$anova

step4 <- stepAIC(full4,directions = 'both') 
step4$anova

step2
step3
step4

summary(step2)
summary(step3)
summary(step4)


# Lauren pointed out our negative raw coefficients probably need a transformation, eg. reciprocal

# Convert to OR
exp(cbind(coef(step2),confint(step2 )))






# fini
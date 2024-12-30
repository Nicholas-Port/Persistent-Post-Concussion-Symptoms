function [OR,CI] = OR_Logistic1(Y, X)
% Calculate the odds ration using Logistic Regression
%   Detailed explanation goes here

T = array2table([Y X],'VariableNames',{'Y','X'});

X = real(X);
Y = real(Y);

%model_spec = 'Y ~ X';
%model_spec = 'Y ~ X -1'; % No intercept
model_spec = 'Y ~ X +1';

%mdl3 = fitglm(T,model_spec,'link','logit','Distribution','binomial');
%mdl4 = fitglm(T,model_spec,'link','log',  'Distribution','binomial');


% Either model spec wors for removing the constant from the equation
% 9-21-22

mdl5 = fitglm(T,model_spec,'Distribution','binomial');
%mdl5 = fitglm(T,model_spec,'Distribution','binomial','Intercept',false);

OR = exp(mdl5.Coefficients{2,1});

%OR = 1/OR;
% if OR < 1
%    OR = 1-OR;
% end

% TRY TO GET THE OR from LOGISTIC REGRESSION: 
% Using this website:
% https://www.andrewheiss.com/blog/2016/04/25/convert-logistic-regression-standard-errors-to-odds-ratios-with-r/

% Calculate the 95% confidience interval
% From Bland and Altman 2000: BMJ. 2000 May 27; 320(7247): 1468.
% CI = beta +- (1.96)*SE, where beta is the beta weight and SE if from the
% table for that beta

beta = mdl5.Coefficients{2,1};
SE   = mdl5.Coefficients{2,2};
CI(1) = beta - (1.96*SE);
CI(2) = beta + (1.96*SE);

CI = exp(CI);

%disp(OR)
%keyboard


end
















% fini







% Extra notes
% This seems to give the same result
%mdl2 = fitglm(T,model_spec,'Distribution','binomial')
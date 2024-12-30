% BSI Project with Lauren Wilkins
%
% Nov. 30, 2022.  Making the switch to the CARE 2.0 data
%

close all;clear all

dbstop if error

%COLORS
RED       = [0.90 0.00 0.15 ];
MAGENTA   = [0.80 0.00 0.80 ];
ORANGE    = [1.00 0.50 0.00 ];
YELLOW    = [1.00 0.68 0.26 ];
GREEN     = [0.09 0.45 0.27 ];
CYAN      = [0.28 0.82 0.80 ];
BLUE      = [0.00 0.00 1.00 ];
BLACK     = [0.00 0.00 0.05 ];

WHITE = [0.9999 0.9999 0.9999];

% Confidence interval function

CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));

LAUREN = 0;

READ_RAW_DATA = 0;
BUILD_TABLES  = 0;

% First read in the raw data

if READ_RAW_DATA == 1
   tic
   read_in_BSI_v7 %6 %b %v1, v2, v3, 
   
   % NOTE
   % To save the full_care_big_data structure, cut and paste this:
   % save full_care_big_data8 sub -v7.3
   
   toc
   
   keyboard
   
else
   
   
   % Data extraction
   if BUILD_TABLES == 1
      if LAUREN == 0
         load('/Users/nlp/Nicholas3/Documents 2022/Lauren/CARE_20/full_care_big_data8')  % The full datafile is big (8.3 GB)
      else
         load('/Users/laurenwilkins/Thesis/CARE_20/full_care_big_data8')
      end

      SCAT_data_extract_v7
      BSI18_data_extract_v13
      BSI18_fig1_counts_v1         
  
      
      keyboard
      

      %save base_table14 T2 T4 T2S T4S % Save this - type in mannually
   else
     load('base_table14');
   end
   
   
end

clear READ_RAW_DATA BUILD_TABLES




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Remove Outliers  - currently using 99.9 97.5% , which is 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CI_CUT = 99.9;
%CI_CUT = 97.5;
%CI_CUT = 95.0;

% BSI18 dataset
ci_v2 = CIFcn(T4.time_t_RTP,CI_CUT); %  99% Confidence interval cutoff
ii2 = find(T4.time_t_RTP > ci_v2(2));
T4.time_t_RTP(ii2) = NaN; % replace with NaN

% Scat dataset
ci_v = CIFcn(T4S.time_t_RTP,CI_CUT); %  99% Confidence interval cutoff
ii = find(T4S.time_t_RTP > ci_v(2));

% Debug outliers - SAVE
% figure
% subplot(2,1,1)
% histogram(T4S.time_t_RTP,100)
% max(T4S.time_t_RTP)

T4S.time_t_RTP(ii) = NaN; % replace with NaN

% Debug outliers - SVE
% max(T4S.time_t_RTP)
% subplot(2,1,2)
% histogram(T4S.time_t_RTP,100)
% size(ii)
% keyboard



%{
% Let's do some descriptive

BSI18_descript_allhx_base1
BSI18_descript_allhx_injury1



%
% Descriptives for the supplement
%

BSI18_descript_mh_base1
BSI18_descript_mh_injury1
BSI18_descript_lad_base1
BSI18_descript_lad_injury1


BSI18_descript_con_hx_base1
BSI18_descript_con_hx_injury1

%}





% Plotting commands for the mansucript - Older versions which has sex
% seperated on every graph - SAVE
% % Baseline descriptives
% BSI18_descript_allhx_base1

% % Post injury descriptives
% BSI18_descript_allhx_injury1

% % RTP graphs
% BSI18_descript_allhx_RTP

% % 2x2 PCS tables

% This is the main script file for creating the adusted ORs. Comment out
% for the alternate asymptomatic code - lines 160 & 179
BSI18_descript_tables_v11 %9 %8


% This script file is for answering the quetion from reviewer #2 about
% using the asmpytomatic time point rather than RTP
%BSI18_descript_tables_vAsympt

% % RTP vs BSI/SCAT Scatter Plot
BSI18_scatterplot_allhx5



%
% New Graphics
%

BSI18_descript_posneg_base_v3
BSI18_descript_posneg_injury_v2

% regular RTP script % Comment this out to run the alternate below, asymptomatic version
BSI18_descript_posneg_RTP_v5

% Alternate RTP script using asymptomatic rather than RTP, comment out the
% line above.  Need to also uncomment line 160
%BSI18_descript_posneg_RTP_vAsympt


%Supplement
CadetRTP




% Find the 80th percentile for SCAT-Symptom-Severity
% As of June 24, 2023 the 80% perctile was "45"
disp('Find the 80th percentile of SCAT Symptom-Severity for all subjects post injury')
prctile( T4S.scatsxsev_score, 80)

disp('Find the 80th percentile of BSI Totatfor all subjects post injury')
prctile( bsitotal, 80)




% Oct 25, 2024. Answering reviewer #2's comments.
disp('mean & median of Asympt & mean & meadianRTP')
nanmean(T4S.time_t_asympt)
nanmedian(T4S.time_t_asympt)
nanmean(T4S.time_t_RTP)
nanmedian(T4S.time_t_RTP)

disp('mean difference')
nanmean(T4S.time_t_RTP)-nanmean(T4S.time_t_asympt)
disp('median difference')
nanmedian(T4S.time_t_RTP)-nanmedian(T4S.time_t_asympt)

di = ~isnan(T4S.time_t_asympt) & ~isnan(T4S.time_t_RTP);

[r,p] = corr(T4S.time_t_RTP(di),T4S.time_t_asympt(di))

figure
plot(T4S.time_t_RTP(di),T4S.time_t_asympt(di),'bo')


% 
disp('Mean RTP')
nanmean(T4S.time_t_RTP)
disp('STD RTP')
nanstd(T4S.time_t_RTP)

disp('Median RTP')
nanmedian(T4S.time_t_RTP)
disp('STD RTP')
nanstd(T4S.time_t_RTP)
disp('95% CI RTP')
CIFcn(T4S.time_t_RTP(~isnan(T4S.time_t_RTP)),95)




%



% fini





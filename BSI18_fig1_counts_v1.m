% This is the script that gives us all the counts needed for figure 1

% This script file needs the 'sub' database from load('../care_data/full_care_big_data') 
% to be loaded


total_num_unique_sub = length(sub);

% Baseline
n_b_1 = 0;
n_b_2 = 0;
n_b_3 = 0;
n_b_4 = 0;
n_b_5 = 0;

% Injury
n_i_1 = 0;
n_i_2 = 0;
n_i_3 = 0;
n_i_4 = 0;
n_i_5 = 0;

% History
a_pos_consistent    = 0;
a_pos_inconsistent  = 0;
a_neg               = 0;

for s = 1:length(sub)
   
   % Baselines
   switch sub(s).n_baseline
      case 1
         n_b_1 = n_b_1 + 1;
      case 2
         n_b_2 = n_b_2 + 1;
      case 3
         n_b_3 = n_b_3 + 1;
      case 4
         n_b_4 = n_b_4 + 1;
      case 5
         n_b_5 = n_b_5 + 1;
   end
   
   % Injuries
   switch sub(s).n_injuries
      case 1
         n_i_1 = n_i_1 + 1;
      case 2
         n_i_2 = n_i_2 + 1;
      case 3
         n_i_3 = n_i_3 + 1;
      case 4
         n_i_4 = n_i_4 + 1;
      case 5
         n_i_5 = n_i_5 + 1;
   end
   
   % Histories
   if sub(s).anxiety == 0
      a_neg = a_neg + 1;
   elseif sub(s).anxiety == 1
      if sub(s).anxiety_consistent == 1
         a_pos_consistent = a_pos_consistent + 1;
      elseif sub(s).anxiety_consistent == 0
         a_pos_inconsistent = a_pos_inconsistent + 1;
      else
         keyboard;
      end
   else
      keyboard    
   end
   
end


disp('Display to the console the number of single, double, etc Baselines')
n_b_1
n_b_2
n_b_3
n_b_4
n_b_5
n_b_1 + n_b_2 + n_b_3 + n_b_4 


disp('Display to the console the number of single, double, etc Injuries')
n_i_1
n_i_2
n_i_3
n_i_4
n_i_5
disp('Number of people with an injury: single, double, tripple, or quad');
n_i_1 + n_i_2 + n_i_3 + n_i_4
disp('Number of injuries')
n_i_1 + (n_i_2*2) + (n_i_3*3) + (n_i_4*4)



disp('Display medical histories to the console')
a_neg
a_pos_consistent
a_pos_inconsistent
a_neg+a_pos_consistent+a_pos_inconsistent


% Only thing left IS DEPRESSION
%
% TODO - ADD NUMBERS TO LAUREN FIGURE 2
% CREATE INJURY TABLE






% Fini
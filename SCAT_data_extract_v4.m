% BSI 18 data extract

% Version 9 - really just a cleanup of the previous version before we make
% new tables for SCAT_data_extract

% Version 4 We are going to make an intermediate table and work from the
% table for further extraction'

%clear BSI_18_anxiety BSI_18_depression BSI_18_somatization
clear T T2 T3 T4 T5 T6

clear med_list med_list_inj


ii = 0;
jj = 0;
kk = 0;

no_base_scat   = 0;
no_injury_scat = 0;

n_bad_timepoint_scat = 0;

%change_anxiety_hx     = 0;
%change_depression_hx  = 0;

med_i = 0;
med_j = 0;

count_prev_concuss = 0;

for s = 1:length(sub)
   
   
   anx      = [];
   dep      = [];
   ld       = [];
   add      = [];
   migraine = [];
   ncaa     = [];

   % Manage medical Hx and how it changes acrosses baselines
   
   % First fill anx and dep with 0 and 1s for each baseline done
   for tb = 1:sub(s).n_baseline
      
      if strcmp(sub(s).base(tb).psydisdxanxdis,'Yes')
         anx(tb) = 1;
      else
         anx(tb) = 0;
      end
      if strcmp(sub(s).base(tb).depression,'Yes')
         dep(tb) = 1;
      else
         dep(tb) = 0;
      end
      
      if strcmp(sub(s).base(tb).psydisdxlearndis,'Yes')
         ld(tb) = 1;
      else
         ld(tb) = 0;
      end
      
      if strcmp(sub(s).base(tb).addadhd,'Yes')
         add(tb) = 1;
      else
         add(tb) = 0;
      end
      if strcmp(sub(s).base(tb).migraine,'Yes')
         migraine(tb) = 1;
      else
         migraine(tb) = 0;
      end
      if     strcmp(sub(s).base(tb).ncaacategory,'NCAA athlete, Non-Contact sport'    )
         ncaa(tb) = 1;
      elseif strcmp(sub(s).base(tb).ncaacategory,'NCAA athlete, Limited Contact sport')
         ncaa(tb) = 2;
      elseif strcmp(sub(s).base(tb).ncaacategory,'NCAA athlete, Contact sport'        )
         ncaa(tb) = 3;
      elseif strcmp(sub(s).base(tb).ncaacategory,'Non-NCAA athlete'                   )
         ncaa(tb) = 4;
      elseif strcmp(sub(s).base(tb).ncaacategory,'Non-Sport Cadets'                   )
         ncaa(tb) = 5;
      else
         ncaa(tb) = NaN;
      end
      
      sport(tb) = sport_lookup( sub(s).base(tb).sport{1}  );
      site( tb) = site_lookup(  sub(s).base(tb).siteid{1} );
      

   end %tb
   
   % With CARE 2.0, we need to check medhxconhxcompletestatus and make sure
   % it is complete

   sub(s).prev_concussion = sub(s).base(1).prevconcussion;

   %if strcmp(sub(s).base(1).medhxconhxcompletestatus, 'Complete') == 1
   %   % Do Nothing
   %elseif strcmp(sub(s).base(1).medhxconhxcompletestatus, 'No Data Collected') == 1
   %   sub(s).prev_concussion = NaN;
   %elseif strcmp(sub(s).base(1).medhxconhxcompletestatus, 'Errors Outstanding')  == 1 & ...
   %   strcmp(sub(s).base(1).haveprevconcussion, 'Yes') == 1
   %elseif strcmp(sub(s).base(1).haveprevconcussion,'Yes')
   %   % Do nothing

   if strcmp(sub(s).base(1).haveprevconcussion,'Yes')
      % Do nothing
   elseif strcmp(sub(s).base(1).haveprevconcussion,'No')
      % Do nothing
  else
      sub(s).prev_concussion = NaN;
      count_prev_concuss = count_prev_concuss + 1;
   end

   sub(s).ncaa  = ncaa(1);
   sub(s).sport = sport(1);
   sub(s).site  = site(1);
   
   % Now determine if there are any 1s.  If so Hx is positive
   if any(anx)
      sub(s).anxiety = 1;
      if ~all(anx) %change in medical status
         sub(s).anxiety_consistent  = 1;
      else
         sub(s).anxiety_consistent  = 0;
      end
   else
      sub(s).anxiety             = 0;
      sub(s).anxiety_consistent  = [];
   end
   
   if any(dep)
      sub(s).depression = 1;
      if ~all(dep) %change in medical status
         sub(s).depression_consistent  = 1;
      else
         sub(s).depression_consistent  = 0;
      end
   else
      sub(s).depression             = 0;
      sub(s).depression_consistent  = [];
   end
   
   if any(ld)
      sub(s).ld = 1;
      if ~all(ld) %change in medical status
         sub(s).ld_consistent  = 1;
      else
         sub(s).ld_consistent  = 0;   
      end
   else
      sub(s).ld              = 0;
      sub(s).ld_consistent   = [];
   end
   
   sub(s).is_stimulant_baseline = 0;  % Note, we are NOT CHECKING FOR STIMULANT in non ADD subjects
   if any(add)
      sub(s).add = 1;


      % Deal with medications
      for b = 1:length(sub(s).base)

         % This is just building a list so we can write the is_stimulant
         % function
         if ~isempty(sub(s).base(b).currrxnames{1})
            med_i = med_i + 1;
            med_list{med_i,1} = sub(s).base(b).currrxnames{1};
            med_list{med_i,2} = sub(s).base(b).prescripmedspsychostimulant{1} ;    
         end %if

         sub(s).is_stimulant_baseline(b) = is_stimulant(sub(s).base(b).currrxnames{1});

         % DEBUG 1
         if length(sub(s).base(b).currrxnames) > 1
            keyboard
         end

         % If the subject checked the box, we count them as on a stimulant
         if strcmp(sub(s).base(b).prescripmedspsychostimulant{1},'Yes')
            sub(s).is_stimulant_baseline(b) = 1;
         end

      end %for b


      if ~all(add) %change in medical status
         sub(s).add_consistent  = 1;
      else
         sub(s).add_consistent  = 0;
      end
   else
      sub(s).add              = 0;
      sub(s).add_consistent   = [];
   end




   if any(migraine)
      sub(s).migraine = 1;
      if ~all(migraine)                          % change in medical status
         sub(s).migraine_consistent  = 1;
      else
         sub(s).migraine_consistent  = 0;
      end
   else
      sub(s).migraine              = 0;
      sub(s).migraine_consistent   = [];
   end
   

  
   
   for b = 1:sub(s).n_baseline
      
      if strcmp(sub(s).base(b).scat3completestatus,'Complete') == 1
         
         ii = ii + 1;
         % The first few columns will be tracking numbers and histories
         T{ii,1} = s;  % Subject number
         T{ii,2} = b;  % Baseline number
         T{ii,3} = sub(s).sub_id;
         T{ii,4} = sub(s).base(b).baselineevalid;
         T{ii,5} = sub(s).base(b).sport;
         T{ii,6} = sub(s).base(b).sex;
         
         
         T{ii,7} = sub(s).anxiety;
         T{ii,8} = sub(s).depression;
         T{ii,9} = sub(s).ld;
         T{ii,10} = sub(s).add;
         T{ii,11} = sub(s).prev_concussion;

         
         T{ii,15} = sub(s).base(b).scatbalprob;
         T{ii,16} = sub(s).base(b).scatblvis;
         T{ii,17} = sub(s).base(b).scatconf;
         T{ii,18} = sub(s).base(b).scatdiffconc;
         T{ii,19} = sub(s).base(b).scatdiffrem;
         T{ii,20} = sub(s).base(b).scatdizz;
         T{ii,21} = sub(s).base(b).scatdontfeel;
         T{ii,22} = sub(s).base(b).scattrfallsleep;
         T{ii,23} = sub(s).base(b).scatdrowsiness;
         T{ii,24} = sub(s).base(b).scatemotional;
         T{ii,25} = sub(s).base(b).scatfatigue;
         T{ii,26} = sub(s).base(b).scatfeelslow;
         T{ii,27} = sub(s).base(b).scatfog;
         T{ii,28} = sub(s).base(b).scatha;
         T{ii,29} = sub(s).base(b).scatirritable;
         T{ii,30} = sub(s).base(b).scatnausea;
         T{ii,31} = sub(s).base(b).scatneckpain;
         T{ii,32} = sub(s).base(b).scatnervanx;
         T{ii,33} = sub(s).base(b).scatpresshead;
         T{ii,34} = sub(s).base(b).scatsad;
         T{ii,35} = sub(s).base(b).scatsenslight;
         T{ii,36} = sub(s).base(b).scatsensnois;
         T{ii,37} = sub(s).base(b).scatsxsev_score;
         T{ii,38} = sub(s).base(b).scattotnumsx_score;
         T{ii,39} = sub(s).migraine;
         T{ii,40} = sub(s).ncaa;
         T{ii,41} = sub(s).sport;
         T{ii,42} = sub(s).site;
         T{ii,43} = any(sub(s).is_stimulant_baseline);

      else
         no_base_scat = no_base_scat + 1;
      end %if bsi18 complete
      
   end % for b
   
  
   
   for in = 1:sub(s).n_injuries



      % 8-21-22 - Lauren and Nick reviwed "inj_rx_type"  We found the code
      % hard to trust.  Code-7 is probably "psycho-stimulant", but it
      % almost never lined up with the other columns. 
      sub(s).is_stimulant_inj(in)  = is_stimulant(sub(s).injury(in).rx_inj{1} );
      sub(s).is_stimulant_inj2(in) = is_stimulant(sub(s).injury(in).inj_rx_type_oth{1} );

      if any([ sub(s).is_stimulant_inj sub(s).is_stimulant_inj2]) % sub(s).is_stimulant_inj == 1 ||  sub(s).is_stimulant_inj2 == 1
         % For each injury, add some columns to med_list_inj
         med_j = med_j + 1;
         med_list_inj{med_j,1} = sub(s).injury(in).rx_inj{1} ;
         med_list_inj{med_j,2} = []; %sub(s).injury(in).inj_rx_type{1} ;
         med_list_inj{med_j,3} = sub(s).injury(in).inj_rx_type_oth{1} ;
         med_list_inj{med_j,4} = 1;
      end

      if strcmp(sub(s).injury(in).InjRxPsychoStim{1},'Yes')
         sub(s).is_stimulant_inj3(in) = 1;
      else
         sub(s).is_stimulant_inj3(in) = 0;
      end



      % Do we have the time point we want ?
      if length(sub(s).injury(in).time_p) <= 2          % Hack because time_p(3) doesn't exist for subjects with only 2 time points
         sub(s).injury(in).time_p(3).injurydt = [];
      end
      
      if ~isempty(sub(s).injury(in).time_p(3).injurydt)
         temp_tp = 3;
         sub(s).injury(in).injurydt = sub(s).injury(in).time_p(3).injurydt;
      elseif ~isempty(sub(s).injury(in).time_p(2).injurydt)
         temp_tp = 2;
         sub(s).injury(in).injurydt = sub(s).injury(in).time_p(2).injurydt;
      else
         n_bad_timepoint_scat = n_bad_timepoint_scat + 1;
         sub(s).injury(in).injurydt = [];
         temp_tp = [];
      end
      
      % Need to add another step.  If injury(in).injurydt is still empty, fill
      % it with another date.  This was counting concussion works
      % accurately
      if isempty( sub(s).injury(in).injurydt )
         temp_tp2 = 4;
         while temp_tp2 <= 13
            if ~isempty(sub(s).injury(in).time_p(temp_tp2).injurydt)
               sub(s).injury(in).injurydt = sub(s).injury(in).time_p(temp_tp2).injurydt;
               break
            else
               temp_tp2 = temp_tp2 + 1;
            end
         end
      end
      
   

      if ~isempty(temp_tp)
         if strcmp(sub(s).injury(in).time_p(temp_tp).scat3completestatus,'Complete') == 1           

            jj = jj + 1;
            
            T3{jj,1} = s;
            T3{jj,2} = sub(s).sub_id;
            T3{jj,3} = sub(s).injury_id(in);
            T3{jj,4} = sub(s).base(1).sex;
            T3{jj,5} = sub(s).injury(in).time_toasympt_days;
            T3{jj,6} = sub(s).injury(in).time_tortp_days;


            % Sort out injury medications
%             if ~isempty( sub(s).injury(in).rx_inj{1} )
%                %disp( sub(s).injury(in).rx_inj )
% 
%             elseif ~isempty ( sub(s).injury(in).inj_rx_type{1} )
%                %disp( sub(s).injury(in).inj_rx_type{1} )
% 
%             elseif ~isempty ( sub(s).injury(in).inj_rx_type_oth{1} )
%                %disp( sub(s).injury(in).inj_rx_type_oth{1} )
%             end
            
            T3{jj,7}  = sub(s).anxiety;
            T3{jj,8}  = sub(s).depression;
            T3{jj,9}  = sub(s).ld;
            T3{jj,10} = sub(s).add;
            T3{jj,11} = sub(s).prev_concussion;
            
            if in == 2
               
               %dn1 = datenum(sub(s).base(1).valdt{1},'ddmmmyyyy');
               dn1 = datenum(sub(s).base(1).evaldate{1},'ddmmmyyyy');
               dn3 = datenum(sub(s).injury(in).time_p(temp_tp).injurydt{1},  'ddmmmyyyy');
               
               if dn3-dn1 >= 0
                  T3{jj,11} = sub(s).prev_concussion + 1;
               else
                  T3{jj,11} = sub(s).prev_concussion + 1;
                  %keyboard
               end
               
            elseif in == 3
               
               %dn1 = datenum(sub(s).base(1).valdt{1},'ddmmmyyyy');
               dn1 = datenum(sub(s).base(1).evaldate{1},'ddmmmyyyy');
               dn2 = datenum(sub(s).injury(in-1).injurydt{1},'ddmmmyyyy');
               dn3 = datenum(sub(s).injury(in).time_p(temp_tp).injurydt{1},  'ddmmmyyyy');
               
               if dn3-dn2 >= 0
                  T3{jj,11} = sub(s).prev_concussion + 2;
               else
                  keyboard
               end
               
            elseif in == 4
               
               %dn2 = datenum(sub(s).injury(in-1).time_p(temp_tp).injurydt{1},'ddmmmyyyy');
               dn2 = datenum(sub(s).injury(in-1).injurydt{1},'ddmmmyyyy');
               dn3 = datenum(sub(s).injury(in).time_p(temp_tp).injurydt{1},  'ddmmmyyyy');
               
               if dn3-dn2 >= 0
                  T3{jj,11} = sub(s).prev_concussion + 3;
               else
                  keyboard
               end
               
            end


            T3{jj,15} = sub(s).injury(in).time_p(temp_tp).scatbalprob;
            T3{jj,16} = sub(s).injury(in).time_p(temp_tp).scatblvis;
            T3{jj,17} = sub(s).injury(in).time_p(temp_tp).scatconf;
            T3{jj,18} = sub(s).injury(in).time_p(temp_tp).scatdiffconc;
            T3{jj,19} = sub(s).injury(in).time_p(temp_tp).scatdiffrem;
            T3{jj,20} = sub(s).injury(in).time_p(temp_tp).scatdizz;
            T3{jj,21} = sub(s).injury(in).time_p(temp_tp).scatdontfeel;
            T3{jj,22} = sub(s).injury(in).time_p(temp_tp).scattrfallsleep;
            T3{jj,23} = sub(s).injury(in).time_p(temp_tp).scatdrowiness;
            T3{jj,24} = sub(s).injury(in).time_p(temp_tp).scatemotional;
            T3{jj,25} = sub(s).injury(in).time_p(temp_tp).scatgfatigue;
            T3{jj,26} = sub(s).injury(in).time_p(temp_tp).scatfeelslow;
            T3{jj,27} = sub(s).injury(in).time_p(temp_tp).scatfog;
            T3{jj,28} = sub(s).injury(in).time_p(temp_tp).scatha;
            T3{jj,29} = sub(s).injury(in).time_p(temp_tp).scatirritable;
            T3{jj,30} = sub(s).injury(in).time_p(temp_tp).scatnausea;
            T3{jj,31} = sub(s).injury(in).time_p(temp_tp).scatneckpain;
            T3{jj,32} = sub(s).injury(in).time_p(temp_tp).scatnervanx;
            T3{jj,33} = sub(s).injury(in).time_p(temp_tp).scatpresshead;
            T3{jj,34} = sub(s).injury(in).time_p(temp_tp).scatsad;
            T3{jj,35} = sub(s).injury(in).time_p(temp_tp).scatsenslight;
            T3{jj,36} = sub(s).injury(in).time_p(temp_tp).scatsensnois;
            T3{jj,37} = sub(s).injury(in).time_p(temp_tp).scatsxsev_score;
            T3{jj,38} = sub(s).injury(in).time_p(temp_tp).scattotnumsx_score;
            % migraine and LOC for injuries
            T3{jj,39} = sub(s).migraine;
            if strcmp(sub(s).injury(in).loc,'Yes')
               T3{jj,40} = 1;
            else
               T3{jj,40} = 0;
            end
            T3{jj,41} = sub(s).ncaa;
            T3{jj,42} = sub(s).sport;
            T3{jj,43} = sub(s).site;


            % Practice or competition
            if strcmp(sub(s).injury(in).injsituation, 'Practice/Training' )
                T3{jj,44} = 1;
            elseif  strcmp(sub(s).injury(in).injsituation, 'Competition'  )
                T3{jj,44} = 2;
            elseif  strcmp(sub(s).injury(in).injsituation, 'Outside Sport')
                T3{jj,44} = 3;
            elseif  isempty(sub(s).injury(in).injsituation{1})
                T3{jj,44} = NaN;   % Should be NaN - Oct 6, 2022
            else 
                T3{jj,44} = 0;
                keyboard
            end


            % Delayed reporting
%             if sub(s).injury(in).days_reported_late >= 1
%                 T3{jj,45} = 1;
%             elseif isempty(sub(s).injury(in).days_reported_late)
%                 T3{jj,45} = 0;
%             else 
%                 T3{jj,45} = 0;
%             end

            % Delayed reporting
            if strcmp(sub(s).injury(in).report_injury_immediately{1},'Yes') == 1
               T3{jj,45} = 0;
            elseif strcmp(sub(s).injury(in).report_injury_immediately{1},'No') == 1
                T3{jj,45} = 1;
            elseif isempty(sub(s).injury(in).report_injury_immediately{1}) == 1
                T3{jj,45} = NaN;           
            else
               keyboard
            end


            % Simulant use
            if any(sub(s).is_stimulant_baseline) || ...
               any(sub(s).is_stimulant_inj)      || ...
               any(sub(s).is_stimulant_inj2)     || ...
               any(sub(s).is_stimulant_inj3)     

               T3{jj,46} = 1;
            else
               T3{jj,46} = 0;
            end


            
         else
            no_injury_scat = no_injury_scat + 1;
            
         end %if SCAT complete
      end  % if temp_tp == 2 or 3
      
      
      
   end %for in
   
   
   
end % for s
  
 
T2= cell2table(T,'VariableNames', ...
    {'sub','base','sub_id','base_id','sport','sex',...
    'anx','dep','ld','add','prev_concuss','b_anx','b_dep','b_soma',...
    'scatbalprob','scatblvis','scatconf','scatdiffconc','scatdiffrem', ...
    'scatdizz','scatdontfeel','scattrfallsleep','scatdrowiness','scatemotional'...
    'scatgfatigue','scatfeelslow','scatfog','scatha','scatirritable', ...
    'scatnausea','scatneckpain','scatnervanx','scatpresshead', ...
    'scatsad','scatsenslight','scatsensnois','scatsxsev_score',...
    'scattotnumsx_score','migraine','ncaa','sport2','site','stimulant' }); 
 

 T4= cell2table(T3,'VariableNames', ...
    {'sub_num','sub_id','injury_id','sex','time_t_asympt','time_t_RTP',...
    'anx_hx','dep_hx','ld','add','prev_concuss','b_anx','b_dep','b_soma',...
    'scatbalprob','scatblvis','scatconf','scatdiffconc','scatdiffrem', ...
    'scatdizz','scatdontfeel','scattrfallsleep','scatdrowiness','scatemotional'...
    'scatgfatigue','scatfeelslow','scatfog','scatha','scatirritable', ...
    'scatnausea','scatneckpain','scatnervanx','scatpresshead', ...
    'scatsad','scatsenslight','scatsensnois','scatsxsev_score',...
    'scattotnumsx_score','migraine','LOC','ncaa','sport2','site', 'situation','daysreportedlate', 'stimulant' });         

    

T2S = T2;
T4S = T4;


clear T T1 T2 T3 T4 T5 T6


%keyboard



%
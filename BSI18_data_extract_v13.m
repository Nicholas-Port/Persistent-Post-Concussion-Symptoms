% BSI 18 data extract

% Version 10 - there appears to be a bug in the bsi18 complete exlusions


% Version 9 - really just a cleanup of the previous version before we make
% new tables for SCAT_data_extract

% Version 4 We are going to make an intermediate table and work from the
% table for further extraction'

%clear BSI_18_anxiety BSI_18_depression BSI_18_somatization
clear T T2 T3 T4 T5 T6

%keyboard


ii = 0;
jj = 0;
kk = 0;

no_base_bsi18   = 0;
no_injury_bsi18 = 0;

n_bad_timepoint_bsi18 = 0;

%change_anxiety_hx     = 0;
%change_depression_hx  = 0;

for s = 1:length(sub)
   
   
   anx       = [];
   dep       = [];
   ld        = [];
   add       = [];
   migraine  = [];
   ncaa      = [];

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

      %  July 25, 2023
      % We need to change NCAA catagory to move the cadets out NCAA
      % athlete and into ncaa=4, which will be cadet only, no matter what
      % the sport, club sport, and whether the NCAA recognizes the sport
      if sub(s).base(tb).cadet == 1
         ncaa(tb) = 4;
      end
      
      sport(tb) = sport_lookup( sub(s).base(tb).sport{1}  );
      site( tb) = site_lookup(  sub(s).base(tb).siteid{1} );
      

   end %tb
   
   sub(s).prev_concussion = sub(s).base(1).prevconcussion;
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
   
   if any(add)
      sub(s).add = 1;
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
      
      if strcmp(sub(s).base(b).bsi18completestatus,'Complete') == 1
         
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

         T{ii,12} = sum([sub(s).base(b).bsinervous  ...  % anxiety
            sub(s).base(b).bsifearful  ...
            sub(s).base(b).bsipanic    ...
            sub(s).base(b).bsirestless ...
            sub(s).base(b).bsiscared   ...
            sub(s).base(b).bsiintense ]);
         
         T{ii,13}= sum([sub(s).base(b).bsiblue  ...     % depression
            sub(s).base(b).bsiendlife  ...
            sub(s).base(b).bsihopeless ...
            sub(s).base(b).bsilonely   ...
            sub(s).base(b).bsiworth    ...
            sub(s).base(b).bsiinterest ]);
         
         T{ii,14} = sum([sub(s).base(b).bsibreath  ...  % somatization
            sub(s).base(b).bsichestpain ...
            sub(s).base(b).bsifaint     ...
            sub(s).base(b).bsinausea    ...
            sub(s).base(b).bsinumb      ...
            sub(s).base(b).bsiweak ]);
         
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
         no_base_bsi18 = no_base_bsi18 + 1;
      end %if bsi18 complete
      
   end % for b
   
   
   for in = 1:sub(s).n_injuries
      
      % Do we have the time point we want ?
      if length(sub(s).injury(in).time_p) <= 2          % Hack because time_p(3) doesn't exist for subjects with only 2 time points
         sub(s).injury(in).time_p(3).injurydt = [];
      end
      if ~isempty(sub(s).injury(in).time_p(3).injurydt)
         temp_tp = 3;
      elseif ~isempty(sub(s).injury(in).time_p(2).injurydt)
         temp_tp = 2;
      else
         n_bad_timepoint_bsi18 = n_bad_timepoint_bsi18 + 1;
         temp_tp = [];
      end
      
      % Another hack to deal with injury dates - switch this to temp_tp2,
      % should fix the number of BSI18 subject bug
%       temp_tp2 = 1;
%       while temp_tp2 <= 13
%          if ~isempty(sub(s).injury(in).time_p(temp_tp2).injurydt)
%             sub(s).injury(in).injurydt = sub(s).injury(in).time_p(temp_tp2).injurydt;
%             break
%          else
%             temp_tp2 = temp_tp2 + 1;
%          end
%       end
      
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
         if strcmp(sub(s).injury(in).time_p(temp_tp).bsi18completestatus,'Complete') == 1
            
            jj = jj + 1;
            
            T3{jj,1} = s;
            T3{jj,2} = sub(s).sub_id;
            T3{jj,3} = sub(s).injury_id(in);
            T3{jj,4} = sub(s).base(1).sex;
            T3{jj,5} = sub(s).injury(in).time_toasympt_days;
            T3{jj,6} = sub(s).injury(in).time_tortp_days;
            
            T3{jj,7}  = sub(s).anxiety;
            T3{jj,8}  = sub(s).depression;
            T3{jj,9}  = sub(s).ld;
            T3{jj,10} = sub(s).add;
            T3{jj,11} = sub(s).prev_concussion;
            
            if in == 2
               
               dn1 = datenum(sub(s).base(1).evaldate{1},'ddmmmyyyy'); % CARE 2.0 sub(s).base(1).valdt{1}
               dn3 = datenum(sub(s).injury(in).time_p(temp_tp).injurydt{1},  'ddmmmyyyy');
               
               if dn3-dn1 >= 0
                  T3{jj,11} = sub(s).prev_concussion + 1;
               else
                  T3{jj,11} = sub(s).prev_concussion + 1;
                  %keyboard
               end
               
            elseif in == 3
               
               dn1 = datenum(sub(s).base(1).evaldate{1},'ddmmmyyyy'); % CARE 2.0 sub(s).base(1).valdt{1}
               dn2 = datenum(sub(s).injury(in-1).injurydt{1},'ddmmmyyyy');
               dn3 = datenum(sub(s).injury(in).time_p(temp_tp).injurydt{1},  'ddmmmyyyy');
               
               if dn3-dn2 >= 0
                  T3{jj,11} = sub(s).prev_concussion + 2;
               else
                  keyboard
               end
               
            elseif in == 4
               
               dn2 = datenum(sub(s).injury(in-1).time_p(temp_tp).injurydt{1},'ddmmmyyyy');
               dn3 = datenum(sub(s).injury(in).time_p(temp_tp).injurydt{1},  'ddmmmyyyy');
               
               if dn3-dn2 >= 0
                  T3{jj,11} = sub(s).prev_concussion + 3;
               else
                  keyboard
               end
               
            end
            
            % NOTE INCREASE COLUMN NMUMBERS AND LABELS FOR T4
            T3{jj,12} = sum([sub(s).injury(in).time_p(temp_tp).bsinervous  ...  % anxiety
               sub(s).injury(in).time_p(temp_tp).bsifearful  ...
               sub(s).injury(in).time_p(temp_tp).bsipanic    ...
               sub(s).injury(in).time_p(temp_tp).bsirestless ...
               sub(s).injury(in).time_p(temp_tp).bsiscared   ...
               sub(s).injury(in).time_p(temp_tp).bsiintense ]);
            
            T3{jj,13}= sum([sub(s).injury(in).time_p(temp_tp).bsiblue  ...     % depression
               sub(s).injury(in).time_p(temp_tp).bsiendlife  ...
               sub(s).injury(in).time_p(temp_tp).bsihopeless ...
               sub(s).injury(in).time_p(temp_tp).bsilonely   ...
               sub(s).injury(in).time_p(temp_tp).bsiworth    ...
               sub(s).injury(in).time_p(temp_tp).bsiinterest ]);
            
            T3{jj,14} = sum([sub(s).injury(in).time_p(temp_tp).bsibreath  ...  % somatization
               sub(s).injury(in).time_p(temp_tp).bsichestpain ...
               sub(s).injury(in).time_p(temp_tp).bsifaint     ...
               sub(s).injury(in).time_p(temp_tp).bsinausea    ...
               sub(s).injury(in).time_p(temp_tp).bsinumb      ...
               sub(s).injury(in).time_p(temp_tp).bsiweak ]);
            
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
            % Migraine and LOC for injuries
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
                T3{jj,44} = 0;
            else 
                T3{jj,44} = 0;
                keyboard
            end

            % Delayed reporting
%             if sub(s).injury(in).days_reported_late >= 1
%                 T3{jj,45} = 1;
%             else %isempty(sub(s).injury(in).days_reported_late)
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
                  any(sub(s).is_stimulant_inj)   || ...
                  any(sub(s).is_stimulant_inj2)
               T3{jj,46} = 1;
            else
               T3{jj,46} = 0;
            end


         else
            no_injury_bsi18 = no_injury_bsi18 + 1;
            
         end %if bsi18 complete
      end  % if temp_tp == 2 or 3
      
     
      
      
      %
      %  Second Injury Table for the 6 month time point
      %
      
      % Do we have the time point we want ?
      if length(sub(s).injury(in).time_p) <= 2          % Hack because time_p(3) doesn't exist for subjects with only 2 time points
         sub(s).injury(in).time_p(13).injurydt = [];
      elseif length(sub(s).injury(in).time_p) <= 12 
         sub(s).injury(in).time_p(13).injurydt = [];
      end
      
      if ~isempty(sub(s).injury(in).time_p(13).injurydt)
         
         if strcmp(sub(s).injury(in).time_p(13).bsi18completestatus,'Complete') == 1
            
            kk = kk + 1;
            
            T5{kk,1} = s;
            T5{kk,2} = sub(s).sub_id;
            T5{kk,3} = sub(s).injury_id(in);
            T5{kk,4} = sub(s).base(1).sex;
            T5{kk,5} = sub(s).injury(in).time_toasympt_days;
            T5{kk,6} = sub(s).injury(in).time_tortp_days;
            
            if strcmp(sub(s).base(1).psydisdxanxdis,'Yes')
               T5{kk,7} = 1;
            else
               T5{kk,7} = 0;
            end
            
            if strcmp(sub(s).base(1).depression,'Yes')
               T5{kk,8} = 1;
            else
               T5{kk,8} = 0;
            end
            
            T5{kk,9} = sum([sub(s).injury(in).time_p(13).bsinervous  ...  % anxiety
               sub(s).injury(in).time_p(13).bsifearful  ...
               sub(s).injury(in).time_p(13).bsipanic    ...
               sub(s).injury(in).time_p(13).bsirestless ...
               sub(s).injury(in).time_p(13).bsiscared   ...
               sub(s).injury(in).time_p(13).bsiintense ]);
            
            T5{kk,10}= sum([sub(s).injury(in).time_p(13).bsiblue  ...     % depression
               sub(s).injury(in).time_p(13).bsiendlife  ...
               sub(s).injury(in).time_p(13).bsihopeless ...
               sub(s).injury(in).time_p(13).bsilonely   ...
               sub(s).injury(in).time_p(13).bsiworth    ...
               sub(s).injury(in).time_p(13).bsiinterest ]);
            
            T5{kk,11} = sum([sub(s).injury(in).time_p(13).bsibreath  ...  % somatization
               sub(s).injury(in).time_p(13).bsichestpain ...
               sub(s).injury(in).time_p(13).bsifaint     ...
               sub(s).injury(in).time_p(13).bsinausea    ...
               sub(s).injury(in).time_p(13).bsinumb      ...
               sub(s).injury(in).time_p(13).bsiweak ]);
            
            T5{kk,12} = sub(s).injury(in).time_p(13).scatbalprob;
            T5{kk,13} = sub(s).injury(in).time_p(13).scatblvis;
            T5{kk,14} = sub(s).injury(in).time_p(13).scatconf;
            T5{kk,15} = sub(s).injury(in).time_p(13).scatdiffconc;
            T5{kk,16} = sub(s).injury(in).time_p(13).scatdiffrem;
            T5{kk,17} = sub(s).injury(in).time_p(13).scatdizz;
            T5{kk,18} = sub(s).injury(in).time_p(13).scatdontfeel;
            T5{kk,19} = sub(s).injury(in).time_p(13).scattrfallsleep;
            T5{kk,20} = sub(s).injury(in).time_p(13).scatdrowiness;
            T5{kk,21} = sub(s).injury(in).time_p(13).scatemotional;
            T5{kk,22} = sub(s).injury(in).time_p(13).scatgfatigue;
            T5{kk,23} = sub(s).injury(in).time_p(13).scatfeelslow;
            T5{kk,24} = sub(s).injury(in).time_p(13).scatfog;
            T5{kk,25} = sub(s).injury(in).time_p(13).scatha;
            T5{kk,26} = sub(s).injury(in).time_p(13).scatirritable;
            T5{kk,27} = sub(s).injury(in).time_p(13).scatnausea;
            T5{kk,28} = sub(s).injury(in).time_p(13).scatneckpain;
            T5{kk,29} = sub(s).injury(in).time_p(13).scatnervanx;
            T5{kk,30} = sub(s).injury(in).time_p(13).scatpresshead;
            T5{kk,31} = sub(s).injury(in).time_p(13).scatsad;
            T5{kk,32} = sub(s).injury(in).time_p(13).scatsenslight;
            T5{kk,33} = sub(s).injury(in).time_p(13).scatsensnois;
            T5{kk,34} = sub(s).injury(in).time_p(13).scatsxsev_score;
            T5{kk,35} = sub(s).injury(in).time_p(13).scattotnumsx_score;
            
         end %if bsi18 complete
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
    'scattotnumsx_score','migraine','LOC','ncaa','sport2','site','situation','daysreportedlate','stimulant' });         

 T6= cell2table(T5,'VariableNames', ...
    {'sub_num','sub_id','injury_id','sex','time_t_asympt','time_t_RTP',...
    'anx_hx','dep_hx','b_anx','b_dep','b_soma',...
    'scatbalprob','scatblvis','scatconf','scatdiffconc','scatdiffrem', ...
    'scatdizz','scatdontfeel','scattrfallsleep','scatdrowiness','scatemotional'...
    'scatgfatigue','scatfeelslow','scatfog','scatha','scatirritable', ...
    'scatnausea','scatneckpain','scatnervanx','scatpresshead', ...
    'scatsad','scatsenslight','scatsensnois','scatsxsev_score',...
    'scattotnumsx_score'});         
    
   







%
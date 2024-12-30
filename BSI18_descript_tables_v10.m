

% scat_anxdep=T4S.scatsxsev_score(anxdep_pos)
% scat_noanxdep=T4S.scatsxsev_score(anxdep_neg)
% BSI18pos =  b_total(anxdep_pos);
% BSI18neg =  b_total(anxdep_neg);

b_total   = [T4.b_anx]+[T4.b_dep]+[T4.b_soma];  % Use the T4 not T4S.  T4 is for BSI analyses
mh_hx     = [T4S.anx_hx] | [T4S.dep_hx];

scattotal = T4S.scatsxsev_score;
ldhx      = [T4S.ld] | [T4S.add];
prevcon   = T4S.prev_concuss;
mighx     = T4S.migraine;
LOC       = T4S.LOC;
sex       = T4S.sex; 

ncaa        = T4S.ncaa;
situation   = T4S.situation;
delayreport = T4S.daysreportedlate;
stimulant   = T4S.stimulant;
 

% Add these columns to T4S
T4S.lad = T4S.ld     | T4S.add;
T4S.mh  = T4S.anx_hx | T4S.dep_hx;

NL = newline;



% Count the number of NaNs for RTP,
% disp('****************************')
% disp('SCAT database - 2S - baseline')
% disp('NaNs for prev_concuss')
% sum(isnan(T2S.prev_concuss))
% disp('sex is undefined')
% sum(T2S.sex == 4)
% % Count the number of NaNs for RTP, 
% disp('BSI database - 4 - post injury')
% disp('NaNs for RTP')
% sum(isnan(T4.time_t_RTP))
% disp('NaNs for prev_concuss')
% sum(isnan(T4.prev_concuss))
% % Count the number of NaNs for RTP,
% disp('SCAT database - 4S - post injury')
% disp('NaNs for RTP')
% sum(isnan(T4S.time_t_RTP))
% disp('NaNs for prev_concuss')
% sum(isnan(T4S.prev_concuss))

% Define PCS for this analysis
% this can be changed anytime

PCS        = 29; %29 % was 48 days
SCAT_max   = 45;
BSI18_max  = 10;



% for i = 1:length(T4S.time_t_RTP)
%     if T4S.time_t_RTP(i) < PCS
%         pcs(i) = 0;
%     elseif T4S.time_t_RTP(i) >= PCS
%         pcs(i) = 1;
%     end
% end
% 
% T4S.pcs = pcs';

T4S.pcs = T4S.time_t_RTP > PCS;



yesyes = 0;
noyes  = 0;
yesno  = 0;
nono   = 0;


yesyes2 = 0;
noyes2  = 0;
yesno2  = 0;
nono2   = 0;

yesyes3 = 0;
noyes3  = 0;
yesno3  = 0;
nono3   = 0;

yesyes4 = 0;
noyes4  = 0;
yesno4  = 0;
nono4   = 0;

yesyes5 = 0;
noyes5  = 0;
yesno5  = 0;
nono5   = 0;

yesyes6 = 0;
noyes6  = 0;
yesno6  = 0;
nono6   = 0;

yesyes7 = 0;
noyes7  = 0;
yesno7  = 0;
nono7   = 0;

yesyes8 = 0;
noyes8  = 0;
yesno8  = 0;
nono8   = 0;

yesyes9 = 0;
noyes9  = 0;
yesno9  = 0;
nono9   = 0;

yesyes10 = 0;
noyes10  = 0;
yesno10  = 0;
nono10   = 0;

yesyes11 = 0;
noyes11  = 0;
yesno11  = 0;
nono11   = 0;

yesyes12 = 0;
noyes12  = 0;
yesno12  = 0;
nono12   = 0;

yesyes13 = 0; %practice
noyes13  = 0;
yesno13  = 0;
nono13   = 0;

yesyes14 = 0; %compeitition
noyes14  = 0;
yesno14  = 0;
nono14   = 0;

yesyes15 = 0; %outside sport
noyes15  = 0;
yesno15  = 0;
nono15   = 0;

yesyes16 = 0; %delayedreporting
noyes16  = 0;
yesno16  = 0;
nono16   = 0;

yesyes17 = 0; %stimulant
noyes17  = 0;
yesno17  = 0;
nono17   = 0;

yesyes18 = 0; %no stimulant
noyes18  = 0;
yesno18  = 0;
nono18   = 0;

% NEED TO ADD THIS TO ALL THE CODE
li = ~isnan(T4S.time_t_RTP) & ~isnan(mh_hx);
y_mh = T4S.time_t_RTP(li) > PCS;
x_mh = mh_hx(li); 

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & mh_hx(i) >= 1
        noyes = noyes +1;
    elseif T4S.time_t_RTP(i) >  PCS & mh_hx(i) >= 1
        yesyes = yesyes+1;
    elseif T4S.time_t_RTP(i) <= PCS & mh_hx(i) == 0
        nono = nono +1;
    elseif T4S.time_t_RTP(i) > PCS & mh_hx(i) == 0
        yesno = yesno+1;
    end
end

li = ~isnan(T4.time_t_RTP) & ~isnan(b_total);
y_bsi = T4.time_t_RTP(li) > PCS;
x_bsi = b_total(li) >= BSI18_max; 

for i = 1:size(T4,1)
    if T4.time_t_RTP(i) <= PCS & b_total(i) >= BSI18_max
        noyes2 = noyes2 +1;
    elseif T4.time_t_RTP(i) > PCS & b_total(i) >= BSI18_max
        yesyes2 = yesyes2+1;
    elseif T4.time_t_RTP(i) <= PCS & b_total(i) < BSI18_max
        nono2 = nono2 +1;
    elseif T4.time_t_RTP(i) > PCS & b_total(i) < BSI18_max
        yesno2 = yesno2+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(scattotal);
y_scat = T4S.time_t_RTP(li) > PCS;
x_scat = scattotal(li)  >= SCAT_max; 

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & scattotal(i) >= SCAT_max
        noyes3 = noyes3 +1;
    elseif T4S.time_t_RTP(i) > PCS & scattotal(i) >= SCAT_max
        yesyes3 = yesyes3+1;
    elseif T4S.time_t_RTP(i) <= PCS & scattotal(i) < SCAT_max
        nono3 = nono3 +1;
    elseif T4S.time_t_RTP(i) > PCS & scattotal(i) < SCAT_max
        yesno3 = yesno3+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(ldhx);
y_ldhx = T4S.time_t_RTP(li) > PCS;
x_ldhx =  ldhx(li); 

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & ldhx(i) >= 1
        noyes4 = noyes4 +1;
    elseif T4S.time_t_RTP(i) > PCS & ldhx(i) >= 1
        yesyes4 = yesyes4+1;
    elseif T4S.time_t_RTP(i) <= PCS & ldhx(i) == 0
        nono4 = nono4 +1;
    elseif T4S.time_t_RTP(i) > PCS & ldhx(i) == 0
        yesno4 = yesno4+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(prevcon);
y_prevcon = T4S.time_t_RTP(li) > PCS;
x_prevcon = prevcon(li) >= 3; 

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & prevcon(i) >= 3
        noyes5 = noyes5 +1;
    elseif T4S.time_t_RTP(i) > PCS & prevcon(i) >= 3
        yesyes5 = yesyes5+1;
    elseif T4S.time_t_RTP(i) <= PCS & prevcon(i) < 3
        nono5 = nono5 +1;
    elseif T4S.time_t_RTP(i) > PCS & prevcon(i) < 3
        yesno5 = yesno5+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(mighx);
y_mighx = T4S.time_t_RTP(li) > PCS;
x_mighx = mighx(li) >= 1;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & mighx(i) >= 1
        noyes6 = noyes6 +1;
    elseif T4S.time_t_RTP(i) > PCS & mighx(i) >= 1
        yesyes6 = yesyes6+1;
    elseif T4S.time_t_RTP(i) <= PCS & mighx(i) == 0
        nono6 = nono6 +1;
    elseif T4S.time_t_RTP(i) > PCS & mighx(i) == 0
        yesno6 = yesno6+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(LOC);
y_loc = T4S.time_t_RTP(li) > PCS;
x_loc = LOC(li) >= 1;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & LOC(i) >= 1
        noyes7 = noyes7 +1;
    elseif T4S.time_t_RTP(i) > PCS & LOC(i) >= 1
        yesyes7 = yesyes7+1;
    elseif T4S.time_t_RTP(i) <= PCS & LOC(i) == 0
        nono7 = nono7 +1;
    elseif T4S.time_t_RTP(i) > PCS & LOC(i) == 0
        yesno7 = yesno7+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(sex);
y_sex = T4S.time_t_RTP(li) > PCS;
x_sex = sex(li) == 1;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & sex(i) == 1
        noyes8 = noyes8 +1;
    elseif T4S.time_t_RTP(i) > PCS & sex(i) == 1
        yesyes8 = yesyes8+1;
    elseif T4S.time_t_RTP(i) <= PCS & sex(i) == 2
        nono8 = nono8 +1;
    elseif T4S.time_t_RTP(i) > PCS & sex(i) == 2
        yesno8 = yesno8+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(ncaa);
y_noncon = T4S.time_t_RTP(li) > PCS;
x_noncon = ncaa(li) == 1;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & ncaa(i) == 1
        noyes9 = noyes9 +1;
    elseif T4S.time_t_RTP(i) > PCS & ncaa(i) == 1
        yesyes9 = yesyes9+1;
    elseif T4S.time_t_RTP(i) <= PCS & ncaa(i) ~= 1
        nono9 = nono9 +1;
    elseif T4S.time_t_RTP(i) > PCS & ncaa(i) ~= 1
        yesno9 = yesno9+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(ncaa);
y_limcon = T4S.time_t_RTP(li) > PCS;
x_limcon = ncaa(li) == 2;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & ncaa(i) == 2
        noyes10 = noyes10 +1;
    elseif T4S.time_t_RTP(i) > PCS & ncaa(i) == 2
        yesyes10 = yesyes10+1;
    elseif T4S.time_t_RTP(i) <= PCS & ncaa(i) ~= 2
        nono10 = nono10 +1;
    elseif T4S.time_t_RTP(i) > PCS & ncaa(i) ~= 2
        yesno10 = yesno10+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(ncaa);
y_contact = T4S.time_t_RTP(li) > PCS;
x_contact = ncaa(li) == 3;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & ncaa(i) == 3
        noyes11 = noyes11 +1;
    elseif T4S.time_t_RTP(i) > PCS & ncaa(i) == 3
        yesyes11 = yesyes11+1;
    elseif T4S.time_t_RTP(i) <= PCS & ncaa(i) ~= 3
        nono11 = nono11 +1;
    elseif T4S.time_t_RTP(i) > PCS & ncaa(i) ~= 3
        yesno11 = yesno11+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(ncaa);
y_nonncaa = T4S.time_t_RTP(li) > PCS;
x_nonncaa = ncaa(li) == 4;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & ncaa(i) == 4
        noyes12 = noyes12 +1;
    elseif T4S.time_t_RTP(i) > PCS & ncaa(i) == 4
        yesyes12 = yesyes12+1;
    elseif T4S.time_t_RTP(i) <= PCS & ncaa(i) ~= 4
        nono12 = nono12 +1;
    elseif T4S.time_t_RTP(i) > PCS & ncaa(i) ~= 4
        yesno12 = yesno12+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(situation);
y_practice = T4S.time_t_RTP(li) > PCS;
x_practice = situation(li) == 1;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & situation(i) == 1
        noyes13 = noyes13 +1;
    elseif T4S.time_t_RTP(i) > PCS & situation(i) == 1
        yesyes13 = yesyes13+1;
    elseif T4S.time_t_RTP(i) <= PCS & situation(i) ~= 1
        nono13 = nono13 +1;
    elseif T4S.time_t_RTP(i) > PCS & situation(i) ~= 1
        yesno13 = yesno13+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(situation);
y_comp = T4S.time_t_RTP(li) > PCS;
x_comp = situation(li) == 2;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & situation(i) == 2
        noyes14 = noyes14 +1;
    elseif T4S.time_t_RTP(i) > PCS & situation(i) == 2
        yesyes14 = yesyes14+1;
    elseif T4S.time_t_RTP(i) <= PCS & situation(i) ~= 2
        nono14 = nono14 +1;
    elseif T4S.time_t_RTP(i) > PCS & situation(i) ~= 2
        yesno14 = yesno14+1;
    end
end

li = ~isnan(T4S.time_t_RTP) & ~isnan(situation);
y_outside = T4S.time_t_RTP(li) > PCS;
x_outside = situation(li) == 3;
[noyes15, yesyes15, nono15, yesno15]=make_2_by_2(x_outside,y_outside);


li = ~isnan(T4S.time_t_RTP) & ~isnan(delayreport);
y_delay = T4S.time_t_RTP(li) > PCS;
x_delay = delayreport(li) == 1;

for i = 1:size(T4S,1)
    if T4S.time_t_RTP(i) <= PCS & delayreport(i) == 1
        noyes16 = noyes16 +1;
    elseif T4S.time_t_RTP(i) > PCS & delayreport(i) == 1
        yesyes16 = yesyes16+1;
    elseif T4S.time_t_RTP(i) <= PCS & delayreport(i) == 0
        nono16 = nono16 +1;
    elseif T4S.time_t_RTP(i) > PCS & delayreport(i) == 0
        yesno16 = yesno16+1;
    end
end

%li = ~isnan(T4S.time_t_RTP) & ~isnan(stimulant) & ~isnan(ldhx); % This doesn't match
% OLD
%li = ~isnan(T4S.time_t_RTP) & ~isnan(stimulant) & ~isnan(ldhx) & ...
%    ~(ldhx >=1 & stimulant ==0);
% New
li = ~isnan(T4S.time_t_RTP) & ~isnan(stimulant) & ~isnan(ldhx);


y_stim = T4S.time_t_RTP(li) > PCS;
x_stim = ldhx(li) >= 1 & stimulant(li) == 1;

[noyes17, yesyes17, nono17, yesno17]=make_2_by_2(x_stim,y_stim);



%li = ~isnan(T4S.time_t_RTP) & ~isnan(stimulant) & ~isnan(ldhx); % This doesn't match
% OLD
%li = ~isnan(T4S.time_t_RTP) & ~isnan(stimulant) & ~isnan(ldhx) & ...
%    ~(ldhx >=1 & stimulant ==1 );
% New 
li = ~isnan(T4S.time_t_RTP) & ~isnan(stimulant) & ~isnan(ldhx); 

y_nostim = T4S.time_t_RTP(li) > PCS;
x_nostim = ldhx(li) >= 1 & stimulant(li) == 0;
[noyes18, yesyes18, nono18, yesno18]=make_2_by_2(x_nostim,y_nostim);



hf = figure;
nlp_fig_prep(hf, 'Portrait');

%2x2 grids
%hx & rtp
ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [.25 8.5 2 2] );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [0 5]         );
set(gca,'ylim',      [0 4]         );
set(gca,'XTick',     [1 2 3 4]     );
set(gca,'YTick',     [1 2 3 4]     );
set(gca,'xcolor',    'none'        );
set(gca,'ycolor',    'none'        );

text(1.5,3.5,'+ Anx or Dep History');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2);


text(1,1.5,'Total');
text(1,2,  'No'   );
text(1,2.5,'Yes'  );
text(2,3,  'Yes'  );
text(3,3,  'No'   );
text(4,3,  'Total');
text(2,1.5,num2str(yesyes + noyes,               '%4.0f'));
text(2,2,  num2str(noyes,                        '%4.0f'));
text(2,2.5,num2str(yesyes,                       '%4.0f'));
text(3,1.5,num2str(yesno + nono,                 '%4.0f'));
text(3,2,  num2str(nono,                         '%4.0f'));
text(3,2.5,num2str(yesno,                        '%4.0f'));
text(4,1.5,num2str(yesyes + noyes + nono + yesno,'%4.0f'));
text(4,2,  num2str(noyes + nono,                 '%4.0f'));
text(4,2.5,num2str(yesyes + yesno,               '%4.0f'));

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes) '/' num2str(yesno) '}{' ...
   num2str(noyes) '/' num2str(nono) '}$ = ' ...
   num2str((yesyes/ yesno)/(noyes / nono),'%3.2f') ],'FontSize',12,'Interpreter','latex')

mh_or = (yesyes/ yesno)/(noyes / nono);


text(2,.5,['Reciprocal = ' num2str(1/mh_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%text(0,.5,['Odds Ratio =' num2str((yesyes/ yesno)/(noyes / nono))])

% Sep 2022 - Trying to figure out logitistic regression

%T = array2table([y_mh x_mh],'VariableNames',{'PCS','MH'});
%model_spec = 'PCS ~ MH';
%mdl2 = fitglm(T,model_spec,'Distribution','binomial')
%mdl3 = fitglm(T,model_spec,'link','logit','Distribution','binomial')

SE = sqrt( (1/yesyes) + (1/yesno) + (1/noyes) + (1/nono) );

%[OR_l,CI_l] = OR_Logistic1(y_mh, x_mh);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none' ); 

[OR_l, CI, P] = OR_Logistic2(y_mh, x_mh);


text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%keyboard
%
% BSI Total
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [3 8.5 2 2] );
set(gca,'FontSize',  12          );
set(gca,'xlim',      [0 5]       );
set(gca,'ylim',      [0 4]       );
set(gca,'XTick',   [1 2 3 4]     );
set(gca,'YTick',   [1 2 3 4]     );
set(gca,'xcolor','none'          );
set(gca,'ycolor','none'          );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK',  'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK',  'LineWidth',2)

text(1.5,3.5,'BSI Total Score >10');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes2 + noyes2],'%4.0f'))
text(2,2,num2str(noyes2,'%4.0f'))
text(2,2.5,num2str(yesyes2,'%4.0f'))
text(3,1.5,num2str([yesno2 + nono2],'%4.0f'))
text(3,2,num2str(nono2,'%4.0f'))
text(3,2.5,num2str(yesno2,'%4.0f'))
text(4,1.5,num2str([yesyes2 + noyes2 + nono2 + yesno2],'%4.0f'))
text(4,2,num2str(noyes2 + nono2,'%4.0f'))
text(4,2.5,num2str(yesyes2 + yesno2,'%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes2) '/'  num2str(yesno2) '}{' ...
   num2str(noyes2) '/' num2str(nono2) '}$ = ' ...
   num2str((yesyes2/ yesno2)/(noyes2 / nono2),'%3.2f') ],'FontSize',12,'Interpreter','latex')

% text(0,.5,['Odds Ratio =' num2str((yesyes2/ yesno2)/(noyes2 / nono2))])

bsi_or = (yesyes2/ yesno2)/(noyes2 / nono2);
text(2,.5,['Reciprocal = ' num2str(1/bsi_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%[OR_l,CI_l] = OR_Logistic1(y_bsi, x_bsi);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none' ); 

[OR_l, CI, P] = OR_Logistic2(y_bsi, x_bsi);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% SCAT total & rtp
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [5.75 8.5 2 2] );
set(gca,'FontSize',  12             );
set(gca,'xlim',      [0 5]          );
set(gca,'ylim',      [0 4]          );
set(gca,'XTick',     [1 2 3 4]      );
set(gca,'YTick',     [1 2 3 4]      );
set(gca,'xcolor','none'             );
set(gca,'ycolor','none'             );

text(1.5,3.5,'SCAT Total Score >45');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS)],'Rotation',90);

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK',  'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK',  'LineWidth',2)

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes3 + noyes3],'%4.0f'))
text(2,2,num2str(noyes3,'%4.0f'))
text(2,2.5,num2str(yesyes3,'%4.0f'))
text(3,1.5,num2str([yesno3 + nono3],'%4.0f'))
text(3,2,num2str(nono3,'%4.0f'))
text(3,2.5,num2str(yesno3,'%4.0f'))
text(4,1.5,num2str([yesyes3 + noyes3 + nono3 + yesno3],'%4.0f'))
text(4,2,num2str(noyes3 + nono3,'%4.0f'))
text(4,2.5,num2str(yesyes3 + yesno3,'%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes3) '/'  num2str(yesno3) '}{' ...
   num2str(noyes3) '/' num2str(nono3) '}$ = ' ...
   num2str((yesyes3/ yesno3)/(noyes3 / nono3),'%3.2f') ],'FontSize',12,'Interpreter','latex')
% text(0,.5,['Odds Ratio =' num2str((yesyes3/ yesno3)/(noyes3 / nono3))])

scat_or = (yesyes3/ yesno3)/(noyes3 / nono3);
text(2,.5,['Reciprocal = ' num2str(1/scat_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%[OR_l,CI_l] = OR_Logistic1(y_scat, x_scat);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none' ); 

[OR_l, CI, P] = OR_Logistic2(y_scat, x_scat);

text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Learning Disability Hx
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [.25 6 2 2]  );
set(gca,'FontSize',  12           );
set(gca,'xlim',      [0 5]        );
set(gca,'ylim',      [0 4]        );
set(gca,'XTick',   [1 2 3 4]      );
set(gca,'YTick',   [1 2 3 4]      );
set(gca,'xcolor','none'           );
set(gca,'ycolor','none'           );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK',  'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK',  'LineWidth',2)

text(1.5,3.5,'Learning Disability Hx');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes4 + noyes4],'%4.0f'))
text(2,2,num2str(noyes4,'%4.0f'))
text(2,2.5,num2str(yesyes4,'%4.0f'))
text(3,1.5,num2str([yesno4 + nono4],'%4.0f'))
text(3,2,num2str(nono4,'%4.0f'))
text(3,2.5,num2str(yesno4,'%4.0f'))
text(4,1.5,num2str([yesyes4 + noyes4 + nono4 + yesno4],'%4.0f'))
text(4,2,num2str(noyes4 + nono4,'%4.0f'))
text(4,2.5,num2str(yesyes4 + yesno4,'%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes4) '/'  num2str(yesno4) '}{' ...
   num2str(noyes4) '/' num2str(nono4) '}$ = ' ...
   num2str((yesyes4/ yesno4)/(noyes4 / nono4),'%3.2f') ],'FontSize',12,'Interpreter','latex')
% text(0,.5,['Odds Ratio =' num2str((yesyes4/ yesno4)/(noyes4 / nono4))])
lad_or = (yesyes4/ yesno4)/(noyes4 / nono4);
text(2,.5,['Reciprocal = ' num2str(1/lad_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%[OR_l,CI_l] = OR_Logistic1(y_ldhx, x_ldhx);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none' ); 

[OR_l, CI, P] = OR_Logistic2(y_ldhx, x_ldhx);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Prevcon
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [3 6 2 2]   );
set(gca,'FontSize',  12          );
set(gca,'xlim',      [0 5]       );
set(gca,'ylim',      [0 4]       );
set(gca,'XTick',     [1 2 3 4]   );
set(gca,'YTick',     [1 2 3 4]   );
set(gca,'xcolor',    'none'      );
set(gca,'ycolor',    'none'      );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2)

text(1.1,3.5,'Previous Concussion >=3');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes5 + noyes5],'%4.0f'))
text(2,2,num2str(noyes5,'%4.0f'))
text(2,2.5,num2str(yesyes5,'%4.0f'))
text(3,1.5,num2str([yesno5 + nono5],'%4.0f'))
text(3,2,num2str(nono5,'%4.0f'))
text(3,2.5,num2str(yesno5,'%4.0f'))
text(4,1.5,num2str([yesyes5 + noyes5 + nono5 + yesno5],'%4.0f'))
text(4,2,num2str(noyes5 + nono5,'%4.0f'))
text(4,2.5,num2str(yesyes5 + yesno5,'%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes5) '/'  num2str(yesno5) '}{' ...
   num2str(noyes5) '/' num2str(nono5) '}$ = ' ...
   num2str((yesyes5/ yesno5)/(noyes5 / nono5),'%3.2f') ],'FontSize',12,'Interpreter','latex')
% text(0,.5,['Odds Ratio =' num2str((yesyes5/ yesno5)/(noyes5 / nono5))])
prevcon_or = (yesyes5/ yesno5)/(noyes5 / nono5);
text(2,.5,['Reciprocal = ' num2str(1/prevcon_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_prevcon, x_prevcon);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI] = OR_Logistic1(y_prevcon, x_prevcon);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Migraine
%
ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [5.75 6 2 2]  );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [0 5]         );
set(gca,'ylim',      [0 4]         );
set(gca,'XTick',   [1 2 3 4]       );
set(gca,'YTick',   [1 2 3 4]       );
set(gca,'xcolor','none'            );
set(gca,'ycolor','none'            );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK',  'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK',  'LineWidth',2)

text(1.5,3.5,'Migraine Hx');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes6 + noyes6],'%4.0f'))
text(2,2,num2str(noyes6,'%4.0f'))
text(2,2.5,num2str(yesyes6,'%4.0f'))
text(3,1.5,num2str([yesno6 + nono6],'%4.0f'))
text(3,2,num2str(nono6,'%4.0f'))
text(3,2.5,num2str(yesno6,'%4.0f'))
text(4,1.5,num2str([yesyes6 + noyes6 + nono6 + yesno6],'%4.0f'))
text(4,2,num2str(noyes6 + nono6,'%4.0f'))
text(4,2.5,num2str(yesyes6 + yesno6,'%4.0f'))


text(0,1,['Odds Ratio = $\frac{' num2str(yesyes6) '/'  num2str(yesno6) '}{' ...
   num2str(noyes6) '/' num2str(nono6) '}$ = ' ...
   num2str((yesyes6/ yesno6)/(noyes6 / nono6),'%3.2f') ],'FontSize',12,'Interpreter','latex')
% text(0,.5,['Odds Ratio =' num2str((yesyes6/ yesno6)/(noyes6 / nono6))])
mig_or = (yesyes6/ yesno6)/(noyes6 / nono6)
text(2,.5,['Reciprocal = ' num2str(1/mig_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_mighx, x_mighx);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_mighx, x_mighx);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% LOC
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [.25 3.5 2 2] );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [0 5]         );
set(gca,'ylim',      [0 4]         );
set(gca,'XTick',     [1 2 3 4]     );
set(gca,'YTick',     [1 2 3 4]     );
set(gca,'xcolor',    'none'        );
set(gca,'ycolor',    'none'        );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK',  'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK',  'LineWidth',2)

text(1.5,3.5,'Loss of Conciousness');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes7 + noyes7],'%4.0f'))
text(2,2,num2str(noyes7,'%4.0f'))
text(2,2.5,num2str(yesyes7,'%4.0f'))
text(3,1.5,num2str([yesno7 + nono7],'%4.0f'))
text(3,2,num2str(nono7,'%4.0f'))
text(3,2.5,num2str(yesno7,'%4.0f'))
text(4,1.5,num2str([yesyes7 + noyes7 + nono7 + yesno7],'%4.0f'))
text(4,2,num2str(noyes7 + nono7,'%4.0f'))
text(4,2.5,num2str(yesyes7 + yesno7,'%4.0f'))


text(0,1,['Odds Ratio = $\frac{' num2str(yesyes7) '/'  num2str(yesno7) '}{' ...
   num2str(noyes7) '/' num2str(nono7) '}$ = ' ...
   num2str((yesyes7/ yesno7)/(noyes7 / nono7),'%3.2f') ],'FontSize',12,'Interpreter','latex')

loc_or = (yesyes7/ yesno7)/(noyes7 / nono7);
text(2,.5,['Reciprocal = ' num2str(1/loc_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_loc, x_loc);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_loc, x_loc);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Sex
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [3 3.5 2 2]   );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [0 5]         );
set(gca,'ylim',      [0 4]         );
set(gca,'XTick',     [1 2 3 4]     );
set(gca,'YTick',     [1 2 3 4]     );
set(gca,'xcolor',    'none'        );
set(gca,'ycolor',    'none'        );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2);

text(1.5,3.5,'Sex');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes8 + noyes8],                 '%4.0f'))
text(2,2,  num2str(noyes8,                             '%4.0f'))
text(2,2.5,num2str(yesyes8,                            '%4.0f'))
text(3,1.5,num2str([yesno8 + nono8],                   '%4.0f'))
text(3,2,  num2str(nono8,                              '%4.0f'))
text(3,2.5,num2str(yesno8,                             '%4.0f'))
text(4,1.5,num2str([yesyes8 + noyes8 + nono8 + yesno8],'%4.0f'))
text(4,2,  num2str(noyes8 + nono8,                     '%4.0f'))
text(4,2.5,num2str(yesyes8 + yesno8,                   '%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes8) '/'  num2str(yesno8) '}{' ...
   num2str(noyes8) '/' num2str(nono8) '}$ = ' ...
   num2str((yesyes8/ yesno8)/(noyes8 / nono8),'%3.2f') ],'FontSize',12,'Interpreter','latex')
sex_or = (yesyes8/ yesno8)/(noyes8 / nono8);
text(2,.5,['Reciprocal = ' num2str(1/sex_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_sex, x_sex);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_sex, x_sex);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Non-Contact
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [5.75 3.5 2 2] );
set(gca,'FontSize',  12             );
set(gca,'xlim',      [0 5]          );
set(gca,'ylim',      [0 4]          );
set(gca,'XTick',     [1 2 3 4]      );
set(gca,'YTick',     [1 2 3 4]      );
set(gca,'xcolor',    'none'         );
set(gca,'ycolor',    'none'         );

plot([1 5],[1.75 1.75],'-','Color',BLACK',  'LineWidth', 2);
plot([1 5],[2.25 2.25],'-','Color',BLACK',  'LineWidth', 2);
plot([1 5],[2.75 2.75],'-','Color',BLACK',  'LineWidth', 2);

text(1.5,3.5,'Non Contact');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total');
text(1,2,  'No'   );
text(1,2.5,'Yes'  );
text(2,3,  'Yes'  );
text(3,3,  'No'   );
text(4,3,  'Total');
text(2,1.5,num2str(yesyes9 + noyes9,                   '%4.0f'));
text(2,2,  num2str(noyes9,                             '%4.0f'));
text(2,2.5,num2str(yesyes9,                            '%4.0f'));
text(3,1.5,num2str(yesno9 + nono9,                     '%4.0f'));
text(3,2,  num2str(nono9,                              '%4.0f'));
text(3,2.5,num2str(yesno9,                             '%4.0f'));
text(4,1.5,num2str(yesyes9 + noyes9 + nono9 + yesno9,  '%4.0f'));
text(4,2,  num2str(noyes9 + nono9,                     '%4.0f'));
text(4,2.5,num2str(yesyes9 + yesno9,                   '%4.0f'));

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes9) '/'  num2str(yesno9) '}{' ...
   num2str(noyes9) '/' num2str(nono9) '}$ = ' ...
   num2str((yesyes9/ yesno9)/(noyes9 / nono9),'%3.2f') ],'FontSize',12,'Interpreter','latex')
noncon_or = (yesyes9/ yesno9)/(noyes9 / nono9);
text(2,.5,['Reciprocal = ' num2str(1/noncon_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_noncon, x_noncon);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_noncon, x_noncon);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Limited Contact
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [.25 1 2 2]   );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [0 5]         );
set(gca,'ylim',      [0 4]         );
set(gca,'XTick',     [1 2 3 4]     );
set(gca,'YTick',     [1 2 3 4]     );
set(gca,'xcolor',    'none'        );
set(gca,'ycolor',    'none'        );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2)

text(1.5,3.5,'Limited Contact');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes10 + noyes10],                 '%4.0f'))
text(2,2,  num2str(noyes10,                             '%4.0f'))
text(2,2.5,num2str(yesyes10,                            '%4.0f'))
text(3,1.5,num2str([yesno10 + nono10],                   '%4.0f'))
text(3,2,  num2str(nono10,                              '%4.0f'))
text(3,2.5,num2str(yesno10,                             '%4.0f'))
text(4,1.5,num2str([yesyes10 + noyes10 + nono10 + yesno10],'%4.0f'))
text(4,2,  num2str(noyes10 + nono10,                     '%4.0f'))
text(4,2.5,num2str(yesyes10 + yesno10,                   '%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes10) '/'  num2str(yesno10) '}{' ...
   num2str(noyes10) '/' num2str(nono10) '}$ = ' ...
   num2str((yesyes10/ yesno10)/(noyes10 / nono10),'%3.2f') ],'FontSize',12,'Interpreter','latex')
limcon_or = (yesyes10/ yesno10)/(noyes10 / nono10);
text(2,.5,['Reciprocal = ' num2str(1/limcon_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_limcon, x_limcon);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_limcon, x_limcon);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );

%
% Contact
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [3 1 2 2]    );
set(gca,'FontSize',  12           );
set(gca,'xlim',      [0 5]        );
set(gca,'ylim',      [0 4]        );
set(gca,'XTick',     [1 2 3 4]    );
set(gca,'YTick',     [1 2 3 4]    );
set(gca,'xcolor',    'none'       );
set(gca,'ycolor',    'none'       );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2);

text(1.5,3.5,'Contact');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes11 + noyes11],                 '%4.0f'))
text(2,2,  num2str(noyes11,                             '%4.0f'))
text(2,2.5,num2str(yesyes11,                            '%4.0f'))
text(3,1.5,num2str([yesno11 + nono11],                   '%4.0f'))
text(3,2,  num2str(nono11,                              '%4.0f'))
text(3,2.5,num2str(yesno11,                             '%4.0f'))
text(4,1.5,num2str([yesyes11 + noyes11 + nono11 + yesno11],'%4.0f'))
text(4,2,  num2str(noyes11 + nono11,                     '%4.0f'))
text(4,2.5,num2str(yesyes11 + yesno11,                   '%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes11) '/'  num2str(yesno11) '}{' ...
   num2str(noyes11) '/' num2str(nono11) '}$ = ' ...
   num2str((yesyes11/ yesno11)/(noyes11 / nono11),'%3.2f') ],'FontSize',12,'Interpreter','latex')
contact_or = (yesyes11/ yesno11)/(noyes11 / nono11);
text(2,.5,['Reciprocal  = ' num2str(1/contact_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_contact, x_contact);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_contact, x_contact);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Non-NCAA
%
ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [5.75 1 2 2]  );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [0 5]         );
set(gca,'ylim',      [0 4]         );
set(gca,'XTick',     [1 2 3 4]     );
set(gca,'YTick',     [1 2 3 4]     );
set(gca,'xcolor',    'none'        );
set(gca,'ycolor',    'none'        );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2);

text(1.5,3.5,'Cadet');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes12 + noyes12],                 '%4.0f'))
text(2,2,  num2str(noyes12,                             '%4.0f'))
text(2,2.5,num2str(yesyes12,                            '%4.0f'))
text(3,1.5,num2str([yesno12 + nono12],                   '%4.0f'))
text(3,2,  num2str(nono12,                              '%4.0f'))
text(3,2.5,num2str(yesno12,                             '%4.0f'))
text(4,1.5,num2str([yesyes12 + noyes12 + nono12 + yesno12],'%4.0f'))
text(4,2,  num2str(noyes12 + nono12,                     '%4.0f'))
text(4,2.5,num2str(yesyes12 + yesno12,                   '%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes12) '/'  num2str(yesno12) '}{' ...
   num2str(noyes12) '/' num2str(nono12) '}$ = ' ...
   num2str((yesyes12/ yesno12)/(noyes12 / nono12),'%3.2f') ],'FontSize',12,'Interpreter','latex')
nonncaa_or = (yesyes12/ yesno12)/(noyes12 / nono12);
text(2,.5,['Reciprocal = ' num2str(1/nonncaa_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_nonncaa, x_nonncaa);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_nonncaa, x_nonncaa);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );


text (0,-1,'Rooks et al Suppl. Fig. 4');
%text (0,-1,'Rooks et al Suppl. Fig. 5');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

% Next OR figure

%
% Practice
%
hf = figure;
nlp_fig_prep(hf, 'Portrait');
%practice
ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [.25 8.5 2 2]  );
set(gca,'FontSize',  12             );
set(gca,'xlim',      [0 5]          );
set(gca,'ylim',      [0 4]          );
set(gca,'XTick',     [1 2 3 4]      );
set(gca,'YTick',     [1 2 3 4]      );
set(gca,'xcolor',    'none'         );
set(gca,'ycolor',    'none'         );

text(1.5,3.5,'Practice');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2);


text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes13 + noyes13],'%4.0f'))
text(2,2,num2str(noyes13,'%4.0f'))
text(2,2.5,num2str(yesyes13,'%4.0f'))
text(3,1.5,num2str([yesno13 + nono13],'%4.0f'))
text(3,2,num2str(nono13,'%4.0f'))
text(3,2.5,num2str(yesno13,'%4.0f'))
text(4,1.5,num2str([yesyes13 + noyes13 + nono13 + yesno13],'%4.0f'))
text(4,2,num2str(noyes13 + nono13,'%4.0f'))
text(4,2.5,num2str(yesyes13 + yesno13,'%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes13) '/' num2str(yesno13) '}{' ...
   num2str(noyes13) '/' num2str(nono13) '}$ = ' ...
   num2str((yesyes13/ yesno13)/(noyes13 / nono13),'%3.2f') ],'FontSize',12,'Interpreter','latex')

practice_or = (yesyes13/ yesno13)/(noyes13 / nono13);
text(2,.5,['Reciprocal = ' num2str(1/practice_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_practice, x_practice);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_practice, x_practice);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Competition
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [3 8.5 2 2]  );
set(gca,'FontSize',  12           );
set(gca,'xlim',      [0 5]        );
set(gca,'ylim',      [0 4]        );
set(gca,'XTick',     [1 2 3 4]    );
set(gca,'YTick',     [1 2 3 4]    );
set(gca,'xcolor',    'none'       );
set(gca,'ycolor',    'none'       );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2)

text(1.5,3.5,'Competition');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes14 + noyes14],'%4.0f'))
text(2,2,num2str(noyes14,'%4.0f'))
text(2,2.5,num2str(yesyes14,'%4.0f'))
text(3,1.5,num2str([yesno14 + nono14],'%4.0f'))
text(3,2,num2str(nono14,'%4.0f'))
text(3,2.5,num2str(yesno14,'%4.0f'))
text(4,1.5,num2str([yesyes14 + noyes14 + nono14 + yesno14],'%4.0f'))
text(4,2,num2str(noyes14 + nono14,'%4.0f'))
text(4,2.5,num2str(yesyes14 + yesno14,'%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes14) '/'  num2str(yesno14) '}{' ...
   num2str(noyes14) '/' num2str(nono14) '}$ = ' ...
   num2str((yesyes14/ yesno14)/(noyes14 / nono14),'%3.2f') ],'FontSize',12,'Interpreter','latex')
comp_or = (yesyes14/ yesno14)/(noyes14 / nono14);
text(2,.5,['Reciprocal = ' num2str(1/comp_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_comp, x_comp);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_comp, x_comp);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Outside Sport
%
 
ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [5.75 8.5 2 2] );
set(gca,'FontSize',  12             );
set(gca,'xlim',      [0 5]          );
set(gca,'ylim',      [0 4]          );
set(gca,'XTick',     [1 2 3 4]      );
set(gca,'YTick',     [1 2 3 4]      );
set(gca,'xcolor',    'none'         );
set(gca,'ycolor',    'none'         );

text(1.5,3.5,'Outside Sport');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS)],'Rotation',90);

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2)

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str( yesyes15 + noyes15,                   '%4.0f'));
text(2,2,num2str(   noyes15,                              '%4.0f'));
text(2,2.5,num2str( yesyes15,                             '%4.0f'));
text(3,1.5,num2str( yesno15 + nono15,                     '%4.0f'));
text(3,2,num2str(   nono15,                               '%4.0f'));
text(3,2.5,num2str( yesno15,                              '%4.0f'));
text(4,1.5,num2str( yesyes15 + noyes15 + nono15 + yesno15,'%4.0f'));
text(4,2,num2str(   noyes15 + nono15,                     '%4.0f'));
text(4,2.5,num2str( yesyes15 + yesno15,                   '%4.0f'));

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes15) '/'  num2str(yesno15) '}{' ...
   num2str(noyes15) '/' num2str(nono15) '}$ = ' ...
   num2str((yesyes15/ yesno15)/(noyes15 / nono15),'%3.2f') ],'FontSize',12,'Interpreter','latex')

outside_or = (yesyes15/ yesno15)/(noyes15 / nono15);
text(2,.5,['Reciprocal = ' num2str(1/outside_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_outside, x_outside);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_outside, x_outside);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Delayed Reporting
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [.25 6 2 2] );
set(gca,'FontSize',  12          );
set(gca,'xlim',      [0 5]       );
set(gca,'ylim',      [0 4]       );
set(gca,'XTick',     [1 2 3 4]   );
set(gca,'YTick',     [1 2 3 4]   );
set(gca,'xcolor',    'none'      );
set(gca,'ycolor',    'none'      );

text(1.5,3.5,'Reported Late');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS)],'Rotation',90);

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2)
plot([1 5],[2.25 2.25],'-','Color',BLACK',  'LineWidth',2)
plot([1 5],[2.75 2.75],'-','Color',BLACK',  'LineWidth',2)

text(1,1.5,'Total')
text(1,2,'No')
text(1,2.5,'Yes')
text(2,3,'Yes')
text(3,3,'No')
text(4,3,'Total')
text(2,1.5,num2str([yesyes16 + noyes16],'%4.0f'))
text(2,2,num2str(noyes16,'%4.0f'))
text(2,2.5,num2str(yesyes16,'%4.0f'))
text(3,1.5,num2str([yesno16 + nono16],'%4.0f'))
text(3,2,num2str(nono16,'%4.0f'))
text(3,2.5,num2str(yesno16,'%4.0f'))
text(4,1.5,num2str([yesyes16 + noyes16 + nono16 + yesno16],'%4.0f'))
text(4,2,num2str(noyes16 + nono16,'%4.0f'))
text(4,2.5,num2str(yesyes16 + yesno16,'%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes16) '/'  num2str(yesno16) '}{' ...
   num2str(noyes16) '/' num2str(nono16) '}$ = ' ...
   num2str((yesyes16/ yesno16)/(noyes16 / nono16),'%3.2f') ],'FontSize',12,'Interpreter','latex')
% text(0,.5,['Odds Ratio =' num2str((yesyes3/ yesno3)/(noyes3 / nono3))])

delay_or = (yesyes16/ yesno16)/(noyes16 / nono16)
text(2,.5,['Reciprocal = ' num2str(1/delay_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_delay, x_delay);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_delay, x_delay);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
%
% Stimulant
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [3 6 2 2]   );
set(gca,'FontSize',  12          );
set(gca,'xlim',      [0 5]       );
set(gca,'ylim',      [0 4]       );
set(gca,'XTick',     [1 2 3 4]   );
set(gca,'YTick',     [1 2 3 4]   );
set(gca,'xcolor',    'none'      );
set(gca,'ycolor',    'none'      );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2);

text(1.1,3.5,'LAD +stimulant');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total');
text(1,2,  'No'   );
text(1,2.5,'Yes'  );
text(2,3,  'Yes'  );
text(3,3,  'No'   );
text(4,3,  'Total');
text(2,1.5,num2str(yesyes17 + noyes17,                   '%4.0f'))
text(2,2,num2str(  noyes17,                              '%4.0f'))
text(2,2.5,num2str(yesyes17,                             '%4.0f'))
text(3,1.5,num2str(yesno17 + nono17,                     '%4.0f'))
text(3,2,num2str(  nono17,                               '%4.0f'))
text(3,2.5,num2str(yesno17,                              '%4.0f'))
text(4,1.5,num2str(yesyes17 + noyes17 + nono17 + yesno17,'%4.0f'))
text(4,2,num2str(  noyes17 + nono17,                     '%4.0f'))
text(4,2.5,num2str(yesyes17 + yesno17,                   '%4.0f'))

text(0,1,['Odds Ratio = $\frac{' num2str(yesyes17) '/'  num2str(yesno17) '}{' ...
   num2str(noyes17) '/' num2str(nono17) '}$ = ' ...
   num2str((yesyes17/ yesno17)/(noyes17 / nono17),'%3.2f') ],'FontSize',12,'Interpreter','latex')
% text(0,.5,['Odds Ratio =' num2str((yesyes5/ yesno5)/(noyes5 / nono5))])
stimulant_or = (yesyes17/ yesno17)/(noyes17 / nono17)
text(2,.5,['Reciprocal = ' num2str(1/stimulant_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

%OR_l = OR_Logistic1(y_stim, x_stim);
%text(2,0,['OR_L = ' num2str(OR_l,'%4.3f' )],'FontSize',12,'Interpreter','none'  );

[OR_l, CI, P] = OR_Logistic2(y_stim, x_stim);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );

%
% No Stim
%

ha=axes;
nlp_axes_prep(ha);
hold on

set(gca,'Position',  [5.75 6 2 2]  );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [0 5]         );
set(gca,'ylim',      [0 4]         );
set(gca,'XTick',     [1 2 3 4]     );
set(gca,'YTick',     [1 2 3 4]     );
set(gca,'xcolor',    'none'        );
set(gca,'ycolor',    'none'        );

plot([1 5],[1.75 1.75],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.25 2.25],'-','Color',BLACK', 'LineWidth',2);
plot([1 5],[2.75 2.75],'-','Color',BLACK', 'LineWidth',2);

text(1.5,3.5,'LAD -stimulant');
ht=text(.5,1.5,['Return to Play > ' num2str(PCS) ],'Rotation',90);

text(1,1.5,'Total')
text(1,2,  'No')
text(1,2.5,'Yes')
text(2,3,  'Yes')
text(3,3,  'No')
text(4,3,  'Total')
text(2,1.5,num2str(yesyes18 + noyes18,                    '%4.0f'))
text(2,2,  num2str(noyes18,                               '%4.0f'))
text(2,2.5,num2str(yesyes18,                              '%4.0f'))
text(3,1.5,num2str(yesno18 + nono18,                      '%4.0f'))
text(3,2,  num2str(nono18,                                '%4.0f'))
text(3,2.5,num2str(yesno18,                               '%4.0f'))
text(4,1.5,num2str(yesyes18 + noyes18 + nono18 + yesno18, '%4.0f'))
text(4,2,  num2str(noyes18 + nono18,                      '%4.0f'))
text(4,2.5,num2str(yesyes18 + yesno18,                    '%4.0f'))


fubar = text(0,1,['Odds Ratio = $\frac{' num2str(yesyes18) '/'  num2str(yesno18) '}{' ...
   num2str(noyes18) '/' num2str(nono18) '}$ = ' ...
   num2str((yesyes18/ yesno18)/(noyes18 / nono18),'%3.2f') ],'FontSize',12,'Interpreter','latex')
% text(0,.5,['Odds Ratio =' num2str((yesyes6/ yesno6)/(noyes6 / nono6))])
nostimulant_or = (yesyes18/ yesno18)/(noyes18 / nono18)
text(2,.5,['Reciprocal = ' num2str(1/nostimulant_or,'%3.2f' )],'FontSize',12,'Interpreter','latex' )

[OR_l, CI, P] = OR_Logistic2(y_nostim, x_nostim);
text(0.0,0,['Logistic OR (CI) = ' num2str(OR_l,'%4.2f' ) ' (' num2str(CI(1),'%3.2f') '-' num2str(CI(2),'%3.2f') ')' NL ' \itp\rm=' num2str(P,'%4.3f')],'FontSize',11  );
text (0,-1,'Rooks et al Suppl Fig 5');
%text (0,-1,'Rooks et al Suppl Fig. 6');



% Clear for the next section
clear CI



% Sep 5, 2022
% Trying to figure out how to do OR with logistic regression on single
% variabes



y_fubar = vertcat( ones((yesyes16+yesno16),1), zeros((noyes16+nono16),1) );
x_fubar = vertcat( ones((yesyes16+noyes16),1), zeros((yesno16+nono16),1) );

T = array2table([y_fubar x_fubar],'VariableNames',{'PCS','Delayed_Reporting'});
model_spec = 'PCS ~ Delayed_Reporting';
mdl2 = fitglm(T,model_spec,'Distribution','binomial')

%mdl3 = fitglm(T,model_spec,'CategoricalVars',[1,2],'Distribution','binomial')
%mdl3 = fitglm(T,model_spec,'CategoricalVars',logical([1 1]),'Distribution','binomial')

% Figure out the OR
exp(mdl2.Coefficients{2,1})  % DONT THINK THIS WORKS 

%keyboard



%%%%%%%%


%
%text(0,.5,['Odds Ratio = $\frac{' num2str(yesyes8) '/'  num2str(yesno8) '}{' ...
%   num2str(noyes8) '/' num2str(nono8) '}$' ],'Interpreter','latex')


%text(0,.5,['Odds Ratio = ' num2str(yesyes8) '/'  num2str(yesno8) '/' ...
%   num2str(noyes8) '/' num2str(nono8) ])

%text(0,0,['=' num2str((yesyes8/ yesno8)/(noyes8 / nono8))])

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                  Stat Models
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Make a table for logistic regression

% Find the high scat values and high bsi18 values
nan_pcs      = find(isnan(T4S.time_t_RTP      ));
nan_scat     = find(isnan(T4S.scatsxsev_score ));
nan_prev_con = find(isnan(T4S.prev_concuss    ));
nan_mig      = find(isnan(T4S.migraine        ));
nan_loc      = find(isnan(T4S.LOC             ));
nan_sex      = find(isnan(T4S.sex             ));
nan_ncaa     = find(isnan(T4S.ncaa            ));



%nan_bsi18 = find(isnan(b_total            ));

pcs          = real( T4S.time_t_RTP       > PCS       );
scat_high    = real( T4S.scatsxsev_score  >= SCAT_max );
prev_concuss = real( T4S.prev_concuss     >=3         );
migraine     = real( T4S.migraine         == 1        );
loc          = real( T4S.LOC              == 1        );
sex          = real( T4S.sex              == 1        );
ncaa         = real( T4S.ncaa             >= 1        );



%bsi18_high = real( b_total   >= BSI18_max          );

pcs(         nan_pcs      )   = NaN;
scat_high(   nan_scat     )   = NaN;
prev_concuss(nan_prev_con )   = NaN;
migraine(nan_mig          )   = NaN;
loc(nan_loc               )   = NaN;
sex(nan_sex               )   = NaN;
ncaa(nan_ncaa             )   = NaN;


%bsi18_high(nan_bsi18) = NaN;

%  Need to fix any sums.  We are treating these variables as binary
mh     = [T4S.anx_hx] + [T4S.dep_hx];
lad    = [T4S.ld]     + [T4S.add];
noncontact = zeros(size(ncaa,1),1);
limcon     = zeros(size(ncaa,1),1);
contact    = zeros(size(ncaa,1),1);
nonncaa    = zeros(size(ncaa,1),1);
practice   = zeros(size(ncaa,1),1);
comp       = zeros(size(ncaa,1),1);
outside    = zeros(size(ncaa,1),1);
stim       = zeros(size(ncaa,1),1);
nostim     = zeros(size(ncaa,1),1);

i_mh         = find(mh   == 2);
i_lad        = find(lad  == 2);
i_noncon     = find(T4S.ncaa == 1);
i_limcon     = find(T4S.ncaa == 2);
i_contact    = find(T4S.ncaa == 3);
i_nonncaa    = find(T4S.ncaa == 4);
i_practice   = find(T4S.situation == 1);
i_comp       = find(T4S.situation == 2);
i_outside    = find(T4S.situation == 3);



%i_delay      = find(T4S.daysreportedlate == 1);


mh( i_mh )               = 1;
lad(i_lad)               = 1;
noncontact(i_noncon    ) = 1;
limcon(    i_limcon    ) = 1;
contact(   i_contact   ) = 1;
nonncaa(   i_nonncaa   ) = 1;
practice(  i_practice  ) = 1;
comp(      i_comp      ) = 1;
outside(   i_outside   ) = 1;


i_stim   = find(lad == 1 & T4S.stimulant == 1);
i_nostim = find(lad == 1 & T4S.stimulant == 0);
i_nolad  = find(lad == 0 );

stim(      i_stim    ) = 1;
nostim(    i_nostim  ) = 1;
nolad(     i_nolad   ) = 1;




% Sanity check - pass save
sum(~isnan(pcs(i_noncon    )))
sum(~isnan(pcs(i_limcon    )))
sum(~isnan(pcs(i_contact   )))
sum(~isnan(pcs(i_nonncaa   )))
sum(~isnan(pcs(i_stim      )))
sum(~isnan(pcs(i_nostim    )))

%keyboard

%T=array2table([ T4.scatsxsev_score T4.sex lad T4.migraine T4.LOC mh T4.prev_concuss pcs scat_high bsi18_high], ...
%   'VariableNames',{'scatsxsev_score', 'sex', 'lad', 'migraine', 'loc', 'mh', 'prev_concuss', 'pcs', 'scat_high','bsi18_high' } );

%T=array2table([ T4s.scatsxsev_score T4s.sex lad T4s.migraine T4s.LOC mh T4s.prev_concuss pcs scat_high bsi18_high T4s.ncaa], ...
%   'VariableNames',{'scatsxsev_score', 'sex', 'lad', 'migraine', 'loc', 'mh', 'prev_concuss', 'pcs', 'scat_high','bsi18_high', 'ncaa' } );

% This should n
%T=array2table([ T4S.scatsxsev_score T4S.sex lad T4S.migraine T4S.LOC mh prev_concuss pcs scat_high T4S.ncaa T4S.situation T4S.daysreportedlate], ...
%   'VariableNames',{'scatsxsev_score', 'sex', 'lad', 'migraine', 'loc', 'mh', 'prev_concuss', 'pcs', 'scat_high', 'ncaa', 'situation', 'delayreport'} );


% Oct 6, 2022 - Accorrding to some websites about how to deal with
% catagorical varabiles.  One picks a reference and then dummy codes the
% others as binary
% https://www.theanalysisfactor.com/odds-ratio-categorical-predictor/
% 
% So, for situtation, we will code the variables to the left: comp &
% practice, they will be compared to outside_competition
% Simillar for NCAA.  Non NCAA is to the right, so it will become the
% reference (nonncaa), so the model should only include contact, limcon, &
% noncon
% For LAD, stim and nonstim are the left and 

%T=array2table(     [ T4S.scatsxsev_score T4S.sex   lad   T4S.migraine T4S.LOC mh    prev_concuss    pcs    scat_high   noncontact limcon    contact    nonncaa     practice    comp   outside    T4S.daysreportedlate  stim    nostim ], ...
%   'VariableNames',{'scatsxsev_score',   'sex',   'lad', 'migraine',  'loc', 'mh', 'prev_concuss', 'pcs', 'scat_high', 'noncon', 'limcon', 'contact', 'nonncaa',  'practice', 'comp', 'outside', 'delayreport',       'stim', 'nostim'}       );
T=array2table(     [ T4S.scatsxsev_score sex   lad   T4S.migraine T4S.LOC mh    prev_concuss    pcs    scat_high   noncontact limcon    contact    nonncaa     practice    comp   outside    T4S.daysreportedlate  stim    nostim ], ...
   'VariableNames',{'scatsxsev_score',   'sex',   'lad', 'migraine',  'loc', 'mh', 'prev_concuss', 'pcs', 'scat_high', 'noncon', 'limcon', 'contact', 'nonncaa',  'practice', 'comp', 'outside', 'delayreport',       'stim', 'nostim'}       );

% Nov 22, - SAVE - make a table without PCS NaNs
pcs_i = ~isnan(pcs) & nonncaa==0;
Tn =array2table(     [ T4S.scatsxsev_score(pcs_i) sex(pcs_i)   lad(pcs_i)   T4S.migraine(pcs_i) T4S.LOC(pcs_i) mh(pcs_i)    prev_concuss(pcs_i)    pcs(pcs_i)    scat_high(pcs_i)   noncontact(pcs_i) limcon(pcs_i)    contact(pcs_i)    nonncaa(pcs_i)     practice(pcs_i)    comp(pcs_i)   outside(pcs_i)    T4S.daysreportedlate(pcs_i)  stim(pcs_i)    nostim(pcs_i) ], ...
    'VariableNames',{'scatsxsev_score',   'sex',   'lad', 'migraine',  'loc', 'mh', 'prev_concuss', 'pcs', 'scat_high', 'noncon', 'limcon', 'contact', 'nonncaa',  'practice', 'comp', 'outside', 'delayreport',       'stim', 'nostim'}       );

disp('OR table for when the non-ncaa cadets are removed from the analysis')
OR_noncon= ...
   ( size(find(Tn.pcs == 1  & Tn.noncon==1))   /   ...
     size(find(Tn.pcs == 1  & Tn.noncon==0)) ) /   ...
   ( size(find(Tn.pcs == 0  & Tn.noncon==1))   /   ...
     size(find(Tn.pcs == 0  & Tn.noncon==0)) )     

OR_limcon= ...
   ( size(find(Tn.pcs == 1  & Tn.limcon==1))   /   ...
     size(find(Tn.pcs == 1  & Tn.limcon==0)) ) /   ...
   ( size(find(Tn.pcs == 0  & Tn.limcon==1))   /   ...
     size(find(Tn.pcs == 0  & Tn.limcon==0)) )     

OR_contact= ...
   ( size(find(Tn.pcs == 1  & Tn.contact==1))   /   ...
     size(find(Tn.pcs == 1  & Tn.contact==0)) ) /   ...
   ( size(find(Tn.pcs == 0  & Tn.contact==1))   /   ...
     size(find(Tn.pcs == 0  & Tn.contact==0)) )     



% Oct 6 2022   - SAVE
% Store tables for R
% writetable(T,'t_logistic.csv')





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Table for R statistics
%

% Nov 22, - SAVE - make a table without PCS NaNs
 pcs_i = ~isnan(pcs);
 T_no_nan=array2table(     [ T4S.scatsxsev_score(pcs_i) sex(pcs_i)   lad(pcs_i)   T4S.migraine(pcs_i) T4S.LOC(pcs_i) mh(pcs_i) ...
    prev_concuss(pcs_i)    pcs(pcs_i)    scat_high(pcs_i)   noncontact(pcs_i) limcon(pcs_i)    contact(pcs_i)    nonncaa(pcs_i) ...
    practice(pcs_i)    comp(pcs_i)   outside(pcs_i)    T4S.daysreportedlate(pcs_i)  stim(pcs_i)    nostim(pcs_i) nolad(pcs_i)' ], ...
    'VariableNames',{'scatsxsev_score',   'sex',   'lad', 'migraine',  'loc', 'mh', ...
    'prev_concuss', 'pcs', 'scat_high', 'noncon', 'limcon', 'contact', 'nonncaa', ...
    'practice', 'comp', 'outside', 'delayreport', 'stim', 'nostim', 'nolad'}       );
% writetable(T_no_nan,'t_logistic_no_nan.csv')
%
% keyboard  %Turn back on to pause the program and re-save the data for R

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%modelspec = 'pcs ~ lad+sex+migraine+loc+mh+prev_concuss+scat_high+bsi18_high';
%modelspec = 'pcs ~ lad+sex+migraine+loc+mh+prev_concuss+scat_high+bsi18_high+ncaa';

% This model is the whole model save for later
% modelspec = 'pcs ~ lad+sex+migraine+loc+mh+prev_concuss+scat_high+ncaa';

% These are test models to check things are working correctly.  Should give
% the same response as above.
model_mh       = 'pcs ~ mh';
model_lad      = 'pcs ~ lad';
model_prev_con = 'pcs ~ prev_concuss';
model_migraine = 'pcs ~ migraine';
model_loc      = 'pcs ~ loc';
model_sex      = 'pcs ~ sex';
model_noncon   = 'pcs ~ noncon';
model_limcon   = 'pcs ~ limcon';
model_contact  = 'pcs ~ contact';
model_nonncaa  = 'pcs ~ nonncaa';
model_practice = 'pcs ~ practice';
model_comp     = 'pcs ~ comp';
model_outside  = 'pcs ~ outside';
model_delay    = 'pcs ~ delayreport';
model_stim     = 'pcs ~ stim';
model_nostim   = 'pcs ~ nostim';


mdl_mh        = fitglm(T,model_mh,      'Distribution','binomial'  );
mdl_lad       = fitglm(T,model_lad,     'Distribution','binomial'  );
mdl_prev_con  = fitglm(T,model_prev_con,'Distribution','binomial'  );
mdl_migraine  = fitglm(T,model_migraine,'Distribution','binomial'  );
mdl_loc       = fitglm(T,model_loc,     'Distribution','binomial'  );
mdl_sex       = fitglm(T,model_sex,     'Distribution','binomial'  );
mdl_noncon    = fitglm(T,model_noncon,  'Distribution','binomial'  );
mdl_limcon    = fitglm(T,model_limcon,  'Distribution','binomial'  );
mdl_contact   = fitglm(T,model_contact, 'Distribution','binomial'  );
mdl_nonncaa   = fitglm(T,model_nonncaa, 'Distribution','binomial'  );
mdl_practice  = fitglm(T,model_practice,'Distribution','binomial'  );
mdl_comp      = fitglm(T,model_comp,    'Distribution','binomial'  );
mdl_outside   = fitglm(T,model_outside, 'Distribution','binomial'  );
mdl_delay     = fitglm(T,model_delay,   'Distribution','binomial'  );
mdl_stim      = fitglm(T,model_stim,    'Distribution','binomial'  );
mdl_nostim    = fitglm(T,model_nostim,  'Distribution','binomial'  );

%Trying to run a ridge regression model 
p = [T_no_nan.contact T_no_nan.comp T_no_nan.limcon T_no_nan.noncon T_no_nan.practice T_no_nan.delayreport T_no_nan.sex T_no_nan.scat_high T_no_nan.prev_concuss];
r = T_no_nan.pcs;
%k = 0:1e-5:5e-3;
k = 0.2
Ridge_Model = ridge(r,p,k);


% The full model needs to have the same variables removed as in R, meaning
% leave a reference variable out
model_all2 = 'pcs ~ mh+prev_concuss+migraine+loc+sex+noncon+limcon+contact+practice+comp+delayreport+stim+nostim';
mdl_all2 = fitglm(T,model_all2,'Distribution','binomial')

% Note model_all2 matches the R table, to the second or third decimal point
%keyboard

% This model is the list of variables after doing stepwise regression in R
% using default AIC variable reduction.  LAD was removed because it is the sum of stim and nostim

% CARE 1.0 stepwise results from R
%model_all = 'pcs ~ contact + comp + limcon + noncon + practice + delayreport + sex + scat_high + prev_concuss + mh + nostim';  % This model seems to work better - only using variable which are significant when they are by themselves

% CARE 2.0 stepwise results from R
model_all = 'pcs ~ contact + comp + limcon + noncon + practice + delayreport + sex + scat_high + prev_concuss';  % This model seems to work better - only using variable which are significant when they are by themselves
mdl_all = fitglm(T,model_all,'Distribution','binomial')

% Create the results table for the odds ratio
mdl_or      = mdl_all.CoefficientNames';
mdl_or(:,2) = num2cell(exp(mdl_all.Coefficients{:,1}) );

beta = mdl_all.Coefficients{:,1};
SE   = mdl_all.Coefficients{:,2};
CI(:,1) = beta - (1.96*SE);
CI(:,2) = beta + (1.96*SE);

% Put the confidence intervals into mdl_or.  THIS IS THE FINAL TABLE for
% the ODDS RATIO FIGURE

mdl_or(:,3:4)=num2cell(exp(CI))



% Find out the predictions
[ypred,yci] = predict(mdl_all,T);

g      = pcs(  ~isnan(pcs));
ypred2 = ypred(~isnan(pcs));



C = confusionmat(logical(g), ypred2 >0.5 );
C_sum = sum(C,2);

%[X,Y,~,AUC]=perfcurve(g, ypred2 ,1);
[X,Y,T1,AUC]=perfcurve(g, ypred2 ,1);
figure
hold on
set(gca,'TickDir','Out');
set(gca,'XLim',[0 1] );
set(gca,'YLim',[0 1] );
plot([0 1],[0 1],'k-','LineWidth',2);
plot(X,Y,'bo-');
axis equal
title(['AUC = ' num2str(AUC,'%3.2f')] )

text(0.6,0.34,'Predicted','FontSize',14);
text(0.65,0.30,'Y  N',     'FontSize',14);
text(0.6,0.25,['Y  ' num2str( C(2,2)/C_sum(2)*100,'%2.0f') ' ' num2str(C(2,1)/C_sum(2)*100,'%2.0f')],'FontSize',14)
text(0.6,0.20,['N  ' num2str( C(1,2)/C_sum(1)*100,'%2.0f') ' ' num2str(C(1,1)/C_sum(1)*100,'%2.0f')],'FontSize',14)

text(0.55,0.18,'Actual','Rotation',90,'FontSize',14);

plot([0.635 0.750],[0.27 0.27],'k-','LineWidth',2); %Horz line
plot([0.635 0.635],[0.18 0.27],'k-','LineWidth',2); %Vert line


%Trying to add 95% CI shading

% m=nanmean(bp1);
% t=nanmean(x1);
% sem=nanstd(bp1)/sqrt(size(x1,1));
% 
% for i = 1:size(x1,2)
%     plot([t(i) t(i)],[m(i)-sem(i) m(i)+sem(i)],'r-' )
% end
% 
% errorbar(X(:,1),Y(:,1),CI(:,1),CI(:,2));
% 
% %[X,Y,T,AUC]=perfcurve(g, ypred2 ,1);


%keyboard











% fini
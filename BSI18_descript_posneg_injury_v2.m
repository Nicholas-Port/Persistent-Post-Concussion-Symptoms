%BSI total w all hx no sex
%Scat total w all hx no sex
%POST INJURY

%CI function

CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));
bsitotal =([T4.b_anx]+[T4.b_dep]+[T4.b_soma]);

% Baseline data is in T4

% Find indexes for sex  (1==f, 2==m)
i1 = find(T4.sex == 1);
i2 = find(T4.sex == 2);

female = bsitotal( i1 );
male = bsitotal( i2   );

% Compound indexes
i3 = find((T4.sex == 1 | T4.sex == 2) & ( T4.anx_hx == 1 | T4.dep_hx == 1) );
i4 = find((T4.sex == 1 | T4.sex == 2) & ( T4.anx_hx == 0 & T4.dep_hx == 0) );


pos_mhhx   = bsitotal(i3);
neg_mhhx   = bsitotal(i4);

% Compound indexes

i5  = find((T4.sex == 1 | T4.sex == 2) & ( T4.ld == 1 | T4.add == 1) & (T4.stimulant == 1));
i22 = find((T4.sex == 1 | T4.sex == 2) & ( T4.ld == 1 | T4.add == 1) & (T4.stimulant == 0));
i6  = find((T4.sex == 1 | T4.sex == 2) & ( T4.ld == 0 & T4.add == 0) );

pos_ladhxstim    = bsitotal( i5 );
neg_ladhx        = bsitotal( i6 );
pos_ladhxnostim  = bsitotal( i22 );

% Compound indexes

i7 = find((T4.sex == 1 | T4.sex == 2) & T4.prev_concuss >= 3);
i8 = find((T4.sex == 1 | T4.sex == 2) & T4.prev_concuss < 3 );

pos_conhx   = bsitotal(i7);
neg_conhx   = bsitotal(i8);

i9 = find((T4.sex == 1 | T4.sex == 2) & T4.migraine == 1);
i10 = find((T4.sex == 1 | T4.sex == 2) & T4.migraine == 0);

pos_mighx   = bsitotal(i9 );
neg_mighx   = bsitotal(i10 );

i11 = find((T4.sex == 1 | T4.sex == 2) & T4.LOC == 1);
i12 = find((T4.sex == 1 | T4.sex == 2) & T4.LOC == 0);

pos_loc   = bsitotal(i11 );
neg_loc   = bsitotal(i12 );

i13 = find(( T4.ncaa==1 ));
i14 = find(( T4.ncaa==2 ));
i15 = find(( T4.ncaa==3 ));
i16 = find(( T4.ncaa==4 ));

noncon      = bsitotal(i13);
limcon      = bsitotal(i14);
contact     = bsitotal(i15);
nonncaa     = bsitotal(i16);

i17 = find((T4.situation==1));
i18 = find((T4.situation==2));
i19 = find((T4.situation==3));

practice    = bsitotal(i17);
comp        = bsitotal(i18);
outside     = bsitotal(i19);

i20 = find((T4.sex == 1 | T4.sex == 2) & T4.daysreportedlate == 1);
i21 = find((T4.sex == 1 | T4.sex == 2) & T4.daysreportedlate == 0);

pos_delay = bsitotal(i20);
neg_delay = bsitotal(i21);

% Baseline data is in T4S

% Find indexes for sex  (1==f, 2==m)
j1 = find(T4S.sex == 1);
j2 = find(T4S.sex == 2);

female_scat = T4S.scatsxsev_score(j1);
male_scat   = T4S.scatsxsev_score(j2);

% Compound indexes
j3 = find((T4S.sex == 1 | T4S.sex == 2) & ( T4S.anx_hx == 1 | T4S.dep_hx == 1) );
j4 = find((T4S.sex == 1 | T4S.sex == 2) & ( T4S.anx_hx == 0 & T4S.dep_hx == 0) );

pos_mhhx_scat   = T4S.scatsxsev_score(j3);
neg_mhhx_scat   = T4S.scatsxsev_score(j4);

% Compound indexes

j5  = find((T4S.sex == 1 | T4S.sex == 2) & ( T4S.ld == 1 | T4S.add == 1) & (T4S.stimulant == 1) );
j22 = find((T4S.sex == 1 | T4S.sex == 2) & ( T4S.ld == 1 | T4S.add == 1) & (T4S.stimulant == 0) );
j6  = find((T4S.sex == 1 | T4S.sex == 2) & ( T4S.ld == 0 & T4S.add == 0) );

pos_ladhxstim_scat   = T4S.scatsxsev_score( j5 );
pos_ladhxnostim_scat = T4S.scatsxsev_score( j22 );
neg_ladhx_scat       = T4S.scatsxsev_score( j6 );

% Compound indexes

j7 = find((T4S.sex == 1 | T4S.sex == 2) & T4S.prev_concuss >= 3);
j8 = find((T4S.sex == 1 | T4S.sex == 2) & T4S.prev_concuss < 3 );

pos_conhx_scat   = T4S.scatsxsev_score(j7);
neg_conhx_scat   = T4S.scatsxsev_score(j8);

j9  = find((T4S.sex == 1 | T4S.sex == 2) & T4S.migraine == 1 );
j10 = find((T4S.sex == 1 | T4S.sex == 2) & T4S.migraine == 0);

pos_mighx_scat   = T4S.scatsxsev_score(j9 );
neg_mighx_scat   = T4S.scatsxsev_score(j10 );

j11 = find((T4S.sex == 1 | T4S.sex == 2) & T4S.LOC == 1);
j12 = find((T4S.sex == 1 | T4S.sex == 2) & T4S.LOC == 0);

pos_loc_scat   = T4S.scatsxsev_score(j11 );
neg_loc_scat   = T4S.scatsxsev_score(j12 );

j13 = find(( T4S.ncaa==1 ));
j14 = find(( T4S.ncaa==2 ));
j15 = find(( T4S.ncaa==3 ));
j16 = find(( T4S.ncaa==4 ));

noncon_scat      = T4S.scatsxsev_score(j13);
limcon_scat      = T4S.scatsxsev_score(j14);
contact_scat     = T4S.scatsxsev_score(j15);
nonncaa_scat     = T4S.scatsxsev_score(j16);

j17 = find((T4S.situation==1));
j18 = find((T4S.situation==2));
j19 = find((T4S.situation==3));

practice_scat    = T4S.scatsxsev_score(j17);
comp_scat        = T4S.scatsxsev_score(j18);
outside_scat     = T4S.scatsxsev_score(j19);

j20 = find((T4S.sex == 1 | T4S.sex == 2) & T4S.daysreportedlate == 1);
j21 = find((T4S.sex == 1 | T4S.sex == 2) & T4S.daysreportedlate == 0);

pos_delay_scat = T4S.scatsxsev_score(j20);
neg_delay_scat = T4S.scatsxsev_score(j21);


% New Figure
hf = figure;
nlp_fig_prep(hf, 'Portrait');


% First axes panel
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 9.15 1.5 1.5]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    [-.5 30]      );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   [0 10 20 30]      );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','on');

hold on
[x1, y1] = cumsum_dist(pos_mhhx);
[x2, y2] = cumsum_dist(neg_mhhx);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

ylabel('Percentage of Athletes')

% Key
%plot([0 1],[1 1],     '-','Color',ORANGE', 'LineWidth',2);
%plot([0 1],[.92 .92], '-','Color',CYAN',   'LineWidth',2);
text(12,.65,  ['+hx n=' num2str(length(pos_mhhx  )) ],'FontSize',10,'Color',ORANGE      );
text(12,.575,['-hx n=' num2str(length(neg_mhhx  )) ],'FontSize',10,'Color',CYAN        );

text(6,.425,'Mean(SD) Median:CI' );
ci1 = CIFcn(pos_mhhx,  95);
ci2 = CIFcn(neg_mhhx,  95);

text(9,.335,[ num2str(nanmean(pos_mhhx),  '%3.1f') ' (' num2str(nanstd(neg_mhhx  ),'%3.1f') ') ' num2str(nanmedian(pos_mhhx  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE );
text(9,.245,[ num2str(nanmean(neg_mhhx),  '%3.1f') ' (' num2str(nanstd(neg_mhhx  ),'%3.1f') ') ' num2str(nanmedian(neg_mhhx  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN   );

 title('Mental Health Hx');
 xlabel('BSI18 Total Score');
 %ylabel('Number of Athletes');


%Effect sizes
d1 = computeCohen_d( pos_mhhx,   'independent');
d2 = computeCohen_d( neg_mhhx,   'independent');
d3 = computeCohen_d( [pos_mhhx'], ...
   [neg_mhhx'], 'independent');

%Hypothesis testing

[H,P3,KSSTAT] = kstest2([pos_mhhx'],[neg_mhhx']);
text(1,.075,['+ & -Hx d='  num2str(d3,'%3.2f') ' ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

% Second axes panel
% lad w bsitotal

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [2.5 9.15 1.5 1.5] );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 30]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 10 20 30]  );
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(pos_ladhxstim);
[x2, y2] = cumsum_dist(neg_ladhx);
[x3, y3] = cumsum_dist(pos_ladhxnostim);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );
plot(x3,y3,'Color',MAGENTA,  'LineStyle','-', 'LineWidth',2 );


%ylabel('Percentage of Athletes');

% Key
text(2,.22,  ['+hx & +stimulant n=' num2str(length(pos_ladhxstim)) ],'FontSize',10,'Color',ORANGE       );
text(2,.135,['-hx n=' num2str(length(neg_ladhx)) ],'FontSize',10,'Color',CYAN         );
text(2,.05,['+hx & -stimulant n=' num2str(length(pos_ladhxnostim)) ],'FontSize',10,'Color',MAGENTA        );

hold on

ci1 = CIFcn(pos_ladhxstim,  95);
ci2 = CIFcn(neg_ladhx,  95);
ci3 = CIFcn(pos_ladhxnostim,  95);

text(11,.685,[ num2str(nanmean(pos_ladhxstim),  '%3.1f') ' (' num2str(nanstd(pos_ladhxstim  ),'%3.1f') ') ' num2str(nanmedian(pos_ladhxstim  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(11,.6,[ num2str(nanmean(neg_ladhx),  '%3.1f') ' (' num2str(nanstd(neg_ladhx  ),'%3.1f') ') ' num2str(nanmedian(neg_ladhx  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);
text(11,.515,[ num2str(nanmean(pos_ladhxnostim),  '%3.1f') ' (' num2str(nanstd(pos_ladhxnostim  ),'%3.1f') ') ' num2str(nanmedian(pos_ladhxnostim  ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);

 title('Learning Disability Hx');
 xlabel('BSI18 Total Score');
 %ylabel('Number of Athletes');


% %Effect sizes
% d3 = computeCohen_d( [pos_ladhx'], ...
%    [neg_ladhx'], 'independent');
% 
% %Hypothesis testing
% [H,P3,KSSTAT] = kstest2([pos_ladhx'],[neg_ladhx']);
% text(3,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

%con w bsitotal
%figure
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[4.25 9.15 1.5 1.5] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12         );
set(gca,'xlim',    [-.5 30]     );
set(gca,'ylim',    [0 1.05] );
set(gca,'XTick',   [0 10 20 30]     );
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(pos_conhx);
[x2, y2] = cumsum_dist(neg_conhx);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

%ylabel('Percentage of Athletes');

% Key
text(12,.685,  ['\geq3 n=' num2str(length(pos_conhx )) ],'FontSize',10,'Color',ORANGE  );
text(12,.6,['<3 n=' num2str(length(neg_conhx)) ],'FontSize',10,'Color',CYAN        );


hold on

ci1 = CIFcn(pos_conhx,  95);
ci2 = CIFcn(neg_conhx,  95);

text(8,.515,[ num2str(nanmean(pos_conhx),  '%3.1f') ' (' num2str(nanstd(pos_conhx  ),'%3.1f') ') ' num2str(nanmedian(pos_conhx  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(8,.43,[ num2str(nanmean(neg_conhx),  '%3.1f') ' (' num2str(nanstd(neg_conhx  ),'%3.1f') ') ' num2str(nanmedian(neg_conhx  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

 title('Concussion Hx');
 xlabel('BSI18 Total Score');
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_conhx'], ...
   [neg_conhx'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_conhx'],[neg_conhx']);
text(3,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );


% Fourth axes panel
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 7 1.5 1.5]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    [-.5 75]      );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   [0 25 50 75]      );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','on');

hold on
[x1, y1] = cumsum_dist(pos_mhhx_scat);
[x2, y2] = cumsum_dist(neg_mhhx_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

ylabel('Percentage of Athletes');

% Key
text(3,1,  ['n=' num2str(length(pos_mhhx_scat  )) ],'FontSize',10,'Color',ORANGE     );
text(3,.92,['n=' num2str(length(neg_mhhx_scat )) ],'FontSize',10,'Color',CYAN        );


hold on
  
ci1 = CIFcn(pos_mhhx_scat,  95);
ci2 = CIFcn(neg_mhhx_scat,  95);

text(20,.225,[ num2str(nanmean(pos_mhhx_scat),  '%3.1f') ' (' num2str(nanstd(pos_mhhx_scat  ),'%3.1f') ') ' num2str(nanmedian(pos_mhhx_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(20,.3,[ num2str(nanmean(neg_mhhx_scat),  '%3.1f') ' (' num2str(nanstd(neg_mhhx_scat  ),'%3.1f') ') ' num2str(nanmedian(neg_mhhx_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

 %title('MH Hx')
 xlabel('SCAT Total Score')
 %ylabel('Number of Athletes')


%Effect sizes
d3 = computeCohen_d( [pos_mhhx_scat'], ...
   [neg_mhhx_scat'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_mhhx_scat'],[neg_mhhx_scat']);
text(20,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );


% fifth axes panel
% lad w scattotal

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [2.5 7 1.5 1.5]   );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 75]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 25 50 75]      );
set(gca,'YTickLabel',{''}          );

hold on
hold on
[x1, y1] = cumsum_dist(pos_ladhxstim_scat);
[x2, y2] = cumsum_dist(neg_ladhx_scat);
[x3, y3] = cumsum_dist(pos_ladhxnostim_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );
plot(x3,y3,'Color',MAGENTA,  'LineStyle','-', 'LineWidth',2 );


%ylabel('Percentage of Athletes');

% Key
text(45,.685,  ['n=' num2str(length(pos_ladhxstim_scat)) ],'FontSize',10,'Color',ORANGE       );
text(45,.515,['n=' num2str(length(neg_ladhx_scat)) ],'FontSize',10,'Color',CYAN         );
text(45,.6,['n=' num2str(length(pos_ladhxnostim_scat)) ],'FontSize',10,'Color',MAGENTA        );

hold on

ci1 = CIFcn(pos_ladhxstim_scat,  95);
ci2 = CIFcn(neg_ladhx_scat,  95);
ci3 = CIFcn(pos_ladhxnostim_scat,  95);

text(21,.35,[ num2str(nanmean(pos_ladhxstim_scat),  '%3.1f') ' (' num2str(nanstd(pos_ladhxstim_scat  ),'%3.1f') ') ' num2str(nanmedian(pos_ladhxstim_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(21,.18,[ num2str(nanmean(neg_ladhx_scat),  '%3.1f') ' (' num2str(nanstd(neg_ladhx_scat  ),'%3.1f') ') ' num2str(nanmedian(neg_ladhx_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);
text(21,.265,[ num2str(nanmean(pos_ladhxnostim_scat),  '%3.1f') ' (' num2str(nanstd(pos_ladhxnostim_scat  ),'%3.1f') ') ' num2str(nanmedian(pos_ladhxnostim_scat  ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);

%title('LAD Hx');
 xlabel('SCAT Total Score');
 %ylabel('Number of Athletes');


% %Effect sizes
% d3 = computeCohen_d( [pos_ladhx_scat'], ...
%    [neg_ladhx_scat'], 'independent');
% 
% %Hypothesis testing
% [H,P3,KSSTAT] = kstest2([pos_ladhx_scat'],[neg_ladhx_scat']);
% text(20,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

%con w scattotal
%figure
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[4.25 7 1.5 1.5] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12         );
set(gca,'xlim',    [-.5 75]     );
set(gca,'ylim',    [0 1.05] );
set(gca,'XTick',   [0 25 50 75]     );
%set(gca,'YTick',     [0 50 100 150 200 250] );
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(pos_conhx_scat);
[x2, y2] = cumsum_dist(neg_conhx_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

%ylabel('Percentage of Athletes');

% Key
text(3,1,  ['n=' num2str(length(pos_conhx_scat)) ],'FontSize',10,'Color',ORANGE      );
text(3,.92,['n=' num2str(length(neg_conhx_scat)) ],'FontSize',10,'Color',CYAN        );

  hold on
  
ci1 = CIFcn(pos_conhx_scat,  95);
ci2 = CIFcn(neg_conhx_scat,  95);

text(18,.3,[ num2str(nanmean(pos_conhx_scat),  '%3.1f') ' (' num2str(nanstd(pos_conhx_scat  ),'%3.1f') ') ' num2str(nanmedian(pos_conhx_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(18,.225,[ num2str(nanmean(neg_conhx_scat),  '%3.1f') ' (' num2str(nanstd(neg_conhx_scat  ),'%3.1f') ') ' num2str(nanmedian(neg_conhx_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

 %title('Con Hx');
 xlabel('SCAT Total Score');
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_conhx_scat'], ...
   [neg_conhx_scat'], 'independent');

[H,P3,KSSTAT] = kstest2([pos_conhx_scat'],[neg_conhx_scat']);
text(20,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

% Migraine panel
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 4.75 1.5 1.5] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    [-.5 30]      );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   [0 10 20 30]   );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','on');

hold on
[x1, y1] = cumsum_dist(pos_mighx);
[x2, y2] = cumsum_dist(neg_mighx);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 )

ylabel('Percentage of Athletes');

% Key
% plot([13 14],[.825 .825],     '-','Color',ORANGE', 'LineWidth',2);
% plot([13 14],[.75 .75], '-','Color',CYAN',   'LineWidth',2);
text(17,0.75,  ['n=' num2str(length(pos_mighx  )) ],'FontSize',10,'Color',ORANGE );
text(17,0.665,['n=' num2str(length(neg_mighx  )) ],'FontSize',10,'Color',CYAN );


hold on

ci1 = CIFcn(pos_mighx,  95);
ci2 = CIFcn(neg_mighx,  95);

%text(6,.6,'Mean(SD) Median:CI' );
text(10,.525,[ num2str(nanmean(pos_mighx),'%3.1f')   ' (' num2str(nanstd(pos_mighx),  '%3.0f') ') ' num2str(nanmedian(pos_mighx  ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE  );
text(10,.440,[ num2str(nanmean(neg_mighx),'%3.1f')   ' (' num2str(nanstd(neg_mighx),  '%3.0f') ') ' num2str(nanmedian(neg_mighx  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN    );

title('Migraine Hx');
%xlabel('BSI18 Total Score' );
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_mighx'], ...
   [neg_mighx'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_mighx'],[neg_mighx']);
text(3,.075,['d='  num2str(d3,'%3.2f') '  \itp\rm = ',num2str(P3,'%4.3f')] );

%LOC BSI

ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[2.5 4.75 1.5 1.5] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    [-.5 30]      );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   [0 10 20 30]   );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','on');
set(gca,'YTickLabel',{''}          );


hold on
[x1, y1] = cumsum_dist(pos_loc);
[x2, y2] = cumsum_dist(neg_loc);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

%ylabel('Percentage of Athletes')

% Key
% plot([14 15],[.825 .825],     '-','Color',ORANGE', 'LineWidth',2);
% plot([14 15],[.75 .75], '-','Color',CYAN',   'LineWidth',2);
text(12,0.75,  ['n=' num2str(length(pos_loc  )) ],'FontSize',10,'Color',ORANGE );
text(12,0.665,['n=' num2str(length(neg_loc  )) ],'FontSize',10,'Color',CYAN );


hold on

%text(6,.6,'Mean(SD) Median:CI' );
ci1 = CIFcn(pos_loc,95);
ci2 = CIFcn(neg_loc,95);

%text(6,.6,'Mean(SD) Median:CI' );
text(6,.525,[ num2str(nanmean(pos_loc),'%3.1f')   ' (' num2str(nanstd(pos_loc),  '%3.0f') ') ' num2str(nanmedian(pos_loc  ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE  );
text(6,.440,[ num2str(nanmean(neg_loc),'%3.1f')   ' (' num2str(nanstd(neg_loc),  '%3.0f') ') ' num2str(nanmedian(neg_loc  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN    );

title('Loss of Consciousness')
 %xlabel('BSI Total Score')
 %ylabel('Number of Athletes')


%Effect sizes
d3 = computeCohen_d( [pos_loc'], ...
   [neg_loc'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_loc'],[neg_loc']);
text(3,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

%migraine scat

ha = axes;
nlp_axes_prep(ha)
set(gca,'Position',  [.75 2.85 1.5 1.5]   );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 75]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 25 50 75]      );
%set(gca,'YTick',     [0 50 100 150 200 250] );
%set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(pos_mighx_scat);
[x2, y2] = cumsum_dist(neg_mighx_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 )

ylabel('Percentage of Athletes');

% Key
%plot([60 65],[.825 .825],     '-','Color',ORANGE', 'LineWidth',2);
%plot([60 65],[.75 .75], '-','Color',CYAN',   'LineWidth',2);
text(5,0.825,  ['n=' num2str(length(pos_mighx_scat  )) ],'FontSize',10,'Color',ORANGE );
text(5,0.75,['n=' num2str(length(neg_mighx_scat  )) ],'FontSize',10,'Color',CYAN );

hold on

ci1 = CIFcn(pos_mighx_scat,  95);
ci2 = CIFcn(neg_mighx_scat,  95);

%text(6,.6,'Mean(SD) Median:CI' );
text(30,.525,[ num2str(nanmean(pos_mighx_scat),'%3.1f')   ' (' num2str(nanstd(pos_mighx_scat),  '%3.0f') ') ' num2str(nanmedian(pos_mighx_scat  ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE  );
text(30,.440,[ num2str(nanmean(neg_mighx_scat),'%3.1f')   ' (' num2str(nanstd(neg_mighx_scat),  '%3.0f') ') ' num2str(nanmedian(neg_mighx_scat  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN    );

 %title('Mig Hx');
 %xlabel('SCAT Total Score' );
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_mighx_scat'], ...
   [neg_mighx_scat'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_mighx_scat'],[neg_mighx_scat']);
text(20,.075,['d='  num2str(d3,'%3.2f') '  \itp\rm = ',num2str(P3,'%4.3f')] );

%LOC scat

ha = axes;
nlp_axes_prep(ha)
set(gca,'Position',  [2.5 2.85 1.5 1.5]   );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 75]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 25 50 75]      );
%set(gca,'YTick',     [0 50 100 150 200 250] );
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(pos_loc_scat);
[x2, y2] = cumsum_dist(neg_loc_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 )

%ylabel('Percentage of Athletes');

% Key
% plot([60 65],[.9 .9],     '-','Color',ORANGE', 'LineWidth',2);
% plot([60 65],[.825 .825], '-','Color',CYAN',   'LineWidth',2);
text(5,.9,  ['n=' num2str(length(pos_loc_scat)) ],'FontSize',10,'Color',ORANGE       );
text(5,.815,['n=' num2str(length(neg_loc_scat)) ],'FontSize',10,'Color',CYAN         );

hold on

ci1 = CIFcn(pos_loc_scat,  95);
ci2 = CIFcn(neg_loc_scat,  95);

%text(6,.6,'Mean(SD) Median:CI' );
text(30,.525,[ num2str(nanmean(pos_loc_scat),'%3.1f')   ' (' num2str(nanstd(pos_loc_scat),  '%3.0f') ') ' num2str(nanmedian(pos_loc_scat  ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE  );
text(30,.440,[ num2str(nanmean(neg_loc_scat),'%3.1f')   ' (' num2str(nanstd(neg_loc_scat),  '%3.0f') ') ' num2str(nanmedian(neg_loc_scat  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN    );

 %title('LOC');
 %xlabel('SCAT Total Score' );
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_loc_scat'], ...
   [neg_loc_scat'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_loc_scat'],[neg_loc_scat']);
text(20,.075,['d='  num2str(d3,'%3.2f') '  \itp\rm = ',num2str(P3,'%4.3f')] );

% sex bsi

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [4.25 4.75 1.5 1.5]      );
set(gca,'FontSize',  12                 );
set(gca,'xlim',      [-.5 30]           );
set(gca,'ylim',      [0 1.05]           );
set(gca,'XTick',     [0 10 20 30]       );
%set(gca,'YTick',     [0 50 100 150 200 250] );
set(gca,'YTickLabel',{''}          );


hold on
[x1, y1] = cumsum_dist(female);
[x2, y2] = cumsum_dist(male);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 )

%ylabel('Percentage of Athletes')

% Key
%plot([13 14],[.9 .9],     '-','Color',ORANGE', 'LineWidth',2);
%plot([13 14],[.825 .825], '-','Color',CYAN',   'LineWidth',2);
text(12,.75,  ['female n=' num2str(length(female)) ],'FontSize',10,'Color',ORANGE    );
text(12,.675,['male n=' num2str(length(male)) ],'FontSize',10,'Color',CYAN        );

hold on

%text(6,.6,'Mean(SD) Median:CI' );
ci = CIFcn(female,95);
ci2 = CIFcn(male,95);

text(7,.525,[ num2str(nanmean(female  ),'%3.1f') ' (' num2str(nanstd(female  ),'%3.0f') ') ' num2str(nanmedian(female ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(7,.440,[ num2str(nanmean(male  ),'%3.1f') ' (' num2str(nanstd(male  ),'%3.0f') ') ' num2str(nanmedian(male  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

title('Sex')
 %xlabel('BSI18 Total Score')
 %ylabel('Number of Athletes')


%Effect sizes
d3 = computeCohen_d( [female'], ...
   [male'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([female'],[male']);
text(3,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

% sex scat

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [4.25 2.85 1.5 1.5]      );
set(gca,'FontSize',  12                 );
set(gca,'xlim',      [-.5 75]           );
set(gca,'ylim',      [0 1.05]           );
set(gca,'XTick',     [0 25 50 75]       );
%set(gca,'YTick',     [0 50 100 150 200 250] );
set(gca,'YTickLabel',{''}          );


hold on
[x1, y1] = cumsum_dist(female_scat);
[x2, y2] = cumsum_dist(male_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 )

%ylabel('Percentage of Athletes')

% Key
%plot([13 14],[.775 .775],     '-','Color',ORANGE', 'LineWidth',2);
%plot([13 14],[.7 .7], '-','Color',CYAN',   'LineWidth',2);
text(50,.785,  ['n=' num2str(length(female_scat)) ],'FontSize',10,'Color',ORANGE    );
text(50,.7,['n=' num2str(length(male_scat)) ],'FontSize',10,'Color',CYAN        );

hold on

%text(6,.6,'Mean(SD) Median:CI' );
ci = CIFcn(female,95);
ci2 = CIFcn(male,95);

text(30,.525,[ num2str(nanmean(female_scat  ),'%3.1f') ' (' num2str(nanstd(female_scat  ),'%3.0f') ') ' num2str(nanmedian(female_scat ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(30,.440,[ num2str(nanmean(male_scat  ),'%3.1f') ' (' num2str(nanstd(male_scat  ),'%3.0f') ') ' num2str(nanmedian(male_scat  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('Sex')
 %xlabel('SCAT Total Score')
 %ylabel('Number of Athletes')


%Effect sizes
d3 = computeCohen_d( [female_scat'], ...
   [male_scat'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([female_scat'],[male_scat']);
text(20,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

% NCAA BSI
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[6 9.15 1.5 1.5]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    [-.5 30]      );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   [0 10 20 30]      );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','on');
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(noncon  );
[x2, y2] = cumsum_dist(limcon  );
[x3, y3] = cumsum_dist(contact );
[x4, y4] = cumsum_dist(nonncaa );

plot(x1,y1, 'Color',ORANGE, 'LineStyle','-', 'LineWidth',2 );
plot(x2,y2, 'Color',CYAN,   'LineStyle','-', 'LineWidth',2 );
plot(x3,y3 ,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 );
plot(x4,y4, 'Color',GREEN,  'LineStyle','-', 'LineWidth',2 );


%ylabel('Percentage of Athletes');

% Key
text(5,.3,  ['non contact n=' num2str(length(noncon  )) ],'FontSize',10,'Color',ORANGE       );
text(5,.225,    ['lim contact n=' num2str(length(limcon  )) ],'FontSize',10,'Color',CYAN     );
text(5,.15,  ['contact n='     num2str(length(contact )) ],'FontSize',10,'Color',MAGENTA     );
text(5,.075,   ['non NCAA n='    num2str(length(nonncaa )) ],'FontSize',10,'Color',GREEN     );


hold on

ci1 = CIFcn(noncon,  95);
ci2 = CIFcn(limcon,  95);
ci3 = CIFcn(contact, 95);
ci4 = CIFcn(nonncaa, 95);
%ci5 = CIFcn(cadetrtp,   95);

text(10,.64,[ num2str(nanmean(noncon),  '%3.1f') ' (' num2str(nanstd(noncon  ),'%3.1f') ') ' num2str(nanmedian(noncon  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(10,.555,[ num2str(nanmean(limcon),  '%3.1f') ' (' num2str(nanstd(limcon  ),'%3.1f') ') ' num2str(nanmedian(limcon  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);
text(10,.47,[ num2str(nanmean(contact), '%3.1f') ' (' num2str(nanstd(contact ),'%3.1f') ') ' num2str(nanmedian(contact ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);
text(10,.385,  [ num2str(nanmean(nonncaa), '%3.1f') ' (' num2str(nanstd(nonncaa ),'%3.1f') ') ' num2str(nanmedian(nonncaa ),'%3.0f') ' : ' num2str(ci4(2),'%3.0f') ],'Color',GREEN);
%text(29,.225,[ num2str(nanmean(cadetrtp),  '%3.1f') ' (' num2str(nanstd(cadetrtp  ),'%3.1f') ') ' num2str(nanmedian(cadetrtp  ),'%3.1f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',BLACK);

 title('NCAA');
xlabel('BSI Total Score')

%NCAA SCAT

ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[6 7 1.5 1.5]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    [-.5 75]      );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   [0 25 50 75]      );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','on');
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(noncon_scat  );
[x2, y2] = cumsum_dist(limcon_scat  );
[x3, y3] = cumsum_dist(contact_scat );
[x4, y4] = cumsum_dist(nonncaa_scat );

plot(x1,y1, 'Color',ORANGE, 'LineStyle','-', 'LineWidth',2 );
plot(x2,y2, 'Color',CYAN,   'LineStyle','-', 'LineWidth',2 );
plot(x3,y3 ,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 );
plot(x4,y4, 'Color',GREEN,  'LineStyle','-', 'LineWidth',2 );


%ylabel('Percentage of Athletes');

% Key
text(50,.7,  ['n=' num2str(length(noncon_scat  )) ],'FontSize',10,'Color',ORANGE       );
text(50,.615,    ['n=' num2str(length(limcon_scat  )) ],'FontSize',10,'Color',CYAN          );
text(50,.53,  ['n='     num2str(length(contact_scat )) ],'FontSize',10,'Color',MAGENTA       );
text(50,.445,   ['n='    num2str(length(nonncaa_scat )) ],'FontSize',10,'Color',GREEN         );


hold on

ci1 = CIFcn(noncon_scat,  95);
ci2 = CIFcn(limcon_scat,  95);
ci3 = CIFcn(contact_scat, 95);
ci4 = CIFcn(nonncaa_scat, 95);
%ci5 = CIFcn(cadetrtp,   95);

text(20,.3,[ num2str(nanmean(noncon_scat),  '%3.1f') ' (' num2str(nanstd(noncon_scat  ),'%3.1f') ') ' num2str(nanmedian(noncon_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(20,.225,[ num2str(nanmean(limcon_scat),  '%3.1f') ' (' num2str(nanstd(limcon_scat  ),'%3.1f') ') ' num2str(nanmedian(limcon_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);
text(20,.15,[ num2str(nanmean(contact_scat), '%3.1f') ' (' num2str(nanstd(contact_scat ),'%3.1f') ') ' num2str(nanmedian(contact_scat ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);
text(20,.075,  [ num2str(nanmean(nonncaa_scat), '%3.1f') ' (' num2str(nanstd(nonncaa_scat ),'%3.1f') ') ' num2str(nanmedian(nonncaa_scat ),'%3.0f') ' : ' num2str(ci4(2),'%3.0f') ],'Color',GREEN);
%text(29,.225,[ num2str(nanmean(cadetrtp),  '%3.1f') ' (' num2str(nanstd(cadetrtp  ),'%3.1f') ') ' num2str(nanmedian(cadetrtp  ),'%3.1f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',BLACK);

xlabel('SCAT Total Score')

%situation BSI

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [6 4.75 1.5 1.5] );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 30]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 10 20 30]  );
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(practice);
[x2, y2] = cumsum_dist(comp    );
[x3, y3] = cumsum_dist(outside );

plot(x1,y1, 'Color',ORANGE, 'LineStyle','-', 'LineWidth',2 );
plot(x2,y2, 'Color',CYAN,   'LineStyle','-', 'LineWidth',2 );
plot(x3,y3 ,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 );


%ylabel('Percentage of Athletes');

% Key
text(10,.685,  ['practice n=' num2str(length(practice  )) ],'FontSize',10,'Color',ORANGE     );
text(10,.6,    ['comp n=' num2str(length(comp  )) ],'FontSize',10,'Color',CYAN       );
text(10,.515,  ['outside n='     num2str(length(outside )) ],'FontSize',10,'Color',MAGENTA);

hold on

ci1 = CIFcn(practice,  95);
ci2 = CIFcn(comp,  95);
ci3 = CIFcn(outside, 95);

text(10,.32,[ num2str(nanmean(practice),  '%3.1f') ' (' num2str(nanstd(practice  ),'%3.1f') ') ' num2str(nanmedian(practice  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(10,.235,[ num2str(nanmean(comp),  '%3.1f') ' (' num2str(nanstd(comp  ),'%3.1f') ') ' num2str(nanmedian(comp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);
text(10,.15,[ num2str(nanmean(outside), '%3.1f') ' (' num2str(nanstd(outside ),'%3.1f') ') ' num2str(nanmedian(outside),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);

 title('Setting');
%xlabel('BSI Total Score')

%situation SCAT

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [6 2.85 1.5 1.5]   );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 75]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 25 50 75]      );
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(practice_scat);
[x2, y2] = cumsum_dist(comp_scat    );
[x3, y3] = cumsum_dist(outside_scat );

plot(x1,y1, 'Color',ORANGE, 'LineStyle','-', 'LineWidth',2 );
plot(x2,y2, 'Color',CYAN,   'LineStyle','-', 'LineWidth',2 );
plot(x3,y3 ,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 );


%ylabel('Percentage of Athletes');

% Key
text(35,.6,   ['n=' num2str(length(practice_scat )) ],'FontSize',10,'Color',ORANGE  );
text(35,.525, ['n=' num2str(length(comp_scat     )) ],'FontSize',10,'Color',CYAN    );
text(35,.45,  ['n=' num2str(length(outside_scat  )) ],'FontSize',10,'Color',MAGENTA );

hold on

ci1 = CIFcn(practice_scat,95);
ci2 = CIFcn(comp_scat,    95);
ci3 = CIFcn(outside_scat, 95);

text(15,.285,[ num2str(nanmean(practice_scat), '%3.1f') ' (' num2str(nanstd(practice_scat  ),'%3.1f') ') ' num2str(nanmedian(practice_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(15,.200,[ num2str(nanmean(comp_scat    ), '%3.1f') ' (' num2str(nanstd(comp_scat      ),'%3.1f') ') ' num2str(nanmedian(comp_scat      ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);
text(15,.115,[ num2str(nanmean(outside_scat ), '%3.1f') ' (' num2str(nanstd(outside_scat   ),'%3.1f') ') ' num2str(nanmedian(outside_scat   ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);

% title('Situation');
%xlabel('SCAT Total Score')

%
% Delayed Reporting BSI
%

ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 .75 1.5 1.5] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12               );
set(gca,'xlim',    [-.5 30]          );
set(gca,'ylim',    [0 1.05]          );
set(gca,'XTick',   [0 10 20 30]      );
%set(gca,'YTickLabel',{''}            );

hold on
[x1, y1] = cumsum_dist(pos_delay);
[x2, y2] = cumsum_dist(neg_delay);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

ylabel('Percentage of Athletes');

% Key
text(10,.685,  ['delayed n=' num2str(length(pos_delay )) ],'FontSize',10,'Color',ORANGE  );
text(10,.6,['no delay n=' num2str(length(neg_delay)) ],'FontSize',10,'Color',CYAN        );


hold on

ci1 = CIFcn(pos_delay,  95);
ci2 = CIFcn(neg_delay,  95);

text(8,.515,[ num2str(nanmean(pos_delay),  '%3.1f') ' (' num2str(nanstd(pos_delay  ),'%3.1f') ') ' num2str(nanmedian(pos_delay  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(8,.430,[ num2str(nanmean(neg_delay),  '%3.1f') ' (' num2str(nanstd(neg_delay  ),'%3.1f') ') ' num2str(nanmedian(neg_delay  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

 title('Delayed Reporting');
 xlabel('BSI18 Total Score');

 %Effect sizes
d3 = computeCohen_d( [pos_delay'], ...
   [neg_delay'], 'independent');

[H,P3,KSSTAT] = kstest2([pos_delay'],[neg_delay']);
text(6,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

 %delayed SCAT

ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[2.5 .75 1.5 1.5] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12               );
set(gca,'xlim',    [-.5 75]          );
set(gca,'ylim',    [0 1.05]          );
set(gca,'XTick',   [0 25 50 75]      );
%set(gca,'YTick',     [0 50 100 150 200 250] );
set(gca,'YTickLabel',{''}            );

hold on
[x1, y1] = cumsum_dist(pos_delay_scat);
[x2, y2] = cumsum_dist(neg_delay_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

%ylabel('Percentage of Athletes');

% Key
text(3,1,  ['n=' num2str(length(pos_delay_scat)) ],'FontSize',10,'Color',ORANGE      );
text(3,.92,['n=' num2str(length(neg_delay_scat)) ],'FontSize',10,'Color',CYAN        );

  hold on
  
ci1 = CIFcn(pos_delay_scat,  95);
ci2 = CIFcn(neg_delay_scat,  95);

text(21,.300,[ num2str(nanmean(pos_delay_scat),  '%3.1f') ' (' num2str(nanstd(pos_delay_scat  ),'%3.1f') ') ' num2str(nanmedian(pos_delay_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(21,.225,[ num2str(nanmean(neg_delay_scat),  '%3.1f') ' (' num2str(nanstd(neg_delay_scat  ),'%3.1f') ') ' num2str(nanmedian(neg_delay_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

 xlabel('SCAT Total Score');

 %Effect sizes
d3 = computeCohen_d( pos_delay_scat', ...
                     neg_delay_scat', 'independent');

[H,P3,KSSTAT] = kstest2(pos_delay_scat',neg_delay_scat');
text(18,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );


text(180,-.1,'Wilkins et al, Fig 3')


%keyboard







% fini
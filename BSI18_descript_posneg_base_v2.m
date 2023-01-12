%BSI total w all hx no sex
%Scat total w all hx no sex
%POST INJURY

%CI function

CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));
bsitotal =([T2.b_anx]+[T2.b_dep]+[T2.b_soma]);

% Baseline data is in T2

% Find indexes for sex  (1==f, 2==m)
i1 = find(T2.sex == 1);
i2 = find(T2.sex == 2);

female = bsitotal( i1 );
male = bsitotal( i2   );

% Compound indexes
i3 = find((T2.sex == 1 | T2.sex == 2) & ( T2.anx == 1 | T2.dep == 1) );
i4 = find((T2.sex == 1 | T2.sex == 2) & ( T2.anx == 0 & T2.dep == 0) );



pos_mhhx   = bsitotal(i3);
neg_mhhx   = bsitotal(i4);

% Compound indexes

i5 = find((T2.sex == 1 | T2.sex == 2) & ( T2.ld == 1 | T2.add == 1) );
i6 = find((T2.sex == 1 | T2.sex == 2) & ( T2.ld == 0 & T2.add == 0) );

pos_ladhx   = bsitotal( i5 );
neg_ladhx   = bsitotal( i6 );

% Compound indexes

i7 = find((T2.sex == 1 | T2.sex == 2) & T2.prev_concuss >= 3);
i8 = find((T2.sex == 1 | T2.sex == 2) & T2.prev_concuss < 3 );

pos_conhx   = bsitotal(i7);
neg_conhx   = bsitotal(i8);



i9 = find((T2.sex == 1 | T2.sex == 2) & T2.migraine == 1);
i10 = find((T2.sex == 1 | T2.sex == 2) & T2.migraine == 0);

pos_mighx   = bsitotal(i9 );
neg_mighx   = bsitotal(i10 );

i11 = find(( T2.ncaa==1 ));
i12 = find(( T2.ncaa==2 ));
i13 = find(( T2.ncaa==3 ));
i14 = find(( T2.ncaa==4 ));

noncon      = bsitotal(i11);
limcon      = bsitotal(i12);
contact     = bsitotal(i13);
nonncaa     = bsitotal(i14);

% Baseline data is in T2S

% Find indexes for sex  (1==f, 2==m)
j1 = find(T2S.sex == 1);
j2 = find(T2S.sex == 2);

female_scat = T2S.scatsxsev_score(j1);
male_scat = T2S.scatsxsev_score(j2);

% Compound indexes
j3 = find((T2S.sex == 1 | T2S.sex == 2) & ( T2S.anx == 1 | T2S.dep == 1) );
j4 = find((T2S.sex == 1 | T2S.sex == 2) & ( T2S.anx == 0 & T2S.dep == 0) );

pos_mhhx_scat   = T2S.scatsxsev_score(j3);
neg_mhhx_scat   = T2S.scatsxsev_score(j4);

% Compound indexes

j5 = find((T2S.sex == 1 | T2S.sex == 2) & ( T2S.ld == 1 | T2S.add == 1) );
j6 = find((T2S.sex == 1 | T2S.sex == 2) & ( T2S.ld == 0 & T2S.add == 0) );

pos_ladhx_scat   = T2S.scatsxsev_score( j5 );
neg_ladhx_scat   = T2S.scatsxsev_score( j6 );

% Compound indexes

j7 = find((T2S.sex == 1 | T2S.sex == 2) & T2S.prev_concuss >= 3);
j8 = find((T2S.sex == 1 | T2S.sex == 2) & T2S.prev_concuss < 3 );

pos_conhx_scat   = T2S.scatsxsev_score(j7);
neg_conhx_scat   = T2S.scatsxsev_score(j8);

j9 = find((T2S.sex == 1 | T2S.sex == 2) & T2S.migraine == 1 );
j10 = find((T2S.sex == 1 | T2S.sex == 2) & T2S.migraine == 0);

pos_mighx_scat   = T2S.scatsxsev_score(j9 );
neg_mighx_scat   = T2S.scatsxsev_score(j10 );

j11 = find(( T2S.ncaa==1 ));
j12 = find(( T2S.ncaa==2 ));
j13 = find(( T2S.ncaa==3 ));
j14 = find(( T2S.ncaa==4 ));

noncon_scat      = T2S.scatsxsev_score(j11);
limcon_scat      = T2S.scatsxsev_score(j12);
contact_scat     = T2S.scatsxsev_score(j13);
nonncaa_scat     = T2S.scatsxsev_score(j14);

% New Figure
hf = figure;
nlp_fig_prep(hf, 'Portrait');


% First axes panel
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 8.75 1.9 1.9]   ); % gca = graphical current axes % left bottom width height
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
%plot([14 15],[.75 .75],     '-','Color',ORANGE', 'LineWidth',2);
%plot([14 15],[.675 .675], '-','Color',CYAN',   'LineWidth',2);
text(15,.75,  ['+hx n=' num2str(length(pos_mhhx  )) ],'FontSize',10,'Color',ORANGE      );
text(15,.675,['-hx n=' num2str(length(neg_mhhx  )) ],'FontSize',10,'Color',CYAN        );

text(8,.5,'Mean(SD) Median:CI' );
ci1 = CIFcn(pos_mhhx,  95);
ci2 = CIFcn(neg_mhhx,  95);

text(9,.425,[ num2str(nanmean(pos_mhhx),  '%3.1f') ' (' num2str(nanstd(neg_mhhx  ),'%3.1f') ') ' num2str(nanmedian(pos_mhhx  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE );
text(9,.350,[ num2str(nanmean(neg_mhhx),  '%3.1f') ' (' num2str(nanstd(neg_mhhx  ),'%3.1f') ') ' num2str(nanmedian(neg_mhhx  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN   );

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
text(4,.075,['+ & -Hx d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

% Second axes panel
% lad w bsitotal

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [3 8.75 1.9 1.9] );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 30]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 10 20 30]  );
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(pos_ladhx);
[x2, y2] = cumsum_dist(neg_ladhx);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

%ylabel('Percentage of Athletes');

% Key
text(11,.75,  ['n=' num2str(length(pos_ladhx)) ],'FontSize',10,'Color',ORANGE       );
text(11,.675,['n=' num2str(length(neg_ladhx)) ],'FontSize',10,'Color',CYAN         );

hold on

%text(10,.6,'Mean(SD) Median:CI' );
ci1 = CIFcn(pos_ladhx,  95);
ci2 = CIFcn(neg_ladhx,  95);

text(11,.525,[ num2str(nanmean(pos_ladhx),  '%3.1f') ' (' num2str(nanstd(pos_ladhx  ),'%3.1f') ') ' num2str(nanmedian(pos_ladhx  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(11,.450,[ num2str(nanmean(neg_ladhx),  '%3.1f') ' (' num2str(nanstd(neg_ladhx  ),'%3.1f') ') ' num2str(nanmedian(neg_ladhx  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

 title('Learning Disability Hx');
 xlabel('BSI18 Total Score');
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_ladhx'], ...
   [neg_ladhx'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_ladhx'],[neg_ladhx']);
text(3,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

%con w bsitotal
%figure
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[5.25 8.75 1.9 1.9] ); % gca = graphical current axes % left bottom width height
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
text(8,.75,  ['\geq3 n=' num2str(length(pos_conhx )) ],'FontSize',10,'Color',ORANGE  );
text(8,.675,['<3 n=' num2str(length(neg_conhx)) ],'FontSize',10,'Color',CYAN        );


hold on

ci1 = CIFcn(pos_conhx,  95);
ci2 = CIFcn(neg_conhx,  95);

text(8,.525,[ num2str(nanmean(pos_conhx),  '%3.1f') ' (' num2str(nanstd(pos_conhx  ),'%3.1f') ') ' num2str(nanmedian(pos_conhx  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(8,.450,[ num2str(nanmean(neg_conhx),  '%3.1f') ' (' num2str(nanstd(neg_conhx  ),'%3.1f') ') ' num2str(nanmedian(neg_conhx  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

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
set(gca,'Position',[.75 6.25 1.9 1.9]   ); % gca = graphical current axes % left bottom width height
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
text(29,.75,  ['n=' num2str(length(pos_mhhx_scat  )) ],'FontSize',10,'Color',ORANGE     );
text(29,.675,['n=' num2str(length(neg_mhhx_scat )) ],'FontSize',10,'Color',CYAN        );


hold on
  
ci1 = CIFcn(pos_mhhx_scat,  95);
ci2 = CIFcn(neg_mhhx_scat,  95);

text(29,.525,[ num2str(nanmean(pos_mhhx_scat),  '%3.1f') ' (' num2str(nanstd(pos_mhhx_scat  ),'%3.1f') ') ' num2str(nanmedian(pos_mhhx_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(29,.450,[ num2str(nanmean(neg_mhhx_scat),  '%3.1f') ' (' num2str(nanstd(neg_mhhx_scat  ),'%3.1f') ') ' num2str(nanmedian(neg_mhhx_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

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
set(gca,'Position',  [3 6.25 1.9 1.9]   );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 75]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 25 50 75]      );
set(gca,'YTickLabel',{''}          );

hold on
[x1, y1] = cumsum_dist(pos_ladhx_scat);
[x2, y2] = cumsum_dist(neg_ladhx_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

%ylabel('Percentage of Athletes');

% Key
text(29,.75,  ['n=' num2str(length(pos_ladhx_scat)) ],'FontSize',10,'Color',ORANGE      );
text(29,.675,['n=' num2str(length(neg_ladhx_scat)) ],'FontSize',10,'Color',CYAN        );

hold on

ci1 = CIFcn(pos_ladhx_scat,  95);
ci2 = CIFcn(neg_ladhx_scat,  95);

text(29,.525,[ num2str(nanmean(pos_ladhx_scat),  '%3.1f') ' (' num2str(nanstd(pos_ladhx_scat  ),'%3.1f') ') ' num2str(nanmedian(pos_ladhx_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(29,.450,[ num2str(nanmean(neg_ladhx_scat),  '%3.1f') ' (' num2str(nanstd(neg_ladhx_scat  ),'%3.1f') ') ' num2str(nanmedian(neg_ladhx_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('LAD Hx');
 xlabel('SCAT Total Score');
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_ladhx_scat'], ...
   [neg_ladhx_scat'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_ladhx_scat'],[neg_ladhx_scat']);
text(20,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );

%con w scattotal
%figure
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[5.25 6.25 1.9 1.9] ); % gca = graphical current axes % left bottom width height
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
text(26,.75,  ['n=' num2str(length(pos_conhx_scat)) ],'FontSize',10,'Color',ORANGE      );
text(26,.675,['n=' num2str(length(neg_conhx_scat)) ],'FontSize',10,'Color',CYAN        );

  hold on
  
ci1 = CIFcn(pos_conhx_scat,  95);
ci2 = CIFcn(neg_conhx_scat,  95);

text(26,.525,[ num2str(nanmean(pos_conhx_scat),  '%3.1f') ' (' num2str(nanstd(pos_conhx_scat  ),'%3.1f') ') ' num2str(nanmedian(pos_conhx_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(26,.450,[ num2str(nanmean(neg_conhx_scat),  '%3.1f') ' (' num2str(nanstd(neg_conhx_scat  ),'%3.1f') ') ' num2str(nanmedian(neg_conhx_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

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
set(gca,'Position',[.75 3.2 1.9 1.9] ); % gca = graphical current axes % left bottom width height
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
%plot([13 14],[.825 .825],     '-','Color',ORANGE', 'LineWidth',2);
%plot([13 14],[.75 .75], '-','Color',CYAN',   'LineWidth',2);
text(8,0.75,  ['n=' num2str(length(pos_mighx  )) ],'FontSize',10,'Color',ORANGE );
text(8,0.675,['n=' num2str(length(neg_mighx  )) ],'FontSize',10,'Color',CYAN );


hold on

ci1 = CIFcn(pos_mighx,  95);
ci2 = CIFcn(neg_mighx,  95);

%text(6,.6,'Mean(SD) Median:CI' );
text(8,.525,[ num2str(nanmean(pos_mighx),'%3.1f')   ' (' num2str(nanstd(pos_mighx),  '%3.0f') ') ' num2str(nanmedian(pos_mighx  ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE  );
text(8,.450,[ num2str(nanmean(neg_mighx),'%3.1f')   ' (' num2str(nanstd(neg_mighx),  '%3.0f') ') ' num2str(nanmedian(neg_mighx  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN    );

title('Migraine Hx');
xlabel('BSI18 Total Score' );
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_mighx'], ...
   [neg_mighx'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_mighx'],[neg_mighx']);
text(3,.075,['d='  num2str(d3,'%3.2f') '  \itp\rm = ',num2str(P3,'%4.3f')] );


%migraine scat

ha = axes;
nlp_axes_prep(ha)
set(gca,'Position',  [.75 .7 1.9 1.9]   );
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
text(25,0.75,  ['n=' num2str(length(pos_mighx_scat  )) ],'FontSize',10,'Color',ORANGE );
text(25,0.675,['n=' num2str(length(neg_mighx_scat  )) ],'FontSize',10,'Color',CYAN );

hold on

ci1 = CIFcn(pos_mighx_scat,  95);
ci2 = CIFcn(neg_mighx_scat,  95);

%text(6,.6,'Mean(SD) Median:CI' );
text(25,.525,[ num2str(nanmean(pos_mighx_scat),'%3.1f')   ' (' num2str(nanstd(pos_mighx_scat),  '%3.0f') ') ' num2str(nanmedian(pos_mighx_scat  ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE  );
text(25,.450,[ num2str(nanmean(neg_mighx_scat),'%3.1f')   ' (' num2str(nanstd(neg_mighx_scat),  '%3.0f') ') ' num2str(nanmedian(neg_mighx_scat  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN    );

 %title('Mig Hx');
 xlabel('SCAT Total Score' );
 %ylabel('Number of Athletes');


%Effect sizes
d3 = computeCohen_d( [pos_mighx_scat'], ...
   [neg_mighx_scat'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([pos_mighx_scat'],[neg_mighx_scat']);
text(20,.075,['d='  num2str(d3,'%3.2f') '  \itp\rm = ',num2str(P3,'%4.3f')] );

% sex bsi

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [3 3.2 1.9 1.9]      );
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
plot([10 11],[.75 .75],     '-','Color',ORANGE', 'LineWidth',2);
plot([10 11],[.675 .675], '-','Color',CYAN',   'LineWidth',2);
text(12,.75,  ['female n=' num2str(length(female)) ],'FontSize',10,'Color',ORANGE    );
text(12,.675,['male n=' num2str(length(male)) ],'FontSize',10,'Color',CYAN        );

hold on

%text(6,.6,'Mean(SD) Median:CI' );
ci = CIFcn(female,95);
ci2 = CIFcn(male,95);

text(6,.525,[ num2str(nanmean(female  ),'%3.1f') ' (' num2str(nanstd(female  ),'%3.0f') ') ' num2str(nanmedian(female ),'%3.0f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(6,.450,[ num2str(nanmean(male  ),'%3.1f') ' (' num2str(nanstd(male  ),'%3.0f') ') ' num2str(nanmedian(male  ),'%3.0f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

title('Sex')
 xlabel('BSI18 Total Score')
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
set(gca,'Position',  [3 .7 1.9 1.9]      );
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
text(20,.75,  ['n=' num2str(length(female_scat)) ],'FontSize',10,'Color',ORANGE    );
text(20,.675,['n=' num2str(length(male_scat)) ],'FontSize',10,'Color',CYAN        );

hold on

%text(6,.6,'Mean(SD) Median:CI' );
ci = CIFcn(female,95);
ci2 = CIFcn(male,95);

text(20,.525,[ num2str(nanmean(female_scat  ),'%3.1f') ' (' num2str(nanstd(female_scat  ),'%3.0f') ') ' num2str(nanmedian(female_scat ),'%3.1f') ':' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(20,.450,[ num2str(nanmean(male_scat  ),'%3.1f') ' (' num2str(nanstd(male_scat  ),'%3.0f') ') ' num2str(nanmedian(male_scat  ),'%3.1f') ':' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('Sex')
 xlabel('SCAT Total Score')
 %ylabel('Number of Athletes')


%Effect sizes
d3 = computeCohen_d( [female_scat'], ...
   [male_scat'], 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2([female_scat'],[male_scat']);
text(20,.075,['d='  num2str(d3,'%3.2f') '  ' ' \itp\rm = ',num2str(P3,'%4.3f')] );


%NCAA BSI

%figure
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[5.25 3.2 1.9 1.9] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12         );
set(gca,'xlim',    [-.5 30]     );
set(gca,'ylim',    [0 1.05] );
set(gca,'XTick',   [0 10 20 30]     );
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
text(8,.8,  ['non contact n=' num2str(length(noncon  )) ],'FontSize',10,'Color',ORANGE       );
text(8,.735,    ['lim contact n=' num2str(length(limcon  )) ],'FontSize',10,'Color',CYAN          );
text(8,.67,  ['contact n='     num2str(length(contact )) ],'FontSize',10,'Color',MAGENTA       );
text(8,.605,   ['non NCAA n='    num2str(length(nonncaa )) ],'FontSize',10,'Color',GREEN         );


hold on

ci1 = CIFcn(noncon,  95);
ci2 = CIFcn(limcon,  95);
ci3 = CIFcn(contact, 95);
ci4 = CIFcn(nonncaa, 95);
%ci5 = CIFcn(cadetrtp,   95);

text(8,.525,[ num2str(nanmean(noncon),  '%3.1f') ' (' num2str(nanstd(noncon  ),'%3.1f') ') ' num2str(nanmedian(noncon  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(8,.450,[ num2str(nanmean(limcon),  '%3.1f') ' (' num2str(nanstd(limcon  ),'%3.1f') ') ' num2str(nanmedian(limcon  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);
text(8,.375,[ num2str(nanmean(contact), '%3.1f') ' (' num2str(nanstd(contact ),'%3.1f') ') ' num2str(nanmedian(contact ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);
text(8,.3,  [ num2str(nanmean(nonncaa), '%3.1f') ' (' num2str(nanstd(nonncaa ),'%3.1f') ') ' num2str(nanmedian(nonncaa ),'%3.0f') ' : ' num2str(ci4(2),'%3.0f') ],'Color',GREEN);
%text(29,.225,[ num2str(nanmean(cadetrtp),  '%3.1f') ' (' num2str(nanstd(cadetrtp  ),'%3.1f') ') ' num2str(nanmedian(cadetrtp  ),'%3.1f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',BLACK);

 title('NCAA');
xlabel('BSI Total Score')


%NCAA SCAT

%figure
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[5.25 .7 1.9 1.9] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize',  12                 );
set(gca,'xlim',      [-.5 75]           );
set(gca,'ylim',      [0 1.05]           );
set(gca,'XTick',     [0 25 50 75]       );
%set(gca,'YTick',     [0 50 100 150 200 250] );
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
text(20,.8,   ['non contact n=' num2str(length(noncon_scat  )) ],'FontSize',10,'Color',ORANGE       );
text(20,.735, ['lim contact n=' num2str(length(limcon_scat  )) ],'FontSize',10,'Color',CYAN          );
text(20,.67,  ['contact n='     num2str(length(contact_scat )) ],'FontSize',10,'Color',MAGENTA       );
text(20,.605, ['non NCAA n='    num2str(length(nonncaa_scat )) ],'FontSize',10,'Color',GREEN         );


hold on

ci1 = CIFcn(noncon_scat,  95);
ci2 = CIFcn(limcon_scat,  95);
ci3 = CIFcn(contact_scat, 95);
ci4 = CIFcn(nonncaa_scat, 95);
%ci5 = CIFcn(cadetrtp,   95);

text(20,.525,[ num2str(nanmean(noncon_scat),  '%3.1f') ' (' num2str(nanstd(noncon_scat  ),'%3.1f') ') ' num2str(nanmedian(noncon_scat  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE );
text(20,.450,[ num2str(nanmean(limcon_scat),  '%3.1f') ' (' num2str(nanstd(limcon_scat  ),'%3.1f') ') ' num2str(nanmedian(limcon_scat  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN   );
text(20,.375,[ num2str(nanmean(contact_scat), '%3.1f') ' (' num2str(nanstd(contact_scat ),'%3.1f') ') ' num2str(nanmedian(contact_scat ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);
text(20,.3,  [ num2str(nanmean(nonncaa_scat), '%3.1f') ' (' num2str(nanstd(nonncaa_scat ),'%3.1f') ') ' num2str(nanmedian(nonncaa_scat ),'%3.0f') ' : ' num2str(ci4(2),'%3.0f') ],'Color',GREEN  );
%text(29,.225,[ num2str(nanmean(cadetrtp),  '%3.1f') ' (' num2str(nanstd(cadetrtp  ),'%3.1f') ') ' num2str(nanmedian(cadetrtp  ),'%3.1f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',BLACK);

xlabel('SCAT Total Score')

text(77,-.25,'Wilkins et al, Fig. 2')

%keyboard









% fini


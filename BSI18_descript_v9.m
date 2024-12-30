% Prev concussion w Post Injury


%CI function
CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));

% Find indexes for sex  (1==f, 2==m)
j1 = find(T4.sex == 1);
j2 = find(T4.sex == 2);




% Compound indexes
j3 = find(T4.sex == 1 & T4.prev_concuss >= 3);
j4 = find(T4.sex == 2 & T4.prev_concuss >= 3);

j7 = find(T4.sex == 1 & T4.prev_concuss < 3);
j8 = find(T4.sex == 2 & T4.prev_concuss < 3);

f_con_bsianx = T4.b_anx(j3); %F w anxiety, bsi anxiety score
m_con_bsianx = T4.b_anx(j4); %M w anxiety, bsi anxiety score
f_nocon_bsianx = T4.b_anx(j7); %F w/o anxiety, bsi anxiety score
m_nocon_bsianx = T4.b_anx(j8); %M w/o anxiety, bsi anxiety score

f_con_bsidep = T4.b_dep(j3); %F w anxiety, bsi dep score
m_con_bsidep = T4.b_dep(j4); %M w anxiety, bsi dep score
f_nocon_bsidep = T4.b_dep(j7); %F w/o anxiety, bsi dep score
m_nocon_bsidep = T4.b_dep(j8); %M w/o anxiety, bsi dep score

f_con_bsisoma = T4.b_soma(j3); %F w anxiety, bsi soma score
m_con_bsisoma = T4.b_soma(j4); %M w anxiety, bsi soma score
f_nocon_bsisoma = T4.b_soma(j7); %F w/o anxiety, bsi soma score
m_nocon_bsisoma = T4.b_soma(j8); %M w/o anxiety, bsi soma score

f_con_scat = T4.scatsxsev_score(j3);
m_con_scat = T4.scatsxsev_score(j4);
f_nocon_scat = T4.scatsxsev_score(j7);
m_nocon_scat = T4.scatsxsev_score(j8);

% New Figure
hf = figure;
nlp_fig_prep(hf, 'Portrait');


% First axes panel
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 8.5 2 2]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    [-.5 24]      );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   [0 8 16 24]      );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','off');

hold on
[x1, y1] = cumsum_dist(f_con_bsianx);
[x2, y2] = cumsum_dist(m_con_bsianx);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2  )

ylabel('Percentage of Athletes')

% Key
plot([13 14],[.9 .9],    '-','Color',ORANGE', 'LineWidth',2)
plot([13 14],[.825 .825],'-','Color',CYAN',   'LineWidth',2)
plot([13 14],[.75 .75],  '-','Color',MAGENTA','LineWidth',2)
plot([13 14],[.675 .675],'-','Color',GREEN',  'LineWidth',2)
text(15,.9,  ['F >3 n='  num2str(length(f_con_bsianx   )) ], 'FontSize', 10,'Color',ORANGE    );
text(15,.825,['M >3 n='  num2str(length(m_con_bsianx   )) ], 'FontSize', 10,'Color',CYAN      );
text(15,.750,['F <=3 n=' num2str(length(f_nocon_bsianx )) ], 'FontSize', 10,'Color',MAGENTA   );
text(15,.675,['M <=3 n=' num2str(length(m_nocon_bsianx )) ], 'FontSize', 10,'Color',GREEN     );


  hold on
 [x3,y3] = cumsum_dist(f_nocon_bsianx);
 [x4,y4] = cumsum_dist(m_nocon_bsianx);

 plot(x3,y3 ,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 )
 plot(x4,y4,'Color',GREEN,  'LineStyle','-', 'LineWidth',2 )

text(6,.6,'Mean(SD) Median:CI' );
ci = CIFcn(f_con_bsianx,95);
text(6,.525,[ num2str(nanmean(f_con_bsianx),'%3.1f') ...
   ' (' num2str(nanstd(f_con_bsianx),'%3.2f') ') ' ...
   num2str(nanmedian(f_con_bsianx)) ':' num2str(ci(2)) ],'Color',ORANGE);
ci = CIFcn(m_con_bsianx,95);
text(6,.450,[ num2str(nanmean(m_con_bsianx),'%3.1f') ...
   ' (' num2str(nanstd(m_con_bsianx),'%3.2f') ') ' ...
   num2str(nanmedian(m_con_bsianx)) ':' num2str(ci(2)) ],'Color',CYAN);
ci = CIFcn(f_nocon_bsianx,95);
text(6,.375,[ num2str(nanmean(f_nocon_bsianx),'%3.1f') ...
   ' (' num2str(nanstd(f_nocon_bsianx),'%3.2f') ') ' ...
   num2str(nanmedian(f_nocon_bsianx)) ':' num2str(ci(2)) ],'Color',MAGENTA);
ci = CIFcn(m_nocon_bsianx,95);
text(6,.3,[ num2str(nanmean(m_nocon_bsianx),'%3.1f') ...
   ' (' num2str(nanstd(m_nocon_bsianx),'%3.2f') ') ' ...
   num2str(nanmedian(m_nocon_bsianx)) ':' num2str(ci(2)) ],'Color',GREEN);

 title('Prev. Concussion Hx')
 xlabel('BSI18 Anxiety Score')
 ylabel('Number of Athletes')


%Effect sizes
d1 = computeCohen_d( f_con_bsianx,   m_con_bsianx,   'independent');
d2 = computeCohen_d( f_nocon_bsianx, m_nocon_bsianx, 'independent');
d3 = computeCohen_d( [f_con_bsianx' m_con_bsianx'], ...
   [f_nocon_bsianx' m_nocon_bsianx'], 'independent');


%Hypothesis testing
[H,P1,KSSTAT] = kstest2(f_con_bsianx,   m_con_bsianx  );
[H,P2,KSSTAT] = kstest2(f_nocon_bsianx, m_nocon_bsianx);
[H,P3,KSSTAT] = kstest2([f_con_bsianx' m_con_bsianx'],[f_nocon_bsianx' m_nocon_bsianx']);

text(3,.225,['m-f +Hx   d=' num2str(d1,'%3.2f') '  ' 'p=',num2str(P1,'%4.2f')])
text(3,.15,['m-f -Hx    d=' num2str(d2,'%3.2f') '  ' 'p=',num2str(P2,'%4.2f')])
text(3,.075,['all +&-Hx d=' num2str(d3,'%3.2f') '  ' 'p=',num2str(P3,'%4.2f')])


% Second axes panel
% con w bsidep

ha = axes
nlp_axes_prep(ha)
set(gca,'Position',  [3.3 8.5 2 2]   );
set(gca,'FontSize',  12            );
set(gca,'xlim',      [-.5 24]      );
set(gca,'ylim',      [0 1.05]      );
set(gca,'XTick',     [0 8 16 24]      );
%set(gca,'YTick',     [0 50 100 150 200 250] );
set(gca,'YTickLabel',{''}          );


hold on
[x1,y1] = cumsum_dist(f_con_bsidep);
[x2,y2] = cumsum_dist(m_con_bsidep);

plot(x1,y1, 'Color',ORANGE,'LineStyle','-',  'LineWidth',2 )
plot(x2,y2, 'Color',CYAN,  'LineStyle','-', 'LineWidth',2  )

%ylabel('Number of Athletes')

hold on
[x3, y3] = cumsum_dist(f_nocon_bsidep);
[x4, y4] = cumsum_dist(m_nocon_bsidep);

plot(x3,y3,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 )
plot(x4,y4,'Color',GREEN,  'LineStyle','-', 'LineWidth',2 )

%text(6,.6,'Mean(SD) Median:CI' );
ci = CIFcn(f_con_bsidep,95);
text(6,.525,[ num2str(nanmean(f_con_bsidep),'%3.1f') ...
   ' (' num2str(nanstd(f_con_bsidep),'%3.2f') ') ' ...
   num2str(nanmedian(f_con_bsidep)) ':' num2str(ci(2)) ],'Color',ORANGE);
ci = CIFcn(m_con_bsidep,95);
text(6,.450,[ num2str(nanmean(m_con_bsidep),'%3.1f') ...
   ' (' num2str(nanstd(m_con_bsidep),'%3.2f') ') ' ...
   num2str(nanmedian(m_con_bsidep)) ':' num2str(ci(2)) ],'Color',CYAN);
ci = CIFcn(f_nocon_bsidep,95);
text(6,.375,[ num2str(nanmean(f_nocon_bsidep),'%3.1f') ...
   ' (' num2str(nanstd(f_nocon_bsidep),'%3.2f') ') ' ...
   num2str(nanmedian(f_nocon_bsidep)) ':' num2str(ci(2)) ],'Color',MAGENTA);
ci = CIFcn(m_nocon_bsidep,95);
text(6,.3,[ num2str(nanmean(m_nocon_bsidep),'%3.1f') ...
   ' (' num2str(nanstd(m_nocon_bsidep),'%3.2f') ') ' ...
   num2str(nanmedian(m_nocon_bsidep)) ':' num2str(ci(2)) ],'Color',GREEN);

title('Prev. Concussion Hx')
xlabel('BSI18 Depression Score')

% Effect sizes
d1 = computeCohen_d( f_con_bsidep,   m_con_bsidep,   'independent');
d2 = computeCohen_d( f_nocon_bsidep, m_nocon_bsidep, 'independent');
d3 = computeCohen_d( [f_con_bsidep' m_con_bsidep'], ...
   [f_nocon_bsidep' m_nocon_bsidep'], 'independent');


% Hypothesis testing
[H,P1,KSSTAT] = kstest2(f_con_bsidep,   m_con_bsidep  );
[H,P2,KSSTAT] = kstest2(f_nocon_bsidep, m_nocon_bsidep);
[H,P3,KSSTAT] = kstest2([f_con_bsidep' m_con_bsidep'],[f_nocon_bsidep' m_nocon_bsidep']);

text(3,.225,['d=' num2str(d1,'%3.2f') '  '   'p=',num2str(P1,'%4.2f')])
text(3,.15,['d=' num2str(d2,'%3.2f') '  '   'p=',num2str(P2,'%4.2f')])
text(3,.075,['d=' num2str(d3,'%3.2f') '  '   'p=',num2str(P3,'%4.2f')])

%con w bsisoma
%figure
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[5.85 8.5 2 2] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12         );
set(gca,'xlim',    [-.5 24]     );
set(gca,'ylim',    [0 1.05] );
set(gca,'XTick',   [0 8 16 24]     );
%set(gca,'YTick',     [0 50 100 150 200 250] );
set(gca,'YTickLabel',{''}          );

hold on
[x1,y1] = cumsum_dist(f_con_bsisoma);
[x2,y2] = cumsum_dist(m_con_bsisoma);

plot(x1,y1,'Color',ORANGE,'LineStyle','-',  'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2  )

%ylabel('Number of Athletes')

hold on
[x3,y3] = cumsum_dist(f_nocon_bsisoma);
[x4,y4] = cumsum_dist(m_nocon_bsisoma);

plot(x3,y3,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 )
plot(x4,y4,'Color',GREEN,  'LineStyle','-', 'LineWidth',2 )

%text(6,.6,'Mean(SD) Median:CI' );
ci = CIFcn(f_con_bsisoma,95);
text(6,.525,[ num2str(nanmean(f_con_bsisoma),'%3.1f') ...
   ' (' num2str(nanstd(f_con_bsisoma),'%3.2f') ') ' ...
   num2str(nanmedian(f_con_bsisoma)) ':' num2str(ci(2)) ],'Color',ORANGE);
ci = CIFcn(m_con_bsisoma,95);
text(6,.450,[ num2str(nanmean(m_con_bsisoma),'%3.1f') ...
   ' (' num2str(nanstd(m_con_bsisoma),'%3.2f') ') ' ...
   num2str(nanmedian(m_con_bsisoma)) ':' num2str(ci(2)) ],'Color',CYAN);
ci = CIFcn(f_nocon_bsisoma,95);
text(6,.375,[ num2str(nanmean(f_nocon_bsisoma),'%3.1f') ...
   ' (' num2str(nanstd(f_nocon_bsisoma),'%3.2f') ') ' ...
   num2str(nanmedian(f_nocon_bsisoma)) ':' num2str(ci(2)) ],'Color',MAGENTA);
ci = CIFcn(m_nocon_bsisoma,95);
text(6,.3,[ num2str(nanmean(m_nocon_bsisoma),'%3.1f') ...
   ' (' num2str(nanstd(m_nocon_bsisoma),'%3.2f') ') ' ...
   num2str(nanmedian(m_nocon_bsisoma)) ':' num2str(ci(2)) ],'Color',GREEN);

 title('Prev. Concussion Hx')
 xlabel('BSI18 Somatization Score')

% Effect sizes
d1 = computeCohen_d( f_con_bsisoma,   m_con_bsisoma,   'independent');
d2 = computeCohen_d( f_nocon_bsisoma, m_nocon_bsisoma, 'independent');
d3 = computeCohen_d( [f_con_bsisoma' m_con_bsisoma'], ...
   [f_nocon_bsisoma' m_nocon_bsisoma'], 'independent');


% Hypothesis testing
[H,P1,KSSTAT] = kstest2(f_con_bsisoma,   m_con_bsisoma  );
[H,P2,KSSTAT] = kstest2(f_nocon_bsisoma, m_nocon_bsisoma);
[H,P3,KSSTAT] = kstest2([f_con_bsisoma' m_con_bsisoma'],[f_nocon_bsisoma' m_nocon_bsisoma']);

text(3,.225,['d=' num2str(d1,'%3.2f') '  '   'p=',num2str(P1,'%4.2f')])
text(3,.15,['d=' num2str(d2,'%3.2f') '  '   'p=',num2str(P2,'%4.2f')])
text(3,.075,['d=' num2str(d3,'%3.2f') '  '   'p=',num2str(P3,'%4.2f')])

%ADD w bsianx
%figure
%{
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 5.5 2 2] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12         );
set(gca,'xlim',    [-.5 24]     );
set(gca,'ylim',    [0 1.05] );
set(gca,'XTick',   [0 8 16 24]     );
%set(gca,'YTick',     [0 100 200 300 400] );
%set(gca,'YTickLabel',{''}          );

hold on
[x1,y1] = cumsum_dist(f_add_bsianx);
[x2,y2] = cumsum_dist(m_add_bsianx);

plot(x1,y1,'Color',ORANGE,'LineStyle','-',  'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2  )

plot([13 14],[.9 .9],'-','Color',ORANGE', 'LineWidth',2)
plot([13 14],[.825 .825],'-','Color',CYAN',   'LineWidth',2)
plot([13 14],[.75 .75],'-','Color',MAGENTA','LineWidth',2)
plot([13 14],[.675 .675],'-','Color',GREEN',  'LineWidth',2)
text(15,.9,  ['n=871','FontSize',10,'Color',ORANGE      );
text(15,.825,['n=436','FontSize',10,'Color',CYAN        );
text(15,.750,['n=16249','FontSize',10,'Color',MAGENTA     );
text(15,.675,['n=29074','FontSize',10,'Color',GREEN       );

ylabel('Number of Athletes')


hold on
[x3,y3] = cumsum_dist(f_noadd_bsianx);
[x4,y4] = cumsum_dist(m_noadd_bsianx);

plot(x3,y3,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 )
plot(x4,y4,'Color',GREEN,  'LineStyle','-', 'LineWidth',2 )

%text(6,.6,'Mean(SD) Median:CI' );
ci = CIFcn(f_add_bsianx,95);
text(6,.525,[ num2str(nanmean(f_add_bsianx),'%3.1f') ...
   ' (' num2str(nanstd(f_add_bsianx),'%3.2f') ') ' ...
   num2str(nanmedian(f_add_bsianx)) ':' num2str(ci(2)) ],'Color',ORANGE);
ci = CIFcn(m_add_bsianx,95);
text(6,.450,[ num2str(nanmean(m_add_bsianx),'%3.1f') ...
   ' (' num2str(nanstd(m_add_bsianx),'%3.2f') ') ' ...
   num2str(nanmedian(m_add_bsianx)) ':' num2str(ci(2)) ],'Color',CYAN);
ci = CIFcn(f_noadd_bsianx,95);
text(6,.375,[ num2str(nanmean(f_noadd_bsianx),'%3.1f') ...
   ' (' num2str(nanstd(f_noadd_bsianx),'%3.2f') ') ' ...
   num2str(nanmedian(f_noadd_bsianx)) ':' num2str(ci(2)) ],'Color',MAGENTA);
ci = CIFcn(m_noadd_bsianx,95);
text(6,.3,[ num2str(nanmean(m_noadd_bsianx),'%3.1f') ...
   ' (' num2str(nanstd(m_noadd_bsianx),'%3.2f') ') ' ...
   num2str(nanmedian(m_noadd_bsianx)) ':' num2str(ci(2)) ],'Color',GREEN);
%}

%SCAT%
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 2.6 2 2]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    [-.5 100]      );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   [0 50 100]      );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','off');

hold on
[x1,y1] = cumsum_dist(f_con_scat);
[x2,y2] = cumsum_dist(m_con_scat);

plot(x1,y1,'Color',ORANGE,'LineStyle','-',  'LineWidth',2 )
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2  )

%ylabel('Number of Athletes')

hold on
[x3,y3] = cumsum_dist(f_nocon_scat);
[x4,y4] = cumsum_dist(m_nocon_scat);

plot(x3,y3,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 )
plot(x4,y4,'Color',GREEN,  'LineStyle','-', 'LineWidth',2 )

%text(30,.6,'Mean(SD) Median:CI' );
ci = CIFcn(f_con_scat,95);
text(30,.525,[ num2str(nanmean(f_con_scat),'%3.1f') ...
   ' (' num2str(nanstd(f_con_scat),'%3.2f') ') ' ...
   num2str(nanmedian(f_con_scat)) ':' num2str(ci(2)) ],'Color',ORANGE);
ci = CIFcn(m_con_scat,95);
text(30,.450,[ num2str(nanmean(m_con_scat),'%3.1f') ...
   ' (' num2str(nanstd(m_con_scat),'%3.2f') ') ' ...
   num2str(nanmedian(m_con_scat)) ':' num2str(ci(2)) ],'Color',CYAN);
ci = CIFcn(f_nocon_scat,95);
text(30,.375,[ num2str(nanmean(f_nocon_scat),'%3.1f') ...
   ' (' num2str(nanstd(f_nocon_scat),'%3.2f') ') ' ...
   num2str(nanmedian(f_nocon_scat)) ':' num2str(ci(2)) ],'Color',MAGENTA);
ci = CIFcn(m_nocon_scat,95);
text(30,.3,[ num2str(nanmean(m_nocon_scat),'%3.1f') ...
   ' (' num2str(nanstd(m_nocon_scat),'%3.2f') ') ' ...
   num2str(nanmedian(m_nocon_scat)) ':' num2str(ci(2)) ],'Color',GREEN);

title('Prev. Concussion Hx')
xlabel('SCAT5 Symptom Score')
%ylabel('Number of Athletes')


% % Effect sizes
d1 = computeCohen_d( f_con_scat,   m_con_scat,   'independent');
d2 = computeCohen_d( f_nocon_scat, m_nocon_scat, 'independent');
d3 = computeCohen_d( [f_con_scat' m_con_scat'], ...
   [f_nocon_scat' m_nocon_scat'], 'independent');


% Hypothesis testing
[H,P1,KSSTAT] = kstest2(f_con_scat,   m_con_scat  );
[H,P2,KSSTAT] = kstest2(f_nocon_scat, m_nocon_scat);
[H,P3,KSSTAT] = kstest2([f_con_scat' m_con_scat'],[f_nocon_scat' m_nocon_scat']);

text(15,.225,['d=' num2str(d1,'%3.2f') '  ' 'p=',num2str(P1,'%4.2f')])
text(15,.15, ['d=' num2str(d2,'%3.2f') '  ' 'p=',num2str(P2,'%4.2f')])
text(15,.075,['d=' num2str(d3,'%3.2f') '  ' 'p=',num2str(P3,'%4.2f')])

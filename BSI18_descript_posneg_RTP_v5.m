%RTP


%CI function

CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));

femalertp = T4S.time_t_RTP( T4S.sex==1 );
malertp   = T4S.time_t_RTP( T4S.sex==2 );

pos_mhhxrtp   = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & ( T4S.anx_hx == 1 | T4S.dep_hx == 1) );
neg_mhhxrtp   = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & ( T4S.anx_hx == 0 & T4S.dep_hx == 0) );

pos_ladhxstimrtp   = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & (T4S.ld == 1 | T4S.add == 1) & (T4S.stimulant == 1) );
pos_ladhxnostimrtp = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & (T4S.ld == 1 | T4S.add == 1) & (T4S.stimulant == 0) );
neg_ladhxrtp       = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & (T4S.ld == 0 & T4S.add == 0) );

pos_conhxrtp   = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & T4S.prev_concuss >= 3 );
neg_conhxrtp   = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & T4S.prev_concuss < 3  );

pos_mighxrtp   = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & T4S.migraine == 1);
neg_mighxrtp   = T4S.time_t_RTP(( T4S.sex == 1 | T4S.sex == 2) & T4S.migraine == 0);

nonconrtp      = T4S.time_t_RTP( T4S.ncaa==1 );
limconrtp      = T4S.time_t_RTP( T4S.ncaa==2 );
contactrtp     = T4S.time_t_RTP( T4S.ncaa==3 );
nonncaartp     = T4S.time_t_RTP( T4S.ncaa==4 );
cadetrtp       = T4S.time_t_RTP( T4S.ncaa==5 );

pos_locrtp   = T4S.time_t_RTP( T4S.LOC == 1);
neg_locrtp   = T4S.time_t_RTP( T4S.LOC == 0);

practicertp = T4S.time_t_RTP( T4S.situation == 1);
comprtp     = T4S.time_t_RTP( T4S.situation == 2);
outsidertp  = T4S.time_t_RTP( T4S.situation == 3);

pos_delayrtp = T4S.time_t_RTP( T4S.daysreportedlate == 1);
neg_delayrtp = T4S.time_t_RTP( T4S.daysreportedlate == 0);


SCAT_max   = 68;
BSI18_max  = 30;

b_total   = [T4.b_anx]+[T4.b_dep]+[T4.b_soma];


pos_scatrtp = T4S.time_t_RTP(T4S.scatsxsev_score >= SCAT_max);
neg_scatrtp = T4S.time_t_RTP(T4S.scatsxsev_score < SCAT_max );

pos_bsirtp = T4.time_t_RTP(b_total >= BSI18_max);
neg_bsirtp = T4.time_t_RTP(b_total < BSI18_max );

% New Figure
hf = figure;
nlp_fig_prep(hf, 'Portrait');

XL = [-2 140];
XT = [0 50 100 140];

BOTTOM = [8.50 6.30 4.10 1.90];

%
% Mental Health
%
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',  [.75 BOTTOM(1) 2 2] ); 
set(gca,'FontSize',  12                  );
set(gca,'xlim',      XL                  );
set(gca,'ylim',      [0 1.05]            );
set(gca,'XTick',     XT                  );
set(gca,'Clipping',  'on'                );
set(gca,'XTickLabel',{''}                );
set(gca,'XColor',    BLACK               );
hold on
[x1, y1] = cumsum_dist(pos_mhhxrtp);
[x2, y2] = cumsum_dist(neg_mhhxrtp);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

ylabel('Percentage of Athletes');

% Key
text(75,.75, ['+hx n=' num2str(length(pos_mhhxrtp(~isnan(pos_mhhxrtp)) )) ],'FontSize',10,'Color',ORANGE      );
text(75,.675,['-hx n=' num2str(length(neg_mhhxrtp(~isnan(neg_mhhxrtp)) )) ],'FontSize',10,'Color',CYAN        );

text(26,.6,'Mean(SD) Median:CI' );
ci1 = CIFcn(pos_mhhxrtp,  95);
ci2 = CIFcn(neg_mhhxrtp,  95);

text(26,.525,[ num2str(nanmean(pos_mhhxrtp),  '%3.1f') ' (' num2str(nanstd(pos_mhhxrtp  ),'%3.1f') ') ' num2str(nanmedian(pos_mhhxrtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(26,.450,[ num2str(nanmean(neg_mhhxrtp),  '%3.1f') ' (' num2str(nanstd(neg_mhhxrtp  ),'%3.1f') ') ' num2str(nanmedian(neg_mhhxrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('Mental Health Hx');
text(1,1.1,'\bfMental Health')


%Effect sizes
d3 = computeCohen_d( pos_mhhxrtp', neg_mhhxrtp', 'independent');

%Hypothesis testing
[~,P3,~] = kstest2(pos_mhhxrtp',neg_mhhxrtp');
text(20,.15,['Cohen''s \itd\rm='  num2str(d3,'%3.2f') '  ' '\itp\rm=',num2str(P3,'%4.3f')] );

% Cox proportional hazzard
predictors=categorical([ones(length(pos_mhhxrtp),1);ones(length(neg_mhhxrtp),1)+1]);
data = table(predictors,[pos_mhhxrtp;neg_mhhxrtp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.075,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ])

hazard_ratio{1,1} = 'MH';
hazard_ratio{1,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{1,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{1,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});

% 
% Learning Disability 
%

ha = axes;
nlp_axes_prep(ha)
set(gca,'Position',  [3 BOTTOM(1) 2 2] );
set(gca,'FontSize',  12                );
set(gca,'xlim',      XL                );
set(gca,'ylim',      [0 1.05]          );
set(gca,'XTick',     XT                );
set(gca,'YTickLabel',{''}              );
set(gca,'XTickLabel',{''}              );
set(gca,'XColor',    BLACK             );
set(gca,'YColor',    BLACK             );

hold on
[x1, y1] = cumsum_dist(pos_ladhxstimrtp   );
[x2, y2] = cumsum_dist(pos_ladhxnostimrtp );
[x3, y3] = cumsum_dist(neg_ladhxrtp       );

plot(x1,y1,'Color',ORANGE, 'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,   'LineStyle','-', 'LineWidth',2 );
plot(x3,y3,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 );

% Key
text(30,.75, ['+hx & +stimulant n='  num2str(length(pos_ladhxstimrtp(  ~isnan(pos_ladhxstimrtp   )) )) ],'FontSize',10,'Color',ORANGE  );
text(30,.675,['+hx & -stimulant n='  num2str(length(pos_ladhxnostimrtp(~isnan(pos_ladhxnostimrtp )) )) ],'FontSize',10,'Color',CYAN    );
text(30,.6,  ['-hx n='               num2str(length(neg_ladhxrtp(      ~isnan(neg_ladhxrtp       )) )) ],'FontSize',10,'Color',MAGENTA    );

ci1 = CIFcn(pos_ladhxstimrtp,   95);
ci2 = CIFcn(pos_ladhxnostimrtp, 95);
ci3 = CIFcn(neg_ladhxrtp,       95);

text(26,.525,[ num2str(nanmean(pos_ladhxstimrtp    ),'%3.1f') ' (' num2str(nanstd(pos_ladhxstimrtp    ),'%3.1f') ') ' num2str(nanmedian(pos_ladhxstimrtp    ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE );
text(26,.450,[ num2str(nanmean(pos_ladhxnostimrtp  ),'%3.1f') ' (' num2str(nanstd(pos_ladhxnostimrtp  ),'%3.1f') ') ' num2str(nanmedian(pos_ladhxnostimrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN   );
text(26,.375,[ num2str(nanmean(neg_ladhxrtp        ),'%3.1f') ' (' num2str(nanstd(neg_ladhxrtp        ),'%3.1f') ') ' num2str(nanmedian(neg_ladhxrtp        ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);

%title('Learning Disability Hx')
text(1,1.1,'\bfLearning Disability')

% Cox proportional hazzard
predictors=categorical([ones(length(pos_ladhxstimrtp   ),1)+0; ...
                        ones(length(pos_ladhxnostimrtp ),1)+1; ...
                        ones(length(neg_ladhxrtp       ),1)+2 ]);

% New ANOVA TABLE
[~,tbl,~]=kruskalwallis( [pos_ladhxstimrtp;pos_ladhxnostimrtp;neg_ladhxrtp], predictors, 'off' );
text(18,0.225,['Chi-sq = ' num2str(tbl{2,5},'%4.3f') ' p = ' num2str(tbl{2,6},'%4.3f')]);

data = table(predictors,[pos_ladhxstimrtp; pos_ladhxnostimrtp; neg_ladhxrtp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(18,0.15, ['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ],'Color',ORANGE);
text(18,0.075,['\beta = ' num2str(mdl.Coefficients{2,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{2,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{2,1}),'%3.2f') ],'Color',CYAN  );

hazard_ratio{2,1} = 'LAD';
hazard_ratio{2,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{2,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{2,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});


hazard_ratio{3,1} = 'LAD2';
hazard_ratio{3,2} = num2str(exp(mdl.Coefficients{2,1}));
hazard_ratio{3,3} = mdl.Coefficients{2,1} - (1.96*mdl.Coefficients{2,2});
hazard_ratio{3,4} = mdl.Coefficients{2,1} + (1.96*mdl.Coefficients{2,2});


%
% Concussion HX
%
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',  [5.25 BOTTOM(1) 2 2] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize',  12                   );
set(gca,'xlim',      XL                   );
set(gca,'ylim',      [0 1.05]             );
set(gca,'XTick',     XT                   );
set(gca,'YTickLabel',{''}                 );
set(gca,'XTickLabel',{''}                 );
set(gca,'XColor',    BLACK                );
set(gca,'YColor',    BLACK                );
hold on
[x1, y1] = cumsum_dist(pos_conhxrtp);
[x2, y2] = cumsum_dist(neg_conhxrtp);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

% Key
text(75,.75,  ['\geq3 n=' num2str(length(pos_conhxrtp(  ~isnan(pos_conhxrtp )) )) ],'FontSize',10,'Color',ORANGE       );
text(75,.675, ['< 3 n='   num2str(length(neg_conhxrtp(  ~isnan(neg_conhxrtp )) )) ],'FontSize',10,'Color',CYAN         );

ci1 = CIFcn(pos_conhxrtp,  95);
ci2 = CIFcn(neg_conhxrtp,  95);

text(29,.525,[ num2str(nanmean(pos_conhxrtp),  '%3.1f') ' (' num2str(nanstd(pos_conhxrtp  ),'%3.1f') ') ' num2str(nanmedian(pos_conhxrtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(29,.450,[ num2str(nanmean(neg_conhxrtp),  '%3.1f') ' (' num2str(nanstd(neg_conhxrtp  ),'%3.1f') ') ' num2str(nanmedian(neg_conhxrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('Concussion Hx');
text(1,1.1,'\bfConcussion Hx')

%Effect sizes
d3 = computeCohen_d( pos_conhxrtp', neg_conhxrtp', 'independent');

%Hypothesis testing
[~,P3,~] = kstest2(pos_conhxrtp',neg_conhxrtp');
text(23,.15,['\itd\rm='  num2str(d3,'%3.2f') ' p=' num2str(P3,'%4.3f') ] );

% Cox proportional hazzard
predictors=categorical([ones(length(pos_conhxrtp),1);ones(length(neg_conhxrtp),1)+1]);
data = table(predictors,[pos_conhxrtp;neg_conhxrtp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.075,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ]);

hazard_ratio{4,1} = 'Concuss';
hazard_ratio{4,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{4,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{4,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});

%
% Migraine Hx
%

ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',  [.75 BOTTOM(2) 2 2] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize',  12             );
set(gca,'xlim',      XL             );
set(gca,'ylim',      [0 1.05]       );
set(gca,'XTick',     XT             );
set(gca,'XColor',    BLACK          );
set(gca,'XTickLabel',{''}           );
set(gca,'Clipping',  'on'           );
hold on;

[x1, y1] = cumsum_dist(pos_mighxrtp);
[x2, y2] = cumsum_dist(neg_mighxrtp);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

% Key
text(75, .75, ['n=' num2str(length(pos_mighxrtp(  ~isnan(pos_mighxrtp  )) )) ],'FontSize',10,'Color',ORANGE      );
text(75, .675,['n=' num2str(length(neg_mighxrtp(  ~isnan(neg_mighxrtp  )) )) ],'FontSize',10,'Color',CYAN        );

ci1 = CIFcn(pos_mighxrtp,  95);
ci2 = CIFcn(neg_mighxrtp,  95);

text(26,.525,[ num2str(nanmean(pos_mighxrtp),  '%3.1f') ' (' num2str(nanstd(pos_mighxrtp  ),'%3.1f') ') ' num2str(nanmedian(pos_mighxrtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(26,.450,[ num2str(nanmean(neg_mighxrtp),  '%3.1f') ' (' num2str(nanstd(neg_mighxrtp  ),'%3.1f') ') ' num2str(nanmedian(neg_mighxrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('Migraine Hx');
text(1,1.1,'\bfMigraine Hx')
ylabel('Percentage of Athletes');


%Effect sizes
d3 = computeCohen_d( pos_mighxrtp', neg_mighxrtp', 'independent');

%Hypothesis testing
[~,P3,~] = kstest2(pos_mighxrtp',neg_mighxrtp');
text(20,.15,['\itd\rm='  num2str(d3,'%3.2f') '  ' 'p=',num2str(P3,'%4.3f')] );

% Cox proportional hazzard
predictors=categorical([ones(length(pos_mighxrtp),1);ones(length(neg_mighxrtp),1)+1]);
data = table(predictors,[pos_mighxrtp;neg_mighxrtp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.075,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ]);

hazard_ratio{5,1} = 'Migraine';
hazard_ratio{5,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{5,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{5,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});



%
% LOC
%

ha = axes;
nlp_axes_prep(ha)
set(gca,'Position',  [3 BOTTOM(2) 2 2] );
set(gca,'FontSize',  12                );
set(gca,'xlim',      XL                );
set(gca,'ylim',      [0 1.05]          );
set(gca,'XTick',     XT                );
set(gca,'YTickLabel',{''}              );
set(gca,'XTickLabel',{''}              );
set(gca,'XColor',    BLACK             );
set(gca,'YColor',    BLACK             );
hold on

[x1, y1] = cumsum_dist(pos_locrtp);
[x2, y2] = cumsum_dist(neg_locrtp);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

% Key
text(75,.75, ['n=' num2str(length(pos_locrtp(  ~isnan(pos_locrtp   )) )) ],'FontSize',10,'Color',ORANGE  );
text(75,.675,['n=' num2str(length(neg_locrtp (  ~isnan(neg_locrtp  )) )) ],'FontSize',10,'Color',CYAN    );

ci1 = CIFcn(pos_locrtp,  95);
ci2 = CIFcn(neg_locrtp,  95);

text(26,.525,[ num2str(nanmean(pos_locrtp  ),'%3.1f') ' (' num2str(nanstd(pos_locrtp  ),'%3.1f') ') ' num2str(nanmedian(pos_locrtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(26,.450,[ num2str(nanmean(neg_locrtp  ),'%3.1f') ' (' num2str(nanstd(neg_locrtp  ),'%3.1f') ') ' num2str(nanmedian(neg_locrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('Loss of Consciousness');
text(1,1.1,'\bfLoss of Consciousness');

%Effect sizes
d3 = computeCohen_d( pos_locrtp', neg_locrtp', 'independent');

%Hypothesis testing
[~,P3,~] = kstest2(pos_locrtp', neg_locrtp');
text(26,.15,['\itd\rm='  num2str(d3,'%3.2f') '  ' 'p=',num2str(P3,'%4.3f')] );

% Cox proportional hazzard
predictors=categorical([ones(length(pos_locrtp),1);ones(length(neg_locrtp),1)+1]);
data = table(predictors,[pos_locrtp;neg_locrtp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.075,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ]);

hazard_ratio{6,1} = 'LOC';
hazard_ratio{6,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{6,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{6,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});


%
% Sex
%
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position', [5.25 BOTTOM(2) 2 2] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize',  12                  );
set(gca,'xlim',      XL                  );
set(gca,'ylim',      [0 1.05]            );
set(gca,'XTick',     XT                  );
set(gca,'YTickLabel',{''}                );
set(gca,'XTickLabel',{''}                );
set(gca,'XColor',    BLACK               );
set(gca,'YColor',    BLACK               );
hold on

[x1, y1] = cumsum_dist(femalertp );
[x2, y2] = cumsum_dist(malertp   );

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

% Key
text(75,.75, ['female n=' num2str(length(femalertp(  ~isnan(femalertp )) )) ],'FontSize',10,'Color',ORANGE      );
text(75,.675,['male n='   num2str(length(malertp(    ~isnan(malertp   )) )) ],'FontSize',10,'Color',CYAN        );

ci1 = CIFcn(femalertp,  95);
ci2 = CIFcn(malertp,  95);

text(29,.525,[ num2str(nanmean(femalertp),'%3.1f') ' (' num2str(nanstd(femalertp  ),'%3.1f') ') ' num2str(nanmedian(femalertp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(29,.450,[ num2str(nanmean(malertp),  '%3.1f') ' (' num2str(nanstd(malertp  ),'%3.1f') ') ' num2str(nanmedian(malertp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('Sex');
text(1,1.1,'\bfSex');

%Effect sizes
d3 = computeCohen_d( femalertp', malertp', 'independent');

%Hypothesis testing
[~,P3,~] = kstest2(femalertp',malertp');
text(23,.15,['\itd\rm='  num2str(d3,'%3.2f') ' p=' num2str(P3,'%4.3f') ] );

% Cox proportional hazzard
predictors=categorical([ones(length(femalertp),1);ones(length(malertp),1)+1]);
data = table(predictors,[femalertp;malertp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.075,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ]);

hazard_ratio{7,1} = 'Sex';
hazard_ratio{7,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{7,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{7,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});

%
% NCAA
%
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',   [.75 BOTTOM(3) 2 2] ); 
set(gca,'FontSize',   12                  );
set(gca,'xlim',       XL                  );
set(gca,'ylim',       [0 1.05]            );
set(gca,'XTick',      XT                  );
set(gca,'XColor',     BLACK               );
set(gca,'XTickLabel', {''}                );
hold on

[x1, y1] = cumsum_dist(nonconrtp  );
[x2, y2] = cumsum_dist(limconrtp  );
[x3, y3] = cumsum_dist(contactrtp );
[x4, y4] = cumsum_dist(nonncaartp );


plot(x1,y1, 'Color',ORANGE, 'LineStyle','-', 'LineWidth',2 );
plot(x2,y2, 'Color',CYAN,   'LineStyle','-', 'LineWidth',2 );
plot(x3,y3 ,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 );
plot(x4,y4, 'Color',GREEN,  'LineStyle','-', 'LineWidth',2 );

ylabel('Percentage of Athletes')

% Key
text(55,.865,  ['contact n='     num2str(length(contactrtp( ~isnan(contactrtp  )) )) ],'FontSize',10,'Color',MAGENTA      );
text(55,.8,    ['lim contact n=' num2str(length(limconrtp(  ~isnan(limconrtp   )) )) ],'FontSize',10,'Color',CYAN         );
text(55,.735,  ['non contact n=' num2str(length(nonconrtp(  ~isnan(nonconrtp   )) )) ],'FontSize',10,'Color',ORANGE       );
text(55,.67,   ['non NCAA n='    num2str(length(nonncaartp( ~isnan(nonncaartp  )) )) ],'FontSize',10,'Color',GREEN        );


ci1 = CIFcn(nonconrtp,  95);
ci2 = CIFcn(limconrtp,  95);
ci3 = CIFcn(contactrtp, 95);
ci4 = CIFcn(nonncaartp, 95);

text(29,.600, [ num2str(nanmean(contactrtp), '%3.1f') ' (' num2str(nanstd(contactrtp ),'%3.1f') ') ' num2str(nanmedian(contactrtp ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);
text(29,.525, [ num2str(nanmean(limconrtp),  '%3.1f') ' (' num2str(nanstd(limconrtp  ),'%3.1f') ') ' num2str(nanmedian(limconrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN   );
text(29,.450, [ num2str(nanmean(nonconrtp),  '%3.1f') ' (' num2str(nanstd(nonconrtp  ),'%3.1f') ') ' num2str(nanmedian(nonconrtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE );
text(29,.375, [ num2str(nanmean(nonncaartp), '%3.1f') ' (' num2str(nanstd(nonncaartp ),'%3.1f') ') ' num2str(nanmedian(nonncaartp ),'%3.0f') ' : ' num2str(ci4(2),'%3.0f') ],'Color',GREEN  );

%title('NCAA');
text(1,1.1,'\bfNCAA');

% Cox proportional hazzard
predictors=categorical([ones(length(nonconrtp ),1)+2; ... %0
                        ones(length(limconrtp ),1)+1; ... %1
                        ones(length(contactrtp),1)+0; ... %2
                        ones(length(nonncaartp),1)+3; ]); %3

% New ANOVA TABLE
[~,tbl,~]=kruskalwallis( [nonconrtp;limconrtp;contactrtp;nonncaartp], predictors, 'off' );
text(18,0.3,['Chi-sq = ' num2str(tbl{2,5},'%4.3f') ' p = ' num2str(tbl{2,6},'%4.3f')]);

data = table(predictors,[nonconrtp;limconrtp;contactrtp;nonncaartp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(18,0.225,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ],'Color',MAGENTA);
text(18,0.15, ['\beta = ' num2str(mdl.Coefficients{2,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{2,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{2,1}),'%3.2f') ],'Color',CYAN   );
text(18,0.075,['\beta = ' num2str(mdl.Coefficients{3,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{3,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{3,1}),'%3.2f') ],'Color',ORANGE );

hazard_ratio{8,1} = 'NCAA';
hazard_ratio{8,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{8,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{8,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});


hazard_ratio{9,1} = 'NCAA2';
hazard_ratio{9,2} = num2str(exp(mdl.Coefficients{2,1}));
hazard_ratio{9,3} = mdl.Coefficients{2,1} - (1.96*mdl.Coefficients{2,2});
hazard_ratio{9,4} = mdl.Coefficients{2,1} + (1.96*mdl.Coefficients{2,2});


hazard_ratio{10,1} = 'NCAA3';
hazard_ratio{10,2} = num2str(exp(mdl.Coefficients{3,1}));
hazard_ratio{10,3} = mdl.Coefficients{3,1} - (1.96*mdl.Coefficients{3,2});
hazard_ratio{10,4} = mdl.Coefficients{3,1} + (1.96*mdl.Coefficients{3,2});




%
% SCAT panel
%

ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',   [3 BOTTOM(3) 2 2] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize',   12                );
set(gca,'xlim',       XL                );
set(gca,'ylim',       [0 1.05]          );
set(gca,'XTick',      XT                );
set(gca,'Clipping',   'on'              );
set(gca,'XTickLabel', {''}              );
set(gca,'YTickLabel', {''}              );
set(gca,'XColor',     BLACK             );
set(gca,'YColor',     BLACK             );

hold on
[x1, y1] = cumsum_dist(pos_scatrtp);
[x2, y2] = cumsum_dist(neg_scatrtp);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

% Key
text(75,.75, ['n=' num2str(length(pos_scatrtp(  ~isnan(pos_scatrtp   ))  )) ],'FontSize',10,'Color',ORANGE      );
text(75,.675,['n=' num2str(length(neg_scatrtp(  ~isnan(neg_scatrtp   ))  )) ],'FontSize',10,'Color',CYAN        );

ci1 = CIFcn(pos_scatrtp,  95);
ci2 = CIFcn(neg_scatrtp,  95);

text(40,.525,[ num2str(nanmean(pos_scatrtp),  '%3.1f') ' (' num2str(nanstd(pos_scatrtp  ),'%3.1f') ') ' num2str(nanmedian(pos_scatrtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(40,.450,[ num2str(nanmean(neg_scatrtp),  '%3.1f') ' (' num2str(nanstd(neg_scatrtp  ),'%3.1f') ') ' num2str(nanmedian(neg_scatrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('SCAT >= 68');
text(1,1.1,'\bfSCAT >= 68');

%Effect sizes
d3 = computeCohen_d( pos_scatrtp', neg_scatrtp', 'independent');

%Hypothesis testing
[~,P3,~] = kstest2(pos_scatrtp',neg_scatrtp');
text(20,.15,['\itd\rm='  num2str(d3,'%3.2f') '  ' '\itp\rm=',num2str(P3,'%4.3f')] );

% Cox proportional hazzard
predictors=categorical([ones(length(pos_scatrtp),1);ones(length(neg_scatrtp),1)+1]);
data = table(predictors,[pos_scatrtp;neg_scatrtp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.075,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ])

hazard_ratio{11,1} = 'SCAT';
hazard_ratio{11,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{11,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{11,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});

%
% BSI
%
ha = axes;
nlp_axes_prep(ha)
set(gca,'Position',  [5.25 BOTTOM(3) 2 2] );
set(gca,'FontSize',   12                  );
set(gca,'xlim',       XL                  );
set(gca,'ylim',       [0 1.05]            );
set(gca,'XTick',      XT                  );
set(gca,'XTickLabel', {''}                );
set(gca,'YTickLabel', {''}                );
set(gca,'XColor',     BLACK               );
set(gca,'YColor',     BLACK               );
hold on

[x1, y1] = cumsum_dist(pos_bsirtp);
[x2, y2] = cumsum_dist(neg_bsirtp);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

% Key
text(75,.75, ['n=' num2str(length(pos_bsirtp( ~isnan(pos_bsirtp))  )) ],'FontSize',10,'Color',ORANGE  );
text(75,.675,['n=' num2str(length(neg_bsirtp( ~isnan(neg_bsirtp))  )) ],'FontSize',10,'Color',CYAN    );

ci1 = CIFcn(pos_bsirtp,  95);
ci2 = CIFcn(neg_bsirtp,  95);

text(26,.525,[ num2str(nanmean(pos_bsirtp  ),'%3.1f') ' (' num2str(nanstd(pos_bsirtp  ),'%3.1f') ') ' num2str(nanmedian(pos_bsirtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(26,.450,[ num2str(nanmean(neg_bsirtp  ),'%3.1f') ' (' num2str(nanstd(neg_bsirtp  ),'%3.1f') ') ' num2str(nanmedian(neg_bsirtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('BSI >= 30');
text(1,1.1,'\bfBSI >= 30');
xlabel('Return to Play (days)','Color',BLACK);


%Effect sizes
d3 = computeCohen_d( pos_bsirtp', neg_bsirtp', 'independent');

%Hypothesis testing
[~,P3,~] = kstest2(pos_bsirtp',neg_bsirtp');
text(26,.15,['\itd\rm='  num2str(d3,'%3.2f') '  ' 'p=',num2str(P3,'%4.3f')] );

% Cox proportional hazzard
predictors=categorical([ones(length(pos_bsirtp),1);ones(length(neg_bsirtp),1)+1]);
data = table(predictors,[pos_bsirtp;neg_bsirtp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.075,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ])

hazard_ratio{12,1} = 'BSI';
hazard_ratio{12,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{12,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{12,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});

%
% Setting
%
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 BOTTOM(4) 2 2]  ); 
set(gca,'FontSize', 12                  );
set(gca,'xlim',    XL                   );
set(gca,'ylim',    [0 1.05]             );
set(gca,'XTick',   XT                   );
set(gca,'Clipping','on');
hold on

[x1, y1] = cumsum_dist(practicertp  );
[x2, y2] = cumsum_dist(comprtp      );
[x3, y3] = cumsum_dist(outsidertp   );

plot(x1,y1, 'Color',ORANGE, 'LineStyle','-', 'LineWidth',2 );
plot(x2,y2, 'Color',CYAN,   'LineStyle','-', 'LineWidth',2 );
plot(x3,y3 ,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 );

ylabel('Percentage of Athletes')

% Key
text(55, 0.865,  ['comp n='     num2str(length(comprtp(     ~isnan(comprtp     )) )) ],'FontSize',10,'Color',CYAN         );
text(55, 0.800,  ['practice n=' num2str(length(practicertp( ~isnan(practicertp )) )) ],'FontSize',10,'Color',ORANGE       );
text(55, 0.735,  ['outside n='  num2str(length(outsidertp(  ~isnan(outsidertp  )) )) ],'FontSize',10,'Color',MAGENTA      );


ci1 = CIFcn(practicertp, 95);
ci2 = CIFcn(comprtp,     95);
ci3 = CIFcn(outsidertp,  95);

text(29,.525, [ num2str(nanmean(comprtp),    '%3.1f') ' (' num2str(nanstd(comprtp    ),'%3.1f') ') ' num2str(nanmedian(comprtp     ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN  );
text(29,.450, [ num2str(nanmean(practicertp),'%3.1f') ' (' num2str(nanstd(practicertp),'%3.1f') ') ' num2str(nanmedian(practicertp ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(29,.375, [ num2str(nanmean(outsidertp), '%3.1f') ' (' num2str(nanstd(outsidertp ),'%3.1f') ') ' num2str(nanmedian(outsidertp  ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);

%title('Setting');
text(1,1.1,'\bfSetting');
xlabel('Return to Play (days)');

% Cox proportional hazzard
predictors=categorical([ones(length(practicertp ),1)+1; ...
                        ones(length(comprtp     ),1)+0; ...
                        ones(length(outsidertp  ),1)+2 ]);

% New ANOVA TABLE
[p,tbl,stats]=kruskalwallis( [practicertp;comprtp;outsidertp], predictors, 'off' );
text(18,0.225,['Chi-sq = ' num2str(tbl{2,5},'%4.3f') ' p = ' num2str(tbl{2,6},'%4.3f')]);

data = table(predictors,[practicertp;comprtp;outsidertp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.150, ['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ],'Color',CYAN  );
text(12,0.075, ['\beta = ' num2str(mdl.Coefficients{2,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{2,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{2,1}),'%3.2f') ],'Color',ORANGE);

hazard_ratio{13,1} = 'Setting';
hazard_ratio{13,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{13,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{13,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});


hazard_ratio{14,1} = 'Setting2';
hazard_ratio{14,2} = num2str(exp(mdl.Coefficients{2,1}));
hazard_ratio{14,3} = mdl.Coefficients{2,1} - (1.96*mdl.Coefficients{2,2});
hazard_ratio{14,4} = mdl.Coefficients{2,1} + (1.96*mdl.Coefficients{2,2});

%
% Delayed Reporting
%

ha = axes;
nlp_axes_prep(ha)
set(gca,'Position',  [3 BOTTOM(4) 2 2]  );
set(gca,'FontSize',  12                 );
set(gca,'xlim',      XL                 );
set(gca,'ylim',      [0 1.05]           );
set(gca,'XTick',     XT                 );
set(gca,'YTickLabel',{''}               );
set(gca,'YColor',    BLACK              );
hold on

[x1, y1] = cumsum_dist(pos_delayrtp);
[x2, y2] = cumsum_dist(neg_delayrtp);

plot(x1,y1,'Color',ORANGE,'LineStyle','-', 'LineWidth',2 );
plot(x2,y2,'Color',CYAN,  'LineStyle','-', 'LineWidth',2 );

% Key
text(75,.75, ['n=' num2str(length(pos_delayrtp(  ~isnan(pos_delayrtp   ))  )) ],'FontSize',10,'Color',ORANGE  );
text(75,.675,['n=' num2str(length(neg_delayrtp(  ~isnan(neg_delayrtp   ))  )) ],'FontSize',10,'Color',CYAN    );

ci1 = CIFcn(pos_delayrtp,  95);
ci2 = CIFcn(neg_delayrtp,  95);

text(26,.525,[ num2str(nanmean(pos_delayrtp  ),'%3.1f') ' (' num2str(nanstd(pos_delayrtp  ),'%3.1f') ') ' num2str(nanmedian(pos_delayrtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE);
text(26,.450,[ num2str(nanmean(neg_delayrtp  ),'%3.1f') ' (' num2str(nanstd(neg_delayrtp  ),'%3.1f') ') ' num2str(nanmedian(neg_delayrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN);

%title('Delayed Reporting')
text(1,1.1,'\bfDelayed Reporting');
xlabel('Return to Play (days)')

%Effect sizes
d3 = computeCohen_d( pos_delayrtp', neg_delayrtp', 'independent');

%Hypothesis testing
[H,P3,KSSTAT] = kstest2(pos_delayrtp',neg_delayrtp');
text(26,.15,['\itd\rm='  num2str(d3,'%3.2f') '  ' 'p=',num2str(P3,'%4.3f')] );

% Cox proportional hazzard
predictors=categorical([ones(length(pos_delayrtp),1);ones(length(neg_delayrtp),1)+1]);
data = table(predictors,[pos_delayrtp;neg_delayrtp],'VariableNames',["Predictors" "RTP"]);
mdl = fitcox(data,"RTP");
text(12,0.075,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ])

hazard_ratio{15,1} = 'Delayed';
hazard_ratio{15,2} = num2str(exp(mdl.Coefficients{1,1}));
hazard_ratio{15,3} = mdl.Coefficients{1,1} - (1.96*mdl.Coefficients{1,2});
hazard_ratio{15,4} = mdl.Coefficients{1,1} + (1.96*mdl.Coefficients{1,2});



text(200,-.4,'Rooks et al, Fig 2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%Odds ratio number line
%

%
% New Figure
%
hf = figure;
nlp_fig_prep(hf, 'Portrait');


ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[2 1 6 6]  ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12          );
set(gca,'xlim',    [0 2.75]      );
set(gca,'ylim',    [0 20]       );
set(gca,'XTick',   [0 1 2 2.5]   );
set(gca,'YTick',   [1 2 3 4 5 6 7 8 9 10 11 12 13]);
%set(gca,'YTickLabel',{''}      );

hold on

%Number line for all factors

for i=1:16
   plot([0 2.5],[i i],'k:');
end 

hold on      

names = {'Delayed'; 'Outside Sport';'Competition'; 'Practice';'Non NCAA'; 'Contact'; 'LimContact'; 'NonContact'; 'Sex'; 'LOC'; 'Migraine'; 'PrevCon'; 'LD'; 'SCAT'; 'BSI18'; 'MH';};

K = 11;
hold on

plot(mh_or,      16, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K );
plot(bsi_or,     15, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K );
plot(scat_or,    14, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K );
plot(lad_or,     13, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K  );
plot(prevcon_or, 12, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K  );
plot(mig_or,     11, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K  );
plot(loc_or,     10, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K  );
plot(sex_or,     9, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K  );
plot(noncon_or,  8, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K  );
plot(limcon_or,  7,'Color', RED, 'Linestyle',':', 'Marker','o',  'MarkerFaceColor', 'r','MarkerSize', K  );
plot(contact_or, 6,'Color', RED, 'Linestyle',':', 'Marker','o',  'MarkerFaceColor', 'r','MarkerSize', K  );
plot(nonncaa_or, 5,'Color', RED, 'Linestyle',':', 'Marker','o',  'MarkerFaceColor', 'r','MarkerSize', K  );
plot(practice_or,4, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K );
plot(comp_or,    3, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K );
plot(outside_or, 2, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K );
plot(delay_or,   1, 'Color', RED, 'Linestyle',':', 'Marker','o', 'MarkerFaceColor', 'r','MarkerSize', K  );


plot(1/mh_or,      16, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/bsi_or,     15, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/scat_or,    14, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/lad_or,     13, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/prevcon_or, 12, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/mig_or,     11, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/loc_or,     10, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/sex_or,     9, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/noncon_or,  8, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/limcon_or,  7,'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/contact_or, 6,'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/nonncaa_or, 5,'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/practice_or,4, 'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/comp_or,    3,'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/outside_or, 2,'Color', BLUE, 'Linestyle',':', 'Marker','^' );
plot(1/delay_or,   1,'Color', BLUE, 'Linestyle',':', 'Marker','^' );


set(gca,'ytick',[1:16],'yticklabel',names);


hold on
plot(0.4, 19,'o','Color',RED, 'MarkerFaceColor', 'r');
plot(0.4, 18,'^','Color',BLUE);
text(0.5, 19, ['Odds Ratio'],'FontSize',10,'Color',RED       );
text(0.5, 18, ['Reciprocal'],'FontSize',10,'Color',BLUE      );
text(0.3, 17, ['Protective'],'FontSize',10,'Color',BLACK     );
text(1.5, 17, ['Risk'],'FontSize',10,'Color',BLACK           );
plot([1 1],[1 17],'k:');
xlabel('Odds Ratio');

title('Unadjusted Odds Ratio & Reciprocals')
set(gca, 'xscale','log');

%hold on

%Number line for just variables that passed the model

clear names

hf = figure;
nlp_fig_prep(hf, 'Portrait');


ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[2 5.5 6 4.8]    ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize',12               );
set(gca,'xlim',    [0 2.75]         );
set(gca,'ylim',    [0 12]           );
set(gca,'XTick',   [0 1 2 2.5]      );
set(gca,'YTick',   [1 2 3 4 5 6 7 8 9 10 11 12 ]);
%set(gca,'YTickLabel',{''}      );
hold on

for i=1:9
   plot([0 2.5],[i i],'k:');
end    

%names = {'NoStim'; 'DelayReport'; 'Competition'; 'Practice'; 'Contact'; 'LimContact'; 'NonContact'; 'SCAT'; 'Prior Concuss'; 'MentalHealth'; 'Sex';};
%names = {'Sex'; 'MentalHealth'; 'Prior Concuss'; 'SCAT'; 'NonContact'; 'LimContact'; 'Contact'; 'Practice'; 'Competition'; 'DelayReport'; 'NoStim';};

%names = {mdl_or{2,1}; mdl_or{3,1}; mdl_or{4,1}; mdl_or{5,1}; mdl_or{6,1}; mdl_or{7,1}; mdl_or{8,1}; mdl_or{9,1}; mdl_or{10,1} };

names ={'Female Sex','Concussion Hx \geq 3','SCAT \geq 68','NCAA Non Conctact','NCAA Lim Contact','NCAA Contact','Setting Practice','Setting Competition','Delayed Reporting'};

K = 11;

hold on


for i = 2:10
    plot([mdl_or{i,3} mdl_or{i,4}],[i-1 i-1],'LineStyle','-','LineWidth',2,'Color',RED)
    plot( mdl_or{i,2},  i-1,'Marker','o', 'MarkerFaceColor', RED,'MarkerEdgeColor',BLACK,'MarkerSize', K )
    plot(1/mdl_or{i,2}, i-1,'Marker','^', 'MarkerFaceColor', BLUE,'MarkerEdgeColor',BLACK,'MarkerSize', K )
end 

set(gca,'ytick',[1:9],'yticklabel',names,'TickLabelInterpreter','tex','FontSize',12);

hold on
plot(0.4, 11.5,'o','Color',RED, 'MarkerFaceColor', 'r');
plot(0.4, 11.0,'^','Color',BLUE);
text(0.5, 11.5, 'Odds Ratio','FontSize',12,'Color',RED       );
text(0.5, 11.0, 'Reciprocal','FontSize',12,'Color',BLUE      );
text(0.3, 10,   'Protective','FontSize',12,'Color',BLACK     );
text(1.5, 10,   'Risk',      'FontSize',12,'Color',BLACK           );
plot([1 1],[1 10],'k:');
xlabel('Odds Ratio','FontSize',12);

text( -0.12, 12, 'A','FontSize',16)
title('Stepwise Reduced Adjusted Odds Ratios')
set(gca, 'xscale','log');

%
% Add the AUC panel
%

ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[2 0.9 3.7 3.7]      ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12            );
set(gca,'TickDir','Out'           );
set(gca,'XLim',[0 1]              );
set(gca,'YLim',[0 1]              );
hold on

plot([0 1],[0 1],'k--','LineWidth',1);

hp=patch(new_x,new_y,'blue')
set(hp,'FaceColor',CYAN)
set(hp,'FaceAlpha',.4)
set(hp,'EdgeColor',CYAN)
set(hp,'EdgeAlpha',.4)

plot(X_auc2(:,1),Y_auc2(:,1),'bo');
plot(X_auc2(:,1),Y_auc2(:,1),'k-','LineWidth',2);
axis equal
text(0.05, 0.95,['AUC = ' num2str(AUC2(1),'%3.2f') '   (' num2str(AUC2(2),'%3.2f') '-' num2str(AUC2(3),'%3.2f') ')' ],'FontSize',14 )

text(0.6,0.345,'Predicted','FontSize',14);
text(0.65,0.30,'Y  N',     'FontSize',14);
text(0.59,0.245,['Y  ' num2str( C(2,2)/C_sum(2)*100,'%2.0f') ' ' num2str(C(2,1)/C_sum(2)*100,'%2.0f')],'FontSize',14)
text(0.59,0.195,['N  ' num2str( C(1,2)/C_sum(1)*100,'%2.0f') ' ' num2str(C(1,1)/C_sum(1)*100,'%2.0f')],'FontSize',14)

text(0.55,0.175,'Actual','Rotation',90,'FontSize',14);

plot([0.635 0.750],[0.27 0.27],'k-','LineWidth',2); %Horz line
plot([0.635 0.635],[0.18 0.27],'k-','LineWidth',2); %Vert line

text( -0.12, 1.01, 'B','FontSize',16)

text( 1.2, -0.15,'Rooks et al  Fig. 3','FontSize',12)

% ciAUC = CIFcn(X,  95);
% errorbar(X,Y(:,1),Y(:,1)-Y(:,2),Y(:,3)-Y(:,1));


title('Prognostic Logistic Regression ROC Curve')












%keyboard












% fini

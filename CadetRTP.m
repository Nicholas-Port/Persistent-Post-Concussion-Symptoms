
%Splitting cadets into their different categories


clubrtp      = T4S.time_t_RTP( T4S.injurymilsporttype==1 );
peclassrtp   = T4S.time_t_RTP( T4S.injurymilsporttype==2 );
trainingrtp  = T4S.time_t_RTP( T4S.injurymilsporttype==3 );
outsidertp   = T4S.time_t_RTP( T4S.injurymilsporttype==4 );
varsityrtp   = T4S.time_t_RTP( T4S.injurymilsporttype==5 );
intramuralrtp= T4S.time_t_RTP( T4S.injurymilsporttype==6 );


% New Figure
hf = figure;
nlp_fig_prep(hf, 'Portrait');

XL = [-2 140];
XT = [0 50 100 140];

%
% Mental Health
%
ha = axes;
nlp_axes_prep(ha);
set(gca,'Position',[.75 5.5 5 5]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',    XL            );
set(gca,'ylim',    [0 1.05]      );
set(gca,'XTick',   XT            );
%set(gca,'YTick',   [0 50 100 150 200 250] );
set(gca,'Clipping','on');


hold on
[x1, y1] = cumsum_dist(clubrtp  );
[x2, y2] = cumsum_dist(peclassrtp  );
[x3, y3] = cumsum_dist(trainingrtp );
[x4, y4] = cumsum_dist(outsidertp );
[x5, y5] = cumsum_dist(varsityrtp   );
[x6, y6] = cumsum_dist(intramuralrtp   );

plot(x1,y1, 'Color',ORANGE, 'LineStyle','-', 'LineWidth',2 );
plot(x2,y2, 'Color',CYAN,   'LineStyle','-', 'LineWidth',2 );
plot(x3,y3 ,'Color',MAGENTA,'LineStyle','-', 'LineWidth',2 );
plot(x4,y4, 'Color',GREEN,  'LineStyle','-', 'LineWidth',2 );
plot(x5,y5, 'Color',RED,    'LineStyle','-', 'LineWidth',2 );
plot(x6,y6, 'Color',BLUE,   'LineStyle','-', 'LineWidth',2 );




ylabel('Percentage of Athletes')

% Key
text(70,.865,  ['Club Sport n='     num2str(length(clubrtp( ~isnan(clubrtp  )) )) ],'FontSize',10,'Color',MAGENTA      );
text(70,.825,    ['PE Class n=' num2str(length(peclassrtp(  ~isnan(peclassrtp   )) )) ],'FontSize',10,'Color',CYAN         );
text(70,.785,  ['Military Training n=' num2str(length(trainingrtp(  ~isnan(trainingrtp   )) )) ],'FontSize',10,'Color',ORANGE       );
text(70,.745,   ['Outside of Sport n='    num2str(length(outsidertp( ~isnan(outsidertp  )) )) ],'FontSize',10,'Color',GREEN        );
text(70,.705,   ['Varsity n='    num2str(length(varsityrtp( ~isnan(varsityrtp  )) )) ],'FontSize',10,'Color',RED        );
text(70,.665,   ['Intramural n='    num2str(length(intramuralrtp( ~isnan(intramuralrtp  )) )) ],'FontSize',10,'Color',BLUE        );



text(70,.6,'Mean(SD) Median:CI' );
ci1 = CIFcn(clubrtp,  95);
ci2 = CIFcn(peclassrtp,  95);
ci3 = CIFcn(trainingrtp, 95);
ci4 = CIFcn(outsidertp, 95);
ci5 = CIFcn(varsityrtp,   95);
ci6 = CIFcn(intramuralrtp,   95);

text(70,.56, [ num2str(nanmean(clubrtp), '%3.1f') ' (' num2str(nanstd(clubrtp ),'%3.1f') ') ' num2str(nanmedian(clubrtp ),'%3.0f') ' : ' num2str(ci3(2),'%3.0f') ],'Color',MAGENTA);
text(70,.52, [ num2str(nanmean(peclassrtp),  '%3.1f') ' (' num2str(nanstd(peclassrtp  ),'%3.1f') ') ' num2str(nanmedian(peclassrtp  ),'%3.0f') ' : ' num2str(ci2(2),'%3.0f') ],'Color',CYAN   );
text(70,.48, [ num2str(nanmean(trainingrtp),  '%3.1f') ' (' num2str(nanstd(trainingrtp  ),'%3.1f') ') ' num2str(nanmedian(trainingrtp  ),'%3.0f') ' : ' num2str(ci1(2),'%3.0f') ],'Color',ORANGE );
text(70,.44, [ num2str(nanmean(outsidertp), '%3.1f') ' (' num2str(nanstd(outsidertp ),'%3.1f') ') ' num2str(nanmedian(outsidertp ),'%3.0f') ' : ' num2str(ci4(2),'%3.0f') ],'Color',GREEN  );
text(70,.4, [ num2str(nanmean(varsityrtp),  '%3.1f') ' (' num2str(nanstd(varsityrtp  ),'%3.1f') ') ' num2str(nanmedian(varsityrtp  ),'%3.1f') ' : ' num2str(ci5(2),'%3.0f') ],'Color',RED);
text(70,.36,[ num2str(nanmean(intramuralrtp),  '%3.1f') ' (' num2str(nanstd(intramuralrtp  ),'%3.1f') ') ' num2str(nanmedian(intramuralrtp  ),'%3.1f') ' : ' num2str(ci6(2),'%3.0f') ],'Color',BLUE);

 title('Cadet');
 xlabel('Return to Play (Days)');
 %ylabel('Number of Athletes');


%Cox proportional hazzard
predictors=categorical([ones(length(clubrtp ),1)+0; ... %0
                        ones(length(peclassrtp ),1)+1; ... %1
                        ones(length(trainingrtp),1)+2; ... %2
                        ones(length(outsidertp),1)+3; ...
                        ones(length(varsityrtp ),1)+4; ... %1
                        ones(length(intramuralrtp),1)+5;  ]); 

% New ANOVA TABLE
[p,tbl,stats]=kruskalwallis( [clubrtp;peclassrtp;trainingrtp;outsidertp;varsityrtp;intramuralrtp], predictors, 'off' )
% LARUEN ADD TABLE HERE
%
%data = table(predictors,[nonconrtp;limconrtp;contactrtp;nonncaartp],'VariableNames',["Predictors" "RTP"]);
%mdl = kruskalwallis(data, "RTP");
text(25,0.32,['Chi-sq = ' num2str(tbl{2,5},'%4.3f') ' p = ' num2str(tbl{2,6},'%4.3f')]);

 data = table(predictors,[clubrtp;peclassrtp;trainingrtp;outsidertp;varsityrtp;intramuralrtp],'VariableNames',["Predictors" "RTP"]);
 mdl = fitcox(data,"RTP");
 text(25,0.28,['\beta = ' num2str(mdl.Coefficients{1,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{1,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{1,1}),'%3.2f') ],'Color',MAGENTA);
 text(25,0.24, ['\beta = ' num2str(mdl.Coefficients{2,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{2,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{2,1}),'%3.2f') ],'Color',CYAN   );
 text(25,0.2,['\beta = ' num2str(mdl.Coefficients{3,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{3,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{3,1}),'%3.2f') ],'Color',ORANGE );
 text(25,0.16,['\beta = ' num2str(mdl.Coefficients{4,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{4,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{4,1}),'%3.2f') ],'Color',GREEN);
 text(25,0.12, ['\beta = ' num2str(mdl.Coefficients{5,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{5,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{5,1}),'%3.2f') ],'Color',RED   );
 %text(18,0.08,['\beta = ' num2str(mdl.Coefficients{6,1},'%3.3f') ' \itp\rm = ' num2str(mdl.Coefficients{6,4},'%3.2f') ' HR = ' num2str(exp(mdl.Coefficients{6,1}),'%3.2f') ],'Color',BLUE );

 hold on

 text (95,-.15,'Rooks et al Suppl Fig 3');

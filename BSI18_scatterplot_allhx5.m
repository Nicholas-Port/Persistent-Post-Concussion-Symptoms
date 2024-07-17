

female = find(T4.sex==1);
male   = find(T4.sex==2);
 
mh_pos = find(T4.anx_hx == 1 | T4.dep_hx ==1);
mh_neg = find(T4.anx_hx == 0 & T4.dep_hx ==0);

b_total   = T4.b_anx + T4.b_dep + T4.b_soma;

lad_pos = find(T4.ld == 1 | T4.add == 1);
lad_neg = find(T4.ld == 0 & T4.add ==0 );

con_pos = find(T4.prev_concuss >= 3);
con_neg = find(T4.prev_concuss <  3);

mig_pos = find(T4.migraine == 1);
mig_neg = find(T4.migraine == 0);

loc_pos = find(T4.LOC == 1);
loc_neg = find(T4.LOC == 0);

delay_pos = find(T4.daysreportedlate == 1);
delay_neg = find(T4.daysreportedlate == 0);

% Make a group negative
all_pos = [mh_pos'  lad_pos'  con_pos' mig_pos' loc_pos' delay_pos' female'];
all_neg = [mh_neg'  lad_neg'  con_neg' mig_neg' loc_neg' delay_neg' male'];
all_pos2 = unique(all_pos);
all_neg2 = unique(all_neg);


BSI18all = b_total;
RTPall   = T4.time_t_RTP;

BSI18pos =  b_total(   all_pos2  );
BSI18neg =  b_total(   all_neg2  );
RTPpos   = T4.time_t_RTP(all_pos2);
RTPneg   = T4.time_t_RTP(all_neg2);

BSI18poslad =  b_total(      lad_pos );
BSI18neglad =  b_total(      lad_neg );
RTPposlad   = T4.time_t_RTP( lad_pos );
RTPneglad   = T4.time_t_RTP( lad_neg );

BSI18posmh   =  b_total(      mh_pos );
BSI18negmh   =  b_total(      mh_neg );
RTPposmh     = T4.time_t_RTP( mh_pos );
RTPnegmh     = T4.time_t_RTP( mh_neg );

BSI18poscon =  b_total(       con_pos );
BSI18negcon =  b_total(       con_neg );
RTPposcon   =  T4.time_t_RTP( con_pos );
RTPnegcon   =  T4.time_t_RTP( con_neg );

BSI18posmig =  b_total(       mig_pos );
BSI18negmig =  b_total(       mig_neg );
RTPposmig   =  T4.time_t_RTP( mig_pos );
RTPnegmig   =  T4.time_t_RTP( mig_neg );

BSI18posdelay =  b_total(       delay_pos );
BSI18negdelay =  b_total(       delay_neg );
RTPposdelay   =  T4.time_t_RTP( delay_pos );
RTPnegdelay   =  T4.time_t_RTP( delay_neg );

BSI18posloc =  b_total(       loc_pos );
BSI18negloc =  b_total(       loc_neg );
RTPposloc   =  T4.time_t_RTP( loc_pos );
RTPnegloc   =  T4.time_t_RTP( loc_neg );

BSI18female =  b_total(     female  );
BSI18male   =  b_total(     male    );
RTPfemale   =  T4.time_t_RTP(female );
RTPmale     =  T4.time_t_RTP( male  );


ldhx    = [[ T4.ld] + [T4.add] ];
prevcon = T4.prev_concuss;

hf = figure;
nlp_fig_prep(hf, 'Portrait');

ha = axes;
nlp_axes_prep(ha);
hold on
set(gca,'Position',[.75 7.5 3 3]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12             );
set(gca,'xlim',      [-4 200]      );
set(gca,'ylim',      [-2 60]       );
%set(gca,'xscale','log');
%set(gca,'yscale','log');

hs2 = scatter(RTPneg,    BSI18neg    );

set(hs2,'CData',[0   0  1],'MarkerEdgeAlpha',0.3   );


xlabel({'Time to RTP','(in days/-HX)'});
ylabel('BSI Total Score');

x2=RTPnegmh(    ~isnan(RTPnegmh) & ~isnan(BSI18negmh) );
y2=BSI18negmh(  ~isnan(RTPnegmh) & ~isnan(BSI18negmh) );

x4=RTPneglad(    ~isnan(RTPneglad) & ~isnan(BSI18neglad) );
y4=BSI18neglad(  ~isnan(RTPneglad) & ~isnan(BSI18neglad) );

x6=RTPnegcon(   ~isnan(RTPnegcon) & ~isnan(BSI18negcon) );
y6=BSI18negcon( ~isnan(RTPnegcon) & ~isnan(BSI18negcon) );

x8=RTPnegmig(   ~isnan(RTPnegmig) & ~isnan(BSI18negmig) );
y8=BSI18negmig( ~isnan(RTPnegmig) & ~isnan(BSI18negmig) );

x10=RTPnegloc(   ~isnan(RTPnegloc) & ~isnan(BSI18negloc) );
y10=BSI18negloc( ~isnan(RTPnegloc) & ~isnan(BSI18negloc) );

x12=RTPnegdelay(   ~isnan(RTPnegdelay) & ~isnan(BSI18negdelay) );
y12=BSI18negdelay( ~isnan(RTPnegdelay) & ~isnan(BSI18negdelay) );

%x14=RTPmale(   ~isnan(RTPmale) & ~isnan(BSI18male) );
%y14=BSI18male( ~isnan(RTPmale) & ~isnan(BSI18male) );

[r2,  p2] =corr( log10(x2+1),  log10(y2+1)  );
[r4,  p4] =corr( log10(x4+1),  log10(y4+1)  );
[r6,  p6] =corr( log10(x6+1),  log10(y6+1)  );
[r8,  p8] =corr( log10(x8+1),  log10(y8+1)  );
[r10, p10]=corr( log10(x10+1), log10(y10+1) );
[r12, p12]=corr( log10(x12+1), log10(y12+1) );
%[r14, p14]=corr( log10(x14+1), log10(y14+1) );

text(60,20, ['-mhHx  ' num2str(length(x2))  '  r=' num2str(r2, '%3.2f')  ' p=' num2str(p2,'%4.3f') ], 'FontName', 'Courier' );
text(60,17, ['-ladHx ' num2str(length(x4))  '  r=' num2str(r4, '%3.2f')  ' p=' num2str(p4,'%4.3f') ], 'FontName', 'Courier' );
text(60,14, ['-conHx ' num2str(length(x6))  '  r=' num2str(r6, '%3.2f')  ' p=' num2str(p6,'%4.3f') ], 'FontName', 'Courier' );
text(60,11, ['-migHx ' num2str(length(x8))  '  r=' num2str(r8, '%3.2f')  ' p=' num2str(p8,'%4.3f') ], 'FontName', 'Courier' );
text(60,8,  ['-loc   ' num2str(length(x10)) '  r=' num2str(r10,'%3.2f')  ' p=' num2str(p10,'%4.3f')], 'FontName', 'Courier' );
text(60,5,  ['-delay ' num2str(length(x12)) '  r=' num2str(r12,'%3.2f')  ' p=' num2str(p12,'%4.3f')], 'FontName', 'Courier' );
%text(60,2,  ['male   ' num2str(length(x14)) '  r=' num2str(r14,'%3.2f')  ' p=' num2str(p14,'%4.3f')], 'FontName', 'Courier' );

hold on

ha = axes;
nlp_axes_prep(ha);
hold on
set(gca,'Position',[2.15 9 1.5 1.5]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',      [-1 50]     );
set(gca,'ylim',      [-1 20]     );
%set(gca,'xscale','log');
%set(gca,'yscale','log');

hs2=scatter(RTPneg, BSI18neg   );


set(hs2,'CData',[0 0 1],'MarkerEdgeAlpha',0.3   );


ha = axes;
nlp_axes_prep(ha);
hold on
set(gca,'Position',[.75 3.5 3 3]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12             );
set(gca,'xlim',      [-4 200]      );
set(gca,'ylim',      [-2 60]       );
%set(gca,'xscale','log');
%set(gca,'yscale','log');

hs3 = scatter(RTPposmh, BSI18posmh   );
hs4 = scatter(RTPposlad, BSI18poslad );
hs5 = scatter(RTPposcon, BSI18poscon );
hs6 = scatter(RTPposmig, BSI18posmig );
hs7 = scatter(RTPposloc, BSI18posloc );
hs8 = scatter(RTPposdelay, BSI18posdelay );
%hs9 = scatter(RTPfemale, BSI18female );


set(hs3,'CData',[1   0  0], 'MarkerEdgeAlpha',0.6 );
set(hs4,'CData',[.0 .95 0], 'MarkerEdgeAlpha',0.6 );
set(hs5,'CData',[.25 .5  0],'MarkerEdgeAlpha',0.6 );
set(hs6,'CData',[.75 1  .5],'MarkerEdgeAlpha',0.6 );
set(hs7,'CData',[0 0 .75],  'MarkerEdgeAlpha',0.6 );
set(hs8,'CData',[0 .5 1],  'MarkerEdgeAlpha',0.6   );
%set(hs9,'CData',[.5 0 .75],  'MarkerEdgeAlpha',0.6);


xlabel({'Time to RTP','(in days/+HX)'});
ylabel('BSI Total Score');

x1=RTPposmh(  ~isnan(RTPposmh) & ~isnan(BSI18posmh) );
y1=BSI18posmh(~isnan(RTPposmh) & ~isnan(BSI18posmh) );

x3=RTPposlad(  ~isnan(RTPposlad) & ~isnan(BSI18poslad) );
y3=BSI18poslad(~isnan(RTPposlad) & ~isnan(BSI18poslad) );

x5=RTPposcon(  ~isnan(RTPposcon) & ~isnan(BSI18poscon) );
y5=BSI18poscon(~isnan(RTPposcon) & ~isnan(BSI18poscon) );

x7=RTPposmig(  ~isnan(RTPposmig) & ~isnan(BSI18posmig) );
y7=BSI18posmig(~isnan(RTPposmig) & ~isnan(BSI18posmig) );

x9=RTPposloc(  ~isnan(RTPposloc) & ~isnan(BSI18posloc) );
y9=BSI18posloc(~isnan(RTPposloc) & ~isnan(BSI18posloc) );

x11=RTPposdelay(  ~isnan(RTPposdelay) & ~isnan(BSI18posdelay) );
y11=BSI18posdelay(~isnan(RTPposdelay) & ~isnan(BSI18posdelay) );

%x13=RTPfemale(  ~isnan(RTPfemale) & ~isnan(BSI18female) );
%y13=BSI18male(~isnan(RTPfemale) & ~isnan(BSI18female) );

[r1, p1]=corr(x1,y1  );
[r3, p3]=corr(x3,y3  );
[r5, p5]=corr(x5,y5  );
[r7, p7]=corr(x7,y7  );
[r9, p9]=corr(x9,y9  );
[r11, p11]=corr(x9,y9);
[r13, p13]=corr(x9,y9);

[r1, p1]=corr( log10(x1+1), log10(y1+1)  );
[r3, p3]=corr( log10(x3+1), log10(y3+1)  );
[r5, p5]=corr( log10(x5+1), log10(y5+1)  );
[r7, p7]=corr( log10(x7+1), log10(y7+1)  );
[r9, p9]=corr( log10(x9+1), log10(y9+1)  );
[r11, p11]=corr(log10(x11+1),log10(y11+1));
%[r13, p13]=corr(log10(x13+1),log10(y13+1));


text(60,20,['+mhHx  ' num2str(length(x1))  ' r= ' num2str(r1,'%3.2f')  ' p=' num2str(p1,'%4.2f') ],  'FontName', 'Courier' );
text(60,17,['+ladHx ' num2str(length(x3))  ' r= ' num2str(r3,'%3.2f')  ' p=' num2str(p3,'%4.2f') ],  'FontName', 'Courier' );
text(60,14,['+conHx ' num2str(length(x5))  ' r= ' num2str(r5,'%3.2f')  ' p=' num2str(p5,'%4.2f') ],  'FontName', 'Courier' );
text(60,11,['+migHx ' num2str(length(x7))  ' r='  num2str(r7,'%3.2f')  ' p=' num2str(p7,'%4.2f') ],  'FontName', 'Courier' );
text(60,8, ['+loc   ' num2str(length(x9))  ' r= ' num2str(r9,'%3.2f')  ' p=' num2str(p9,'%4.2f') ],  'FontName', 'Courier' );
text(60,5, ['+delay ' num2str(length(x11)) ' r= ' num2str(r11,'%3.2f') ' p=' num2str(p11,'%4.2f') ], 'FontName', 'Courier' );
%text(60,2, ['female   ' num2str(length(x13)) ' r=' num2str(r13,'%3.2f') ' p=' num2str(p13,'%4.2f') ], 'FontName', 'Courier' );


ha = axes;
nlp_axes_prep(ha);
hold on
set(gca,'Position',[2.15 5 1.5 1.5]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',      [-1 50]     );
set(gca,'ylim',      [-1 20]     );
%set(gca,'xscale','log');
%set(gca,'yscale','log');

hs3=scatter(RTPposmh,  BSI18posmh );
hs4=scatter(RTPposlad, BSI18poslad);
hs5=scatter(RTPposcon, BSI18poscon);
hs6=scatter(RTPposmig, BSI18posmig);
hs7=scatter(RTPposloc, BSI18posloc);
hs8=scatter(RTPposdelay,BSI18posdelay);
%hs9=scatter(RTPfemale, BSI18female);


set(hs3,'CData',[1   0  0], 'MarkerEdgeAlpha',0.6 );
set(hs4,'CData',[.0 .95 0], 'MarkerEdgeAlpha',0.6 );
set(hs5,'CData',[.25 .5  0],'MarkerEdgeAlpha',0.6 );
set(hs6,'CData',[.75 1  .5],'MarkerEdgeAlpha',0.6 );
set(hs7,'CData',[0 0 .75],  'MarkerEdgeAlpha',0.6 );
set(hs8,'CData',[0 .5 1],  'MarkerEdgeAlpha',0.6   );
%set(hs9,'CData',[.5 0 .75],  'MarkerEdgeAlpha',0.6);



clear x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14y1 y2 y3 y4 y5 y6 y7 y8 y9 y10 y11 y12 y13 y14
clear r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 p1  p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14
clear mh_neg mh_pos con_neg con_pos lad_neg lad_pos male female mig_pos mig_neg loc_pos loc_neg delay_neg delay_pos female male
clear b_total ldhx prevcon all_pos all_pos2 all_neg all_neg2
clear RTPpos RTPneg SCATpos SCATneg RTPposlad RTPneglad RTPposcon RTPnegcon RTPposmig RTPnegmig RTPposloc RTPnegloc RTPfemale RTPmale RTPposdelay RTPnegdelay





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Now do the SCAT analysis
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

female = find(T4S.sex==1);
male   = find(T4S.sex==2);
 
mh_pos = find(T4S.anx_hx == 1 | T4S.dep_hx ==1);
mh_neg = find(T4S.anx_hx == 0 & T4S.dep_hx ==0);
  
scat_anxdep   = T4S.scatsxsev_score(mh_pos);
scat_noanxdep = T4S.scatsxsev_score(mh_neg);


%b_total   = T4.b_anx + T4.b_dep + T4.b_soma;
scattotal = T4S.scatsxsev_score;

lad_pos = find(T4S.ld == 1 | T4S.add == 1);
lad_neg = find(T4S.ld == 0 & T4S.add ==0 );

con_pos = find(T4S.prev_concuss >= 3);
con_neg = find(T4S.prev_concuss <  3);

mig_pos = find(T4S.migraine == 1);
mig_neg = find(T4S.migraine == 0);

loc_pos = find(T4S.LOC == 1);
loc_neg = find(T4S.LOC == 0);

delay_pos = find(T4S.daysreportedlate == 1);
delay_neg = find(T4S.daysreportedlate == 0);


% Make a group negative
all_pos = [mh_pos'  lad_pos'  con_pos' mig_pos' loc_pos' delay_pos' female'];
all_neg = [mh_neg'  lad_neg'  con_neg' mig_neg' loc_neg' delay_neg' male'];
all_pos2 = unique(all_pos);
all_neg2 = unique(all_neg);


%BSI18all = b_total;
RTPall   = T4S.time_t_RTP;
SCATall = scattotal;

%BSI18poslad =  b_total(      lad_pos );
%BSI18neglad =  b_total(      lad_neg );
RTPposlad   = T4S.time_t_RTP( lad_pos );
RTPneglad   = T4S.time_t_RTP( lad_neg );

%BSI18pos   =  b_total(      anxdep_pos );
%BSI18neg   =  b_total(      anxdep_neg );
RTPpos     = T4S.time_t_RTP( all_pos2 );
RTPneg     = T4S.time_t_RTP( all_neg2 );

RTPposmh     = T4S.time_t_RTP( mh_pos );
RTPnegmh     = T4S.time_t_RTP( mh_neg );

RTPposmig   =  T4S.time_t_RTP( mig_pos );
RTPnegmig   =  T4S.time_t_RTP( mig_neg );

RTPposloc   =  T4S.time_t_RTP( loc_pos );
RTPnegloc   =  T4S.time_t_RTP( loc_neg );

RTPposdelay   =  T4S.time_t_RTP( delay_pos );
RTPnegdelay   =  T4S.time_t_RTP( delay_neg );

RTPfemale =  T4S.time_t_RTP( female );
RTPmale   =  T4S.time_t_RTP( male   );


%BSI18poscon =  b_total(       con_pos );
%BSI18negcon =  b_total(       con_neg );



RTPposcon   =  T4S.time_t_RTP( con_pos );
RTPnegcon   =  T4S.time_t_RTP( con_neg );

SCATposcon =  scattotal(       con_pos );
SCATnegcon =  scattotal(       con_neg );

SCATposlad =  scattotal(       lad_pos );
SCATneglad =  scattotal(       lad_neg );

SCATposmig =  scattotal(       mig_pos );
SCATnegmig =  scattotal(       mig_neg );

SCATposdelay =  scattotal(       delay_pos );
SCATnegdelay =  scattotal(       delay_neg );

SCATfemale =  scattotal(       female );
SCATmale   =  scattotal(       male   );

SCATposloc =  scattotal(       loc_pos );
SCATnegloc =  scattotal(       loc_neg );

SCATposmh =  scattotal(       mh_pos );
SCATnegmh =  scattotal(       mh_neg );

SCATneg = scattotal( all_neg2 );
SCATpos = scattotal( all_pos2 );





ha = axes;
nlp_axes_prep(ha);
hold on
set(gca,'Position',[4.9 7.5 3 3] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',      [-5 500]    );
%set(gca,'ylim',      [-2 50]    );
%set(gca,'xscale','log');
%set(gca,'yscale','log');

hs2=scatter(RTPneg, SCATneg   );


set(hs2,'CData',[0 0 1],'MarkerEdgeAlpha',0.3   );

x2=RTPnegmh(  ~isnan(RTPnegmh) & ~isnan(SCATnegmh) );
y2=SCATnegmh( ~isnan(RTPnegmh) & ~isnan(SCATnegmh) );

x4=RTPneglad(  ~isnan(RTPneglad) & ~isnan(SCATneglad) );
y4=SCATneglad( ~isnan(RTPneglad) & ~isnan(SCATneglad) );

x6=RTPnegcon(   ~isnan(RTPnegcon) & ~isnan(SCATnegcon) );
y6=SCATnegcon(  ~isnan(RTPnegcon) & ~isnan(SCATnegcon) );

x8=RTPnegmig(   ~isnan(RTPnegmig) & ~isnan(SCATnegmig) );
y8=SCATnegmig(  ~isnan(RTPnegmig) & ~isnan(SCATnegmig) );

x10=RTPnegloc(   ~isnan(RTPnegloc) & ~isnan(SCATnegloc) );
y10=SCATnegloc(  ~isnan(RTPnegloc) & ~isnan(SCATnegloc) );

x12=RTPnegdelay(   ~isnan(RTPnegdelay) & ~isnan(SCATnegdelay) );
y12=SCATnegdelay(  ~isnan(RTPnegdelay) & ~isnan(SCATnegdelay) );

%x14=RTPmale(   ~isnan(RTPmale) & ~isnan(SCATmale) );
%y14=SCATmale( ~isnan(RTPmale) & ~isnan(SCATmale) );

[r2,  p2] =corr(x2, y2 );
[r4,  p4] =corr(x4, y4 );
[r6,  p6] =corr(x6, y6 );
[r8,  p8] =corr(x8, y8 );
[r10, p10]=corr(x10,y10);
[r12, p12]=corr(x12,y12);
%[r14, p14]=corr(x14,y14);


 text(150,40,['-mhHx  ' num2str(length(x2))  ' r=' p_n_str(r2)   ' p=',num2str(p2, '%4.3f') ], 'FontName', 'Courier' );
 text(150,35,['-ladHx ' num2str(length(x4))  ' r=' p_n_str(r4)   ' p=',num2str(p4, '%4.3f') ], 'FontName', 'Courier' );
 text(150,30,['-conHx ' num2str(length(x6))  ' r=' p_n_str(r6)   ' p=',num2str(p6, '%4.3f') ], 'FontName', 'Courier' );
 text(150,25,['-migHx ' num2str(length(x8))  ' r=' p_n_str(r8)   ' p=',num2str(p8, '%4.3f') ], 'FontName', 'Courier' );
 text(150,20,['-loc   ' num2str(length(x10)) ' r=' p_n_str(r10)  ' p=',num2str(p10,'%4.3f') ], 'FontName', 'Courier' );
 text(150,15,['-delay ' num2str(length(x12)) ' r=' p_n_str(r12)  ' p=' num2str(p12,'%4.3f')], 'FontName', 'Courier' );
%text(150,10,['male   ' num2str(length(x14)) '  r=' p_n_str(r14)  ' p=' num2str(p14,'%4.3f')], 'FontName', 'Courier' );

 xlabel({'Time to RTP','(in days/-HX)'});
 ylabel('SCAT Total Score');


 ha = axes;
 nlp_axes_prep(ha);
 hold on
 set(gca,'Position',[6.2 9 1.5 1.5]   ); % gca = graphical current axes % left bottom width height
 set(gca,'FontSize', 12               );
 set(gca,'xlim',      [-5 50]      );
 set(gca,'ylim',      [-2 40]      );
 
 hs2=scatter(RTPneg, SCATneg   );


set(hs2,'CData',[0 0 1],'MarkerEdgeAlpha',0.3   );

ha = axes;
nlp_axes_prep(ha);
hold on
set(gca,'Position',[4.9 3.5 3 3] ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12           );
set(gca,'xlim',      [-5 500]  );
%set(gca,'ylim',      [-2 50]    );
%set(gca,'xscale','log');
%set(gca,'yscale','log');

hs3=scatter(RTPposmh, SCATposmh   );
hs4=scatter(RTPposlad, SCATposlad);
hs5=scatter(RTPposcon, SCATposcon);
hs6=scatter(RTPposmig, SCATposmig);
hs7=scatter(RTPposloc, SCATposloc);
hs8=scatter(RTPposdelay,SCATposdelay);
%hs9=scatter(RTPfemale, SCATfemale);


set(hs3,'CData',[1 0 0],'MarkerEdgeAlpha',0.6   );
set(hs4,'CData',[.0 .95 0],'MarkerEdgeAlpha',0.6);
set(hs5,'CData',[.25 .5 0],'MarkerEdgeAlpha',0.6 );
set(hs6,'CData',[.75 1 .5],'MarkerEdgeAlpha',0.6 );
set(hs7,'CData',[0 0 .75],'MarkerEdgeAlpha',0.6 );
set(hs8,'CData',[0 .5 1],'MarkerEdgeAlpha',0.6 );
%set(hs9,'CData',[0 0 .75],'MarkerEdgeAlpha',0.6 );


x1=RTPposmh(  ~isnan(RTPposmh) & ~isnan(SCATposmh) );
y1=SCATposmh( ~isnan(RTPposmh) & ~isnan(SCATposmh) );

x3=RTPposlad(  ~isnan(RTPposlad) & ~isnan(SCATposlad) );
y3=SCATposlad( ~isnan(RTPposlad) & ~isnan(SCATposlad) );

x5=RTPposcon(  ~isnan(RTPposcon) & ~isnan(SCATposcon) );
y5=SCATposcon( ~isnan(RTPposcon) & ~isnan(SCATposcon) );

x7=RTPposmig(  ~isnan(RTPposmig) & ~isnan(SCATposmig) );
y7=SCATposmig( ~isnan(RTPposmig) & ~isnan(SCATposmig) );

x9=RTPposloc(  ~isnan(RTPposloc) & ~isnan(SCATposloc) );
y9=SCATposloc( ~isnan(RTPposloc) & ~isnan(SCATposloc) );

x11=RTPposdelay(  ~isnan(RTPposdelay) & ~isnan(SCATposdelay) );
y11=SCATposdelay(~isnan(RTPposdelay) & ~isnan(SCATposdelay) );

%x13=RTPfemale(  ~isnan(RTPfemale) & ~isnan(SCATfemale) );
%y13=SCATmale(~isnan(RTPfemale) & ~isnan(SCATfemale) );


[r1, p1]=corr(x1,y1);
[r3, p3]=corr(x3,y3);
[r5, p5]=corr(x5,y5);
[r7, p7]=corr(x7,y7);
[r9, p9]=corr(x9,y9);
[r11, p11]=corr(x11,y11);
%[r13, p13]=corr(x13,y13);

text(150,40,['+mhHx  ' num2str(length(x1)) ' r=' p_n_str(r1) ' p=',num2str(p1,'%4.3f') ], 'FontName', 'Courier' );
%text(150,40,['+mhHx  r=' p_n_str(r1) ' p=',num2str(p1,'%4.3f') ], 'FontName', 'Courier' );
text(150,35,['+ladHx ' num2str(length(x3)) ' r=' p_n_str(r3) ' p=',num2str(p3,'%4.3f') ], 'FontName', 'Courier' );
text(150,30,['+conHx ' num2str(length(x5)) ' r=' p_n_str(r5) ' p=',num2str(p5,'%4.3f') ], 'FontName', 'Courier' );
text(150,25,['+migHx ' num2str(length(x7)) ' r=' p_n_str(r7) ' p=',num2str(p7,'%4.3f') ], 'FontName', 'Courier' );
text(150,20,['+loc   ' num2str(length(x9)) ' r=' p_n_str(r9) ' p=',num2str(p9,'%4.3f') ], 'FontName', 'Courier' );
text(150,15,['+delay ' num2str(length(x11)) ' r=' p_n_str(r11) ' p=',num2str(p11,'%4.3f') ], 'FontName', 'Courier' );
%text(150,10,['female   ' num2str(length(x13)) ' r=' p_n_str(r13) ' p=',num2str(p13,'%4.3f') ], 'FontName', 'Courier' );

xlabel({'Time to RTP','(in days/+HX)'});
ylabel('SCAT Total Score');
 
 


 
hold on

ha = axes;
nlp_axes_prep(ha);
hold on
set(gca,'Position',[6.2 5 1.5 1.5]   ); % gca = graphical current axes % left bottom width height
set(gca,'FontSize', 12               );
set(gca,'xlim',      [-5 50]      );
set(gca,'ylim',      [-2 40]      );

hs3=scatter(RTPposmh, SCATposmh  );
hs4=scatter(RTPposlad, SCATposlad);
hs5=scatter(RTPposcon, SCATposcon);
hs6=scatter(RTPposmig, SCATposmig);
hs7=scatter(RTPposloc, SCATposloc);
hs8=scatter(RTPposdelay, SCATposdelay);
%hs9=scatter(RTPfemale, SCATfemale);



set(hs3,'CData',[1 0 0],   'MarkerEdgeAlpha',0.6 );
set(hs4,'CData',[.0 .95 0],'MarkerEdgeAlpha',0.6 );
set(hs5,'CData',[.25 .5 0],'MarkerEdgeAlpha',0.6 );
set(hs6,'CData',[.75 1 .5],'MarkerEdgeAlpha',0.6 );
set(hs7,'CData',[0 0 .75], 'MarkerEdgeAlpha',0.6 );
set(hs8,'CData',[0 .5 1],  'MarkerEdgeAlpha',0.6   );
%set(hs9,'CData',[.5 0 .75], 'MarkerEdgeAlpha',0.6);
% 

text (-10,-80,'Rooks et al. Suppl. Fig. 5')















% fini

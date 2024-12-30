 function h = nlp_hist_stair (x,s1,s2,sn) %This plot my favorite kind of histogram in the current graphical axis
 % x is the data set
 % s1 is the first bin
 % s2 is the last bin
 % sn is the increments between bins
 
 
 
bins = s1:sn:s2;
y    = histc(x,bins);
h    = stairs(bins,y);
%keyboard;

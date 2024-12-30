function [noyes, yesyes, nono, yesno] = make_2_by_2(x,y) %,PCS,K)

% Make a 2 by 2 table of yes's and no's
noyes  = length(find(x==1 & y == 0));
yesyes = length(find(x==1 & y == 1));
nono   = length(find(x==0 & y == 0));
yesno  = length(find(x==0 & y == 1));



%keyboard


end



% Old non-matab way  %PCS was 1 and K was 1
% noyes  = 0;
% yesyes = 0;
% nono   = 0;
% yesno  = 0;
% 
% for i = 1:size(y,1)
%     if y(i) == 0 & x(i) == K
%         noyes = noyes +1;
%     elseif y(i) == PCS & x(i) == K
%         yesyes = yesyes+1;
%     elseif y(i) == 0 & x(i) == 0
%         nono = nono +1;
%     elseif y(i) == PCS & x(i) == 0
%         yesno = yesno+1;
%     end
% end
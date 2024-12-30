function y = sport_lookup( x_str )
% Translate between sport name and sport_number

%   Detailed explanation goes here

switch x_str
   
   case { 'UF' }
      y = 1;
   case { 'UGA' }
      y = 2;
   case { 'UCLA' }
      y = 3;
   case { 'UMICH' }
      y = 4;
   case { 'UNC' }
      y = 5;
   case { 'OU' }
      y = 6;
   case { 'PITT' }
      y = 7;
   % - Same sport below
   case { 'PRIN' }
      y = 8;
   case { 'WASH' }
      y = 9;
   case { 'WISC' }
      y = 10;
   case { 'USCGA' }
      y = 11;
      
   case { 'USAFA' }
      y = 12;
   case { 'USMA' }
      y = 13;
   case { 'VT' }
      y = 14;
   case {'CLU'}   
      y = 15;
   case {'HSU'}   
      y = 16;
   case {'UR'}   
      y = 17;
   case {'AU'}   
      y = 18;
   case {'UD'}   
      y = 19;
   case {'IUB'}   
      y = 20;
   case {'BUP'}   
      y = 21;
   case {'UofC'}   
      y = 22;
   case {'UM'}   
      y = 23;
   case {'UNG'}   
      y = 24;
   case {'UPENN'}   
      y = 25;
   case {'TEMPLE'}   
      y = 26;
   case {'WFU'}
      y = 27;
   case {'WC'}
      y = 28;
   case {'WSSU'}
      y = 29;
   case {'UNL'}
      y = 30;
   case {'APU'}
      y = 31;
   case {'NAVY'}
      y = 32;

      
      
   otherwise  
      x_str
      keyboard
      
      
      
      
end %switch



end


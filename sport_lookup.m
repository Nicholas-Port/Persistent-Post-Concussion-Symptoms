function y = sport_lookup( x_str )
% Translate between sport name and sport_number

%   Detailed explanation goes here

switch x_str
   
   case { 'Football' }
      y = 1;
   case { 'Swimming' }
      y = 2;
   case { 'Baseball' }
      y = 3;
   case { 'Volleyball' }
      y = 4;
   case { 'Diving' }
      y = 5;
   case { 'Golf' }
      y = 6;
   case { 'Tennis' }
      y = 7;
   % - Same sport below
   case { 'Cross Country / Track' }
      y = 8;
   case { 'Field Event' }
      y = 8;
   case { 'Track and Field' }
      y = 8;
   %   
   case { 'Softball' }
      y = 9;
   case { 'Lacrosse' }
      y = 10;
   case { 'Basketball' }
      y = 11;
   case { 'Soccer' }
      y = 12;
   case { 'Gymnastics' }
      y = 13;
   case {'Rowing/Crew'}   
      y = 14;
   case {'Water Polo'}   
      y = 15;
   case {'Ice Hockey'}   
      y = 16;
   case {'Field Hockey'}   
      y = 17;
   case {'Beach Volleyball'}   
      y = 18;
   case {'Wrestling'}   
      y = 19;
   case {'Cheerleading'}   
      y = 20;
   case {'Rifle'}   
      y = 21;
   case {'Bowling'}   
      y = 22;
   case {'Fencing'}   
      y = 23;
   case {'Sailing'}   
      y = 24;
   case {'Rugby'}   
      y = 25;
   case {'Boxing'}
      y = 26;
   case {'Sprint Football'}
      y = 27;
   case {''}
      y = 28;
   case {'Squash'}
      y = 29;

      
      
   otherwise  
      x_str
      keyboard
      
      
      
      
end %switch



end


function new_str = p_n_str(r)
% This little function converts a number to a string and deals with
% negatives
% 

if r >= 0 
   new_str = [' ' num2str(r,'%4.2f') ];
else
   new_str = num2str(r,'%4.2f');
end



end


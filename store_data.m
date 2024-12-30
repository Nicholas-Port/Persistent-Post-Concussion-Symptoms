function out = store_data(x)
% Convert 'yes', 'no', NAN, etc into a binary output
%

if iscell(x)
   if strcmp( x{1}, 'No')
      out = 0;
   elseif strcmp( x{1}, 'Yes')
      out = 1;
   elseif isempty(x{1})
      out = 0;
   end
elseif isnan(x)
   out = 0;
elseif x == 1
   out = 1;
   keyboard

else
   out = NaN;
   keyboard
end %if





end
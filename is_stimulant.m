function output = is_stimulant(in_str)
% This function search a variable with text and checks to see if it pattern
% matteches a known stimulant
%  

% The drug STRATERA, CLONADINE are used for ADD/ADHD, but it is not considered a
% stimulant, so we are not counting it here.

output = 0;

if contains(in_str,'ADDERALL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADERRALL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADERALL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADDERRAL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADDERAL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADHERRAL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADEROL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADHERALL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADERRAL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADREALL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADIRAL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADORAL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADD','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADHD','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'DEFICITE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'ADERAL','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'RITTALIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'RITALIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'RIDALIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'RIDDLED','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'RIDILLIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'RIDELIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'RIDLIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'RIDILIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'PHENIDATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'PENIDATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'PHENEDATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'PZENIDATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'METHLYDATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'METHYLPHENADATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'METHALPHYMADATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'METADATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'METHALPHENODATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'MEDIDATE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'CONCERTA','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'CONCENA','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'CONSERTA','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'CONCERTIA','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'CONCERTU','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'CONSERDA','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYVANSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYVANCE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VIVANX','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VIVANCE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VIVANSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYVANESE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYVANES','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYANESE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYSAMINE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYNANSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYUANKE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYRANSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYRANSSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VIVACE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYUENSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VVYANSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VAYVANSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYANSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYANCE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'VYRONSE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'AMPHETAMINE','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'FOCALIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'FOCAOLIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'FOCOLIN','IgnoreCase',1)
   output = 1;
elseif contains(in_str,'FOCULIN','IgnoreCase',1)
   output = 1;
end

% switch in_str
% 
%    case {'ADDERALL'}
%       output = 1;
%    case {'ADERALL'}
%       output = 1;
%    case {'RITTALIN'}
%       output = 1;
% 
% end %switch
% 



end
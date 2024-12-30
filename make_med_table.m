

clear med_table

ii = 0;

for i = 1:length(med_list)

   output = is_stimulant(med_list{i});
   if output == 0
      ii = ii + 1;
      med_table(ii,1) = med_list(i,1);
      med_table{ii,2} = output;
      med_table{ii,3} = med_list(i,2);
   end

end
function [ y ] = combine_probability( ang,dis,fea,hap,sad,sur )
%
%COMBINE_RESULTS - combines 6 lists of positive/negative results into one
%                  list of results with appropriate labels 
%
%IN:  ang/dis/fea/hap/sad/sur: 6 results vectors
%OUT: y: list of remapped results

y = zeros(size(ang));
for i = 1:size(y)
    y(i) = pick_label(ang(i),dis(i),fea(i),hap(i),sad(i),sur(i));
end
end

function [ index ] = pick_label( a,b,c,d,e,f )
    output = [a,b,c,d,e,f];
    max = output(1);
    index = 1;
    for j = 2:6
          if output(j) > max
             max = output(j);
             index = j; 
          end
    end
end



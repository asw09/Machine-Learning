function [ new_case ] = CBR_get_case( au_vector,label )
% CBR_GET_CASE - returns a new CBR case given a vector of AUs and the
%                matching label

    vector = [];
    for i = 1:length(au_vector)
       if au_vector(i)
          vector = vertcat(vector,i); 
       end
    end
    
    new_case.active_aus = vector;
    new_case.label = label;

end


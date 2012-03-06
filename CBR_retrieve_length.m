function [ similar_case ] = CBR_retrieve_length( trained_cbr,new_case )
% CBR_RETRIEVE_LENGTH - retrieves a case from a trained CBR system by
%                       comparing the length of the new case and the length
%                       of cases from the CBR system

    new_size = length(new_case.active_aus(:));
    best_diff = 999;
    for i = 1:size(trained_cbr,1)
        current_size = length(trained_cbr{i}.active_aus(:));
        diff = abs(new_size - current_size);
        if diff < best_diff
           best_diff = diff;
           best_case = i;
        end
    end
    similar_case = trained_cbr{best_case};    

end
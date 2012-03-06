function [ similar_case ] = CBR_retrieve_match_pc( trained_cbr,new_case )
% CBR_RETRIEVE_matches - retrieves a case from a trained CBR system by
%                        comparing the number of matching active AUs there
%                        are in cases from the CBR system, using total
%                        percentage of matches to break ties

    new_aus = new_case.active_aus(:);
    best_matches = 0;
    best_percent = 0;
    for i = 1:size(trained_cbr,1)
        current_aus = trained_cbr{i}.active_aus(:);
        matches = size(find(ismember(current_aus,new_aus)),1);
        percentage = matches / size(current_aus,1);
        if (matches > best_matches ...
           || ((matches == best_matches) && percentage > best_percent))
           best_matches = matches;
           best_percent = percentage;
           best_case = i;
        end
    end
    similar_case = trained_cbr{best_case};  

end


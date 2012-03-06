function [ similar_case,best_matches,best_percent ] = ...
    CBR_retrieve_match_pc( trained_cbr,new_case )
% CBR_RETRIEVE_match_pc - retrieves a case from a trained CBR system by
%                         comparing the number of matching active AUs there
%                         are in cases from the CBR system, using total
%                         percentage of matches to break ties

    new_aus = new_case.active_aus(:);
    best_matches = 0;
    best_percent = 0;
    for i = 1:size(trained_cbr,1)
        current_aus = trained_cbr{i}.active_aus(:);
        matches = size(find(ismember(current_aus,new_aus)),1);
        pc = matches / size(current_aus,1);
        pc2 = matches / size(new_aus,1);
        percentage = (pc + pc2) / 2;
        if (percentage > best_percent)
           best_matches = pc;
           best_percent = percentage;
           best_case = i;
           % Skip to the end if percentage cannot be beaten
           if (percentage == 1)
              i = size(trained_cbr,1) + 1;
           end
        end
    end
    if (best_percent < 0.5)
       disp('Guessing')
       similar_case.label = 5;
       similar_case.active_aus = new_case.active_aus;
    else
       similar_case = trained_cbr{best_case};
    end

end


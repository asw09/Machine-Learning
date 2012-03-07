function [ best_case,best_percent ] = ...
    CBR_retrieve_from_branch( trained_cbr_branch,new_case )
% CBR_RETRIEVE_FROM_BRANCH - retrieves a case from a branch of a 
%                            trained CBR system

    new_aus = new_case.active_aus(:);
    best_percent = 0;
    best_case = 1;
    for i = 1:size(trained_cbr_branch,1)
        current_aus = trained_cbr_branch(i).active_aus(:);
        matches = size(find(ismember(current_aus,new_aus)),1);
        pc = matches / size(current_aus,1);
        pc2 = matches / size(new_aus,1);
        percentage = (pc + pc2) / 2;
        if (percentage > best_percent)
           best_percent = percentage;
           best_case = i;
           % Skip to the end if percentage cannot be beaten
           if (percentage == 1)
              return
           end
        end
    end

end
function [ k_neighbours ] = ...
    CBR_retrieve_from_branch( trained_cbr_branch,new_case,k_neighbours )
% CBR_RETRIEVE_FROM_BRANCH - retrieves a case from a branch of a 
%                            trained CBR system - works exactly like the
%                            code in CBR_retrieve_match_pc

    new_aus = new_case.active_aus(:);
    best_percent = 0;
    for i = 1:size(trained_cbr_branch,1)
        current_aus = trained_cbr_branch(i).active_aus(:);
        matches = size(find(ismember(current_aus,new_aus)),1);
        pc = matches / size(current_aus,1);
        pc2 = matches / size(new_aus,1);
        percentage = (pc + pc2) / 2;
        % Sort the list of nearest neighbours
        k_struct = cell2mat(k_neighbours);
        [~,order] = sort([k_struct.percent],'ascend');
            k_neighbours = k_neighbours(order);
        % Add the percentage to the list of K-nearest if it is nearer than
        % the worst nearest neighbour
        if (percentage > k_neighbours{1}.percent)
            k_neighbours{1}.percent = percentage;
            k_neighbours{1}.index = size(current_aus,1);
            k_neighbours{1}.case_num = i;
            k_neighbours{1}.label = trained_cbr_branch(i).label;
        end
        if (percentage > best_percent)
           best_percent = percentage;
           % Skip to the end if percentage cannot be beaten
           if (percentage == 1)
              return
           end
        end
    end

end
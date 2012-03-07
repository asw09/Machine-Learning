function [ similar_case ] = ...
    CBR_retrieve_match_pc( trained_cbr,new_case )
% CBR_RETRIEVE_MATCH_PC - retrieves a case from a trained CBR system by
%                         comparing the number of matching active AUs there
%                         are in cases from the CBR system, using total
%                         percentage of matches to break ties

    % Set up to use k-NN
    k = 5;
    k_neighbours = cell(k,1);
    for i = 1:k
        k_neighbours{i} = struct('percent',0,'index',0, ...
            'case_num',0,'label',0);
    end
    new_aus = new_case.active_aus(:);
    best_percent = 0;
    % Find which branch of the CBR system to use
    index = size(new_aus,1);
    if index > 7
        index = 7;
    end
    % Searc hall cases o the chosen branch
    for i = 1:size(trained_cbr{index},1)
        current_aus = trained_cbr{index}(i).active_aus(:);
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
            k_neighbours{1}.index = index;
            k_neighbours{1}.case_num = i;
            k_neighbours{1}.label = trained_cbr{index}(i).label;
        end
        if (percentage > best_percent)
           best_percent = percentage;
           best_case = i;
           % Skip to the end if percentage cannot be beaten
           if (percentage == 1)
              similar_case = trained_cbr{index}(best_case);
              return
           end
        end
    end
    
    % If no suitably similar cases have been found, try the other branches
    if (best_percent < 0.9)
       for try_index = 1:7
          if try_index == index
              continue
          end
          [k_neighbours] = ...
             CBR_retrieve_from_branch(trained_cbr{try_index},new_case, ...
                                      k_neighbours);
       end
    end
    
    % Find the best label based on nearest neighbours
    label_weights = zeros(6,1);
    for n = 1:6
       for m = 1:k
           current = k_neighbours{m};
           if (current.label == n)
               label_weights(n) = label_weights(n) + ...
                   (current.percent ^ 4) * ...
                   trained_cbr{current.index}(current.case_num).typicality;
           end
       end
    end
    % Find the 'nearest' label
    label = find(label_weights==(max(max(label_weights))));
    % Choose a random label if multiple have the same 'nearness'
    similar_case.label = label(unidrnd(size(label,1)));

end


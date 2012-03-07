function [ similar_case,best_matches,best_percent ] = ...
    CBR_retrieve_match_pc( trained_cbr,new_case )
% CBR_RETRIEVE_match_pc - retrieves a case from a trained CBR system by
%                         comparing the number of matching active AUs there
%                         are in cases from the CBR system, using total
%                         percentage of matches to break ties

    new_aus = new_case.active_aus(:);
    best_matches = 0;
    best_percent = 0;
    index = size(new_aus,1);
    if index > 7
        index = 7;
    end
    best_index = index;
    for i = 1:size(trained_cbr{index},1)
        current_aus = trained_cbr{index}(i).active_aus(:);
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
              similar_case = trained_cbr{index}(best_case);
              return
           end
        end
    end
    if (best_percent < 0.7)
       for try_index = 1:7
          if try_index == index
              continue
          end
          [try_case,try_percent] = ...
              CBR_retrieve_from_branch(trained_cbr{try_index},new_case);
          if (try_percent > best_percent)
             best_index = try_index;
             best_case = try_case;
             best_percent = try_percent;
          end
       end
    end
    similar_case = trained_cbr{best_index}(best_case);

end


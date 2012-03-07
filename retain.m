function [ trained_cbr ] = retain( trained_cbr,solved_case,training )
% RETAIN - adds a solved case to the existing CBR system
%
%IN:  trained_cbr: a CBR system
%     solved_case: the new case to (potentially) add
%     training: is the CBR still recieving training examples?
%OUT: updated_cbr: CBR system containing the new example

    found_same_example = 0;
    index = size(solved_case.active_aus,1);
    if (index > 7)
        index = 7;
    end
    for i = 1:size(trained_cbr{index},1)
        branch = trained_cbr{index};
        current_aus = branch(i).active_aus(:);
        solved_aus = solved_case.active_aus(:); 
        same = 1;
        if ~(size(solved_aus,1) == size(current_aus,1))
           same = 0; 
        else
            for j = 1:size(solved_aus,1)
                if ~(solved_aus(j) == current_aus(j))
                   same = 0; 
                end
            end
        end
        if (same)
            if ~(solved_case.label == branch(i).label) && training
               disp('Mismatch in training - example doubly classified:') 
               disp(solved_case.label)
               disp(trained_cbr{i}.label)
            elseif solved_case.label == branch(i).label ...
                    && isfield(branch(i), 'typicality')
                trained_cbr{index}(i).typicality = branch(i).typicality + 1;
            end
            found_same_example = 1;
        end
    end
    if ~found_same_example
        % Only add the example if it does not match a pre-existing example
        index = size(solved_case.active_aus,1);
        if index > 7
            index = 7;
        end
        trained_cbr{index} = vertcat(trained_cbr{index},solved_case);
    end
end

function [ trained_cbr ] = retain( trained_cbr,solved_case,training )
% RETAIN - adds a solved case to the existing CBR system
%
%IN:  trained_cbr: a CBR system
%     solved_case: the new case to (potentially) add
%     training: is the CBR still recieving training examples?
%OUT: updated_cbr: CBR system containing the new example

    found_same_example = 0;
    % Find which branch to put the case into
    index = size(solved_case.active_aus,1);
    if (index > 7)
        index = 7;
    end
    % Search all cases on that branch to see if the new case matches any
    branch = trained_cbr{index};
    branch_length = size(branch,1);
    for i = 1:branch_length
        current_aus = branch(i).active_aus(:);
        solved_aus = solved_case.active_aus(:); 
        if (isequal(current_aus,solved_aus))
            if ~(solved_case.label == branch(i).label)
               % Lower its typicality
               trained_cbr{index}(i).typicality = ...
                    branch(i).typicality - 1;
               % If it now has 0 typicality, remove it from the case base
               if (trained_cbr{index}(i).typicality < 1)
                    trained_cbr{index}(i) = [];
                    break
               end
            elseif solved_case.label == branch(i).label
                % Increase the 'typicality' of the matching case
                trained_cbr{index}(i).typicality = ...
                    branch(i).typicality + 1;
            end
            % Don't add this example to the case base at the end
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

function [ updated_cbr ] = retain( trained_cbr,solved_case,training )
% RETAIN - adds a solved case to the existing CBR system
%
%IN:  trained_cbr: a CBR system
%     solved_case: the new case to (potentially) add
%     training: is the CBR still recieving training examples?
%OUT: updated_cbr: CBR system containing the new example

    found_same_example = 0;
    for i = 1:size(trained_cbr,1)
        current_aus = trained_cbr{i}.active_aus(:);
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
            if ~(solved_case.label == trained_cbr{i}.label) && training
               disp('Mismatch in training - example doubly classified:') 
               disp(solved_case.label)
               disp(trained_cbr{i}.label)
            end
            found_same_example = 1;
        end
    end
    if ~found_same_example
        % Only add the example if it does not match a pre-existing example
        updated_cbr = vertcat(trained_cbr,solved_case);
    else
        updated_cbr = trained_cbr;
    end
end

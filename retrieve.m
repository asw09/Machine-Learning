function [ similar_case ] = retrieve( trained_cbr,new_case )
% RETRIEVE - retrieves a similar case from a trained CBR system

    new_aus = new_case.active_aus(:);
    best_matches = 0;
    for i = 1:size(trained_cbr,1)
        current_aus = trained_cbr{i}.active_aus(:);
        matches = size(find(ismember(current_aus,new_aus)),1);
        if matches > best_matches
           best_matches = matches;
           best_case = i;
        end
    end
    similar_case = trained_cbr{best_case};
    %similar_case = trained_cbr{unidrnd(size(trained_cbr,1))};

end
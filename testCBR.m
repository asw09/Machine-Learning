function [ results ] = testCBR( trained_cbr,test_set )
% testCBR - generates a vector of predictions for a set of examples

    results = cell(size(test_set,1),1);
    for i = 1:size(test_set,1)
        new_case = CBR_get_case(test_set(i,:),0);
        [similar_case,m,p] = retrieve(trained_cbr,new_case);
        solved_case = reuse(similar_case,new_case);
        trained_cbr = retain(trained_cbr,solved_case,0);
        results{i}.label = solved_case.label;
        results{i}.matches = m;
        results{i}.percentage = p;
    end

end